-- Examen RA3 · Versión A. Soluciones para MySQL 8.
-- Datos: tiendaonline-schema.sql + tiendaonline-data-parte1.sql + tiendaonline-data-parte2.sql
USE tienda_online;

-- Consulta 1: Muestra el nombre y la categoría de cada producto en una sola columna, con el formato «nombre [categoría]». Ordena por identificador de producto.
SELECT id_producto, CONCAT(nombre, ' [', categoria, ']') AS producto_categoria
FROM productos
ORDER BY id_producto;

-- Consulta 2: Muestra el identificador, nombre y número de mes de registro de cada cliente. Ordena por identificador de cliente.
SELECT id_cliente, nombre, MONTH(fecha_registro) AS mes_registro
FROM clientes
ORDER BY id_cliente;

-- Consulta 3: Muestra los diez productos con mayor valor de inventario (precio por stock). Incluye identificador, nombre y valor; desempata por identificador.
SELECT id_producto, nombre, precio * stock AS valor_inventario
FROM productos
ORDER BY valor_inventario DESC, id_producto ASC
LIMIT 10;

-- Consulta 4: Calcula la suma de coste_total de los pedidos por año y estado. Muestra año, estado e importe, ordenados por año y por importe descendente.
SELECT YEAR(fecha_pedido) AS anio, estado, SUM(coste_total) AS importe
FROM pedidos
GROUP BY YEAR(fecha_pedido), estado
ORDER BY anio, importe DESC, CONCAT(estado, '') ASC;

-- Consulta 5: Cuenta los clientes de cada país. Muestra el país y el número de clientes, ordenados por número de clientes descendente y país.
SELECT pais, COUNT(*) AS clientes
FROM clientes
GROUP BY pais
ORDER BY clientes DESC, pais ASC;

-- Consulta 6: Cuenta los clientes registrados en cada día del mes, sin distinguir mes ni año. Muestra el número de día y el número de clientes, ordenados por día.
SELECT DAY(fecha_registro) AS dia_mes, COUNT(*) AS clientes
FROM clientes
GROUP BY DAY(fecha_registro)
ORDER BY dia_mes;

-- Consulta 7: Usa obligatoriamente CHAR_LENGTH(), función no trabajada en clase. Considera los productos cuyo nombre tiene al menos 16 caracteres y, por categoría, muestra cuántos hay y su precio medio redondeado a dos decimales. Ordena por cantidad descendente y categoría.
SELECT categoria, COUNT(*) AS productos, ROUND(AVG(precio), 2) AS precio_medio
FROM productos
WHERE CHAR_LENGTH(nombre) >= 16
GROUP BY categoria
ORDER BY productos DESC, categoria ASC;

-- Consulta 8: Usa obligatoriamente WEEKDAY(), función no trabajada en clase (lunes = 0). Para los pedidos de 2024, suma el coste por día de la semana. Muestra el día y el importe, ordenados por importe descendente y día ascendente.
SELECT WEEKDAY(fecha_pedido) AS dia_semana, SUM(coste_total) AS importe
FROM pedidos
WHERE YEAR(fecha_pedido) = 2024
GROUP BY WEEKDAY(fecha_pedido)
ORDER BY importe DESC, dia_semana ASC;
