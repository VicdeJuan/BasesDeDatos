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
-- Fíjate en el resultado. ¿No es raro que salgan 128 clientes? ¿Cuántos hay en total?
select count(*) from clientes;

-- Si solo hay 45 clientes, ¿cómo sale 128?

SELECT categoria,id_detalle,id_cliente
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
ORDER BY id_cliente;

-- El count de id_cliente cuenta las filas que salen. Y sale una fila por cada detalle,
-- por eso los counts de la siguiente consulta salen los mismos.

SELECT categoria,count(id_cliente),count(id_detalle)
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
    GROUP BY categoria;

-- Lo que queremos no es contar los id_clientes (porque eso, en realidad, está contando el número de filas) 
-- sino que queremos contar los id_cliente DIFERENTES, DISTINTOS entre sí. Por eso,la solución es:
    
SELECT categoria,count(distinct id_cliente)
FROM 
	productos JOIN detalle_pedido USING(id_producto)
    JOIN pedidos USING(id_pedido)
    GROUP BY categoria;
    
    

