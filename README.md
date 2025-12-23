# bd_banca_transacciones_pdan6
📌 Caso de Estudio
Banca – Gestión de Transacciones Bancarias

Una entidad bancaria desea desarrollar un sistema de información que permita registrar, controlar y analizar las transacciones realizadas por sus clientes a través de distintos canales (ventanilla, cajero automático, banca móvil, banca por internet) que permita gestionar las transacciones bancarias.

El sistema debe permitir:

Gestionar información de clientes.

Administrar cuentas bancarias de distintos tipos.

Registrar transacciones bancarias (depósitos, retiros, transferencias, pagos).

Controlar sucursales y canales de atención.

Posteriormente, facilitar el análisis de transacciones para la toma de decisiones gerenciales.

🧩 PARTE I – Modelo Transaccional (OLTP)
🎯 Objetivo

Diseñar un modelo de datos relacional normalizado que permita registrar correctamente las operaciones bancarias diarias.

🔹 Requerimientos del negocio

Un cliente puede ser persona natural o jurídica.

Un cliente puede tener una o más cuentas bancarias.

Cada cuenta pertenece a un solo cliente y a un tipo de cuenta (ahorros, corriente, plazo fijo, etc.).

Las cuentas se abren en una sucursal bancaria.

Las transacciones:

Se realizan sobre una cuenta.

Tienen un tipo de transacción (depósito, retiro, transferencia, pago).

Se ejecutan a través de un canal (ventanilla, ATM, app móvil, web).

Registran fecha, hora, monto y saldo resultante.

En el caso de transferencias, se debe identificar la cuenta origen y la cuenta destino.

🔹 Actividades solicitadas

Identificar las entidades del sistema.

Determinar atributos clave para cada entidad.

Definir:

Claves primarias

Claves foráneas

Cardinalidades y reglas de negocio

Elaborar el modelo entidad–relación (ER).

Transformar el modelo ER a un modelo relacional normalizado (3FN).

🔒 No se deben incluir sentencias SQL en esta etapa.

🧩 PARTE II – Modelo Dimensional (BI)
🎯 Objetivo

Diseñar un modelo dimensional que permita analizar las transacciones bancarias para fines estratégicos.

🔹 Requerimientos analíticos

La gerencia desea responder preguntas como:

¿Cuál es el monto total de transacciones por período?

¿Qué tipo de transacción se realiza con mayor frecuencia?

¿Qué canales concentran más operaciones?

¿Qué sucursales generan mayor volumen transaccional?

Evolución mensual del número y monto de transacciones.

🔹 Actividades solicitadas

Identificar el proceso de negocio a analizar.

Definir la tabla de hechos principal.

Identificar las dimensiones necesarias.

Establecer la granularidad del modelo.

Diseñar un modelo estrella que soporte los requerimientos.

🧠 Enfoque didáctico (alineado a tu curso)

Tema realista y cercano al mundo profesional.

Permite evaluar:

Análisis del negocio

Capacidad de abstracción

Dominio de normalización

Comprensión de BI

Escalable:

Puedes agregar luego SQL, indicadores, o Power BI.
