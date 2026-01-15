USE bd_pdan_transacciones_bi_6;
USE bd_banca_transacciones_pdan6;

-- Poblar dim_tiempo
SELECT*FROM dim_tiempo;

SELECT 
	DISTINCT CONVERT(DATE,fecha_inicio_transaccion) AS 'fecha_transaccion',
	YEAR(fecha_inicio_transaccion) AS 'anio', 
	MONTH(fecha_inicio_transaccion) AS 'mes',
	DAY(fecha_inicio_transaccion) AS 'dia'
FROM transacciones;

-- Poblar dim_canal
SELECT
	id AS canal_id,
	nombre AS 'canal'
FROM canales;

-- poblar dim_sucursal

SELECT
	id AS 'sucursal_id',
	codigo AS 'sucursal',
	sector
FROM sucursales;


--poblar dim_tipo_transaccion

SELECT
id AS 'tipo_transaccion_id',
nombre AS 'tipo_transaccion'
FROM tipos_transaccion;
--Poblar Hechos transacciones

SELECT
	CAST(fecha_inicio_transaccion AS DATE) AS 'fecha_transaccion',
	t.tipo_transaccion_id,
	c.sucursal_id,
	t.canal_id,
	SUM(monto) AS 'Monto',
	COUNT(t.id) AS 'cantidad'
FROM transacciones t
INNER JOIN cuentas c ON t.cuenta_origen_id = c.id AND t.cuenta_destino_id IS NULL
WHERE c.id IN ()
GROUP BY
	CAST(fecha_inicio_transaccion AS DATE),
	t.tipo_transaccion_id,
	c.sucursal_id,
	t.canal_id;

	SELECT*FROM transacciones;