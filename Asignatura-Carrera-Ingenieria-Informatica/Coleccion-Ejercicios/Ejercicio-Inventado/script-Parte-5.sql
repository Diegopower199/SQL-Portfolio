-- ========================================
-- Ejercicio 1
-- Crear una función que devuelva el día de la semana (en letras: Lunes... Domingo) en el cual hay más comandas. 
-- ========================================
DROP FUNCTION IF EXISTS dia_semana_con_mas_comandas ;

DELIMITER //
CREATE FUNCTION dia_semana_con_mas_comandas()
RETURNS VARCHAR(10)
BEGIN
    DECLARE dia VARCHAR(10);
    
    SELECT CASE DAYOFWEEK(Fecha)
        WHEN 1 THEN 'Domingo'
        WHEN 2 THEN 'Lunes'
        WHEN 3 THEN 'Martes'
        WHEN 4 THEN 'Miércoles'
        WHEN 5 THEN 'Jueves'
        WHEN 6 THEN 'Viernes'
        WHEN 7 THEN 'Sábado'
    END INTO dia
    FROM COMANDA
    GROUP BY Fecha
    ORDER BY COUNT(*) DESC
    LIMIT 1;
    
    RETURN dia;
END //
DELIMITER ;

SELECT dia_semana_con_mas_comandas();



-- ========================================
-- Ejercicio 2
-- Crear una función que reciba por parámetro un tipo de plato  y devuelva el número de platos que hay de ese tipo.
-- ========================================
DROP FUNCTION IF EXISTS cantidad_platos_por_tipo;

DELIMITER //
CREATE FUNCTION cantidad_platos_por_tipo(tipo_plato VARCHAR(50))
RETURNS INTEGER
BEGIN
	DECLARE cantidad INTEGER;
    SELECT COUNT(*) INTO cantidad
    FROM PLATO
    WHERE PLATO.tipo_plato = tipo_plato;
    
    RETURN cantidad;
END //
DELIMITER ;

SELECT cantidad_platos_por_tipo("Primer Plato");
SELECT cantidad_platos_por_tipo("Ensalada");
SELECT cantidad_platos_por_tipo("Postre");



-- ========================================
-- Ejercicio 3
-- Crear una función que reciba por parámetro el código de un plato y devuelva si el plato tiene o no alergenos.
-- ========================================
DELIMITER //
CREATE FUNCTION tiene_alergenos(codigo_plato INT) RETURNS BOOLEAN
BEGIN
    DECLARE num_alergenos INT;
    SET num_alergenos = (SELECT COUNT(*) FROM ALERGENOS_PRODUCTO WHERE Codigo_Producto = codigo_plato);
    IF num_alergenos > 0 THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END //
DELIMITER ;

SELECT tiene_alergenos(1) AS tiene_alergenos_plato;



-- ========================================
-- Ejercicio 4
-- Crear un procedimiento almacenado que, utilizando la vista ultima_compra_por_producto del producto 3,  actualice el campo precio_compra de cada producto basado en el último precio de compra.
-- ========================================
DELIMITER //
CREATE PROCEDURE actualizar_precio_compra()
BEGIN
    UPDATE PRODUCTO
    SET precio_compra = ultima_compra_por_producto.ultimo_precio
    WHERE productos.Nombre = ultima_compra_por_producto.nombre_producto AND productos.Codigo_Producto = 3;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 5
-- Crear un procedimiento almacenado que cree una nueva tabla donde se guarden los productos próximos a caducar (con una semana de margen).
-- ========================================
DELIMITER //
CREATE PROCEDURE productos_proximos_a_caducar()
BEGIN
    CREATE TABLE IF NOT EXISTS productos_caducando AS
        SELECT *
        FROM COMPRAS_PRODUCTO
        WHERE caducidad BETWEEN CURRENT_DATE() AND CURRENT_DATE() + INTERVAL 7 DAY;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 6
-- Inventar una función que brinde algún tipo de información sobre las ventas del día.
-- ========================================
DELIMITER //
CREATE FUNCTION ventas_del_dia(fecha DATE) RETURNS FLOAT
BEGIN
    DECLARE total FLOAT;
    SELECT SUM(PVP) INTO total  FROM COMANDA INNER JOIN COMANDA_ELABORADOS ON COMANDA.id_Comanda = COMANDA_ELABORADOS.id_Comanda WHERE DATE(Fecha) = fecha;
    SELECT SUM(PVP) INTO total  FROM COMANDA INNER JOIN COMANDA_PLATOS ON COMANDA.id_Comanda = COMANDA_PLATOS.id_Comanda WHERE DATE(Fecha) = fecha;
    RETURN total;
END //
DELIMITER ;

SELECT ventas_del_dia('2023-03-12') AS total_ventas;



-- ========================================
-- Ejercicio 7
-- Inventar un procedimiento almacenado que tenga un parámetro de entrada.
-- ========================================
DELIMITER //
CREATE PROCEDURE obtener_plato_por_producto(IN codigo_producto_parametro VARCHAR(45))
BEGIN
    SELECT *
    FROM plato
    WHERE Codigo_Producto = codigo_producto_parametro;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 8
-- Crear un disparador que, al realizar el registro en la tabla comanda_elaborados, verifique que el tipoProducto sea Elaborado efectivamente y si no, muestra un mensaje de error.
-- ========================================
DELIMITER //
CREATE TRIGGER trigger_comanda_elaborados
BEFORE INSERT ON COMANDA_ELABORADOS
FOR EACH ROW
BEGIN
    IF PRODUCTO.tipoProducto <> 'Elaborado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de producto debe ser Elaborado';
    END IF;
END //
DELIMITER ;



-- ========================================
-- Ejercicio 9
-- Crear un disparador que, al realizar la compra de un producto, actualice el precio de compra en la tabla Producto.
-- ========================================
DELIMITER //
CREATE TRIGGER trigger_comanda_elaborados
BEFORE INSERT ON COMANDA_ELABORADOS
FOR EACH ROW
BEGIN
    IF NEW.PRODUCTO.tipoProducto <> 'Elaborado' THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'El tipo de producto debe ser Elaborado';
    END IF;
END //
DELIMITER ;
