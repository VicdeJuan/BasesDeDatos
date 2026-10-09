-- Examen RA3 · Versión C. Soluciones para MySQL 8.
-- Datos: tiendaonline-schema.sql + tiendaonline-data-parte1.sql + tiendaonline-data-parte2.sql
USE tienda_online;

-- Consulta 1: Construye una etiqueta para los quince primeros pedidos con el formato «Pedido identificador / estado». Muestra también el identificador y ordena por él.
SELECT id_pedido, CONCAT('Pedido ', id_pedido, ' / ', estado) AS etiqueta
FROM pedidos
ORDER BY id_pedido
LIMIT 15;

-- Consulta 2: Muestra el identificador, nombre y trimestre de registro de los quince primeros clientes por identificador.
SELECT id_cliente, nombre, QUARTER(fecha_registro) AS trimestre
FROM clientes
ORDER BY id_cliente
LIMIT 15;

-- Consulta 3: Muestra los diez productos cuya diferencia absoluta entre su stock y 350 unidades es mayor. Incluye identificador, nombre y diferencia; desempata por identificador.
SELECT id_producto, nombre, ABS(stock - 350) AS diferencia_stock
FROM productos
ORDER BY diferencia_stock DESC, id_producto ASC
LIMIT 10;

-- Consulta 4: Calcula por pedido la suma de los importes de sus líneas de detalle (cantidad por precio_unitario). Muestra identificador de pedido e importe; ordena por identificador.
SELECT id_pedido, SUM(cantidad * precio_unitario) AS importe_lineas
FROM detalle_pedido
GROUP BY id_pedido
ORDER BY id_pedido;

-- Consulta 5: Cuenta los pedidos por estado. Muestra el estado y el número de pedidos, ordenados por número de pedidos descendente y estado.
SELECT estado, COUNT(*) AS pedidos
FROM pedidos
GROUP BY estado
ORDER BY pedidos DESC, CONCAT(estado, '') ASC;

-- Consulta 6: Cuenta los pagos con fecha en cada día del mes, sin distinguir mes ni año. Muestra día y número de pagos, ordenados por día.
SELECT DAY(fecha_pago) AS dia_mes, COUNT(*) AS pagos
FROM pagos
WHERE fecha_pago IS NOT NULL
GROUP BY DAY(fecha_pago)
ORDER BY dia_mes;

-- Consulta 7: Usa obligatoriamente DAYOFYEAR(), función no trabajada en clase. Considera los clientes registrados después del día 180 de su año y, por año, muestra cuántos son y de cuántos países distintos proceden. Ordena por año.
SELECT YEAR(fecha_registro) AS anio, COUNT(*) AS clientes,
       COUNT(DISTINCT pais) AS paises
FROM clientes
WHERE DAYOFYEAR(fecha_registro) > 180
GROUP BY YEAR(fecha_registro)
ORDER BY anio;

-- Consulta 8: Usa obligatoriamente GREATEST(), función no trabajada en clase. Para cada producto de precio al menos 20 euros, calcula cuántas unidades superan el umbral de 350, asignando 0 si no lo supera. Suma ese exceso por categoría y ordena por exceso descendente y categoría.
SELECT categoria, SUM(GREATEST(stock - 350, 0)) AS exceso_stock
FROM productos
WHERE precio >= 20
GROUP BY categoria
ORDER BY exceso_stock DESC, categoria ASC;
