/*

🟠 NIVEL 3 – AVANZADO (Control y Gestión Bancaria)

📙 Objetivo: subconsultas, CTE, CASE, EXISTS, lógica de negocio

Caso 21

Identificar clientes que retiraron más dinero del que depositaron.

Caso 22

Mostrar cuentas cuyo saldo actual no coincide con el movimiento histórico de transacciones.

Caso 23

Clasificar las transacciones según monto:

Bajo (< 500)

Medio (500 – 2000)

Alto (> 2000)

*/

USE bd_banca_transacciones_pdan6;
SELECT
id,
monto,
CASE
	WHEN monto<'500' THEN 'bajo'
	WHEN monto > '500' AND monto < '2000' THEN 'Medio'
	WHEN monto > '2000' THEN 'Alto'
END  AS 'clasificacion'
FROM transacciones;


SELECT*FROM sucursales;
/*
Caso 24

Listar los clientes que realizaron transacciones en más de un canal.

Caso 25

Obtener las cuentas con movimientos consecutivos en días seguidos.

Caso 26

Mostrar las transacciones realizadas fuera del horario laboral (ej. después de las 6pm).

Caso 27

Identificar clientes inactivos (sin transacciones en los últimos 6 meses).

Caso 28

Mostrar el ranking de clientes por volumen de dinero movido.

Caso 29

Detectar transacciones que superan el promedio general del sistema.

Caso 30

Obtener el canal dominante por sucursal.
*/