-- ========================================
-- Ejercicio 1
-- ========================================
SELECT customerNumber, customerName, city, creditLimit FROM customers ORDER BY creditLimit ASC; 



-- ========================================
-- Ejercicio 2
-- ========================================
SELECT customerNumber, customerName, city, creditLimit FROM customers ORDER BY creditLimit ASC, city DESC; 



-- ========================================
-- Ejercicio 3
-- ========================================
SELECT customerNumber, customerName, city, creditLimit FROM customers WHERE city = 'Nantes' AND country = 'France' ORDER BY customerName; 



-- ========================================
-- Ejercicio 4
-- ========================================
SELECT customerNumber, customerName, city, creditLimit FROM customers WHERE city = 'Nantes' AND creditLimit >= 100000  ORDER BY customerName; 



-- ========================================
-- Ejercicio 5
-- ========================================
SELECT customerName, city FROM customers WHERE city IN ('Madrid', 'Lyon', 'Paris') ORDER BY city; 



-- ========================================
-- Ejercicio 6
-- ========================================
SELECT customerName, creditLimit FROM customers WHERE creditLimit BETWEEN 10000 AND 87000; 



-- ========================================
-- Ejercicio 7
-- ========================================
SELECT customerName, contactLastname FROM customers WHERE contactLastname LIKE 'De%';



-- ========================================
-- Ejercicio 8
-- ========================================
SELECT customerName, CONCAT (contactFirstName, ' ', contactLastname) AS contacto FROM customers WHERE contactLastname LIKE 'De%';



-- ========================================
-- Ejercicio 9
-- ========================================
SELECT DISTINCT(city) FROM customers ORDER BY city ASC LIMIT 7;



-- ========================================
-- Ejercicio 10
-- ========================================
SELECT DISTINCT(country) FROM customers WHERE city <> 'Spain' AND city <> 'France';



-- ========================================
-- Ejercicio 11
-- ========================================
SELECT MIN(creditLimit), MAX(creditLimit) FROM customers;



-- ========================================
-- Ejercicio 12
-- ========================================
SELECT SUM(creditLimit), AVG(creditLimit) FROM customers;



-- ========================================
-- Ejercicio 13
-- ========================================
SELECT COUNT(*), city FROM customers GROUP BY city ORDER BY city;



-- ========================================
-- Ejercicio 14
-- ========================================
SELECT SUM(creditLimit), city FROM customers WHERE salesRepEmployeeNumber > 3 GROUP BY city;



-- ========================================
-- Ejercicio 15
-- ========================================
SELECT SUM(creditLimit) AS total, country FROM customers WHERE salesRepEmployeeNumber >= 5 GROUP BY country HAVING total > 500000;