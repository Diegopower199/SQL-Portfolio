-- ========================================
-- Ejercicio 1
-- Crear el usuario administrador llamado admin, que tendrá todos los privilegios sobre la base de datos de nuestro proyecto.
-- ========================================
DROP USER 'administrador'@'localhost'; 

CREATE USER 'administrador'@'localhost' IDENTIFIED BY 'admin'; 

GRANT ALL PRIVILEGES ON icxo_p3_22_local.* TO 'administrador'@'localhost'; 



-- ========================================
-- Ejercicio 2
-- El usuario administrador crea 2 usuarios más, uno llamado ‘encargado’ y el otro llamado ‘camarero’. 
-- ========================================
DROP USER 'encargado'@'localhost'; 

CREATE USER 'encargado'@'localhost' IDENTIFIED BY 'contraseña_encargado'; 

GRANT ALL PRIVILEGES ON icxo_p3_22_local.* TO 'encargado'@'localhost' WITH GRANT OPTION; 

FLUSH PRIVILEGES; 

DROP USER 'camarero'@'localhost'; 

CREATE USER 'camarero'@'localhost' IDENTIFIED BY 'contraseña_camarero'; 

GRANT ALL PRIVILEGES ON icxo_p3_22_local.* TO 'camarero'@'localhost' WITH GRANT OPTION; 

FLUSH PRIVILEGES; 



-- ========================================
-- Ejercicio 3
-- A partir de los dos usuarios nuevos creados por el administrador, pensar y dar los privilegios que creas oportunos sobre las tablas y atributos de la base de datos. Justificar la respuesta. 
-- ========================================
GRANT SELECT, INSERT, UPDATE, DELETE ON proveedor TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON categoria TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON producto TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON alergeno TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON alergenos_producto TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON compras_producto TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON donaciones TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON detalle_donacion TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON plato TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON productos_plato TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON comanda_platos TO 'encargado'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT, UPDATE, DELETE ON comanda_elaborados TO 'encargado'@'localhost';
FLUSH PRIVILEGES;

GRANT SELECT ON proveedor TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON categoria TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON producto TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON productos_plato TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON alergenos_producto TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON compras_producto TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON donaciones TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON detalle_donacion TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON plato TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT ON productos_plato TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT ON comanda_platos TO 'camarero'@'localhost';
FLUSH PRIVILEGES;
GRANT SELECT, INSERT ON comanda_elaborados TO 'camarero'@'localhost';
FLUSH PRIVILEGES;

/*
Justificación: 
El usuario "encargado" tendría acceso completo a todas las tablas, lo que le permitiría realizar tareas administrativas y de gestión, como agregar o eliminar proveedores y productos, actualizar los precios y las categorías, y revisar las donaciones y las compras.
El usuario "camarero" tendría acceso de solo lectura a todas las tablas, excepto a las tablas "COMANDA_PLATOS" y "COMANDA_ELABORADOS", en las que tendría permisos de INSERT y SELECT. Esto le permitiría registrar y actualizar los pedidos de los clientes, pero no hacer cambios en otras áreas de la base de datos.
*/



-- ========================================
-- Ejercicio 4
-- Realizar una tabla ACL (Access Control Lists) con control de acceso discrecional (DAC), dónde pueda verse la distribución de privilegios para cada usuario: 
-- ========================================
CREATE TABLE ACL (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario VARCHAR(80) NOT NULL,
    tabla VARCHAR(80) NOT NULL,
    privilegio VARCHAR(80) NOT NULL
);

INSERT INTO ACL (usuario, tabla, privilegio) VALUES 
    ('admin', 'PROVEEDOR', 'ALL'),
    ('admin', 'CATEGORIA', 'ALL'),
    ('admin', 'PRODUCTO', 'ALL'),
    ('admin', 'ALERGENO', 'ALL'),
    ('admin', 'ALERGENOS_PRODUCTO', 'ALL'),
    ('admin', 'COMPRAS_PRODUCTO', 'ALL'),
    ('admin', 'DONACIONES', 'ALL'),
    ('admin', 'DETALLE_DONACION', 'ALL'),
    ('admin', 'TIPO_PLATOS', 'ALL'),
    ('admin', 'PLATO', 'ALL'),
    ('admin', 'PRODUCTO_PLATO', 'ALL'),
    ('admin', 'COMANDA_PLATOS', 'ALL'),
    ('admin', 'COMANDA_ELABORADOS', 'ALL'),
    ('encargado', 'PROVEEDOR', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'CATEGORIA', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'PRODUCTO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'ALERGENO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'ALERGENOS_PRODUCTO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'COMPRAS_PRODUCTO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'DONACIONES', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'DETALLE_DONACION', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'TIPO_PLATOS', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'PLATO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'PLATO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'PRODUCTO_PLATO', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'COMANDA_PLATOS', 'SELECT, INSERT, UPDATE, DELETE'),
    ('encargado', 'COMANDA_ELABORADOS', 'SELECT, INSERT, UPDATE, DELETE'),
    ('camarero', 'PROVEEDOR', 'SELECT'),
    ('camarero', 'CATEGORIA', 'SELECT'),
    ('camarero', 'PRODUCTO', 'SELECT'),
    ('camarero', 'ALERGENO', 'SELECT'),
    ('camarero', 'ALERGENOS_PRODUCTO', 'SELECT'),
    ('camarero', 'COMPRAS_PRODUCTO', 'SELECT'),
    ('camarero', 'DONACIONES', 'SELECT'),
    ('camarero', 'DETALLE_DONACION', 'SELECT'),
    ('camarero', 'TIPO_PLATOS', 'SELECT'),
    ('camarero', 'PLATO', 'SELECT'),
    ('camarero', 'PLATO', 'SELECT'),
    ('camarero', 'PRODUCTO_PLATO', 'SELECT'),
    ('camarero', 'COMANDA_PLATOS', 'SELECT, INSERT'),
    ('camarero', 'COMANDA_ELABORADOS', 'SELECT, INSERT');