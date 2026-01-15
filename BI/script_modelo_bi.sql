CREATE DATABASE bd_pdan_transacciones_bi_6;
USE bd_pdan_transacciones_bi_6;

-- Dim tiempo
CREATE TABLE dim_tiempo(
id INT IDENTITY(1,1) PRIMARY KEY,
fecha_transaccion DATE NOT NULL,
anio DATE NOT NULL,
mes DATE NOT NULL,
dia DATE NOT NULL
)

-- DIM SUCURSAL
CREATE TABLE dim_sucursal
( id INT IDENTITY(1,1) PRIMARY KEY, 
sucursal_id INT,
sucursal  VARCHAR(6),
sector  VARCHAR(255));

-- DIM CANAL

create table dim_canal
(
id int IDENTITY(1,1) primary key,
canal varchar (255)
)

-- DIM dim_tipo_transaccion
CREATE TABLE dim_tipo_transaccion (
    id INT IDENTITY(1,1) PRIMARY KEY,
    tipo_transaccion_id INT NOT NULL,
    tipo_transaccion VARCHAR(100) NOT NULL
);

-- Hechos

CREATE TABLE hechos_transacciones (
    id INT IDENTITY(1,1) NOT NULL,
    dim_tiempo_id INT NOT NULL,              
    dim_tipo_transaccion_id INT NOT NULL,           
    dim_sucursal_id INT NOT NULL,              
    dim_canal_id INT NOT NULL,   
    Monto DECIMAL(18, 2) NOT NULL,       
    Cantidad INT NOT NULL, 
    CONSTRAINT PK_hechos_transacciones PRIMARY KEY (id)
);

ALTER TABLE hechos_transacciones 
ADD CONSTRAINT FK_hechos_tiempo 
FOREIGN KEY (dim_tiempo_id) REFERENCES dim_tiempo(id);

ALTER TABLE hechos_transacciones 
ADD CONSTRAINT FK_hechos_tipo_transaccion 
FOREIGN KEY (dim_tipo_transaccion_id) REFERENCES dim_tipo_transaccion(id);

ALTER TABLE hechos_transacciones 
ADD CONSTRAINT FK_hechos_sucursal 
FOREIGN KEY (dim_sucursal_id) REFERENCES dim_sucursal(id);

ALTER TABLE hechos_transacciones 
ADD CONSTRAINT FK_hechos_canal 
FOREIGN KEY (dim_canal_id) REFERENCES dim_canal(id);