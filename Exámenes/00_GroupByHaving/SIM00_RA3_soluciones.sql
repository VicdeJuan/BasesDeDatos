use tienda_online;

/* EJERCICIO 1:
Muestra las diez líneas de pedido con mayor importe (cantidad por precio_
unitario). Incluye identificador de línea, cantidad, precio unitario e importe; desempata por
identificador.*/

explain detalle_pedido;

SELECT id_detalle, cantidad, precio_unitario, precio_unitario*cantidad AS importe
FROM detalle_pedido
ORDER BY precio_unitario*cantidad DESC, id_detalle
LIMIT 10;

/* EJERCICIO 2:
Consulta 2 (1 punto). Muestra el identificador, fecha y año de pago de los quince primeros
pagos por identificador. Conserva los pagos sin fecha.*/

explain pagos;
select id_pago,fecha_pago, year(fecha_pago)
FROM pagos
order by fecha_pago ASC, id_pago
LIMIT 15;


/*Consulta 3 (1 punto). Construye una etiqueta para cada cliente con el formato
 «nombre <email>». Muestra el identificador y la etiqueta, ordenados por la quinta letra del nombre.*/

SELECT id_cliente, CONCAT(nombre,'<',email,'>') AS etiqueta
FROM clientes
ORDER BY substring(nombre,5,1);

/*Consulta 4 (1 punto). Suma el coste de los pedidos por número de mes, reuniendo todos los
años. Muestra mes e importe, ordenados por mes.*/
describe pedidos;

SELECT MONTH(fecha_pedido) AS mes, SUM(coste_total) as importe
FROM pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY MONTH(fecha_pedido);

/*Consulta 5 (1 punto). Calcula el stock medio por categoría. Redondea la media a dos decimales
y ordena por ella de menor a mayor y por categoría.*/

EXPLAIN productos;
SELECT categoria,round(avg(stock),2) AS stock_medio
FROM productos
GROUP BY categoria
ORDER BY stock_medio ASC,categoria;

/*Consulta 6 (1 punto). Cuenta los pedidos distintos por día del mes y estado, sin distinguir mes
ni año. Muestra día, estado y número de pedidos; ordena por día y por número de pedidos
descendente.*/

SELECT 
	DAY(fecha_pedido) AS dia,estado,
    count(DISTINCT id_pedido) AS num_pedidos
FROM pedidos
GROUP BY DAY(fecha_pedido),estado
ORDER BY dia,num_pedidos;



SELECT 
	DAY(fecha_pedido) AS dia,estado,
    count(id_pedido) AS num_pedidos
FROM pedidos
GROUP BY DAY(fecha_pedido),estado
ORDER BY dia,num_pedidos;

-- En este caso concreto, el distinct no aporta nada.

/*Consulta 7 (2 puntos). Pista: puedes usar DATEDIFF(). Relaciona cada pedido con su cliente
y calcula, por país, el promedio de días entre el registro del cliente y el pedido. Muestra también
el número de pedidos y ordena por número de pedidos descendente y país. Redondea el
promedio a un decimal.*/

SELECT pais,round(avg(DATEDIFF(fecha_registro,fecha_pedido)),1) AS promedio_dias,count(id_pedido) AS num_pedidos
FROM clientes
	JOIN pedidos USING(id_cliente)
GROUP BY pais
ORDER BY num_pedidos DESC,pais;

-- POR PROFUNDIZAR EN EL DISTINCT:

SELECT pais, count(id_pedido), count(distinct id_pedido), count(id_cliente), count(distinct id_cliente)
FROM clientes
	JOIN pedidos USING(id_cliente)
GROUP BY pais;

-- como un cliente puede realizar varios pedidos, hay id_cliente repetidos para id_pedido diferentes. 
-- Por eso el distinct de id_cliente sí hace algo, pero el de id_pedido no.


/*Consulta 8 (2 puntos). Pista: puedes usar LEAST(). Por año de pedido, muestra el número de
pedidos, la suma de todos sus costes y la suma de los costes limitados a 1000 euros por pedido.
Ordena por año.*/

SELECT 
    YEAR(fecha_pedido) AS año_de_pedido,
    COUNT(id_pedido),
    SUM(coste_total) AS coste_total,
    SUM(LEAST(coste_total,1000)) AS coste_total_limitado
FROM
    pedidos
GROUP BY YEAR(fecha_pedido)
ORDER BY YEAR(fecha_pedido);

-- Extra (0.5 puntos) ¿Ha habido algún pago en 29 de febrero? ¿Y algún pedido?
SELECT *
FROM pagos 
WHERE fecha_pago LIKE '%02-29%';

SELECT * 
FROM pedidos
WHERE MONTH(fecha_pedido) = 2 AND DAY(fecha_pedido) = 29;

-- Rta: no ha habido ningún pago ni ningún pedido en 29 de febrero.
