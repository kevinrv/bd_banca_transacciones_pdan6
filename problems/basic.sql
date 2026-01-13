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

*/

SELECT t.*, c.nombre AS 'canal'
FROM transacciones t
INNER JOIN canales c ON c.id=t.canal_id
WHERE c.nombre='Banca Móvil';


/*

Caso 4

Obtener todas las transacciones cuyo monto sea mayor a 1000 soles.

*/

SELECT COUNT(*) FROM transacciones;

SELECT *
FROM transacciones
WHERE monto> '1000';


SELECT *
FROM transacciones
WHERE monto< '1000';
/*

Caso 5

Listar las sucursales ordenadas por fecha de creación (de la más antigua a la más reciente).

*/

SELECT*FROM sucursales
ORDER BY fecha_creacion ASC;
/*

Caso 6

Mostrar los distintos tipos de transacción registrados en el sistema.

*/ 

SELECT DISTINCT(tt.nombre)
FROM transacciones t
INNER JOIN tipos_transaccion tt ON tt.id=t.tipo_transaccion_id;
/*

Caso 7

Listar las cuentas que pertenecen a clientes jurídicos.

*/

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

Caso 8

Mostrar las transacciones realizadas en una fecha específica.
*/

SELECT*FROM transacciones
WHERE CONVERT(DATE, fecha_inicio_transaccion)='2025-12-25';
/*

Caso 9

Listar las cuentas cuyo saldo sea menor a 500 soles.

*/

SELECT *
FROM cuentas
WHERE saldo < 500 AND moneda='SOL';

/*

Caso 10

Mostrar las transacciones indicando:

monto

fecha

tipo de transacción

canal utilizado
*/