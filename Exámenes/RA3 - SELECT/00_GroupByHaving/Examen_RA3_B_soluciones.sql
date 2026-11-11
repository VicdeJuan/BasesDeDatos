-- Examen RA3 · Versión B. Soluciones para MySQL 8.
-- Datos: tiendaonline-schema.sql + tiendaonline-data-parte1.sql + tiendaonline-data-parte2.sql
USE tienda_online;

-- Consulta 1: Construye una etiqueta de cada cliente con el formato «nombre - país». Muestra también su identificador y ordena por él.
SELECT id_cliente, CONCAT(nombre, ' - ', pais) AS cliente_pais
FROM clientes
ORDER BY id_cliente;

-- Consulta 2: Muestra el identificador, fecha y número de día del mes de los quince primeros pedidos por identificador.
SELECT id_pedido, fecha_pedido, DAY(fecha_pedido) AS dia_mes
FROM pedidos
ORDER BY id_pedido
LIMIT 15;

-- Consulta 3: Calcula el precio de cada producto tras un descuento del 10 %, redondeado a dos decimales. Muestra los diez precios rebajados más bajos con identificador y nombre; desempata por identificador.
SELECT id_producto, nombre, ROUND(precio * 0.90, 2) AS precio_rebajado
FROM productos
ORDER BY precio_rebajado ASC, id_producto ASC
LIMIT 10;

-- Consulta 4: Suma el total pagado por cada método de pago. Muestra método e importe, ordenados por importe descendente y método.
SELECT metodo_pago, SUM(total_pagado) AS importe
FROM pagos
GROUP BY metodo_pago
ORDER BY importe DESC, CONCAT(metodo_pago, '') ASC;

-- Consulta 5: Calcula el precio medio de los productos por categoría. Redondea a dos decimales y ordena por media descendente y categoría.
SELECT categoria, ROUND(AVG(precio), 2) AS precio_medio
FROM productos
GROUP BY categoria
ORDER BY precio_medio DESC, categoria ASC;

-- Consulta 6: Suma el coste de los pedidos por día del mes, sin distinguir mes ni año. Muestra día e importe, ordenados por día.
SELECT DAY(fecha_pedido) AS dia_mes, SUM(coste_total) AS importe
FROM pedidos
GROUP BY DAY(fecha_pedido)
ORDER BY dia_mes;

-- Consulta 7: Usa obligatoriamente MOD(), función no trabajada en clase. Considera los productos con stock par y muestra, por categoría, cuántos productos hay y la suma de su stock. Ordena por suma descendente y categoría.
SELECT categoria, COUNT(*) AS productos, SUM(stock) AS stock_total
FROM productos
WHERE MOD(stock, 2) = 0
GROUP BY categoria
ORDER BY stock_total DESC, categoria ASC;

-- Consulta 8: Usa obligatoriamente LAST_DAY(), función no trabajada en clase. Agrupa los pagos de 2024 por último día del mes de pago y método. Muestra esa fecha, el método, el número de pagos y el importe total; ordena por fecha y método.
SELECT LAST_DAY(fecha_pago) AS fin_mes, metodo_pago,
       COUNT(*) AS pagos, SUM(total_pagado) AS importe
FROM pagos
WHERE YEAR(fecha_pago) = 2024
GROUP BY LAST_DAY(fecha_pago), metodo_pago
ORDER BY fin_mes, CONCAT(metodo_pago, '') ASC;
