-- Simulacro RA3 · Versión D. Soluciones para MySQL 8.
-- Datos: tiendaonline-schema.sql + tiendaonline-data-parte1.sql + tiendaonline-data-parte2.sql
-- Desempates adicionales por identificador (consulta 3) y estado alfabético (consulta 6).
-- DATEDIFF conserva los valores negativos presentes en los datos.
USE tienda_online;

-- Consulta 1: Muestra las diez líneas de pedido con mayor importe (cantidad por precio_unitario). Incluye identificador de línea, cantidad, precio unitario e importe; desempata por identificador.
SELECT id_detalle, cantidad, precio_unitario,
       cantidad * precio_unitario AS importe_linea
FROM detalle_pedido
ORDER BY importe_linea DESC, id_detalle ASC
LIMIT 10;

-- Consulta 2: Muestra el identificador, fecha y año de pago de los quince primeros pagos por identificador. Conserva los pagos sin fecha.
SELECT id_pago, fecha_pago, YEAR(fecha_pago) AS anio_pago
FROM pagos
ORDER BY id_pago
LIMIT 15;

-- Consulta 3: Construye una etiqueta para cada cliente con el formato «nombre <email>». Muestra el identificador y la etiqueta, ordenados por la quinta letra del nombre.
SELECT id_cliente, CONCAT(nombre, ' <', email, '>') AS contacto
FROM clientes
ORDER BY SUBSTRING(nombre, 5, 1) ASC, id_cliente ASC;

-- Consulta 4: Suma el coste de los pedidos por número de mes, reuniendo todos los años. Muestra mes e importe, ordenados por mes.
SELECT MONTH(fecha_pedido) AS mes, SUM(coste_total) AS importe
FROM pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY mes;

-- Consulta 5: Calcula el stock medio por categoría. Redondea la media a dos decimales y ordena por ella de menor a mayor y por categoría.
SELECT categoria, ROUND(AVG(stock), 2) AS stock_medio
FROM productos
GROUP BY categoria
ORDER BY stock_medio ASC, categoria ASC;

-- Consulta 6: Cuenta los pedidos distintos por día del mes y estado, sin distinguir mes ni año. Muestra día, estado y número de pedidos; ordena por día y por número de pedidos descendente.
SELECT DAY(fecha_pedido) AS dia_mes, estado, COUNT(DISTINCT id_pedido) AS pedidos
FROM pedidos
GROUP BY DAY(fecha_pedido), estado
ORDER BY dia_mes ASC, pedidos DESC, CONCAT(estado, '') ASC;

-- Consulta 7: Usa obligatoriamente DATEDIFF(), función no trabajada en clase. Relaciona cada pedido con su cliente y calcula, por país, el promedio de días entre el registro del cliente y el pedido. Muestra también el número de pedidos y ordena por número de pedidos descendente y país. Redondea el promedio a un decimal.
SELECT c.pais, COUNT(*) AS pedidos,
       ROUND(AVG(DATEDIFF(p.fecha_pedido, c.fecha_registro)), 1) AS dias_medios
FROM clientes AS c
JOIN pedidos AS p ON p.id_cliente = c.id_cliente
GROUP BY c.pais
ORDER BY pedidos DESC, c.pais ASC;

-- Consulta 8: Usa obligatoriamente LEAST(), función no trabajada en clase. Por año de pedido, muestra el número de pedidos, la suma de todos sus costes y la suma de los costes limitados a 1000 euros por pedido. Ordena por año.
SELECT YEAR(fecha_pedido) AS anio, COUNT(*) AS pedidos,
       SUM(coste_total) AS importe_total,
       SUM(LEAST(coste_total, 1000)) AS importe_limitado
FROM pedidos
GROUP BY YEAR(fecha_pedido)
ORDER BY anio;

-- Extra (0,5 puntos): ¿Ha habido algún pago en 29 de febrero? ¿Y algún pedido?
-- Las consultas devuelven los registros encontrados, cualquiera que sea el año.
-- EXTRA - PAGOS DEL 29 DE FEBRERO
SELECT id_pago, id_pedido, fecha_pago, total_pagado
FROM pagos
WHERE MONTH(fecha_pago) = 2 AND DAY(fecha_pago) = 29
ORDER BY id_pago;

-- EXTRA - PEDIDOS DEL 29 DE FEBRERO
SELECT id_pedido, id_cliente, fecha_pedido, estado, coste_total
FROM pedidos
WHERE MONTH(fecha_pedido) = 2 AND DAY(fecha_pedido) = 29
ORDER BY id_pedido;
