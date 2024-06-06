-- ========================================
-- Ejercicio 1
-- Crea las tablas especificadas en el modelo relacional. En este punto, sólo se desea que definas las claves primarias sin ningún otro tipo de restricción (no incluir claves foráneas). los tipo de campo utilizados, deberán justificarse.
-- ========================================
CREATE TABLE `PROVEEDOR` (
    `NIF` VARCHAR(9),
    `Empresa` VARCHAR(45),
    `contacto` VARCHAR(45),
    `telefonos` VARCHAR(45),
    `direccion` VARCHAR(100),
    `mail` VARCHAR(45),
    `web` VARCHAR(100),
    `registro` VARCHAR(45),
    `idCategoria` INT,
    PRIMARY KEY (`NIF`)
);


CREATE TABLE `CATEGORIA` (
    `idCategoria` INT,
    `Categoria` VARCHAR(50),
    PRIMARY KEY (`idCategoria`)
);


CREATE TABLE `PRODUCTO` (
    `Codigo_Producto` VARCHAR(10),
    `Nombre` VARCHAR(45),
    `unidad` VARCHAR(45),
    `Alerta_Stock` INT,
    `idCategoria` INT,
    PRIMARY KEY (`Codigo_Producto`)
);

 
CREATE TABLE `INGREDIENTE` (
    `Codigo_Producto` VARCHAR(45),
    `conservacion` VARCHAR(45),
    PRIMARY KEY (`Codigo_Producto`)
);


CREATE TABLE `ELABORADO` (
    `Codigo_Producto` VARCHAR(45),
    PRIMARY KEY (`Codigo_Producto`)
);


CREATE TABLE `ALERGENO` (
    `Alergeno` VARCHAR(45),
    PRIMARY KEY (`Alergeno`)
);


CREATE TABLE `ALERGENOS_PRODUCTO` (
    `Codigo_Producto` VARCHAR(10),
    `Alergeno` VARCHAR(45),
    PRIMARY KEY (`Codigo_Producto` , `Alergeno`)
);


CREATE TABLE `COMPRAS_PRODUCTO` (
    Codigo_Producto VARCHAR(10),
    NIF VARCHAR(9),
    fecha DATE,
    cantidad INT,
    precio FLOAT,
    IVA FLOAT,
    caducidad VARCHAR(45),
    PRIMARY KEY (`Codigo_Producto` , `NIF` , `fecha`)
);


CREATE TABLE `DONACIONES` (
    `fecha` DATE,
    PRIMARY KEY (`fecha`)
);


CREATE TABLE `DETALLE_DONACION` (
    `fecha` DATE,
    `linea` VARCHAR(45),
    `Codigo_Producto` VARCHAR(10),
    `Cantidad` VARCHAR(45),
    `observaciones` VARCHAR(45),
    PRIMARY KEY (`fecha` , `linea` , `Codigo_Producto`)
);


CREATE TABLE `TIPO_PLATO` (
    id_Tipo VARCHAR(45),
    tipo_de_plato VARCHAR(45),
    PRIMARY KEY (`id_Tipo`)
);


CREATE TABLE `PLATO` (
    `Codigo_Plato` VARCHAR(10),
    `NombrePlato` VARCHAR(45),
    `tipo_plato` VARCHAR(45),
    `Elaboracion` VARCHAR(45),
    `PVP` VARCHAR(45),
    `IVA` VARCHAR(45),
    `en_menu` VARCHAR(45),
    PRIMARY KEY (`Codigo_Plato`)
);


CREATE TABLE `INGREDIENTES_PLATO` (
    `Codigo_Plato` VARCHAR(10),
    `Codigo_Producto` VARCHAR(10),
    `Cant_Bruta` FLOAT,
    `Cant_Neta` FLOAT,
    `Unidad` INT,
    PRIMARY KEY (`Codigo_Plato` , `Codigo_Producto`)
);


CREATE TABLE `COMANDA` (
    `id_Comanda` INT,
    `Fecha` DATE,
    `Hora` DATETIME,
    `Mesa` VARCHAR(45),
    `Comensales` VARCHAR(45),
    `Ticket` VARCHAR(45),
    PRIMARY KEY (`id_Comanda`)
);


CREATE TABLE `COMANDA_PLATOS` (
    `Id_Comanda` INT,
    `Codigo_Plato` VARCHAR(10),
    `cantidad` FLOAT,
    `PVP` FLOAT,
    `IVA` FLOAT,
    PRIMARY KEY (`Id_Comanda` , `Codigo_Plato`)
);


CREATE TABLE `COMANDA_ELABORADOS` (
    `Id_Comanda` INT,
    `Codigo_Producto` VARCHAR(10),
    `cantidad` FLOAT,
    `PVP` FLOAT,
    `IVA` FLOAT,
    PRIMARY KEY (`Id_Comanda` , `Codigo_Producto`)
);



-- ========================================
-- Ejercicio 2
-- Haciendo uso de la sentencia ALTER TABLE agrega las claves foráneas. Éstas deberán incluir las cláusulas ON UPDATE - ON DELETE cuyo valor deberá justificarse en cada caso.
-- ========================================
ALTER TABLE PROVEEDOR ADD FOREIGN KEY (idCategoria) REFERENCES CATEGORIA(idCategoria);
ALTER TABLE PRODUCTO ADD FOREIGN KEY (idCategoria) REFERENCES CATEGORIA(idCategoria);
ALTER TABLE INGREDIENTE ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE ELABORADO ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE ALERGENOS_PRODUCTO ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE ALERGENOS_PRODUCTO ADD FOREIGN KEY (Alergeno) REFERENCES ALERGENO(Alergeno);
ALTER TABLE COMPRAS_PRODUCTO ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE COMPRAS_PRODUCTO ADD FOREIGN KEY (NIF) REFERENCES PROVEEDOR(NIF);
ALTER TABLE DETALLE_DONACION ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE PLATO ADD FOREIGN KEY (Codigo_Plato) REFERENCES TIPO_PLATO(id_Tipo); 
ALTER TABLE INGREDIENTES_PLATO ADD FOREIGN KEY (Codigo_Plato) REFERENCES PLATO(Codigo_Plato);
ALTER TABLE INGREDIENTES_PLATO ADD FOREIGN KEY (Codigo_Producto) REFERENCES PRODUCTO(Codigo_Producto);
ALTER TABLE COMANDA_PLATOS ADD FOREIGN KEY (Id_Comanda) REFERENCES COMANDA(Id_Comanda);
ALTER TABLE COMANDA_PLATOS ADD FOREIGN KEY (Codigo_Plato) REFERENCES PLATO(Codigo_Plato);
ALTER TABLE COMANDA_ELABORADOS ADD FOREIGN KEY (Id_Comanda) REFERENCES COMANDA(Id_Comanda);
ALTER TABLE COMANDA_ELABORADOS ADD FOREIGN KEY (Codigo_Producto) REFERENCES ELABORADO(Codigo_Producto);



-- ========================================
-- Ejercicio 3
-- Agrega el resto de restricciones que creas conveniente para cada campo (UNIQUE, NOT NULL, etc). Deberás justificarlas en cada caso
-- ========================================
ALTER TABLE CATEGORIA MODIFY COLUMN idCategoria INT NOT NULL AUTO_INCREMENT; 
ALTER TABLE COMANDA MODIFY COLUMN id_Comanda INT NOT NULL AUTO_INCREMENT;


 
-- ========================================
-- Ejercicio 4
-- ========================================
-- a) Agrega los siguientes campos a la tabla PRODUCTO:
-- 		- tipoProducto (Enum) Los valores que podrá recibir el campo son: Ingrediente, Elaborado.
-- 		- PVP
-- 		- porcentaje_IVA
-- 		- conservación
ALTER TABLE PRODUCTO ADD tipoProducto ENUM('Ingrediente','Elaborado') NULL;
ALTER TABLE PRODUCTO ADD PVP FLOAT(0.0);
ALTER TABLE PRODUCTO ADD porcentaje_IVA FLOAT(0.0);
ALTER TABLE PRODUCTO ADD conservacion FLOAT(0.0);


-- b) Revisar las tablas y renombrar todos los campos denominados IVA por porcentaje_IVA. Agregarles a todos ellos una restricción check que limite sus valores a valores entre 0 y 1.
ALTER TABLE COMPRAS_PRODUCTO RENAME COLUMN IVA TO porcentaje_IVA;
ALTER TABLE PLATO RENAME COLUMN IVA TO porcentaje_IVA;
ALTER TABLE COMANDA_PLATOS RENAME COLUMN IVA TO porcentaje_IVA;
ALTER TABLE COMANDA_ELABORADOS RENAME COLUMN IVA TO porcentaje_IVA;
ALTER TABLE COMPRAS_PRODUCTO ADD CHECK (porcentaje_IVA >= 0 AND porcentaje_IVA <= 1);
ALTER TABLE PLATO ADD CHECK (porcentaje_IVA >= 0 AND porcentaje_IVA <= 1);
ALTER TABLE COMANDA_PLATOS ADD CHECK (porcentaje_IVA >= 0 AND porcentaje_IVA <= 1);
ALTER TABLE COMPRAS_PRODUCTO ADD CHECK (porcentaje_IVA >= 0 AND porcentaje_IVA <= 1);


-- c) Generar una restricción de tipo UNIQUE para la combinación Fecha + Hora + Mesa, en la tabla COMANDA.
ALTER TABLE COMANDA ADD CONSTRAINT combinacionFechaHoraMesa UNIQUE(Fecha, Hora, Mesa);


-- d) Generar un campo calculado tanto en las tablas PRODUCTO como en la tabla COMPRAS_PRODUCTO que calcule el precio final del mismo tomando en cuenta el porcentaje_IVA.
ALTER TABLE PRODUCTO ADD Precio_Final DECIMAL(10,2) AS (PVP * (1 + Porcentaje_IVA / 100));
ALTER TABLE COMPRAS_PRODUCTO ADD Precio_Final DECIMAL(10,2) AS (precio * (1 + Porcentaje_IVA / 100));


-- e) Eliminar las tablas INGREDIENTE y ELABORADO. Recordar eliminar previamente las Foreign Keys. Revincular directamente la tabla INGREDIENTES_PLATO con la tabla PRODUCTO.
ALTER TABLE COMANDA_ELABORADOS DROP CONSTRAINT `COMANDA_ELABORADOS_ibfk_2`;
ALTER TABLE INGREDIENTES_PLATO ADD CONSTRAINT `PRODUCTOS_PLATO_ibfk_2` FOREIGN KEY (Id_Producto) REFERENCES PRODUCTO(Id_Producto);


-- f) Renombrar la tabla INGREDIENTES_PLATO por PRODUCTOS_PLATO
ALTER TABLE INGREDIENTES_PLATO RENAME PRODUCTOS_PLATO;


-- g) Cambiar el tipo de datos del campo TIPO_PLATO en la tabla PLATO por SET. Los valores del campo pueden ser 'Entrante', 'Sopa', 'Ensalada', 'Primer Plato', 'Segundo Plato', 'Plato Combinado', 'Postre'
ALTER TABLE PLATO CHANGE COLUMN `tipo_plato` `tipo_plato` SET('Entrante', 'Sopa', 'Ensalada', 'Primer Plato', 'Segundo Plato', 'Plato Combinado', 'Postre') NULL DEFAULT NULL;


-- h) Eliminar la tabla TIPO_PLATOS de la Base de datos
ALTER TABLE PLATO DROP CONSTRAINT `PLATO_ibfk_1`;
DROP TABLE TIPO_PLATO;



-- ========================================
-- Ejercicio 5
-- Insertar en la tabla ALERGENO los siguientes 14 alérgenos: Altramuces, Apio, Moluscos, Sésamo, Gluten, Pescado, Sulfitos, Mostaza, Crustáceos, Lactosa, Huevo, Soja, Frutos secos, Cacahuetes 
-- ========================================
INSERT INTO ALERGENO (Alergeno) VALUES ('Altramuces');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Apio');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Moluscos');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Sésamo');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Gluten');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Pescado');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Sulfitos');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Mostaza');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Crustáceos');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Lactosa');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Huevo');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Soja');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Frutos secos');
INSERT INTO ALERGENO (Alergeno)  VALUES ('Cacahuetes');

SELECT * FROM ALERGENO;



-- ========================================
-- Ejercicio 6
-- Insertar en la tabla CATEGORIA los datos de la siguiente tabla. Anotar la sentencia SQL y su salida en un documento.
-- Tabla CATEGORIAS
	-- idCategoría	Categoria
	-- 1 Aceites y vinagres
	-- 2 Carnes y Aves
	-- 3 Bebidas
	-- 4 Fruta y Verdura
	-- 5 Pescados y Mariscos
	-- 6 Conservas
	-- 7 Embutidos
	-- 8 Especias
	-- 9 Productos Lácteos
	-- 10 Ovoproductos
	-- 11 Pan y Bollería
	-- 12 Postres
	-- 13 Harinas
	-- 14 Salsas
	-- 15 Elaborados
	-- 16 Semielaborados
-- ========================================
INSERT INTO CATEGORIA (Categoria) VALUES ('Aceites y vinagres');
INSERT INTO CATEGORIA (Categoria) VALUES ('Carnes y Aves');
INSERT INTO CATEGORIA (Categoria) VALUES ('Bebidas');
INSERT INTO CATEGORIA (Categoria) VALUES ('Fruta y Verdura');
INSERT INTO CATEGORIA (Categoria) VALUES ('Pescados y Mariscos');
INSERT INTO CATEGORIA (Categoria) VALUES ('Conservas');
INSERT INTO CATEGORIA (Categoria) VALUES ('Embutidos');
INSERT INTO CATEGORIA (Categoria) VALUES ('Especias');
INSERT INTO CATEGORIA (Categoria) VALUES ('Productos Lácteos'); 
INSERT INTO CATEGORIA (Categoria) VALUES ('Ovoproductos');
INSERT INTO CATEGORIA (Categoria) VALUES ('Pan y Bollería');
INSERT INTO CATEGORIA (Categoria) VALUES ('Postres');
INSERT INTO CATEGORIA (Categoria) VALUES ('Harinas');
INSERT INTO CATEGORIA (Categoria) VALUES ('Salsas');
INSERT INTO CATEGORIA (Categoria) VALUES ('Elaborados');
INSERT INTO CATEGORIA (Categoria) VALUES ('Semielaborados');


-- ========================================
-- Ejercicio 7
-- Insertar en las tablas PROVEEDOR los datos que el consultor/a os facilitará en el tablón del consultor. 
-- ========================================
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ('B65639155', 'BIRRA 365', 3, '---', '960714310 / 722 61 50 65', 'Jeronimo Monsoriu, 58, Valencia (Ciudad) - Valencia', 'info@birra365.com', 'https://www.birra365.com');
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ('A60177623', 'BOU Café', 4, 'C. Gotor', '902 305 352', 'Calle Botánica, 55 Hospitalet del Llobregat, Barcelona 08908', 'tuopinion@cafesbou.com', 'http://www.cafesbou.com/index.php/es/');
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ('B65639157', 'ALBERTO POLO DISTRIBUCIONES', 2, 'A. Polo', '976 57 49 09','Calle Río Ara 8, 50014, Zaragoza, Zaragoza', 'info@albertopolo.com', 'https://albertopolo.com/');
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639158", "CARNS B", 2, "J. Bigordà Alberni", "93.336.40.40 \/ 639.31.77.77", "Longitudinal 10, núm. 60 Mercabarna, Barcelona", "joaquim@carnsb.com", "www.carnsb.com");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ( "B65639159", "INDUSTRIA AVICOLA SUREÑA", 2, "J. Molina", "915 077600 \/ 915 076 224 \/ 902 101 566","C\/ Toledo 149 E Pa 28005 - (Madrid) - Madrid", "info@inasur.es", "www.inasur.es");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639160","RUBIATO PAREDES SL", 2, "J. Pedros Riasol", "916415512 \/607387265", "Calle de los Cerrajeros, 6 y 8 , Alcorcón - Madrid 28923", "rubiatoparedes@rubiatoparedes.com", "https:\/\/www.rubiatoparedes.com\/");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ( "B65639161", "MAKRO", 5, "L. Piquer", "93 336 31 11", "Carrer A, nª 1, Sector C – Polígono Industrial Zona Franca 08040 Barcelona", "atencionclientes.02@makro.es", "https:\/\/www.makro.es\/");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639162","AGRORIZAO", 6, "M. Agrorizao", "96 842 54 70 \/ 86 845 7203 \/ 968 420 381", "Carretera Nacional 340 (KM 614), - 30850 Totana, Murcia 30850", "ventas@agrorizao.com", "www.agrorizao.com");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639163", "CHEF FRUIT", 6, "J. Domingo", "910 57 81 36", "Centro de Transportes de Madrid (ctm), CL EJE 6 2, Madrid, 28053 , Madrid", "pedidos@chef-fruit.com", "https:\/\/www.chef-fruit.com\/");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639164","FRUTAS CUEVAS", 6, "J. Cuevas", "954 41 7158 - 615 187204", "Polígono Pagusa Calle Labrador 47 41007 Sevilla Sevilla Capital España", "info@frutascuevas.es","https:\/\/www.frutascuevas.es\/");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639165", "HUEVERIAS BONET, S.A.", 13, "A. Bonet Pedret","93.335.72.12", "Transversal 8, núm. 48 Multiservei I", "dbonet@dbonet.es","http:\/\/dbonet.es\/");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639166", "MONTSEC", 12, "J. del Castillo", "93 849 87 99", "Severo Ochoa, 36 - Pol. Ind. Font del Radium, 08403 Granollers.Barcelona.","info@comercialmontsec.com", "http:\/\/www.comercialmontsec.com");
INSERT INTO PROVEEDOR (`NIF`, `Empresa`, `idCategoria`, `contacto`, `telefonos`, `direccion`,`mail`, `web`) VALUES ("B65639167", "ALAVESA DE PATATAS", 7, "J. Suárez Tascón", "945 400 429\/ 691 423 566", "Polígono industrial Lurgorri s\/n Alegría-Dulantzi 01240 - Álava", "alavesadepatatas@alavesadepatatas.com","http:\/\/alavesadepatatas.com\/");



-- ========================================
-- Ejercicio 8
-- Diseñar un menú con un mínimo de 4 y un máximo de 7 platos para la Rosticería, (que incluya recetas) para que a partir de allí llenéis las tablas PLATO, PRODUCTOS_PLATO, PRODUCTO, ALERGENOS_PRODUCTO.
-- ========================================
INSERT INTO PRODUCTO (Codigo_Producto, Nombre, unidad, Alerta_Stock, idCategoria, tipoProducto, PVP, porcentaje_IVA, conservacion) VALUES ('2', 'Ensalada César', '30', '4', '2', 'Elaborado', '3.32', '10', '0.34');
INSERT INTO PRODUCTO (Codigo_Producto, Nombre, unidad, Alerta_Stock, idCategoria, tipoProducto, PVP, porcentaje_IVA, conservacion) VALUES ('3', 'Patatas Bravas', '54', '4', '3', 'Elaborado', '4.1', '10', '0.6');
INSERT INTO PRODUCTO (Codigo_Producto, Nombre, unidad, Alerta_Stock, idCategoria, tipoProducto, PVP, porcentaje_IVA, conservacion) VALUES ('4', 'Pasta con atún', '26', '5', '9', 'Elaborado', '1.3', '10', '0.7');

ALTER TABLE PLATO MODIFY PVP FLOAT;
ALTER TABLE PLATO MODIFY Elaboracion VARCHAR(500);
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('2', 'Ensalada César', 'Entrante', 'Cortar la lechuga tipo juliana, machacar el ajo, emulsionar aceite y mostaza y mezclar todo ', '3.32', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('3', 'Patatas Bravas', 'Entrante', 'Cortar las patatas en gajos, freír, rociar con la salsa y la mayonesa ', '4.1', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('4', 'Pasta con atún', 'Primer Plato', 'Cocer la pasta, freír el atún en aceite y mezclar todo ', '12.9', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('5', 'Pollo asado con papas y cebolla caramelizada', 'Primer Plato', 'Cortar y freír las patatas y la cebolla, coger el pollo del asador y servir', '9.30', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('6', 'Macedonia', 'Postre', 'Cortar en trocitos de 1 centímetro y mezclar', '2.63', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('7', 'Flan', 'Postre', 'Cocer todos los ingredientes y añadir por ultimo la piel y la rama de canela, dejar enfriar y servir', '3.15', '1', 'S');
INSERT INTO PLATO (Codigo_Plato, NombrePlato, tipo_plato, Elaboracion, PVP, porcentaje_IVA, en_menu) VALUES ('8', 'Brownie', 'Postre', 'Derretimos el chocolate con la mantequilla, luego batimos los huevos y el azúcar. Luego una vez mezclado todo lo metemos al horno', '5.00', '1', 'S');

INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('2', '2', '200', '180');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('3', '3', '300', '255');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('4', '4', '230', '200');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('5', '5', '350', '300');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('6', '6', '100', '85');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('7', '7', '200', '185');
INSERT INTO PRODUCTOS_PLATO (Codigo_Plato, Codigo_Producto, Cant_Bruta, Cant_Neta) VALUES ('8', '8', '250', '200');

INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('2', 'Lactosa');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('3', 'Huevo');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('4', 'Gluten');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('5', 'Pescado');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('6', 'Ninguno');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('7', 'Huevo');
INSERT INTO ALERGENOS_PRODUCTO (Codigo_Producto, Alergeno) VALUES ('8', 'Lactosa');



-- ========================================
-- Ejercicio 9
-- Insertar un mínimo de 10 registros en las siguientes tablas (COMPRAS_PRODUCTO, COMANDA, COMANDA_PLATOS, COMANDA_ELABORADOS) 
-- ========================================
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('2', 'A60177623', '2023-03-12', 30, 3.32, 1, '2023-03-21');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('3', 'B65639155', '2023-03-04', 54, 4.1, 1, '2023-04-01');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('4', 'B65639157', '2023-03-01', 26, 12.9, 1, '2023-03-04');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('5', 'B65639158', '2023-02-12', 9, 10.3, 1, '2023-02-16');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('6', 'B65639159', '2023-01-21', 100, 2.63, 1, '2023-01-28');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('7', 'B65639160', '2023-02-25', 60, 3.15, 1, '2023-03-01');
INSERT INTO COMPRAS_PRODUCTO (Codigo_Producto, NIF, fecha, cantidad, precio, porcentaje_IVA, caducidad) VALUES ('8', 'B65639161', '2023-01-07', 13, 5, 1, '2023-01-09');

ALTER TABLE COMANDA MODIFY Hora TIME;
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-12', '20:00:00', '21', 'Maria, Pedro, Miguel', 12);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-12', '19:30:00', '24', 'Luis, Pedro', 11);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-12', '16:00:00', '01', 'Julio, Ana', 04);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-13', '20:00:00', '07', 'Marta, Diego', 30);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-15', '20:30:00', '21', 'Marta, Pepep, Marcos', 50);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-15', '21:25:00', '22', 'Javier, Ignacio', 35);
INSERT INTO COMANDA (Fecha, Hora, Mesa, Comensales, Ticket) VALUES ('2023-03-15', '22:00:00', '23', 'Federico', 17);

INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('1', '2', 30 , 3.32 , 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('2','3', 54 , 4.1 , 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('3','4', 26, 12.9, 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('4','5', 9 , 10.3, 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('5','6', 100 , 2.63 , 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('6','7', 60 , 3.15 , 1);
INSERT INTO COMANDA_PLATOS (Id_Comanda, Codigo_Plato, cantidad, PVP, porcentaje_IVA) VALUES ('7','8', 13 , 5 , 1);