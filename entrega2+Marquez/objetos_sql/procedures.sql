
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
	IN id_salida INT, IN numero_solicitud VARCHAR(10), IN id_responsable_registro INT, 
    IN turno ENUM('día', 'noche'), IN id_destino INT, IN id_area_solicitud INT, IN id_quien_recibe INT, 
    IN id_producto_a INT, IN cantidad_a INT, 
    IN id_producto_b INT, IN cantidad_b INT, 
    IN id_producto_c INT, IN cantidad_c INT)
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

