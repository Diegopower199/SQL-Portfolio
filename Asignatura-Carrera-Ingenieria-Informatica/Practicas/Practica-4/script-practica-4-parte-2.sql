-- ========================================
-- Ejercicio 1
-- ========================================
SHOW INDEXES FROM offices;
SHOW INDEXES FROM offices IN classicmodels;



-- ========================================
-- Ejercicio 2
-- ========================================
EXPLAIN SELECT* FROM offices WHERE country = 'France';
/*
---------------------------------------------------------------------------------
|SELECT te da el resultado y EXPLAIN te explica de donde lo coge y como lo coge.|
|SELECT * FROM offices where country = 'France';                                |
---------------------------------------------------------------------------------
*/



-- ========================================
-- Ejercicio 3
-- ========================================
CREATE INDEX idx_country ON offices (country);



-- ========================================
-- Ejercicio 4
-- ========================================
SHOW INDEXES FROM offices IN classicmodels;



-- ========================================
-- Ejercicio 5
-- ========================================
EXPLAIN SELECT* FROM offices WHERE country = 'France';



-- ========================================
-- Ejercicio 6
-- ========================================
DROP INDEX idx_country ON offices;



-- ========================================
-- Ejercicio 7
-- ========================================
CREATE TABLE t (
   pk INT,
   c VARCHAR(50),
   PRIMARY KEY (pk)
);



-- ========================================
-- Ejercicio 8
-- ========================================
DROP INDEX `PRIMARY` ON t;



-- ========================================
-- Ejercicio 9
-- ========================================
CREATE UNIQUE INDEX idx_productName ON products (productName);



-- ========================================
-- Ejercicio 10
-- ========================================
INSERT INTO products (productCode, productName) VALUES ('500_000', '18th century shooner');



-- ========================================
-- Ejercicio 11
-- ========================================
-- Primera forma de hacerlo
CREATE TABLE h (
    pk INT PRIMARY KEY AUTO_INCREMENT,
    c VARCHAR(10),
    d VARCHAR (10),
    INDEX (c ASC, d DESC)
);	

-- Segunda forma de hacerlo
/*CREATE TABLE h (
    pk INT PRIMARY KEY AUTO_INCREMENT,
    c VARCHAR(10),
    d VARCHAR (10)
);
CREATE INDEX idx_c_d ON h (c ASC, d DESC);*/



-- ========================================
-- Ejercicio 12
-- ========================================
INSERT INTO h (c, d) VALUES ('z', 'a'), ('b', 'f'), ('hhh', 'jj'), ('b', 'zz'), ('gg', 'bb');



-- ========================================
-- Ejercicio 13
-- ========================================
SELECT * FROM h;