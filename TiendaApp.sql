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
    FechaComienzo 		DATE,
    FechaTermino 		DATE,
    Tamaño 				INT,
    Precio 				INT,
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



	


    
    
    
    
    
    
	

    
    
    
    
    
    
    
    