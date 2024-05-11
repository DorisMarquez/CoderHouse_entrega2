
-- FUNCIONES

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

-- Función 1: Función para obtener el total de entradas de un producto


DROP FUNCTION IF EXISTS fn_1_total_entradas;

DELIMITER //
CREATE FUNCTION fn_1_total_entradas(id_prod INT ) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT SUM(cantidad) INTO total FROM detalle_entradas WHERE id_producto = id_prod;
RETURN total;
END //
DELIMITER ;


/**************************************************************************************************************/

-- Función 2: Función para obtener el total de salidas de un producto


DROP FUNCTION IF EXISTS fn_2_total_salidas;

DELIMITER //
CREATE FUNCTION fn_2_total_salidas(id_prod INT) RETURNS INT
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT SUM(cantidad) INTO total FROM detalle_salidas WHERE id_producto = id_prod;
RETURN total;
END //
DELIMITER ;


/**************************************************************************************************************/

-- Función 3: para actualizar el valor del ultimo precio de un producto en la tabla inventario cuando se ingresa una entrada

DROP FUNCTION IF EXISTS fn_3_actualizar_ultimo_precio;

DELIMITER //
CREATE FUNCTION fn_3_actualizar_ultimo_precio(id_prod INT) RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE ultimo_precio DECIMAL(10, 2);
    SELECT precio_compra_$ INTO ultimo_precio FROM detalle_entradas WHERE id_producto = id_prod AND id_entrada = (SELECT MAX(id_entrada) FROM detalle_entradas WHERE id_producto = id_prod);
    RETURN ultimo_precio;
END //
DELIMITER ;


/**************************************************************************************************************/

-- Función 4: Función para obtener el valor total del inventario


DROP FUNCTION IF EXISTS fn_4_valor_total_inventario;

DELIMITER //
CREATE FUNCTION fn_4_valor_total_inventario() RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
DECLARE total INT;
SELECT SUM(stock * ultimo_precio_$) INTO total FROM inventario;
RETURN total;
END //
DELIMITER ;

/**************************************************************************************************************/
