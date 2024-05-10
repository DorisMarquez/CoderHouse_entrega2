
-- BASE DE DATOS CONTROL_INVENTARIO
-- CODERHOUSE SEGUNDA PRE-ENTREGA
-- DORIS MARQUEZ
-- 27-04-2024

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

-- Creación de la base de datos

DROP DATABASE IF EXISTS control_inventario;

CREATE DATABASE control_inventario;

USE control_inventario;


-- Creación de las tablas sin las restricciones de Foreign Key

-- 1. Tabla productos

CREATE TABLE productos (
	id_producto INT PRIMARY KEY,
	descripcion VARCHAR(50),
	id_marca INT NOT NULL,
	id_categoria INT NOT NULL,
	id_ubicacion INT DEFAULT 1
)
COMMENT "Almacena los detalles de los productos disponibles en el inventario" ;


-- 2. Tabla inventario

CREATE TABLE inventario (
    id_producto INT PRIMARY KEY,
    inventario_inicial INT NOT NULL DEFAULT 0,
    total_entradas INT DEFAULT 0,
    total_salidas INT DEFAULT 0,
    stock INT AS (inventario_inicial + total_entradas - total_salidas),
    unidad_medida VARCHAR(10) DEFAULT 'unidad',
    ultimo_precio_$ DECIMAL(10, 2) DEFAULT 0
)
COMMENT "Registra los detalles del inventario para cada producto";


-- 3. Tabla entradas

CREATE TABLE entradas (
	id_entrada INT PRIMARY KEY,
	fecha DATETIME DEFAULT (NOW()),
	numero_guia VARCHAR(10) NOT NULL,
	id_responsable_registro INT DEFAULT 10
)
COMMENT "Registra las guías que son recibidas en el almacén";


-- 4. Tabla detalle_entradas

CREATE TABLE detalle_entradas (
	id_entrada INT,
	id_producto INT,
	cantidad INT NOT NULL,
	unidad_medida VARCHAR(10) DEFAULT 'unidad',
	precio_compra_$ DECIMAL(10, 2),
    PRIMARY KEY (id_entrada, id_producto)
)
COMMENT "Registra los productos y las cantidades que ingresan al almacén";


-- 5. Tabla salidas

CREATE TABLE salidas (
	id_salida INT PRIMARY KEY,
	fecha DATETIME DEFAULT (NOW()),
	numero_solicitud VARCHAR(10) NOT NULL,
	id_responsable_registro INT DEFAULT 10,
	turno ENUM('día', 'noche'),
	id_destino INT ,
	id_area_solicitud INT,
	id_quien_recibe INT 
)
COMMENT "Registra las solicitudes de materiales hechas por las diferentes áreas de la empresa";
 

-- 5. Tabla detalle_salidas 

CREATE TABLE detalle_salidas (
	id_salida INT,
	id_producto INT,
	cantidad INT,
	unidad_medida VARCHAR(10) DEFAULT 'unidad',
    PRIMARY KEY (id_salida, id_producto)
)
COMMENT "Registra los productos y las cantidades que salen del almacén";
  
  
  -- 6. Tabla categorias
  
CREATE TABLE categorias (
	id_categoria INT PRIMARY KEY AUTO_INCREMENT,
	categoria VARCHAR(50)
)
COMMENT "Describe las distintas categorías en que se clasifican lo productos en el almacén";
  
   
   -- 7. Tabla areas
   
CREATE TABLE areas (
	id_area INT PRIMARY KEY AUTO_INCREMENT,
	area VARCHAR(50)
)
COMMENT "Describe las diferentes áreas que conforman la empresa";
  
  
  -- 8. Tabla empleados
    
CREATE TABLE empleados (
	id_empleado INT PRIMARY KEY AUTO_INCREMENT,
	nombre_empleado VARCHAR(50),
	apellido_empleado VARCHAR(50),
	email_empleado VARCHAR(100),
	id_area INT,
	cargo_empleado VARCHAR(50)
)
COMMENT "Contiene la información de los empleados de la empresa";
 
 
 -- 9. Tabla ubicaciones
 
CREATE TABLE ubicaciones (
	id_ubicacion INT PRIMARY KEY AUTO_INCREMENT,
	ubicacion VARCHAR(50)
)
COMMENT "Describe las diferentes ubicaciones en que se encuentra organizado el almacén";
  
  
  -- 10. Tabla destinos
  
CREATE TABLE destinos (
	id_destino INT PRIMARY KEY AUTO_INCREMENT,
	destino VARCHAR(50)
)
COMMENT "Describe el destino del materia solicitado, ya sea un lugar de la empresa o un equipo";
  
   
   -- 12. Tabla marcas
   
CREATE TABLE marcas (
	id_marca INT PRIMARY KEY AUTO_INCREMENT,
	marca VARCHAR(50)
)
COMMENT "Describe las diferentes marcas de los produsctos almacenados";


-- Creación de foreing keys:

-- Restricciones para la tabla 'productos'
ALTER TABLE productos ADD CONSTRAINT fk_marca FOREIGN KEY (id_marca) REFERENCES marcas(id_marca) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE productos ADD CONSTRAINT fk_categoria FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE productos ADD CONSTRAINT fk_ubicacion FOREIGN KEY (id_ubicacion) REFERENCES ubicaciones(id_ubicacion) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Restricciones para la tabla 'inventario'
ALTER TABLE inventario ADD CONSTRAINT fk_inventario_producto FOREIGN KEY (id_producto) REFERENCES productos(id_producto) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Restricciones para la tabla 'entradas'
ALTER TABLE entradas ADD CONSTRAINT fk_entradas_responsable FOREIGN KEY (id_responsable_registro) REFERENCES empleados(id_empleado) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
    
-- Restricciones para la tabla 'salidas'
ALTER TABLE salidas ADD CONSTRAINT fk_salidas_responsable FOREIGN KEY (id_responsable_registro) REFERENCES empleados(id_empleado) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE salidas ADD CONSTRAINT fk_salidas_destinos FOREIGN KEY (id_destino) REFERENCES destinos(id_destino) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE salidas ADD CONSTRAINT fk_salidas_area FOREIGN KEY (id_area_solicitud) REFERENCES areas(id_area) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE salidas ADD CONSTRAINT fk_salidas_recibe FOREIGN KEY (id_quien_recibe) REFERENCES empleados(id_empleado) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Restricciones para la tabla 'detalle_entradas'
ALTER TABLE detalle_entradas ADD CONSTRAINT fk_detalle_entradas_entradas FOREIGN KEY (id_entrada) REFERENCES entradas(id_entrada) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE detalle_entradas ADD CONSTRAINT fk_detalle_entradas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Restricciones para la tabla 'detalle_salidas'
ALTER TABLE detalle_salidas ADD CONSTRAINT fk_detalle_salidas_salidas FOREIGN KEY (id_salida) REFERENCES salidas(id_salida) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;
ALTER TABLE detalle_salidas ADD CONSTRAINT fk_detalle_salidas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;

-- Restricciones para la tabla 'empleados'
ALTER TABLE empleados ADD CONSTRAINT fk_empleados_area FOREIGN KEY (id_area) REFERENCES areas(id_area) 
	ON DELETE NO ACTION ON UPDATE NO ACTION;


