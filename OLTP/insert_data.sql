USE bd_banca_transacciones_pdan6;
GO
-- EJERCICIOS PARTE 1
--- Persona natural
SELECT*FROM personas_naturales;
--Insert
INSERT INTO personas_naturales (numero_documento,nombres,apellidos,direccion,celular, email,fecha_nacimiento,genero,estado_civil)
VALUES ('12345678','kevin','rivera vergaray','Lima-Santa Anita','918839228', 'krv@gmail.com','1996-05-12','Masculino','Soltero');


INSERT INTO personas_naturales (numero_documento,nombres,apellidos,direccion,celular, email,fecha_nacimiento,genero,estado_civil)
VALUES ('12305608','Jose','Flores Flores','Lima-Rimac','918530j28', 'jff2@gmail.com','1998-09-12','Masculino','Casado');

--Update
UPDATE personas_naturales SET direccion='Lima-Breña'
WHERE id=5;

--Delete
DELETE FROM personas_naturales WHERE id=5;

--- Personas Juridicas

SELECT*FROM personas_juridicas;

INSERT INTO personas_juridicas VALUES (
'12345670910','DSRP 2 Perú', 'Lima - Perú','dsrp2@gmail.com','123456789','Mype','educación','2018-12-12');


-- Clientes

SELECT*FROM clientes;

INSERT INTO clientes VALUES 
(2,'Persona Natural'),
(4,'Persona Natural'),
(1,'Persona Juridica');

INSERT INTO clientes VALUES 
(2,'Persona Juridica');

EXEC SP_HELP clientes;


--- Eliminar Constraint
ALTER TABLE clientes
DROP FK__clientes__person__3D5E1FD2;

ALTER TABLE clientes
DROP FK__clientes__person__3E52440B;

-- SELECT clientes Personas naturales
SELECT*FROM clientes;

SELECT c.persona_id,c.tipo_cliente, n.numero_documento, n.nombres, n.apellidos
FROM clientes c
INNER JOIN personas_naturales n ON n.id=c.persona_id AND c.tipo_cliente='Persona Natural';

-- SELECT clientes Personas juridica

SELECT c.persona_id,c.tipo_cliente, j.ruc, j.razon_social, j.email
FROM clientes c
INNER JOIN personas_juridicas j ON j.id=c.persona_id AND c.tipo_cliente='Persona Juridica';

--ELIMINAR DATA PERSONAS 

DELETE FROM personas_juridicas;
DELETE FROM personas_naturales;


--- EJERCICIOS PARTE 2
--  clientes naturales

DECLARE @i INT = 1;

WHILE @i <= 200
BEGIN
    INSERT INTO clientes (tipo_cliente)
    VALUES ('N');

    SET @i += 1;
END;

SELECT*FROM clientes;
SELECT*FROM personas_naturales;

DECLARE @cliente_id INT;

DECLARE cur_clientes_n CURSOR FOR
SELECT id
FROM clientes
WHERE tipo_cliente = 'N'
AND id NOT IN (SELECT cliente_id FROM personas_naturales);

OPEN cur_clientes_n;
FETCH NEXT FROM cur_clientes_n INTO @cliente_id;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO personas_naturales (
        numero_documento,
        nombres,
        apellidos,
        direccion,
        celular,
        email,
        fecha_nacimiento,
        genero,
        estado_civil,
        cliente_id
    )
    VALUES (
        CAST(ABS(CHECKSUM(NEWID())) % 90000000 + 10000000 AS VARCHAR),
        CONCAT('Nombre', @cliente_id),
        CONCAT('Apellido', @cliente_id),
        CONCAT('Av. Principal ', @cliente_id),
        CONCAT('9', ABS(CHECKSUM(NEWID())) % 90000000),
        CONCAT('cliente', @cliente_id, '@correo.com'),
        DATEADD(YEAR, - (ABS(CHECKSUM(NEWID())) % 50 + 18), GETDATE()),
        CASE WHEN @cliente_id % 2 = 0 THEN 'Masculino' ELSE 'Femenino' END,
        CASE WHEN @cliente_id % 3 = 0 THEN 'Casado' ELSE 'Soltero' END,
        @cliente_id
    );

    FETCH NEXT FROM cur_clientes_n INTO @cliente_id;
END;

CLOSE cur_clientes_n;
DEALLOCATE cur_clientes_n;


--- Personas Jurdicas
DECLARE @i INT = 1;
SET @i = 1;

WHILE @i <= 200
BEGIN
    INSERT INTO clientes (tipo_cliente)
    VALUES ('J');

    SET @i += 1;
END;

DECLARE @cliente_j_id INT;

DECLARE cur_clientes_j CURSOR FOR
SELECT id
FROM clientes
WHERE tipo_cliente = 'J'
AND id NOT IN (SELECT cliente_id FROM personas_juridicas);

OPEN cur_clientes_j;
FETCH NEXT FROM cur_clientes_j INTO @cliente_j_id;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO personas_juridicas (
        ruc,
        razon_social,
        direccion,
        email,
        telefono,
        tipo_empresa,
        rubro,
        fecha_creacion,
        cliente_id
    )
    VALUES (
        CAST(ABS(CHECKSUM(NEWID())) % 90000000000 + 10000000000 AS CHAR(11)),
        CONCAT('Empresa ', @cliente_j_id),
        CONCAT('Calle Comercial ', @cliente_j_id),
        CONCAT('empresa', @cliente_j_id, '@correo.com'),
        CONCAT('01', ABS(CHECKSUM(NEWID())) % 9000000),
        CASE
			WHEN @cliente_j_id % 2 = 0 THEN 'SAC'
			WHEN @cliente_j_id % 3 = 0 THEN 'EIRL'
			WHEN @cliente_j_id % 5 = 0 THEN 'SA'
			WHEN @cliente_j_id % 7 = 0 THEN 'SAA'
		ELSE 'SRL' END,
        CASE 
			 WHEN @cliente_j_id % 2 = 0 THEN 'Servicios'
			 WHEN @cliente_j_id % 3 = 0 THEN 'Comercio'
			 WHEN @cliente_j_id % 5 = 0 THEN 'Agroindustria'
			 WHEN @cliente_j_id % 7 = 0 THEN 'Manufactura'
		ELSE 'Minería' END,
        DATEADD(YEAR, - (ABS(CHECKSUM(NEWID())) % 20 + 1), GETDATE()),
        @cliente_j_id
    );

    FETCH NEXT FROM cur_clientes_j INTO @cliente_j_id;
END;

CLOSE cur_clientes_j;
DEALLOCATE cur_clientes_j;


SELECT*FROM personas_juridicas;

INSERT INTO canales (nombre, descripcion)
VALUES
('Ventanilla', 'Atención presencial en sucursal'),
('Cajero Automático', 'Operaciones mediante ATM'),
('Banca Móvil', 'Aplicación móvil del banco'),
('Banca por Internet', 'Portal web del banco'),
('Agente Corresponsal', 'Agentes autorizados externos'),
('Call Center', 'Atención telefónica'),
('POS', 'Pagos mediante terminal POS');


INSERT INTO tipos_cuenta (nombre, descripcion)
VALUES
('Ahorros', 'Cuenta de ahorros tradicional'),
('Cuenta Corriente', 'Cuenta para operaciones frecuentes'),
('Plazo Fijo', 'Cuenta con plazo y tasa fija'),
('CTS', 'Cuenta de Compensación por Tiempo de Servicios'),
('Sueldo', 'Cuenta para pago de planillas'),
('Dólares', 'Cuenta en moneda extranjera (USD)');

INSERT INTO tipos_transaccion (nombre, descripcion)
VALUES
('Depósito', 'Ingreso de dinero a una cuenta'),
('Retiro', 'Salida de dinero de una cuenta'),
('Transferencia', 'Envío de dinero entre cuentas'),
('Pago de Servicios', 'Pago de servicios básicos'),
('Pago de Préstamo', 'Pago de cuotas de préstamo'),
('Pago con Tarjeta', 'Pago mediante tarjeta de débito'),
('Anulación', 'Reverso de una transacción');

	SELECT * FROM canales;
SELECT * FROM tipos_cuenta;
SELECT * FROM tipos_transaccion;
SELECT * FROM sucursales;