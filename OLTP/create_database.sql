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

-- personas juridicas
CREATE TABLE personas_juridicas(
id INT IDENTITY(1,1) PRIMARY KEY,
ruc CHAR(11) NOT NULL UNIQUE,
razon_social VARCHAR(255) NOT NULL,
direccion VARCHAR(200) NOT NULL,
email VARCHAR(155) NOT NULL,
telefono VARCHAR(20) NOT NULL,
tipo_empresa VARCHAR(55) NOT NULL,
rubro VARCHAR(55),
fecha_creacion DATE NOT NULL
);
Go

-- Clientes
CREATE TABLE clientes(
id INT IDENTITY(1,1) PRIMARY KEY,
persona_id INT NOT NULL,
tipo_cliente varchar(50) NOT NULL,
FOREIGN KEY (persona_id) REFERENCES personas_naturales(id),
FOREIGN KEY (persona_id) REFERENCES personas_juridicas(id)
);

--sucursales
--Tipos de cuenta