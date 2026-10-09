-- Fechas en las que se ha pedido cada producto identificado por nombre de producto.

/* 1) ¿Qué necesito? 
- pedidos.fecha_pedido
- productos.nombre
- detalle_pedido para unir las 2 tablas.
	2) ¿Qué columnas unen?
pedidos y detalle_pedido se unen con pedidos.id_pedido = detalle_pedido.id_pedido
productos y detalle_pedido se unen con productos.id_producto = detalle_pedido.id_producto.

Tip: el fallo típico es poner como condición id_pedido = id_producto (que no tiene sentido, pero funciona).
*/ 

-- versión "cutre"
SELECT pr.nombre, pr.id_producto ,pe.fecha_pedido
FROM pedidos AS pe, productos AS pr, detalle_pedido AS dp
WHERE pe.id_pedido = dp.id_pedido AND pr.id_producto = dp.id_producto;

-- versión pro (hay varias, cada una mejor que la anterior)
SELECT  pr.nombre, pr.id_producto ,pe.fecha_pedido
FROM 
	pedidos pe 
		JOIN 
	detalle_pedido dp ON pe.id_pedido = dp.id_pedido
		JOIN 
	productos pr ON dp.id_producto = pr.id_producto;

SELECT  pr.nombre, pr.id_producto ,pe.fecha_pedido
FROM 
	pedidos pe 
		JOIN 
	detalle_pedido dp USING(id_pedido) -- solo si la columna se llama igual en las 2 tablas.
		JOIN 
	productos pr USING(id_producto);

-- Saca el listado de productos (nombre e id) y el nombre de los clientes que los han comprado.
/* 
1) ¿Qué necesito? 
clientes.nombre
productos.nombre
necesito para unir:
productos -> detalle_pedido -> pedidos -> clientes

2) ¿Qué columnas unen?
productos -> detalle_pedido (id_producto)
detalle_pedido -> pedidos (id_pedido)
pedidos -> clientes (id_cliente)

Tip: el fallo típico es poner como condición id_pedido = id_producto (que no tiene sentido, pero funciona).
*/ 
SELECT productos.id_producto,productos.nombre,clientes.nombre
FROM productos
	JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
    JOIN clientes USING(id_cliente);

-- Saca los productos que se encuentren en un estado de pedido "CANCELADO".

SELECT nombre
FROM productos JOIN detalle_pedido USING(id_producto)
	JOIN pedidos USING(id_pedido)
WHERE estado = "cancelado";

-- ¿Cuántos clientes han hecho algún pedido de cada categoría?

SELECT categoria,count(id_cliente)
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
    GROUP BY categoria;
    
select count(*) from clientes;

SELECT categoria,id_cliente
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
ORDER BY id_cliente;


SELECT categoria,count(distinct id_cliente)
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
    GROUP BY categoria;
    
    

