-- ========================================
-- Ejercicio 1
-- ========================================
CREATE VIEW vista1 AS SELECT offices.officeCode, offices.city, offices.country, employees.firstName, employees.lastName FROM offices, employees where offices.officeCode = employees.officeCode ORDER BY offices.officeCode;



-- ========================================
-- Ejercicio 2
-- ========================================
SHOW FULL TABLES;

SHOW FULL TABLES WHERE table_type = 'VIEW';
SELECT * FROM vista1;



-- ========================================
-- Ejercicio 3
-- ========================================
CREATE VIEW vista2 AS SELECT COUNT(*), city FROM vista1 GROUP BY city;



-- ========================================
-- Ejercicio 4
-- ========================================
SHOW FULL TABLES;
SHOW FULL TABLES WHERE table_type = 'VIEW';
SELECT * FROM vista2;



-- ========================================
-- Ejercicio 5
-- ========================================
CREATE or REPLACE VIEW vista2 AS SELECT COUNT(*) AS 'Cantidad', city as 'Ciudad' FROM vista1 GROUP BY city;



-- ========================================
-- Ejercicio 6
-- ========================================
CREATE VIEW vista AS SELECT customerNumber, amount FROM payments;



-- ========================================
-- Ejercicio 7
-- ========================================
UPDATE vista3 SET amount = 0.0 WHERE customerNumber = 103;



-- ========================================
-- Ejercicio 8
-- ========================================
SELECT * FROM payments;
SELECT * FROM vista3;



-- ========================================
-- Ejercicio 9
-- ========================================
DELETE FROM vista3 WHERE customerNumber = 124;



-- ========================================
-- Ejercicio 10
-- ========================================
SELECT * FROM vista3;



-- ========================================
-- Ejercicio 11
-- ========================================
CREATE VIEW vista4 AS SELECT * FROM payments WHERE amount > 1000 WITH CHECK OPTION;



-- ========================================
-- Ejercicio 12
-- ========================================
INSERT INTO vista4 (customerNumber, checkNumber, paymentDate, amount) VALUES (112, 'GG31455', '2004-12-17', 900);



-- ========================================
-- Ejercicio 13
-- ========================================
INSERT INTO vista4 (customerNumber, checkNumber, paymentDate, amount) VALUES (112, 'GG31455', '2004-12-17', 1100);



-- ========================================
-- Ejercicio 14
-- ========================================
SELECT * FROM payments;
SELECT * FROM vista4;



-- ========================================
-- Ejercicio 15
-- ========================================
SHOW FULL TABLES WHERE table_type = 'VIEW';



-- ========================================
-- Ejercicio 16
-- ========================================
RENAME TABLE vista4 TO vista5;



-- ========================================
-- Ejercicio 17
-- ========================================
DROP VIEW IF EXISTS vista5;