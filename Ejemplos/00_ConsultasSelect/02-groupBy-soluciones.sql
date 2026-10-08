USE tienda_online;

# CLIENTES
## 1) Número total de clientes
SELECT COUNT(*) AS num_clientes FROM clientes;

## 2) Número de clientes por país
SELECT pais,count(id_cliente) FROM clientes GROUP BY pais;

## 3) Número de clientes registrados por año
SELECT YEAR(fecha_registro), count(id_cliente) AS num_clientes
FROM clientes
GROUP BY   YEAR(fecha_registro);

select fecha_registro from clientes;
## 4) Número de clientes registrados por mes (todas las fechas)
SELECT MONTH(fecha_registro) AS mes, count(id_cliente) AS num_clientes
FROM clientes
GROUP BY   MONTH(fecha_registro);

-- bonus track: num_clietnes por mes de cada año.
select YEAR(fecha_registro) AS año, MONTH(fecha_registro) AS mes, count(id_cliente) AS num_clientes
FROM clientes
GROUP BY  YEAR(fecha_registro), MONTH(fecha_registro)
ORDER BY YEAR(fecha_registro) ASC, MONTH(fecha_registro) ASC;

/*EN UNA CONSULTA DE GROUP BY, LO QUE HAY EN EL SELECT TIENE QUE ESTAR
AGRUPADO (ES DECIR, EN EL GROUP BY) O AGREGADO (COUNT,AVG,MIN,MAX ...) */

## 5) Fecha de primer y último cliente registrado
SELECT min(fecha_registro) AS primer_registro,MAX(fecha_registro) AS ultimo_registro FROM clientes;

## 6) Número de países distintos con clientes
SELECT COUNT(DISTINCT pais) AS num_paises_con_clientes FROM clientes;
-- El distinct se puede conseguir con un group by
SELECT pais FROM clientes GROUP BY pais;
-- SELECT pais,COUNT(pais) FROM clientes GROUP BY pais;
SELECT count(*) FROM (SELECT pais FROM clientes GROUP BY pais) AS tabla_nueva;

## 7) Conteo de clientes con email y sin email

SELECT COUNT(email) , NOT COUNT(email) 
FROM clientes
WHERE email LIKE '%@%';

SELECT 
    RIGHT(email, 3) AS tiene_email,
    COUNT(email)
FROM
    clientes
GROUP BY RIGHT(email, 3);

-- incompleto

## 8) Distribución de clientes por primera letra del nombre
SELECT left(nombre,1),COUNT(*)
FROM clientes
GROUP BY left(nombre,1)
ORDER BY left(nombre,1);

# PRODUCTOS
## 9) Número total de productos
SELECT COUNT(*) FROM productos;
## 10) Número de productos por categoría
SELECT categoria,COUNT(*) AS num_productos
FROM productos
GROUP BY categoria;

## 11) Precio promedio de productos
SELECT AVG(precio) FROM productos;

## 12) Precio mínimo y máximo de productos
SELECT MIN(precio),MAX(precio) FROM productos;

## 13) Stock total de productos
SELECT SUM(stock) FROM productos;

## 14) Stock total por categoría
SELECT categoria,SUM(stock) AS stock_acumulado FROM productos GROUP BY categoria;

## 15) Valor de inventario total (stock * precio)
SELECT SUM(stock*precio) AS valor_inventario_total from productos;

## 16) Valor de inventario por categoría
SELECT 
    categoria, SUM(stock * precio) AS valor_inventario_total
FROM
    productos
GROUP BY categoria;

# PEDIDOS
## 18) Número total de pedidos
select count(*) from pedidos;

## 19) Número de pedidos por estado
select estado, count(id_pedido) from pedidos group by estado;

## 20) Total facturado (suma de la columna total)
select sum(coste_total) from pedidos;

## 21) Promedio del total de pedidos
select avg(coste_total) from pedidos;

## 22) Pedido de mayor y menor importe
select max(coste_total) AS mas_caro,min(coste_total) AS mas_barato from pedidos;

## 23) Número de pedidos por año
explain pedidos;
select count(fecha_pedido),count(id_pedido),count(id_cliente),count(estado),count(coste_total),count(*),year(fecha_pedido) from pedidos group by year(fecha_pedido);
-- da igual la columa que cuentes.

## 24) Total facturado por año
SELECT 
	YEAR(fecha_pedido) AS año,
    SUM(coste_total) AS facturado
FROM
    pedidos
GROUP BY YEAR(fecha_pedido);

## 25) Número de pedidos por mes de todos los años
SELECT 
	MONTH(fecha_pedido) as mes,
    COUNT(*) AS num_pedidos
FROM pedidos
GROUP BY MONTH(fecha_pedido)
ORDER BY MONTH(fecha_pedido) ASC;
-- BONUS TRACK: Num de pedidos agrupado por mes y por año:
SELECT 
	YEAR(fecha_pedido) AS año,
	MONTH(fecha_pedido) AS mes,
    COUNT(*) AS num_pedidos
FROM pedidos
GROUP BY YEAR(fecha_pedido), MONTH(fecha_pedido)
ORDER BY YEAR(fecha_pedido) ASC, MONTH(fecha_pedido) ASC;

## 26) Total facturado por estado
SELECT 
	estado,
    SUM(coste_total) AS facturado
FROM
    pedidos
GROUP BY estado;

## 27) Promedio del total por estado
SELECT 
	estado,
    AVG(coste_total) AS facturado_medio
FROM
    pedidos
GROUP BY estado;


# DETALLE_PEDIDO
## 29) Número de líneas de detalle registradas
## 30) Total de unidades vendidas (suma de cantidad)
## 31) Precio promedio de las líneas de detalle
## 32) Cantidad promedio por línea
## 33) Número de líneas por producto
## 34) Unidades totales por producto
## 35) Ingreso total por producto (cantidad * precio_unitario)

# Otros ejemplos

## 1) ¿Cuántos clientes se han registrado por año y mes?
## 2) ¿Cuántos clientes españoles se han registrado por año y mes?
## 3) Ordenas las consultas anteriores
## 4) Precio promedio agrupando por categoría e inicial del nombre con más de 3 unidades de stock
## 5) ¿Cuántos clientes cuyo nombre empieza por 'A' se han registrado cada año?
## 6) ¿Cuántos productos se han pedido en cada pedido?
## 7) Obtén el listado de los pedidos que han solicitado más de 10 productos

