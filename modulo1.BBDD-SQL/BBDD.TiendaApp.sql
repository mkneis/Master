-- CREACION BASE DE DATOS
DROP DATABASE IF EXISTS TiendaApp;
CREATE DATABASE TiendaApp;
USE TiendaApp;

-- CREACION DE TABLAS
DROP TABLE IF EXISTS TiendaApp;
DROP TABLE IF EXISTS DesarrolladorApp;
DROP TABLE IF EXISTS Empleado;
DROP TABLE IF EXISTS ExpEmpleado;
DROP TABLE IF EXISTS EquipoApp;
DROP TABLE IF EXISTS Usuario;
DROP TABLE IF EXISTS Descarga;
DROP TABLE IF EXISTS App;
DROP TABLE IF EXISTS Upload;
DROP TABLE IF EXISTS Categoria;
DROP TABLE IF EXISTS RespaldoApp;

SET foreign_key_checks = 0;

CREATE TABLE TiendaApp(
	Nombre 				VARCHAR(30) PRIMARY KEY,
    Gestionadora 		VARCHAR(30) NOT NULL,
    Web					VARCHAR(500) NOT NULL
);

CREATE TABLE DesarrolladorApp(
	Nombre 				VARCHAR(30) PRIMARY KEY,
    Pais				VARCHAR(30) NOT NULL,
    AñoCreacion			NUMERIC(4),
    Mail 				VARCHAR(40),
    Web					VARCHAR(500)
);

CREATE TABLE Empleado(
	DNI 				VARCHAR(9) PRIMARY KEY,
    Calle 				VARCHAR(50) NOT NULL,
    Numero 				INT NOT NULL,
    CodigoPostal 		NUMERIC(7),
    Mail 				VARCHAR(40) NOT NULL,
    Telefono 			VARCHAR(9) NOT NULL
);
    
CREATE TABLE App(
	Codigo 				NCHAR(4) PRIMARY KEY,
    Nombre 				VARCHAR(30) UNIQUE,
    FechaComienzo 		DATE NOT NULL,
    FechaTermino 		DATE NOT NULL,
    Tamaño 				INT NOT NULL,
    Precio 				INT NOT NULL,
    DesarrolladorApp	VARCHAR(30),
    EncargadoApp		VARCHAR(9),
    FOREIGN KEY(DesarrolladorApp) REFERENCES DesarrolladorApp(Nombre)
    ON DELETE CASCADE
	ON UPDATE CASCADE,
    FOREIGN KEY(EncargadoApp) REFERENCES Empleado(DNI) 
	ON UPDATE CASCADE
);
    
CREATE TABLE Usuario(
	NumCuenta 			INT(3) PRIMARY KEY,
    Nombre				VARCHAR(30),
    Direccion			VARCHAR(100),
    Pais				VARCHAR(30)
);
    
-- TABLAS CREADAS DEBIDO A RELACIONES MUCHOS A MUCHOS (N:N)
CREATE TABLE ExpEmpleado(
	NombreDesarrollador	VARCHAR(30),
    DniEmpleado			VARCHAR(9),
    FechaInicio			DATE NOT NULL,
    FechaTermino		DATE DEFAULT NULL,
    PRIMARY KEY(NombreDesarrollador, DniEmpleado, FechaInicio),
    FOREIGN KEY(NombreDesarrollador) REFERENCES DesarrolladorApp(Nombre),
    FOREIGN KEY(DniEmpleado) REFERENCES Empleado(DNI)
);
    
CREATE TABLE EquipoApp(
	CodigoApp			NCHAR(4),
    DniEmpleado			VARCHAR(9),
    PRIMARY KEY(CodigoApp, DniEmpleado),
    FOREIGN KEY(CodigoApp) REFERENCES App(Codigo),
    FOREIGN KEY(DniEmpleado) REFERENCES Empleado(DNI)
);
    
CREATE TABLE Descarga(
	NumCuenta			INT(3),
    CodigoApp			NCHAR(4),
    Tienda				VARCHAR(30),
    Dispositivo			VARCHAR(20) NOT NULL,
    Telefono			VARCHAR(9),
    Fecha				DATE NOT NULL,
    Valoracion			INT, 
    Comentario			VARCHAR(1000),
    PRIMARY KEY(NumCuenta, CodigoApp),
    FOREIGN KEY(NumCuenta) REFERENCES Usuario(NumCuenta),
    FOREIGN KEY(CodigoApp) REFERENCES App(Codigo),
    FOREIGN KEY(Tienda) REFERENCES TiendaApp(Nombre),
    CHECK (Valoracion BETWEEN 0 AND 5)
);
    
CREATE TABLE Upload(
	CodigoApp			NCHAR(4),
    NombreTienda		VARCHAR(30),
    PRIMARY KEY(CodigoApp, NombreTienda),
    FOREIGN KEY(CodigoApp) REFERENCES App(Codigo)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
    FOREIGN KEY(NombreTienda) REFERENCES TiendaApp(Nombre)
    ON UPDATE CASCADE
    ON DELETE CASCADE
);
-- Creacion tabla de atributo multivalorado de la entidad App
CREATE TABLE Categoria(
	CodigoApp			NCHAR(4),
    Categoria			VARCHAR(30),
    PRIMARY KEY(CodigoApp, Categoria),
    FOREIGN KEY(CodigoApp) REFERENCES App(Codigo)
    ON DELETE CASCADE
);

-- Creacion de tabla de respaldo de datos de aplicaciones para trigger
CREATE TABLE RespaldoApp(
	Codigo 				NCHAR(4) PRIMARY KEY,
    Nombre 				VARCHAR(30) UNIQUE,
    Precio 				INT,
    PrecioNuevo			INT,
    FechaActualizacion	DATE
);
    
-- Carga de datos
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/DesarrolladorApp.csv'  
INTO TABLE DesarrolLadorApp
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows
;
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Empleado.csv'  
INTO TABLE Empleado
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/App.csv'  
INTO TABLE App
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/EquipoApp.csv'  
INTO TABLE EquipoApp
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/ExpEmpleado.csv'  
INTO TABLE ExpEmpleado
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Usuario.csv'  
INTO TABLE Usuario
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Descarga.csv'  
INTO TABLE Descarga
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/TiendaApp.csv'  
INTO TABLE TiendaApp
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
; 
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Upload.csv'  
INTO TABLE Upload
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
;  
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Categoria.csv'  
INTO TABLE Categoria
CHARACTER SET latin1
FIELDS TERMINATED BY ';'  
LINES TERMINATED BY '\n'
IGNORE 1 rows 
;  
SET foreign_key_checks = 1
;

-- Trigger Respaldo cambio de precio de Aplicaciones
delimiter //
DROP TRIGGER IF EXISTS ActualizarApp;
CREATE TRIGGER ActualizaraApp 
BEFORE UPDATE ON App 
FOR EACH ROW
	INSERT INTO RespaldoApp values (OLD.Codigo, OLD.Nombre, OLD.Precio, NEW.Precio, NOW());
END
// 
delimiter ;   
    
-- CONSULTAS

-- Fecha en la que se realizan mas descargas
SELECT Fecha, COUNT(Fecha) AS Descargas
FROM Descarga
GROUP BY Fecha
ORDER BY COUNT(Fecha) DESC
LIMIT 1
;
-- Pais de los Usuarios que mas descargas han realizado
SELECT Usuario.Pais, COUNT(Descarga.CodigoApp) AS Descargas
FROM Usuario INNER JOIN Descarga ON Usuario.NumCuenta = Descarga.NumCuenta
GROUP BY Usuario.Pais
ORDER BY Descargas DESC
LIMIT 1
;
-- Puntuacion media de cada App
SELECT A.Codigo, A.Nombre, CAST(AVG(D.Valoracion) AS DECIMAL(10,1)) AS ValoracionMedia
FROM App AS A INNER JOIN Descarga AS D ON A.Codigo = D.CodigoApp
GROUP BY A.Codigo, A.Nombre
ORDER BY ValoracionMedia DESC
;
-- Desarrolladores de Aplicaciones y la valoracion media de sus aplicaciones
SELECT A.DesarrolladorApp, CAST(AVG(D.Valoracion) AS DECIMAL(10,1)) AS ValoracionMedia
FROM App AS A INNER JOIN Descarga AS D ON A.Codigo = D.CodigoApp
GROUP BY A.DesarrolladorApp
;
-- Aplicaciones y sus ganancias brutas (sin descuento 30% pertenencientes las tiendas)
SELECT App.Nombre AS Aplicacion, COUNT(Descarga.CodigoApp) * Precio AS Ventas 
FROM App INNER JOIN Descarga ON App.Codigo = Descarga.CodigoApp
GROUP BY App.Nombre
ORDER BY Ventas DESC
;
DROP VIEW IF EXISTS GananciasBrutas;
CREATE VIEW GananciasBrutas AS
SELECT App.DesarrolladorApp,App.Codigo, App.Nombre, COUNT(Descarga.CodigoApp) * Precio AS Ventas
FROM App INNER JOIN Descarga ON App.Codigo = Descarga.CodigoApp
GROUP BY App.Nombre
;
-- Desarrolladores de Aplicaciones y sus ganancias netas (ventas - 30% de comision TiendasApp) 
SELECT DesarrolladorApp, ROUND(SUM(Ventas) *  0.7,0) AS VentasNetas
From GananciasBrutas
GROUP BY DesarrolladorApp
ORDER BY VentasNetas DESC
;
-- Cantidad de aplicaciones en las que han trabajado los empleado (Experiencia)
SELECT DniEmpleado, COUNT(DniEmpleado) AS CantidadApp
FROM EquipoApp
GROUP BY DniEmpleado
ORDER BY CantidadApp DESC
;
-- Aplicaciones y cuantos dias tardaron en fabricarse
SELECT Nombre, DATEDIFF(FechaTermino, FechaComienzo) AS DiasFabricacion
FROM App
ORDER BY DiasFabricacion DESC
;
-- Tienda con la mayor cantidad de aplicaciones
SELECT NombreTienda, MAX(STOCK) AS StockApp
FROM (SELECT NombreTienda, COUNT(CodigoApp) AS Stock
	  FROM Upload
      GROUP BY NombreTienda
      ORDER BY Stock DESC) AS StockTiendas
;
-- Experiencia de los empleados en dias trabajados en aplicaciones
SELECT DniEmpleado, SUM(DATEDIFF(FechaTermino, FechaComienzo)) AS DiasExperiencia
FROM (SELECT DniEmpleado, FechaComienzo, FechaTermino
	  FROM EquipoApp, App
	  WHERE CodigoApp = Codigo) AS DiasExperiencia
GROUP BY DniEmpleado
ORDER BY DiasExperiencia DESC
;
-- Usuarios que solo han descargado 1 aplicacion
SELECT NumCuenta, NumDescargas
FROM (SELECT NumCuenta, COUNT(NumCuenta) AS NumDescargas
	  FROM Descarga
	  GROUP BY NumCuenta) AS NumDescargas
WHERE NumDescargas = 1
;
-- Tiendas y la suma de sus ganancias unitarias por aplicacion
SELECT Upload.NombreTienda, SUM(App.Precio * 0.3) AS SumaGanaciasUnitarias
FROM Upload, App
WHERE Upload.CodigoApp = App.Codigo
GROUP BY Upload.NombreTienda
;
DROP VIEW IF EXISTS SumaGananciasUnitarias;
CREATE VIEW SumaGananciasUnitarias AS
SELECT Upload.NombreTienda, SUM(App.Precio * 0.3) AS SumaGananciasUnitarias
FROM Upload, App
WHERE Upload.CodigoApp = App.Codigo
GROUP BY Upload.NombreTienda
; 
 -- Ganancias esperadas si todos los usuarios descargan todas las aplicaciones disponibles desde una tienda
SELECT NombreTienda, (SELECT COUNT(NumCuenta)
                       FROM Usuario) * SumaGananciasUnitarias AS GananciasEsperadas
FROM SumaGananciasUnitarias
;
-- Ranking de las tres tiendas con mas Descargas
SELECT Tienda, Count(Tienda) AS NumDescargas
FROM Descarga 
GROUP BY Tienda
ORDER BY NumDescargas DESC 
LIMIT 3
;
-- Experiencia trabajadores en años Trabajados
SELECT DniEmpleado, CAST(DATEDIFF(IFNULL(FechaTermino, NOW()), FechaInicio)/365 AS DECIMAL(10,1)) AS AñosExperiencia
FROM ExpEmpleado
GROUP BY DniEmpleado
ORDER BY AñosExperiencia DESC
;
 -- Tiendas y sus ganancias Totales
SELECT Descarga.Tienda, SUM(App.Precio * 0.3) GananciasTotales
FROM Descarga, App
WHERE Descarga.CodigoApp = App.Codigo
GROUP BY Descarga.Tienda
ORDER BY GananciasTotales DESC
;

	


    
    
    
    
    
    
	

    
    
    
    
    
    
    
    