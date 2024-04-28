-- INSERCION DE DATOS

USE gestion_inventario;

-- tabla categorias  (10 registros)

INSERT INTO categorias(id_categoria,nombre_categoria)
VALUES
(1,'catmovimientos_inventarioegoria1'),
(2,'categoria2'),
(3,'categoria3'),
(4,'categoria4'),
(5,'categoria5'),
(6,'categoria6'),
(7,'categoria7'),
(8,'categoria8'),
(9,'categoria9'),
(10,'categoria10');


-- tabla proveedores  (10 registros)

INSERT INTO proveedores(id_proveedor,nombre_proveedor,email_proveedor,direccion_proveedor,telefono_proveedor)
VALUES
(1,'proveedor1','mail1','direccion1','telefono1'),
(2,'proveedor2','mail1','direccion1','telefono1'),
(3,'proveedor3','mail1','direccion1','telefono1'),
(4,'proveedor4','mail1','direccion1','telefono1'),
(5,'proveedor5','mail1','direccion1','telefono1'),
(6,'proveedor6','mail1','direccion1','telefono1'),
(7,'proveedor7','mail1','direccion1','telefono1'),
(8,'proveedor8','mail1','direccion1','telefono1'),
(9,'proveedor9','mail1','direccion1','telefono1'),
(10,'proveedor10','mail1','direccion1','telefono1');


-- tabla productos

USE gestion_inventario;

SET GLOBAL LOCAL_INFILE=1;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\productos.csv'   -- en github cambiar toda la ruta por:    './data_csv/productos.csv'
INTO TABLE productos
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS ;


-- tabla detalle_ventas

USE gestion_inventario;

SET GLOBAL LOCAL_INFILE=1;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\detalle_ventas.csv'   -- en github cambiar toda la ruta por:    './data_csv/detalle_ventas.csv'
INTO TABLE detalle_ventas
FIELDS TERMINATED BY ','  
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS ;


