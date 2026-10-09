-- AQUÍ SOLO ESTÁN LAS CONSULTAS QUE EJECUTAMOS PARA CONSTRUIR EL EXCEL.
-- MIRA EN EL AV EL EXCEL CON LOS RESULTADOS DE ESTAS CONSUTLAS Y LAS EXPLICACIONES.
use tienda_online;

SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos;


SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_cliente = clientes.id_cliente;


SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_cliente = clientes.id_cliente  AND	nombre LIKE '%Ana Torres%';


-- ej 2:

SELECT	clientes.id_cliente, clientes.nombre,
	pedidos.id_pedido,pedidos.id_cliente,pedidos.fecha_pedido, pedidos.estado,pedidos.coste_total
FROM	clientes, pedidos
WHERE	pedidos.id_pedido = clientes.id_cliente;


-- ej 3: 
SELECT	
     productos.id_producto, productos.nombre,
	 detalle_pedido.id_detalle,detalle_pedido.id_pedido, detalle_pedido.id_producto, detalle_pedido.cantidad
FROM 	productos p ,detalle_pedido dp
WHERE detalle_pedido.id_producto = productos.id_producto;

-- version resumida 1:

SELECT	
     p.id_producto, p.nombre,
	 dp.id_detalle,dp.id_pedido, dp.id_producto, dp.cantidad
FROM 	productos AS p ,detalle_pedido AS dp
WHERE dp.id_producto = p.id_producto;


-- EJ 4
SELECT 
	c.id_cliente,c.nombre,dp.id_producto,dp.cantidad
FROM clientes as c, detalle_pedido as dp, pedidos as p
WHERE p.id_pedido = dp.id_pedido AND p.id_cliente = c.id_cliente;

