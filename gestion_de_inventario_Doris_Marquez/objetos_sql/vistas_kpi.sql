
-- VISTAS

/**************************************************************************************************************/

-- crear una tabla cruzada llamada producto_fechas entre el campo id_producto de la tabla productos y 
-- el campo fecha_semanal de la tabla fechas_semanales


-- crear vista usando las tablas productos y fechas_semanales

DROP VIEW IF EXISTS vw_producto_fechas ;

CREATE VIEW vw_producto_fechas AS (
SELECT f.fecha_semanal, p.id_producto
FROM productos p
CROSS JOIN fechas_semanales f
ORDER BY f.fecha_semanal DESC, p.id_producto
);


/**************************************************************************************************************/

-- calcular la cantidad de productos vendidos semanalmente por producto (demanda semanal de productos)


-- crear vista a partir de la vista vw_producto_fechas y la tabla detalle_ventas

DROP VIEW IF EXISTS vw_demanda_sem_x_prod ;

CREATE VIEW vw_demanda_sem_x_prod AS (
SELECT vpf.fecha_semanal, vpf.id_producto, SUM(dv.cantidad) AS demanda_semanal
FROM vw_producto_fechas vpf
JOIN detalle_ventas dv
ON vpf.id_producto = dv.id_producto AND vpf.fecha_semanal >= dv.fecha_venta AND (vpf.fecha_semanal - INTERVAL 6 DAY) < dv.fecha_venta 
GROUP BY vpf.fecha_semanal, vpf.id_producto
ORDER BY vpf.fecha_semanal DESC
);


-- como vista materializada de la vista vw_demanda_sem_x_prod seria:

DROP TABLE IF EXISTS vwm_demanda_sem_x_prod ;

CREATE TABLE vwm_demanda_sem_x_prod AS 
SELECT * FROM vw_demanda_sem_x_prod;


/**************************************************************************************************************/

-- calcular el dinero obtenido por ventas semanales por producto, para eso usamos la demanda semanal obtenida en el punto anterior
--  y se multiplica con el precio unitario de venta de cada producto que se toma de la tabla productos


-- Crear la vista a partir de la vista vw_demanda_sem_x_prod y la tabla producto

DROP VIEW IF EXISTS vw_ventas_sem_x_prod;

CREATE VIEW vw_ventas_sem_x_prod AS (
SELECT vdsxp.fecha_semanal, vdsxp.id_producto, ( vdsxp.demanda_semanal * p.precio_unitario_venta) AS venta_semanal_$
FROM vw_demanda_sem_x_prod vdsxp
LEFT JOIN productos p
USING (id_producto)
);



/**************************************************************************************************************/

-- CALCULAR LA CANTIDAD TOTAL DE UNIDADES VENDIDAS POR CADA PRODUCTO EN EL ULTIMO AÑO

-- usando la vista vw_demanda_sem_x_prod

DROP VIEW IF EXISTS vw_demanda_anual_x_prod;

CREATE VIEW vw_demanda_anual_x_prod AS (
SELECT id_producto, SUM(demanda_semanal) AS demanda_anual
FROM vw_demanda_sem_x_prod
GROUP BY id_producto
ORDER BY id_producto
);

/**************************************************************************************************************/

-- CALCULAR LOS INGRESOS ANUALES PERCIBIDOS POR CADA PRODUCTO

-- formula:     demanda anual por producto x precio unitario de venta

-- usando la vista vw_demanda_anual_x_prod y la tabla productos 


DROP VIEW IF EXISTS vw_ventas_anual_x_prod;

CREATE VIEW vw_ventas_anual_x_prod AS (
SELECT vdaxp.id_producto, (vdaxp.demanda_anual * p.precio_unitario_venta) AS venta_anual_$
FROM vw_demanda_anual_x_prod vdaxp
LEFT JOIN productos p
USING (id_producto)
GROUP BY vdaxp.id_producto
ORDER BY vdaxp.id_producto
);

/**************************************************************************************************************/

-- CALCULAR EL % DE INGRESO ANUAL QUE REPRESENTA CADA PRODUCTO

-- formula:     ingreso anual de cada producto * 100 / suma del ingreso anual de todos los productos

-- calcular la suma del ingreso anual de todos los productos

SELECT SUM(venta_anual_$) AS venta_anual_total_$
FROM vw_ventas_anual_x_prod;

-- incluir el calculo anterior como subquery
-- ordenar por porcentaje en forma descente

DROP VIEW IF EXISTS vw_poncentaje_venta_anual_x_prod;

CREATE VIEW vw_poncentaje_venta_anual_x_prod AS (
SELECT vvaxp.id_producto, 
		ROUND(vvaxp.venta_anual_$*100/
			(SELECT SUM(venta_anual_$) AS venta_anual_total_$
			FROM vw_ventas_anual_x_prod), 4)
		AS poncentaje_venta_anual
FROM vw_ventas_anual_x_prod vvaxp
LEFT JOIN productos p
USING (id_producto)
GROUP BY vvaxp.id_producto
ORDER BY poncentaje_venta_anual DESC
);
