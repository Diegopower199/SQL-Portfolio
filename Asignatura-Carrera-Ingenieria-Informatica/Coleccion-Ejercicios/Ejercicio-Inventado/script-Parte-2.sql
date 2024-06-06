-- ========================================
-- Ejercicio 1
-- Indicar el número de productos elaborados registrados en la Base de Datos.
-- ========================================
SELECT 
    COUNT(*) AS 'Elaborados'
FROM
    PRODUCTO
WHERE
    tipoProducto = 'Elaborado';



-- ========================================
-- Ejercicio 2
-- Listar todos los productos ordenados por alergeno y nombre del producto.
-- ========================================
SELECT 
    producto.Nombre, alergeno.Alergeno
FROM
    PRODUCTO producto
        LEFT JOIN
    ALERGENOS_PRODUCTO alergeno_producto ON producto.Codigo_Producto = alergeno_producto.Codigo_Producto
        LEFT JOIN
    ALERGENO alergeno ON alergeno_producto.Alergeno = alergeno.Alergeno
ORDER BY alergeno.Alergeno , producto.Nombre;



-- ========================================
-- Ejercicio 3
-- Mostrar una lista de productos ordenada por el nombre de la categoría, y el nombre del producto, que muestre además códigos de categoría y producto, precio_compra, porcentaje_iva  y  coste_total.
-- ========================================
SELECT 
    CATEGORIA.idCategoria AS 'Codigo de Categoria',
    CATEGORIA.Categoria AS 'Nombre de Categoría',
    PRODUCTO.Codigo_Producto AS 'Código de Producto',
    PRODUCTO.Nombre AS 'Nombre de Producto',
    PRODUCTO.PVP AS 'Precio de Compra',
    PRODUCTO.porcentaje_IVA AS 'Porcentaje de IVA',
    PRODUCTO.Precio_Final AS 'Precio Final'
FROM
    PRODUCTO
        INNER JOIN
    CATEGORIA ON PRODUCTO.idCategoria = CATEGORIA.idCategoria
ORDER BY CATEGORIA.Categoria , PRODUCTO.Nombre;



-- ========================================
-- Ejercicio 4
-- Mostrar todos los proveedores que pertenecen a la categoría 'Especias', incluyendo los detalles de la categoría a la que pertenecen.
-- ========================================
SELECT 
    *
FROM
    PROVEEDOR
        INNER JOIN
    CATEGORIA ON PROVEEDOR.idCategoria = CATEGORIA.idCategoria
WHERE
    CATEGORIA.Categoria = 'Especias';



-- ========================================
-- Ejercicio 5
-- Listar las compras realizadas durante el mes en curso.
-- ========================================
SELECT 
    *
FROM
    COMPRAS_PRODUCTO
WHERE
    DAY(fecha) = DAY(CURRENT_DATE())
        AND MONTH(fecha) = MONTH(CURRENT_DATE())
        AND YEAR(fecha) = YEAR(CURRENT_DATE());



-- ========================================
-- Ejercicio 6
-- Indicar el número de Entrantes registrados.
-- ========================================
SELECT 
    COUNT(*) AS 'Numero entrantes'
FROM
    PLATO
WHERE
    tipo_plato = 'Entrante';



-- ========================================
-- Ejercicio 7
-- Mostrar aquellos proveedores cuyo teléfono comience por 93.
-- ========================================
SELECT 
    *
FROM
    PROVEEDOR
WHERE
    telefonos LIKE '93%';



-- ========================================
-- Ejercicio 8
-- Mostrar los productos que no contengan alérgenos.
-- ========================================
SELECT 
    *
FROM
    ALERGENOS_PRODUCTO
WHERE
    Alergeno = 'Ninguno';



-- ========================================
-- Ejercicio 9
-- Reportar el total de compras en € realizadas a cada proveedor. La consulta deberá tener los siguientes campos: Empresa, Número de productos y Total Euros.
-- ========================================
SELECT 
    PROVEEDOR.Empresa,
    COUNT(*) AS 'Número de productos',
    SUM(COMPRAS_PRODUCTO.precio) AS 'Total Euros'
FROM
    COMPRAS_PRODUCTO
        JOIN
    PROVEEDOR ON COMPRAS_PRODUCTO.NIF = PROVEEDOR.NIF
GROUP BY PROVEEDOR.Empresa;



-- ========================================
-- Ejercicio 10
-- Indicar la cantidad de productos de cada categoría.
-- ========================================
SELECT 
    CATEGORIA.Categoria, COUNT(*) AS 'Cantidad de productos'
FROM
    PRODUCTO
        JOIN
    CATEGORIA ON PRODUCTO.idCategoria = CATEGORIA.idCategoria
GROUP BY CATEGORIA.Categoria;



-- ========================================
-- Ejercicio 11
-- Indicar cuántos productos elaborados no se están ofertando en Menú.
-- ========================================
SELECT 
    COUNT(*) AS 'Cantidad de productos no ofertados en menú'
FROM
    PLATO
WHERE
    en_menu = 'No';



-- ========================================
-- Ejercicio 12
-- Mostrar la oferta de tipos de producto por proveedor (contar cuántos tipos de productos diferentes puede ofrecer cada proveedor)
-- ========================================
SELECT 
    PROVEEDOR.Empresa,
    COUNT(DISTINCT PRODUCTO.idCategoria) AS 'Cantidad de tipos de producto'
FROM
    PROVEEDOR
        JOIN
    COMPRAS_PRODUCTO ON PROVEEDOR.NIF = COMPRAS_PRODUCTO.NIF
        JOIN
    PRODUCTO ON PRODUCTO.Codigo_Producto = COMPRAS_PRODUCTO.Codigo_Producto
GROUP BY PROVEEDOR.Empresa;



-- ========================================
-- Ejercicio 13
-- Formular una consulta que tenga una agrupación con Group By.
-- ========================================
SELECT 
    tipo_plato AS 'Tipo Plato', COUNT(*) AS 'Numero entrantes'
FROM
    PLATO
GROUP BY tipo_plato;



-- ========================================
-- Ejercicio 14
-- Formular una consulta que tenga una agrupación con Group By y un filtraje con Having.
-- ========================================
SELECT 
    tipo_plato AS 'Tipo Plato', COUNT(*) AS 'Numero entrantes'
FROM
    PLATO
GROUP BY tipo_plato
HAVING COUNT(*) > 2;



-- ========================================
-- Ejercicio 15
-- Actualizar el campo tipo_Plato. Se deberá agregar el valor Primer Plato a todos aquellos platos que sean Entrantes o Sopas.
-- ========================================
UPDATE PLATO 
SET 
    tipo_plato = 'Primer Plato'
WHERE
    tipo_plato IN ('Entrante' , 'Sopas');



-- ========================================
-- Ejercicio 16
-- Cambiar la fecha de caducidad de los productos, sumándole 7 días.
-- ========================================
/*Hacer lo siguiente para que funcione
------------------------------------------------------------------------------------
|    Go to Edit --> Preferences                                                    |
|    Click "SQL Editor" tab and uncheck "Safe Updates" check box                   |
|    Query --> Reconnect to Server // logout and then login                        |
------------------------------------------------------------------------------------
*/
UPDATE COMPRAS_PRODUCTO 
SET 
    caducidad = DATE_ADD(caducidad, INTERVAL 7 DAY);



-- ========================================
-- Ejercicio 17
-- Actualizar el PVP de los platos, aumentando en un 3%.
-- ========================================
UPDATE PLATO 
SET 
    PVP = ROUND(PVP * 1.03, 2);



-- ========================================
-- Ejercicio 18
-- Eliminar aquellas CATEGORÍAS que no tengan PROVEEDORES.
-- ========================================
ALTER TABLE PROVEEDOR ADD CONSTRAINT fk_proveedores_categorias FOREIGN KEY (idCategoria) REFERENCES CATEGORIA(idCategoria) ON DELETE CASCADE;

SET FOREIGN_KEY_CHECKS=0;
 
DELETE FROM CATEGORIA 
WHERE
    NOT EXISTS( SELECT 
        *
    FROM
        PROVEEDOR
    
    WHERE
        PROVEEDOR.idCategoria = CATEGORIA.idCategoria);

SET FOREIGN_KEY_CHECKS=1;