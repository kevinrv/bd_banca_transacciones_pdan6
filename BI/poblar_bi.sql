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
INNER JOIN
	cuentas c ON c.id = CASE 
			WHEN t.cuenta_origen_id IS NOT NULL
				THEN t.cuenta_origen_id
			ELSE t.cuenta_destino_id
			END
GROUP BY
	CAST(fecha_inicio_transaccion AS DATE),
	t.tipo_transaccion_id,
	c.sucursal_id,
	t.canal_id
ORDER BY 1;

-- Limpiar dimensiones

DELETE FROM dim_tiempo
 DBCC CHECKIDENT('dim_tiempo', RESEED, 0);
DELETE FROM dim_sucursal
 DBCC CHECKIDENT('dim_sucursal', RESEED, 0);
DELETE FROM dim_tipo_transaccion
 DBCC CHECKIDENT('dim_tipo_transaccion', RESEED, 0);
DELETE FROM dim_canal
 DBCC CHECKIDENT('dim_canal', RESEED, 0);
DELETE FROM hechos_transacciones
 DBCC CHECKIDENT('hechos_transacciones', RESEED, 0);


 
DROP TABLE dim_tiempo

DELETE FROM dim_sucursal

DELETE FROM dim_tipo_transaccion

DROP TABLE dim_canal

DROP TABLE hechos_transacciones

