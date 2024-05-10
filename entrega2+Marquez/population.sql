
-- INSERCION DE DATOS

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

-- tabla areas

INSERT INTO areas (id_area, area) VALUES 
(1, 'Gerencia y administración'),
(2, 'Producción'),
(3, 'Operaciones'),
(4, 'Mantenimiento'),
(5, 'Seguridad'),
(6, 'RRHH'),
(7, 'Logística');


-- tabla categorias

INSERT INTO categorias (id_categoria, categoria) VALUES 
(1, 'Repuestos'),
(2, 'Herramientas'),
(3, 'Filtros'),
(4, 'Aceros'),
(5, 'Suministro'),
(6, 'EPP'),
(7, 'Lubricantes');


-- tabla ubicaciones

INSERT INTO ubicaciones (id_ubicacion, ubicacion) VALUES 
(1, 'pendiente'), -- cuando no se tiene ubicacion definida cuando se ingresa el producto
(2, 'ubicacion2'),
(3, 'ubicacion3'),
(4, 'ubicacion4'),
(5, 'ubicacion5'),
(6, 'ubicacion6'),
(7, 'ubicacion7'),
(8, 'ubicacion8'),
(9, 'ubicacion9'),
(10, 'ubicacion10');


-- tabla lugar_equipo_destino

INSERT INTO destinos (id_destino, destino) VALUES 
(1, 'lugar1'),
(2, 'lugar2'),
(3, 'lugar3'),
(4, 'lugar4'),
(5, 'lugar5'),
(6, 'lugar6'),
(7, 'lugar7'),
(8, 'lugar8'),
(9, 'lugar9'),
(10, 'lugar10'),
(11, 'equipo1'),
(12, 'equipo2'),
(13, 'equipo3'),
(14, 'equipo4'),
(15, 'equipo5'),
(16, 'equipo6'),
(17, 'equipo7'),
(18, 'equipo8'),
(19, 'equipo9'),
(20, 'equipo10');


-- tabla marcas

INSERT INTO marcas (id_marca, marca) VALUES 
(1, 'marca1'),
(2, 'marca2'),
(3, 'marca3'),
(4, 'marca4'),
(5, 'marca5'),
(6, 'marca6'),
(7, 'marca7'),
(8, 'marca8'),
(9, 'marca9'),
(10, 'marca10');


-- tabla empleados

INSERT INTO empleados (id_empleado , nombre_empleado , apellido_empleado, email_empleado, id_area, cargo_empleado) VALUES 
(1, 'Powell', 'Saill', 'psaill3b@netvibes.com', 1, 'Gerente'),
(2, 'Agnese', 'Ouslem', 'aouslem3c@photobucket.com', 1, 'Administrador'),
(3, 'Barret', 'Gerran', 'barret.gerran@empresa11.com', 1, 'Auxiliar de administración'),
(4, 'Keslie', 'Furley', 'kfurley3d@woothemes.com', 2, 'Auxiliar de producción'),
(5, 'Saba', 'Hissie', 'shissie3e@amazonaws.com', 3, 'Auxiliar de operaciones'),
(6, 'Roddie', 'Voelker', 'rvoelker3f@phoca.cz', 4, 'Auxiliar de mantenimiento'),
(7, 'Fletch', 'Oels', 'foels3g@illinois.edu', 5, 'Auxiliar de SHI'),
(8, 'Conni', 'Larrat', 'clarrat3h@whitehouse.gov', 6, 'Auxiliar de RRHH'),
(9, 'Genvieve', 'Segebrecht', 'gsegebrecht3i@altervista.org', 7, 'Jefe almacén'),
(10, 'Lavinie', 'Perkis', 'lperkis3j@newyorker.com', 7, 'Encargado de almacén'),
(11, 'Garrick', 'Warden', 'gwarden3k@fastcompany.com', 7, 'Encargado de almacén'),
(12, 'Guntar', 'Piccop', 'gpiccop3l@chron.com', 7, 'Encargado de almacén'),
(13, 'Christopher', 'Pechell', 'christopher.pechell@empresa10.com', 7, 'Encargado de almacén');


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

CALL sp_3_registrar_salida(1, 'S-1', 10, 'dia', 18, 4, 6, 1, 7, 4, 8, 6, 9 );
CALL sp_3_registrar_salida(2, 'S-2', 12, 'noche', 19, 6, 8, 1, 6, 4, 7, 6, 8 );
CALL sp_3_registrar_salida(3, 'S-3', 11, 'dia', 18, 1, 3, 1, 9, 5, 20, 6, 10 );
CALL sp_3_registrar_salida(4, 'S-4', 13, 'noche', 17, 1, 3, 2, 9, 5, 19, 7, 14 );
CALL sp_3_registrar_salida(5, 'S-5', 10, 'dia', 11, 3, 5, 2, 8, 5, 22, 7, 13 );
CALL sp_3_registrar_salida(6, 'S-6', 12, 'noche', 20, 4, 6, 2, 10, 7, 15, 9, 24 );
CALL sp_3_registrar_salida(7, 'S-7', 11, 'dia', 7, 1, 3, 3, 4, 8, 5, 9, 23 );
CALL sp_3_registrar_salida(8, 'S-8', 13, 'noche', 5, 6, 8, 3, 3, 8, 4, 10, 5 );
CALL sp_3_registrar_salida(9, 'S-9', 10, 'dia', 7, 3, 5, 3, 6, 8, 8, 10, 4 );
CALL sp_3_registrar_salida(10, 'S-10', 12, 'noche', 15, 4, 6, 4, 10, 9, 25, 10, 7 );


