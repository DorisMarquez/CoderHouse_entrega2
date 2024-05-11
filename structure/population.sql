
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




