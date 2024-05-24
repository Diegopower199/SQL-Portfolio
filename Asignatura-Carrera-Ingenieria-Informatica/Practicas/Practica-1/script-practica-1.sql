-- ========================================
-- Ejercicio 1
-- ========================================
USE classicmodels;



-- ========================================
-- Ejercicio 2
-- ========================================
Show tables;



-- ========================================
-- Ejercicio 3
-- ========================================
DESC employees;



-- ========================================
-- Ejercicio 4
-- ========================================
INSERT INTO employees (employeeNumber, lastName, firstName, extension, email, officeCode, reportsTo, jobTitle) values (2, 'Gonzalez', 'Diego', 'x0001', 'diegogs2323#gmail.com', 1, 1002, 'Sales Rep');



-- ========================================
-- Ejercicio 5
-- ========================================
CREATE TABLE typecustomers (
	tipo char(10)
);



-- ========================================
-- Ejercicio 6
-- ========================================
SHOW TABLES;



-- ========================================
-- Ejercicio 7
-- ========================================
ALTER TABLE typecustomers RENAME type_customers;
SHOW TABLES;



-- ========================================
-- Ejercicio 8
-- ========================================
ALTER TABLE type_customers ADD descripcion VARCHAR(55);



-- ========================================
-- Ejercicio 9
-- ========================================
SELECT * FROM type_customers;



-- ========================================
-- Ejercicio 10
-- ========================================
INSERT INTO type_customers (tipo, descripcion) VALUES (1, 'Primer tupla'), (2, 'Segunda tupla'), (3, 'Tercera tupla');
SELECT * FROM type_customers;



-- ========================================
-- Ejercicio 11
-- ======================================== 
CREATE TABLE customers_type_customers (
	tipo char (10),
    customerNumber_aux int NOT NULL, 
    PRIMARY KEY (customerNumber_aux), 
    FOREIGN KEY (customerNumber_aux) REFERENCES customers(customerNumber),
    FOREIGN KEY (tipo) REFERENCES type_customers(tipo)
);



-- ========================================
-- Ejercicio 12
-- ========================================
INSERT INTO customers_type_customers VALUES ('1', 103);



-- ========================================
-- Ejercicio 14
-- ========================================
DROP TABLE customers_type_customers;
DROP TABLE type_customers;