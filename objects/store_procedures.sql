
-- STORED PROCEDURES

/*

NOTA IMPORTANTE: 
Para evitar errores en la ejecución de los scripts favor seguir el siguiente orden:
1. db_control_inventario.sql
2. funciones.sql
3. triggers.sql
4. procedures.sql
5. vistas_kpi.sql
6. population.sql

*/

USE control_inventario;

/**************************************************************************************************************/

-- Procedimiento 1: procedimiento para insertar un nuevo producto e iniciar el inventario del mismo

DROP PROCEDURE IF EXISTS sp_1_insertar_producto;

DELIMITER //
CREATE PROCEDURE sp_1_insertar_producto(IN id_producto INT, IN descripcion VARCHAR(50), IN id_marca INT, IN id_categoria INT, IN id_ubicacion INT, IN inventario_inicial INT )      
BEGIN
INSERT INTO productos (id_producto, descripcion, id_marca, id_categoria, id_ubicacion) VALUES (id_producto, descripcion, id_marca, id_categoria, id_ubicacion);
INSERT INTO inventario (id_producto, inventario_inicial, total_entradas, total_salidas, stock, unidad_medida, ultimo_precio_$) VALUES (id_producto, inventario_inicial, DEFAULT, DEFAULT, DEFAULT, DEFAULT, DEFAULT);
END //
DELIMITER ;


/**************************************************************************************************************/

-- Procedimiento 2: procedimiento para registrar la entrada de una guia que contiene 3 productos

DROP PROCEDURE IF EXISTS sp_2_registrar_entrada;

DELIMITER //
CREATE PROCEDURE sp_2_registrar_entrada (
	IN id_entrada INT, IN numero_guia VARCHAR(10), IN id_responsable_registro INT, 
	IN id_producto_a INT, IN cantidad_a INT, IN precio_compra_$_a DECIMAL(10, 2),
	IN id_producto_b INT, IN cantidad_b INT, IN precio_compra_$_b DECIMAL(10, 2), 
	IN id_producto_c INT, IN cantidad_c INT, IN precio_compra_$_c DECIMAL(10, 2)
    )
BEGIN
	INSERT INTO entradas (id_entrada, fecha, numero_guia, id_responsable_registro) 
	VALUES 
    (id_entrada, DEFAULT, numero_guia, id_responsable_registro) ;
    
	INSERT INTO detalle_entradas (id_entrada, id_producto, cantidad, unidad_medida, precio_compra_$) 
	VALUES 
	(id_entrada, id_producto_a, cantidad_a, DEFAULT, precio_compra_$_a ) ,
	(id_entrada, id_producto_b, cantidad_b, DEFAULT, precio_compra_$_b ) ,
	(id_entrada, id_producto_c, cantidad_c, DEFAULT, precio_compra_$_c ) ;
END //
DELIMITER ;


/**************************************************************************************************************/

-- Procedimiento 3: procedimiento para registrar una solicitud de prodcutos que contiene 3 productos

DROP PROCEDURE IF EXISTS sp_3_registrar_salida;

DELIMITER //
CREATE PROCEDURE sp_3_registrar_salida (
	IN id_salida INT,
	IN numero_solicitud VARCHAR(10),
	IN id_responsable_registro INT, 
    IN turno INT,
	IN id_destino INT,
	IN id_area_solicitud INT,
	IN id_quien_recibe INT, 
    IN id_producto_a INT,
	IN cantidad_a INT, 
    IN id_producto_b INT,
	IN cantidad_b INT, 
    IN id_producto_c INT,
	IN cantidad_c INT)
BEGIN
	INSERT INTO salidas (id_salida, fecha, numero_solicitud, id_responsable_registro, 
    turno, id_destino, id_area_solicitud, id_quien_recibe)
	VALUES 
    (id_salida, DEFAULT, numero_solicitud, id_responsable_registro, 
    turno, id_destino, id_area_solicitud, id_quien_recibe) ;
    
	INSERT INTO detalle_salidas (id_salida, id_producto, cantidad) 
	VALUES 
    ( id_salida , id_producto_a , cantidad_a ), 
	( id_salida , id_producto_b , cantidad_b ),
	( id_salida , id_producto_c , cantidad_c );
END //
DELIMITER ;


/**************************************************************************************************************/



-- tabla productos e inventario

USE control_inventario;

CALL sp_1_insertar_producto(1, 'descripción_producto_1', 4, 2, 1, 190);
CALL sp_1_insertar_producto(2, 'descripción_producto_2', 1, 5, 4, 160);
CALL sp_1_insertar_producto(3, 'descripción_producto_3', 7, 5, 2, 130);
CALL sp_1_insertar_producto(4, 'descripción_producto_4', 10, 2, 1, 100);
CALL sp_1_insertar_producto(5, 'descripción_producto_5', 1, 6, 9, 140);
CALL sp_1_insertar_producto(6, 'descripción_producto_6', 9, 1, 4, 170);
CALL sp_1_insertar_producto(7, 'descripción_producto_7', 7, 6, 9, 130);
CALL sp_1_insertar_producto(8, 'descripción_producto_8', 8, 6, 5, 190);
CALL sp_1_insertar_producto(9, 'descripción_producto_9', 10, 1, 7, 210);
CALL sp_1_insertar_producto(10, 'descripción_producto_10', 1, 2, 3, 90);


-- tabla entrada, detalle_entradas e inventario

USE control_inventario;

CALL sp_2_registrar_entrada( 1, 'G-1', 10, 1, 16, 8, 4, 15, 46, 6, 16, 13 );
CALL sp_2_registrar_entrada( 2, 'G-2', 12, 1, 10, 8, 4, 9, 46, 6, 16, 13 ); 
CALL sp_2_registrar_entrada( 3, 'G-3', 11, 1, 11, 8, 5, 10, 449, 6, 13, 13 ); 
CALL sp_2_registrar_entrada( 4, 'G-4', 13, 2, 10, 59, 5, 9, 449, 7, 19, 9 );
CALL sp_2_registrar_entrada( 5, 'G-5', 10, 2, 18, 59, 5, 17, 449, 7, 15, 9 ); 
CALL sp_2_registrar_entrada( 6, 'G-6', 12, 2, 17, 59, 7, 17, 9, 9, 19, 418 ); 
CALL sp_2_registrar_entrada( 7, 'G-7', 11, 3, 17, 7, 8, 11, 12, 9, 19, 418 );
CALL sp_2_registrar_entrada( 8, 'G-8', 13, 3, 14, 7, 8, 13, 12, 10, 17, 11); 
CALL sp_2_registrar_entrada( 9, 'G-9', 10, 3, 20, 7, 8, 11, 12, 10, 21, 11 ); 
CALL sp_2_registrar_entrada( 10, 'G-10', 12, 4, 16, 46, 9, 19, 418, 10, 18, 11 ); 


-- tabla salidas, detalle_salidas e inventario

CALL sp_3_registrar_salida(1, 'S-1', 10, 1, 18, 4, 6, 1, 7, 4, 8, 6, 9 );
CALL sp_3_registrar_salida(2, 'S-2', 12, 2, 19, 6, 8, 1, 6, 4, 7, 6, 8 );
CALL sp_3_registrar_salida(3, 'S-3', 11, 1, 18, 1, 3, 1, 9, 5, 20, 6, 10 );
CALL sp_3_registrar_salida(4, 'S-4', 13, 2, 17, 1, 3, 2, 9, 5, 19, 7, 14 );
CALL sp_3_registrar_salida(5, 'S-5', 10, 1, 11, 3, 5, 2, 8, 5, 22, 7, 13 );
CALL sp_3_registrar_salida(6, 'S-6', 12, 2, 20, 4, 6, 2, 10, 7, 15, 9, 24 );
CALL sp_3_registrar_salida(7, 'S-7', 11, 1, 7, 1, 3, 3, 4, 8, 5, 9, 23 );
CALL sp_3_registrar_salida(8, 'S-8', 13, 2, 5, 6, 8, 3, 3, 8, 4, 10, 5 );
CALL sp_3_registrar_salida(9, 'S-9', 10, 1, 7, 3, 5, 3, 6, 8, 8, 10, 4 );
CALL sp_3_registrar_salida(10, 'S-10', 12, 2, 15, 4, 6, 4, 10, 9, 25, 10, 7 );
