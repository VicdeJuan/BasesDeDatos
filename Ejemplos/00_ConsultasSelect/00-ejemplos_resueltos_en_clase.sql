# Ejemplos resueltos en la BBDD tiendaonline_completa.

USE tienda_online; -- Para indicar en qué base de datos vamos a trabajar.


## 1) Selección básica de datos y renombrado de columnas

-- Listado simple de nombres y correos de todos los clientes.
SELECT nombre,email -- La columna de la tabla de la BBDD se llama email, no correo.
FROM clientes;

-- Catálogo: nombre y precio de todos los productos.
show tables; -- para ver las tablas.
explain productos; -- para ver qué columnas hay
select * from productos; -- solamente para ver qué columnas hay

-- SOLUCIÓN:
SELECT nombre,precio
FROM productos;

-- Pedidos con su fecha y estado.
SELECT fecha_pedido,estado
FROM pedidos;

-- Pagos: método y monto registrados.

-- explain pagos; -- lo pongo porque necesito ver los nombres de las columnas.
select metodo_pago,total_pagado
from pagos;

-- Detalle de líneas: producto y cantidad por cada detalle_pedido.
SELECT id_producto,cantidad FROM detalle_pedido;


-- Clientes con fecha de registro (orden natural de inserción).
SELECT nombre,fecha_registro FROM clientes; -- Aquí el profesor echó una chapa fina
-- sobre la vida real, algo del informático, mi primo y el código de descuento
--  y alguna movida así más.

-- POR DEFECTO: EL ORDEN POR DEFECTO ES ORDEN NATURAL DE INSERCIÓN.

-- Si quisiera ordernar (por contestar a Gaba), utilizo ORDER BY al final de la query.
SELECT nombre,fecha_registro FROM clientes ORDER BY fecha_registro ASC; -- Ascendente.
SELECT nombre,fecha_registro FROM clientes ORDER BY fecha_registro DESC; -- Descendente.

-- Productos con su categoría asociada (solo columnas principales).
SELECT nombre,precio,categoria FROM productos;
-- IDs de pedidos y su total.
SELECT id_pedido,coste_total FROM pedidos;
-- IDs de pagos con su fecha de pago.
SELECT id_pago,fecha_pago FROM pagos;
-- Relación básica: id_pedido e id_producto de detalle_pedido.
SELECT id_pedido,id_producto from detalle_pedido;

## 2) Filtros con WHERE (comparadores, lógicos, BETWEEN, IN, LIKE, NULL)

-- Clientes registrados en 2024.
SELECT * FROM clientes WHERE YEAR(fecha_registro) = 2024;


-- Productos con precio > 200.
SELECT * FROM productos; -- VER LAS COLUMNAS
SELECT * FROM productos WHERE precio > 200;

-- Pedidos con estado = 'pendiente' y total > 500.
SELECT * FROM pedidos; -- ver las columnas
SELECT * FROM pedidos WHERE estado = 'pendiente' AND coste_total > 500;

-- OJO CON LOS TIPOS DE DATOS: '10' < '2' pero 10 > 2.  (Disclaimer)


-- Pagos cuyo método IN ('tarjeta','paypal').
SELECT * FROM pagos;
SELECT * FROM pagos WHERE metodo_pago = 'tarjeta' OR metodo_pago = 'paypal';
-- otra alternativa de resolución mejor:
SELECT * FROM pagos WHERE metodo_pago IN ('tarjeta','paypal');

-- Productos con stock entre 300 y 400.
SELECT * FROM productos WHERE stock >= 300 AND stock <= 400;
SELECT * FROM productos WHERE stock BETWEEN 340 AND 370;
-- SELECT * FROM productos WHERE stock IN (300,301,302,303,304,...,400);

-- Clientes de país IN ('España','México','Argentina').
SELECT * FROM clientes WHERE pais IN ('España','México','Argentina');

-- Productos cuyo nombre contenga Silla.
SELECT * FROM productos WHERE nombre like '_illa%';

-- contenga -> %palabra%
-- empiece -> palabra%
-- termine -> %palabra
-- % -> cualquier conjunto de caracteres (incluyendo ninguno)
-- _ -> un único caracter

-- LA BUSQUEDA ES CASE INSENSITIVE

-- Pedidos con fecha_pedido en abril de 2023.
SELECT * FROM pedidos WHERE fecha_pedido LIKE '2023-04%';
SELECT * FROM pedidos WHERE YEAR(fecha_pedido) = 2023 AND MONTH(fecha_pedido) = 04;
SELECT * FROM pedidos WHERE fecha_pedido < '2023-05-01 00:00:00' 
						AND fecha_pedido > '2023-03-31 23:59:59';
SELECT * FROM pedidos WHERE fecha_pedido BETWEEN '2023-04-01 00:00:00' AND
												'2023-04-30 23:59:59';
-- Pagos con fecha_pago IS NULL (simularía no pagados si existieran).
SELECT * FROM pagos WHERE fecha_pago is NULL;
-- SELECT * FROM pagos WHERE fecha_pago is not NULL;

-- Detalles donde cantidad sea 3 o más pero el precio_unitario menor que 50.
SELECT * FROM detalle_pedido
	WHERE cantidad >= 3 AND precio_unitario < 50;


## 3) Ordenación, límite y duplicados (ORDER BY, LIMIT, DISTINCT)

-- Top 10 productos más caros.
-- Últimos 20 pedidos por fecha_pedido DESC.
-- Clientes más recientes por fecha_registro.
-- Primeros 5 productos con menor stock.
-- DISTINCT de categorías de productos disponibles.
-- Países distintos de los clientes registrados.
-- Pagos ordenados por monto DESC (mayor a menor).
-- Pedidos ordenados por total ASC.
-- Primeros 10 clientes por orden alfabético del nombre.
-- Top 5 productos más baratos en la categoría “Accesorios”.


