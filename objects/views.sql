
-- VISTAS

USE control_inventario;

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


/**************************************************************************************************************/

-- Vista 1: Vista que muestra informacion de las tablas productos e inventario, mostrando además descripcion, marca y categoria

DROP VIEW IF EXISTS vw_1_informe_inventario;

CREATE VIEW vw_1_informe_inventario AS
SELECT i.id_producto, p.descripcion, m.marca, c.categoria, i.inventario_inicial, 
i.total_entradas, i.total_salidas, i.stock, i.ultimo_precio_$
FROM inventario i
JOIN productos p ON p.id_producto = i.id_producto
JOIN marcas m ON m.id_marca = p.id_marca
JOIN categorias c ON c.id_categoria = p.id_categoria
;

/**************************************************************************************************************/

-- Vista 2: Vista que muestra el valor del inventario y el porcentaje que corresponde a cada porducto ordenado en forma descendente

DROP VIEW IF EXISTS vw_2_valor_inventario;

CREATE VIEW vw_2_valor_inventario AS
SELECT i.id_producto, p.descripcion, i.stock, i.ultimo_precio_$, 
(i.stock * i.ultimo_precio_$) AS valor_inventario, 
ROUND((i.stock * i.ultimo_precio_$ * 100 / fn_4_valor_total_inventario()),2) AS porcentaje_valor_inventario
FROM inventario i
JOIN productos p ON p.id_producto = i.id_producto
ORDER BY valor_inventario DESC
;

/**************************************************************************************************************/

-- Vista 3: Vista que muestra el valor total del inventario

DROP VIEW IF EXISTS vw_3_valor_total_inventario;

CREATE VIEW vw_3_valor_total_inventario AS
SELECT  
SUM(stock * ultimo_precio_$) AS valor_total_inventario
FROM inventario
;


/**************************************************************************************************************/

-- Vista 4: Vista de productos con su inventario, incluyendo descripcion, marca, categoria, ubicacion y stock

DROP VIEW IF EXISTS vw_4_productos_inventario;

CREATE VIEW vw_4_productos_inventario AS
SELECT p.id_producto, p.descripcion, m.marca, c.categoria, u.ubicacion, i.stock 
FROM productos p
JOIN inventario i ON p.id_producto = i.id_producto
JOIN marcas m ON m.id_marca = p.id_marca
JOIN categorias c ON c.id_categoria = p.id_categoria
JOIN ubicaciones u ON u.id_ubicacion = p.id_ubicacion
ORDER BY id_producto;
;


/**************************************************************************************************************/

-- Vista 5: Vista de todas las entradas de productos

DROP VIEW IF EXISTS vw_5_entradas_productos;

CREATE VIEW vw_5_entradas_productos AS
SELECT e.id_entrada, DATE(e.fecha) AS fecha, d.id_producto, p.descripcion, d.cantidad
FROM entradas e
JOIN detalle_entradas d ON e.id_entrada = d.id_entrada
JOIN productos p ON d.id_producto = p.id_producto
;


/**************************************************************************************************************/

-- Vista 6: Vista de salidas de productos

DROP VIEW IF EXISTS vw_6_salidas_productos;

CREATE VIEW vw_6_salidas_productos AS
SELECT s.id_salida, DATE(s.fecha) AS fecha, d.id_producto, p.descripcion, d.cantidad
FROM salidas s
JOIN detalle_salidas d ON s.id_salida = d.id_salida
JOIN productos p ON d.id_producto = p.id_producto
;


/**************************************************************************************************************/


