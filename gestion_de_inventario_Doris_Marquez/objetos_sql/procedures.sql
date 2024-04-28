-- PROCEDIMIENTOS

--  procedimiento que permita poblar la tabla fechas_semanales del periodo correspondiente

DROP PROCEDURE IF EXISTS sp_populate_fechas_semanales;

DELIMITER //
CREATE PROCEDURE sp_populate_fechas_semanales()
BEGIN
    DECLARE fecha_actual DATE;
    DECLARE fecha_fin DATE;
    DECLARE delta INT;

    SET fecha_actual = CURDATE();
    SET fecha_fin = fecha_actual - INTERVAL 365 DAY;
    SET delta = 7;

    WHILE fecha_actual >= fecha_fin DO
        INSERT INTO fechas_semanales (fecha_semanal) VALUES (fecha_actual);
        SET fecha_actual = fecha_actual - INTERVAL delta DAY;
    END WHILE;
END //
DELIMITER ;

-- Ejecuta el procedimiento para poblar la tabla
CALL sp_populate_fechas_semanales();
