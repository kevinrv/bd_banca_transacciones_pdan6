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

EXEC SP_HELP clientes;
--sucursales

CREATE TABLE sucursales (
id INT IDENTITY(1,1) PRIMARY KEY,
codigo CHAR(6) UNIQUE NOT NULL,
direccion VARCHAR(255) NOT NULL,
telefono VARCHAR(20),
fecha_creacion DATE NOT NULL,
sector VARCHAR (50),
gerente_id INT UNIQUE NOT NULL
);
GO
--Tipos de cuenta

CREATE TABLE tipos_cuenta (
id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(100) UNIQUE NOT NULL,
descripcion VARCHAR(500) 
);
Go

-- cuentas

CREATE TABLE cuentas(
id INT IDENTITY(1,1) PRIMARY KEY,
sucursal_id INT NOT NULL,
cliente_id INT NOT NULL,
tipo_cuenta_id INT NOT NULL,
num_cuenta VARCHAR(20) NOT NULL,
cci VARCHAR(25) NULL,
moneda VARCHAR(50) NOT NULL,
saldo MONEY NOT NULL,
fecha_creacion DATETIME NOT NULL,
fecha_vencimiento DATETIME NOT NULL,
FOREIGN KEY (sucursal_id) REFERENCES sucursales(id),
CONSTRAINT fk_cuentas_clientes FOREIGN KEY (cliente_id) REFERENCES clientes(id),
FOREIGN KEY (tipo_cuenta_id) REFERENCES tipos_cuenta(id)
);
--canales
CREATE TABLE canales(
id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
descripcion VARCHAR(100) NOT NULL
)
GO

-- tipos transacciones
CREATE TABLE tipos_transaccion(
id INT IDENTITY(1,1) PRIMARY KEY,
nombre VARCHAR(50) NOT NULL,
descripcion VARCHAR(100) NOT NULL
)
GO

-- transacciones
CREATE TABLE transacciones(
id INT IDENTITY(1,1) PRIMARY KEY,
cuenta_origen_id INT NULL,
cuenta_destino_id INT NULL,
canal_id INT NOT NULL,
tipo_transaccion_id INT NOT NULL,
monto MONEY NOT NULL,
tipo_moneda varchar(50) NOT NULL,
fecha_inicio_transaccion DATETIME NOT NULL,
fecha_fin_transaccion DATETIME NOT NULL,
tiempo_transaccion INT NOT NULL,
FOREIGN KEY(cuenta_origen_id) REFERENCES cuentas(id),
FOREIGN KEY(cuenta_destino_id) REFERENCES cuentas(id),
FOREIGN KEY(canal_id) REFERENCES canales(id),
FOREIGN KEY(tipo_transaccion_id) REFERENCES tipos_transaccion(id)
)