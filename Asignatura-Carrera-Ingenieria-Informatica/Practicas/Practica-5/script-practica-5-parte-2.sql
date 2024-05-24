-- ========================================
-- Ejercicio 1
-- ========================================
DELIMITER // 
CREATE TRIGGER before_offices_insert BEFORE INSERT ON offices FOR EACH ROW
    
    BEGIN
    
    IF ISNULL(new.phone) = 1 THEN
        SIGNAL SQLSTATE '45000' SET message_text = 'El atributo phone debe contener un valor (no nulo)';
    END IF;
    
END //
DELIMITER ;



-- ========================================
-- Ejercicio 2
-- ========================================
INSERT INTO offices VALUES ('2', 'a', null, 'a', 'a', 'a', 'a', 'a', 'a');



-- ========================================
-- Ejercicio 3
-- ========================================
DELIMITER // 
CREATE TRIGGER before_offices_delete BEFORE DELETE ON offices FOR EACH ROW

	BEGIN
    SET @total =  (SELECT COUNT(*) FROM employees WHERE officeCode = old.officeCode);
    
    IF (@total > 0) THEN
		SIGNAL SQLSTATE '45000' SET message_text = 'La oficina no se puede borrar porque existen empleados que pertenecen a esa oficina';
	END IF;
    
END //
DELIMITER ;



-- ========================================
-- Ejercicio 4
-- ========================================
DELETE FROM offices WHERE officeCode  = '1';



-- ========================================
-- Ejercicio 5
-- ========================================
#Table
CREATE TABLE officesChanges (
	id INT AUTO_INCREMENT,
    officeCode VARCHAR(55),
    oldCity VARCHAR(55),
    newCity VARCHAR(55),
    PRIMARY KEY (id)
);


#Trigger
DELIMITER //
CREATE TRIGGER after_offices_update AFTER UPDATE ON offices FOR EACH ROW
BEGIN
    IF OLD.city <> NEW.city THEN
        INSERT INTO officesChanges (officeCode, oldCity, newCity)
        VALUES (NEW.officeCode, OLD.city, NEW.city);
    END IF;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 6
-- ========================================
UPDATE offices SET city = 'Tokyo' WHERE city = 'Madrid';



-- ========================================
-- Ejercicio 7
-- ========================================
SHOW TRIGGERS;



-- ========================================
-- Ejercicio 8
-- ========================================
DROP TRIGGER before_offices_insert;
DROP TRIGGER after_offices_update;
DROP TRIGGER before_offices_delete;