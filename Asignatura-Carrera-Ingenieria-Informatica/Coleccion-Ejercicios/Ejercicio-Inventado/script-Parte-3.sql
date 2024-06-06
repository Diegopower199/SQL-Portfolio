-- ========================================
-- Ejercicio 1
-- Mostrar el nombre de cada producto y fecha de su última compra. El producto ha de aparecer a pesar de que nunca haya sido comprado. 
-- Guardar esta consulta como una VISTA, con el nombre ultima_compra_por_producto.
-- ========================================
CREATE VIEW ultima_compra_por_producto AS
    SELECT 
        producto.Nombre AS nombre_producto,
        MAX(compras_producto.fecha) AS ultima_compra
    FROM
        PRODUCTO producto
            LEFT JOIN
        COMPRAS_PRODUCTO compras_producto ON producto.Codigo_Producto = compras_producto.Codigo_Producto
    GROUP BY producto.Codigo_Producto , producto.Nombre
    ORDER BY producto.Nombre; 

SELECT * FROM ultima_compra_por_producto;



-- ========================================
-- Ejercicio 2
-- Mostrar los datos de los 3 platos que más se venden en la Rosticería.
-- ========================================
SELECT 
    Codigo_Plato, SUM(cantidad) AS total_vendido
FROM
    COMANDA_PLATOS
GROUP BY Codigo_Plato
ORDER BY cantidad DESC
LIMIT 3;



-- ========================================
-- Ejercicio 3
-- Inventar una consulta que contenga un GROUP BY + HAVING + agregación (COUNT).
-- ========================================
SELECT 
    tipo_plato, COUNT(*) AS num_ordenes
FROM
    PLATO
GROUP BY tipo_plato
HAVING COUNT(*) > 3;



-- ========================================
-- Ejercicio 4
-- Inventar una consulta que contenga una combinación externa + ordenación (ORDER BY). 
-- ========================================
SELECT 
    PROVEEDOR.Empresa,
    COUNT(*) AS 'Número de productos',
    SUM(COMPRAS_PRODUCTO.cantidad) AS 'Total Euros'
FROM
    COMPRAS_PRODUCTO
        JOIN
    PROVEEDOR ON COMPRAS_PRODUCTO.NIF = PROVEEDOR.NIF
GROUP BY PROVEEDOR.Empresa;



-- ========================================
-- Ejercicio 5
-- Realizar una consulta que guarde el número de platos ofertados en menú. Guardar la consulta como una vista llamada platos_ofertados. 
-- ========================================
CREATE VIEW platos_ofertados AS
    SELECT 
        tipo_plato, en_menu, COUNT(*) AS num_platos_ofertados
    FROM
        PLATO
    GROUP BY tipo_plato;

SELECT * FROM platos_ofertados;



-- ========================================
-- Ejercicio 6
-- Crear siete VISTAS (una por tipo de plato), que tengan dos columnas: el tipo de plato y el número de platos guardado por tipo. 
-- Sus nombres deberán ser similares al tipo de plato. Ejemplo: La vista entrante mostraría las siguientes columnas Entrantes 2 (por ejemplo) 
-- ========================================
CREATE VIEW entrantes AS
    SELECT 
        'Entrantes' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Entrante';
        
CREATE VIEW sopa AS
    SELECT 
        'Sopa' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Sopa';
        
CREATE VIEW ensalada AS
    SELECT 
        'Ensalada' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Ensalada';
        
CREATE VIEW primer_plato AS
    SELECT 
        'Primer Plato' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Primer Plato';
        
CREATE VIEW segundo_plato AS
    SELECT 
        'Segundo Plato' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Segundo Plato';
        
CREATE VIEW plato_combinado AS
    SELECT 
        'Plato Combinado' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Plato Combinado';
        
CREATE VIEW postres AS
    SELECT 
        'Postre' AS tipo_plato, COUNT(*) AS num_platos
    FROM
        PLATO
    WHERE
        tipo_plato = 'Postre'; 

SELECT * FROM entrantes; 
SELECT * FROM sopa; 
SELECT * FROM ensalada; 
SELECT * FROM primer_plato; 
SELECT * FROM segundo_plato; 
SELECT * FROM plato_combinado; 
SELECT * FROM postres; 



-- ========================================
-- Ejercicio 7
-- Hacer una consulta de UNION que muestre todas las siete vistas anteriores en una sola consulta. Llamarla numero_Platos_porTipo.
-- ========================================
CREATE VIEW numero_Platos_porTipo AS
    SELECT 
        tipo_plato, num_platos
    FROM
        entrantes 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        sopa 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        ensalada 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        primer_plato 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        segundo_plato 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        plato_combinado 
    UNION SELECT 
        tipo_plato, num_platos
    FROM
        postres;

SELECT * FROM numero_Platos_porTipo;



-- ========================================
-- Ejercicio 8
-- Generar automáticamente una nueva tabla resumen a partir de las dos vistas anteriores (platos_ofertados y numero_Platos_portipo).
-- En la tabla se deberán guardar los siguientes campos Tipo de Plato, Número de Platos, % sobre platos ofertados.
-- ========================================
CREATE TABLE resumen_platos (
    tipo_plato VARCHAR(50),
    num_platos INT,
    porcentaje FLOAT
);

INSERT INTO resumen_platos (tipo_plato, num_platos, porcentaje) SELECT np.tipo_plato, np.num_platos, ROUND((np.num_platos / (SELECT SUM(num_platos_ofertados) FROM platos_ofertados)) * 100, 3) AS Porcentaje_sobre_oferta FROM numero_Platos_porTipo np JOIN platos_ofertados po ON np.tipo_plato = po.tipo_plato;

SELECT * FROM resumen_platos;



-- ========================================
-- Ejercicio 9
-- Eliminar los proveedores a los cuales no se les haya comprado productos durante el año en curso.
-- ========================================
DELETE FROM PROVEEDOR 
WHERE
    NIF NOT IN (SELECT DISTINCT
        NIF
    FROM
        COMPRAS_PRODUCTO
    
    WHERE
        YEAR(fecha) = YEAR(CURRENT_DATE()));