-- ========================================
-- Ejercicio 1
-- ========================================
SELECT firstName, lastName FROM employees UNION SELECT contactFirstName, contactLastName FROM customers ORDER BY lastName, firstName;



-- ========================================
-- Ejercicio 2
-- ========================================
CREATE TABLE empleadosclientes (
	nombre VARCHAR(55),
	apellido VARCHAR(55)
);



-- ========================================
-- Ejercicio 3
-- ========================================
INSERT INTO empleadosclientes SELECT firstName, lastName FROM employees UNION SELECT contactFirstName, contactLastName FROM customers ORDER BY lastName, firstName; 



-- ========================================
-- Ejercicio 4
-- ========================================
SELECT * FROM empleadosclientes;



-- ========================================
-- Ejercicio 5
-- ========================================
SELECT * FROM empleadosclientes INNER JOIN employees ON empleadosclientes.nombre = employees.firstName AND empleadosclientes.apellido = employees.lastName;



-- ========================================
-- Ejercicio 6
-- ========================================
UPDATE empleadosclientes INNER JOIN customers ON empleadosclientes.nombre = customers.contactFirstName AND empleadosclientes.apellido = customers.contactLastName SET nombre = 'Contacto', apellido = 'Contacto';



-- ========================================
-- Ejercicio 7
-- ========================================
SELECT * FROM empleadosclientes;



-- ========================================
-- Ejercicio 8
-- ======================================== 
SELECT customerName, checkNumber FROM customers LEFT JOIN payments ON customers.customerNumber = payments.customerNumber;



-- ========================================
-- Ejercicio 9
-- ========================================
SELECT customerNumber, orderNumber 
FROM orders
RIGHT JOIN customers
ON customers.customerNumber = orders.customerNumber;

SELECT * FROM orders RIGHT JOIN customers ON customers.customerNumber = orders.customerNumber;



-- ========================================
-- Ejercicio 10
-- ========================================
SELECT CONCAT (m.firstName, ' ', m.lastName) AS "Manager", CONCAT (e.firstName, ' ', e.lastName) AS "Direct report" FROM employees e INNER JOIN employees m ON m.employeeNumber = e.reportsTo; 



-- ========================================
-- Ejercicio 11
-- ========================================
SELECT CONCAT (m.firstName, ' ', m.lastName) AS "Jefe", CONCAT (e.firstName, ' ', e.lastName) AS "Subordinado" FROM employees e INNER JOIN employees m ON m.employeeNumber = e.reportsTo; 



-- ========================================
-- Ejercicio 12
-- ========================================
SELECT lastName FROM employees WHERE lastName IN (SELECT contactLastName FROM customers WHERE contactLastName = lastName);



-- ========================================
-- Ejercicio 13
-- ========================================
SELECT productName FROM products WHERE EXISTS (SELECT 1 FROM orderdetails WHERE orderdetails.productCode = products.productCode AND quantityOrdered > 20);



-- ========================================
-- Ejercicio 14
-- ========================================
SELECT productName FROM products WHERE productCode = ANY (SELECT productCode FROM orderdetails WHERE quantityOrdered > 20);
/*
-------------------------------------------------------------------------------------------------------------------------------------------------
|  DEFINICIÓN DE ANY y ALL:                                                                                                                     |
|  ANY: El operador ANY devuelve verdadero si alguno de los valores de subconsulta cumple la condición.                                         |
|  ALL: El operador ALL selecciona los valores si todos los registros de subconsulta cumplen la condición.                                      |                                                                                                                                              |
|-----------------------------------------------------------------------------------------------------------------------------------------------|                                                                                                                                            |
|  Esto es una aclaracion de que hace ALL. Aqui si lo ponemos en MYSQL no va a salir ninguna consulta ya que algunas consultas son iguales a 20,| 
|  y la funcion ALL debe cumplir que todos los valores sean superior a 20     .                                                                 |  
|  SELECT productName FROM products WHERE productCode = All (SELECT productCode FROM orderdetails WHERE quantityOrdered > 20);                  |
-------------------------------------------------------------------------------------------------------------------------------------------------
*/



-- ========================================
-- Ejercicio 15
-- ========================================
CREATE TABLE emp1 (
	employeeNumber INT NOT NULL,
  lastName VARCHAR(50) NOT NULL,
  firstName VARCHAR(50) NOT NULL
);

INSERT INTO emp1 SELECT customerNumber, contactLastName, contactFirstName FROM customers WHERE country ='USA';



-- ========================================
-- Ejercicio 16
-- ========================================
UPDATE employees INNER JOIN offices ON employees.officeCode = offices.officeCode SET employees.extension = offices.territory;



-- ========================================
-- Ejercicio 17
-- ========================================
DELETE customers FROM customers LEFT JOIN orders ON customers.customerNumber = orders.customerNumber WHERE orderNumber IS NULL;



-- ========================================
-- Ejercicio 18
-- ========================================
-- Apartado a
CREATE TABLE edificios (
	numedif INT,
    PRIMARY KEY (numedif) 
);


-- Apartado b
INSERT INTO edificios values (1), (2), (3);


-- Apartado c
CREATE TABLE puertas (
	numpuerta INT NOT NULL,
    numedif INT NOT NULL,
    PRIMARY KEY (numpuerta),
    FOREIGN KEY (numedif) REFERENCES edificios(numedif) ON DELETE CASCADE
);


-- Apartado d
INSERT INTO puertas values (1, 1), (2, 1), (3, 1), (4, 1), (5, 2), (6, 3);


-- Apartado e
DELETE FROM edificios WHERE numedif = 1;
SELECT * FROM puertas;