USE bd_banca_transacciones_pdan6;
/*
🟢 NIVEL 1 – BÁSICO (Fundamentos OLTP)

📘 Objetivo: dominar SELECT, WHERE, JOIN simples, ORDER BY

Caso 1

Listar todos los clientes naturales mostrando:

id_cliente

nombres

apellidos
*/

SELECT 
	cliente_id, 
	nombres, 
	apellidos
FROM personas_naturales;


/*
tipo_cliente

Caso 2

Mostrar todas las cuentas indicando:

número de cuenta

tipo de cuenta

saldo actual

nombre del cliente */

SELECT 
	cn.num_cuenta,
	tc.nombre AS 'tipo_cuenta',
	cn.saldo,
	n.nombres AS 'nombre_cliente',
	c.tipo_cliente
FROM cuentas cn
INNER JOIN tipos_cuenta tc ON tc.id=cn.tipo_cuenta_id
INNER JOIN clientes c ON c.id=cn.cliente_id
INNER JOIN personas_naturales n ON n.cliente_id=c.id
UNION
SELECT 
	cn.num_cuenta,
	tc.nombre AS 'tipo_cuenta',
	cn.saldo,
	j.razon_social AS 'nombre_cliente',
	c.tipo_cliente
FROM cuentas cn
INNER JOIN tipos_cuenta tc ON tc.id=cn.tipo_cuenta_id
INNER JOIN clientes c ON c.id=cn.cliente_id
INNER JOIN personas_juridicas j ON j.cliente_id=c.id;

/*

Caso 3

Listar todas las transacciones realizadas por el canal Banca Móvil.

Caso 4

Obtener todas las transacciones cuyo monto sea mayor a 1000 soles.

Caso 5

Listar las sucursales ordenadas por fecha de creación (de la más antigua a la más reciente).

Caso 6

Mostrar los distintos tipos de transacción registrados en el sistema.

Caso 7

Listar las cuentas que pertenecen a clientes jurídicos.

Caso 8

Mostrar las transacciones realizadas en una fecha específica.

Caso 9

Listar las cuentas cuyo saldo sea menor a 500.

Caso 10

Mostrar las transacciones indicando:

monto

fecha

tipo de transacción

canal utilizado
*/