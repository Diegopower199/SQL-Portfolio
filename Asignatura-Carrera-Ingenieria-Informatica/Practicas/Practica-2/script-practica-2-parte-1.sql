-- ========================================
-- Ejercicio 1
-- ========================================
SELECT * FROM empleado;



-- ========================================
-- Ejercicio 2
-- ========================================
SELECT id_empleado AS ie FROM empleado;
SELECT nombre_empleado AS ne FROM empleado;
SELECT numero_telefono AS nt FROM empleado;
SELECT fecha_contratacion AS fc FROM empleado;
SELECT * FROM empleado;



-- ========================================
-- Ejercicio 3
-- ========================================
SELECT COUNT(*) FROM empleado;



-- ========================================
-- Ejercicio 4
-- ========================================
SELECT * FROM empleado WHERE numero_telefono IS NULL;



-- ========================================
-- Ejercicio 5
-- ========================================
SELECT * FROM empleado WHERE numero_telefono IS NOT NULL;



-- ========================================
-- Ejercicio 6
-- ========================================
UPDATE empleado set numero_telefono = '616741711';
SELECT * FROM empleado;



-- ========================================
-- Ejercicio 7
-- ========================================
DELETE FROM empleado;