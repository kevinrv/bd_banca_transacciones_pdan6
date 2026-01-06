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