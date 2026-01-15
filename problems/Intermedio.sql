
USE bd_banca_transacciones_pdan6;
/*
🟡 NIVEL 2 – INTERMEDIO (Análisis Operativo)

📗 Objetivo: GROUP BY, HAVING, funciones agregadas, JOIN múltiples

Caso 11

Calcular el monto total transaccionado por cada tipo de transacción.

*/

SELECT 
	tt.nombre AS 'tipo_transaccion',
	SUM(t.monto) AS 'monto total'
FROM transacciones t
INNER JOIN tipos_transaccion tt ON tt.id =t.tipo_transaccion_id
GROUP BY tt.nombre;

/*

Caso 12

Obtener el número de transacciones por canal.
*/

SELECT 
	t.canal_id,
	c.nombre,
	COUNT(*) AS total_transacciones
FROM transacciones t
INNER JOIN canales c ON c.id=t.canal_id
GROUP BY canal_id, c.nombre;

/*
Caso 13

Listar los clientes que tienen más de 20  cuentas.

*/

SELECT 
	c.id, 
	COUNT(cn.cliente_id) AS 'num_cuentas'
FROM clientes c
INNER JOIN cuentas cn ON cn.cliente_id=c.id
GROUP BY c.id
HAVING COUNT(cn.cliente_id)>20;

--Version 2

SELECT 
	c.id,
	n.nombres,
	COUNT(cn.cliente_id) AS 'num_cuentas'
FROM clientes c
INNER JOIN personas_naturales n ON n.cliente_id=c.id
INNER JOIN cuentas cn ON cn.cliente_id=c.id
GROUP BY c.id,n.nombres
HAVING COUNT(cn.cliente_id)>20
UNION

SELECT 
	c.id,
	j.razon_social,
	COUNT(cn.cliente_id) AS 'num_cuentas'
FROM clientes c
INNER JOIN personas_juridicas j ON j.cliente_id=c.id
INNER JOIN cuentas cn ON cn.cliente_id=c.id
GROUP BY c.id,j.razon_social
HAVING COUNT(cn.cliente_id)>20
/*

Caso 14

Mostrar el saldo promedio por tipo de cuenta.
*/

select
c.nombre,
 AVG(t.saldo) AS Saldo
 from cuentas t 
INNER JOIN tipos_cuenta c ON c.id = t.tipo_cuenta_id
GROUP BY c.nombre;

/*


Caso 15

Identificar las sucursales que registraron más de 2500 transacciones.
*/

SELECT  s.codigo, Count(tor.id) AS 'count'
INTO #t01
FROM sucursales s
INNER JOIN cuentas c ON c.sucursal_id=s.id 
INNER JOIN transacciones tor ON tor.cuenta_origen_id = c.id AND tor.cuenta_destino_id IS NULL
GROUP BY s.codigo
UNION
SELECT s.codigo, Count(tor.id) AS 'count'
FROM sucursales s
INNER JOIN cuentas c ON c.sucursal_id=s.id 
INNER JOIN transacciones tor ON tor.cuenta_origen_id = c.id AND tor.cuenta_destino_id IS NOT NULL
GROUP BY s.codigo
UNION
SELECT s.codigo, Count(tor.id) AS 'count'
FROM sucursales s
INNER JOIN cuentas c ON c.sucursal_id=s.id 
INNER JOIN transacciones tor ON tor.cuenta_destino_id = c.id AND tor.cuenta_origen_id IS NULL
GROUP BY s.codigo

SELECT 
codigo,
SUM(count)
FROM #t01
GROUP BY codigo
HAVING SUM(count)> 2500;

SELECT 
codigo,
SUM(count)
FROM #t01
GROUP BY codigo
HAVING SUM(count)< 2500;


SELECT*FROM transacciones;
/*

Caso 16

Obtener el cliente que realizó el mayor monto acumulado en transacciones.

Caso 17

Mostrar el total de transacciones por día.

Caso 18

Listar las cuentas que nunca registraron transacciones.

Caso 19

Calcular el monto total transaccionado por tipo de cliente (N / J).

Caso 20

Mostrar los 3 canales más utilizados según número de transacciones.
*/