-- ========================================
-- Ejercicio 1
-- ========================================
DELIMITER //
CREATE PROCEDURE SelectPostalCode()
BEGIN
	SELECT * from offices where postalcode LIKE '28%';
END //
DELIMITER ;



-- ========================================
-- Ejercicio 2
-- ========================================
SHOW PROCEDURE STATUS;



-- ========================================
-- Ejercicio 3
-- ========================================
CALL SelectPostalCode();



-- ========================================
-- Ejercicio 4
-- ========================================
DROP PROCEDURE SelectPostalCode;



-- ========================================
-- Ejercicio 5
-- ========================================
DROP PROCEDURE SelectPostalCode;



-- ========================================
-- Ejercicio 6
-- ========================================
DELIMITER //
CREATE PROCEDURE SelectSumAmount(IN numCli INT, OUT total DECIMAL(10,2))
BEGIN
	SELECT SUM(amount) INTO total FROM payments WHERE customerNumber = numCli;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 7
-- ========================================
CALL SelectSumAmount(103, @tot);
SELECT @tot;



-- ========================================
-- Ejercicio 8
-- ========================================
DELIMITER //
CREATE PROCEDURE SumCant()
BEGIN
   DECLARE TOTAL INT DEFAULT 0;
   SELECT SUM(quantityOrdered) INTO total FROM orderLines WHERE orderNumber = 10100;
   SELECT total;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 9
-- ========================================
SHOW PROCEDURE STATUS;



-- ========================================
-- Ejercicio 10
-- ========================================
DELIMITER //
CREATE PROCEDURE RangoVendedor(IN numVen VARCHAR(15), OUT tipo VARCHAR(10))
BEGIN
	DECLARE dato INT DEFAULT 0;
	SELECT max(quantityInStock)
	INTO dato FROM products WHERE productVendor = numVen;
	IF dato < 1000 THEN
		SET tipo = 'Bajo';
        
	ELSEIF dato >= 1000 and dato <= 5000 THEN 
		SET tipo = 'Medio';
        
	ELSE 
		SET tipo = 'Alto';
	END IF;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 11
-- ========================================
CALL Rangovendedor('10100', @tip);
SELECT @tip;



-- ========================================
-- Ejercicio 12
-- ========================================
DELIMITER //
CREATE PROCEDURE LoopFibonacci()
BEGIN
	DECLARE x, y, z INT;
    
    SET x = 0;
    SET y = 1;
    
    SELECT x;
    SELECT y;
    
    loop_label: LOOP
		SET z = x + y;
        IF Z > 55 THEN
			LEAVE loop_label;
		END IF;
        
        SELECT z, ' ';
        SET x = y;
        SET y = z;
        
	END LOOP;
    
END //
DELIMITER ;



-- ========================================
-- Ejercicio 13
-- ========================================
CALL LoopFibonacci();



-- ========================================
-- Ejercicio 14
-- ========================================
DELIMITER //
CREATE PROCEDURE LoadCalendars(ano VARCHAR(255),mes INT)
BEGIN
	DECLARE dia INT DEFAULT 1;
    DECLARE maxdia INT;
    
    IF mes = 1 or mes = 3 or mes = 5 or mes = 7 or mes = 8 or mes = 10 or mes = 12 THEN
		SET maxdia = 31;
        
	ELSEIF mes = 2 THEN 
			SET maxdia = 28;
            
	ELSE 
		SET maxdia = 30;
	END IF;
    
    WHILE dia <= maxdia DO
		SELECT CONCAT (dia,'-',mes,'-',ano);
        SET dia = dia +1;
	END WHILE;
    
END //
DELIMITER ;



-- ========================================
-- Ejercicio 15
-- ========================================
CALL LoadCalendars('2002', 2);



-- ========================================
-- Ejercicio 16
-- ========================================
DELIMITER //
CREATE PROCEDURE RepeatMultiplicar(num INT)

BEGIN
	DECLARE mul INT DEFAULT 1;
    DECLARE result INT;
    
    REPEAT
		SET result = num * mul;
		SELECT CONCAT(num,'*',mul, '=', result);
        SET mul = mul+ 1;
	UNTIL mul > 10
    END REPEAT;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 17
-- ========================================
CALL RepeatMultiplicar (8);



-- ========================================
-- Ejercicio 18
-- ========================================
DELIMITER //
CREATE PROCEDURE createCommentList()
	
    BEGIN
		DECLARE finished INTEGER DEFAULT 0;
        DECLARE resultado VARCHAR(10000) DEFAULT "";
        DECLARE com varchar(4000);
        
        DECLARE curComments CURSOR FOR
				SELECT comments FROM orders;
                
		DECLARE CONTINUE HANDLER
        
        FOR NOT FOUND SET finished = 1;
        
        OPEN curComments;
        
        getComment: LOOP
			FETCH curComments INTO com;
            IF finished = 1 THEN
				LEAVE getComment;
			END IF;
            
            IF ISNULL(com) = 0 THEN
				SET resultado = CONCAT(com,'-',resultado);
			END IF;
            
            END LOOP getComment;
            CLOSE curComments;
            SELECT resultado;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 19
-- ========================================
CALL createCommentList();