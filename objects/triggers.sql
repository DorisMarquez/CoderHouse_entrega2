
-- TRIGGERS

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

-- Trigger 1: Trigger para actualizar el total de entradas en la tabla inventario después de registrar una entradas en la tabla detalle_entradas

DROP TRIGGER IF EXISTS tr_actualizar_total_entradas;

DELIMITER //
CREATE TRIGGER tr_actualizar_total_entradas AFTER INSERT ON detalle_entradas
FOR EACH ROW
BEGIN
UPDATE inventario 
SET total_entradas = fn_1_total_entradas(NEW.id_producto) WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;

/**************************************************************************************************************/

-- Trigger 2: Trigger para actualizar el total de salidas en la tabla inventario cuando se registra una salida en la tabla detalle_salidas

DROP TRIGGER IF EXISTS tr_actualizar_total_salidas;

DELIMITER //
CREATE TRIGGER tr_actualizar_total_salidas AFTER INSERT ON detalle_salidas
FOR EACH ROW
BEGIN
UPDATE inventario SET total_salidas = fn_2_total_salidas(NEW.id_producto) WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;


/**************************************************************************************************************/

-- Trigger 3: Trigger para actualizar el último precio de un producto en la tabla inventario cuando se registra una entrada en la tabla detalle_entradas

DROP TRIGGER IF EXISTS tr_actualizar_ultimo_precio;

DELIMITER //
CREATE TRIGGER tr_actualizar_ultimo_precio AFTER INSERT ON detalle_entradas
FOR EACH ROW
BEGIN
UPDATE inventario SET ultimo_precio_$ = fn_3_actualizar_ultimo_precio(NEW.id_producto) WHERE id_producto = NEW.id_producto;
END //
DELIMITER ;




/**************************************************************************************************************/

