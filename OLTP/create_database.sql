-- Creación de la base de datos

CREATE DATABASE bd_banca_transacciones_pdan6;
GO

USE bd_banca_transacciones_pdan6;
GO
--- Creación de las tablas
--- Persona Natural

CREATE TABLE personas_naturales (
id INT IDENTITY(1,1) PRIMARY KEY,
numero_documento VARCHAR(20) UNIQUE NOT NULL,
nombres VARCHAR(155) NOT NULL,
apellidos VARCHAR(255) NOT NULL,
direccion VARCHAR (255) NOT NULL,
celular VARCHAR(20) NOT NULL,
email VARCHAR(155) NOT NULL,
fecha_nacimiento DATE NOT NULL,
genero VARCHAR(20) NOT NULL,
estado_civil VARCHAR(20) NOT NULL
);
GO