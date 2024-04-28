-- BASE DE DATOS GESTION DE INVENTARIO
-- CODERHOUSE SEGUNDA PRE-ENTREGA
-- DORIS MARQUEZ
-- 27-04-2024


-- Creación de la base de datos

DROP DATABASE IF EXISTS gestion_inventario;

CREATE DATABASE gestion_inventario;

USE gestion_inventario;

-- Creación de las tablas sin las restricciones de Foreign Key

CREATE TABLE productos ( 
    id_producto INT PRIMARY KEY AUTO_INCREMENT,
    SKU VARCHAR(10) UNIQUE NOT NULL,
    nombre_producto VARCHAR(255) NOT NULL,
    id_categoria INT,
    id_proveedor INT,
    precio_unitario_compra DECIMAL(10, 2) NOT NULL,
    precio_unitario_venta DECIMAL(10, 2) NOT NULL, 
    stock_actual INT NOT NULL, 
	unidad_stock VARCHAR(10),
    t_avg_reposicion_dias INT,
	t_max_reposicion_dias INT

)
COMMENT "Almacena los detalles de los productos disponibles en el inventario" ;


CREATE TABLE categorias (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nombre_categoria VARCHAR(255) NOT NULL
)
COMMENT "Clasifica los productos en diferentes categorías" ;


CREATE TABLE proveedores (
    id_proveedor INT PRIMARY KEY AUTO_INCREMENT,
    nombre_proveedor VARCHAR(255) NOT NULL,
    email_proveedor VARCHAR(50) NOT NULL,  
    direccion_proveedor VARCHAR(255),  
    telefono_proveedor VARCHAR(20)
)
COMMENT "Almacena información sobre los proveedores de los productos" ;


CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre_cliente VARCHAR(255) NOT NULL,
    email_clientes VARCHAR(50) NOT NULL,  
    direccion_cliente VARCHAR(255),
    telefono_cliente VARCHAR(20)
)
COMMENT "Contiene datos de los clientes que realizan compras" ;


CREATE TABLE empleados (
    id_empleado INT PRIMARY KEY AUTO_INCREMENT,
    nombre_empleado VARCHAR(255) NOT NULL,
    email_empleados VARCHAR(50) NOT NULL,  
    cargo_empleado VARCHAR(100),  
    salario_empleado DECIMAL(10, 2) 
)
COMMENT "Almacena información sobre el personal de la empresa" ;


CREATE TABLE ventas (
    id_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATE NOT NULL,
    id_cliente INT,
    id_empleado INT
)
COMMENT "Registra las ventas realizadas" ;


CREATE TABLE detalle_ventas (
    id_detalle_venta INT PRIMARY KEY AUTO_INCREMENT,
    fecha_venta DATE NOT NULL,
	id_producto INT,
    cantidad INT NOT NULL
)
COMMENT "Almacena los artículos específicos vendidos en cada transacción" ;

CREATE TABLE compras (
    id_compra INT PRIMARY KEY AUTO_INCREMENT,
    fecha_compra DATE NOT NULL,
    id_proveedor INT,
    id_empleado INT   
)
COMMENT "Registra las compras realizadas a proveedores" ;


CREATE TABLE detalle_compras (
    id_detalle_compra INT PRIMARY KEY AUTO_INCREMENT,
    fecha_compra DATE NOT NULL,
    id_compra INT,
    id_producto INT,
    cantidad INT NOT NULL
)
COMMENT "Almacena los artículos específicos comprados en cada transacción" ;


CREATE TABLE movimientos_inventario (
    id_movimiento INT PRIMARY KEY AUTO_INCREMENT,
    fecha_movimiento DATE NOT NULL,
    tipo_movimiento ENUM('Entrada', 'Salida') NOT NULL,
    id_producto INT,
    cantidad INT NOT NULL,
    id_compra INT,  
	id_venta INT,   
    id_empleado INT       
)
COMMENT "Esta tabla registra las entradas y salidas de productos en el inventario de la empresa" ;


CREATE TABLE devoluciones (
    id_devolucion INT PRIMARY KEY AUTO_INCREMENT,
    fecha_devolucion DATE NOT NULL,
    id_cliente INT
)
COMMENT "Esta tabla registra las devoluciones de clientes. Puede incluir devoluciones de productos defectuosos, cambios o reembolsos" ;


CREATE TABLE pagos (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,
    fecha_pago DATE NOT NULL,
    id_cliente INT,
    id_compra INT, 
    monto_pagado DECIMAL(10, 2) NOT NULL  
)
COMMENT "Esta tabla gestiona los pagos recibidos y emitidos. Puede incluir pagos de clientes por productos o servicios, así como pagos a proveedores o empleados" ;


CREATE TABLE facturas (   
    id_factura INT PRIMARY KEY AUTO_INCREMENT,
    fecha_factura DATE NOT NULL,
    id_cliente INT,
    id_venta INT,  
    monto_total DECIMAL(10, 2) NOT NULL  
)
COMMENT "Esta tabla se utiliza para la emisión y gestión de facturas" ;


DROP TABLE IF EXISTS fechas_semanales ;

CREATE TABLE fechas_semanales (
    id_semana INT PRIMARY KEY AUTO_INCREMENT,
    fecha_semanal DATE
)
COMMENT "Esta tabla es auxiliar y se utiliza en el calculo de la cantidad de productos vendido semanalmente" ;


-- Creación de las restricciones de Foreign Key

ALTER TABLE productos
    ADD FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria),
    ADD FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor);

ALTER TABLE ventas
    ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

ALTER TABLE compras
    ADD FOREIGN KEY (id_proveedor) REFERENCES proveedores(id_proveedor);

ALTER TABLE detalle_compras
    ADD FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    ADD FOREIGN KEY (id_producto) REFERENCES productos(id_producto);

ALTER TABLE movimientos_inventario
    ADD FOREIGN KEY (id_producto) REFERENCES productos(id_producto),
	ADD FOREIGN KEY (id_compra) REFERENCES compras(id_compra),
    ADD FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    ADD FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado);

ALTER TABLE devoluciones
    ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente);

ALTER TABLE pagos
    ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    ADD FOREIGN KEY (id_compra) REFERENCES compras(id_compra);

ALTER TABLE facturas
    ADD FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    ADD FOREIGN KEY (id_venta) REFERENCES ventas(id_venta);