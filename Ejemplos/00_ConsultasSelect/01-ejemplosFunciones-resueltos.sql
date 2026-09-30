USE tienda_online;
## 1. Funciones numéricas
### 1.1. Truncar el precio de cada producto a 1 decimal
SELECT * FROM productos;

-- Ejemplos de uso:
SELECT TRUNCATE(1.223,1);
SELECT TRUNCATE(1.753,1);

-- Solución:
SELECT precio,TRUNCATE(precio,1)
FROM productos;

### 1.2. Redondear hacia abajo (FLOOR) y hacia arriba (CEIL) el precio
SELECT precio,FLOOR(precio),CEIL(precio)
FROM productos;

-- Bonus track: obtén la parte decimal del precio
--  y filtra para obtener los que tienen un .99

SELECT 
    precio,
    FLOOR(precio) AS parte_entera,
    precio - FLOOR(precio) AS parte_decimal
FROM
    productos
WHERE
    parte_decimal = 0.99; -- falla porque ... 
    
/*
	PONGAS ALGO
*/

SELECT nombre
FROM productos
WHERE precio - FLOOR(precio) = 0.99;

### 1.3. Calcular el precio con IVA (21%)
SELECT nombre,precio AS precio_sin_IVA, precio * 1.21 AS precio_con_iva
FROM productos;

-- Salen 4 decimales en precio con IVA. Vamos a poner solo 2.
SELECT 
    nombre,
    precio AS precio_sin_IVA,
    precio * 1.21 AS precio_con_iva_sin_redondeo,
    ROUND(precio * 1.21,2) AS precio_con_iva_redondeado
FROM
    productos;


### 1.4. Descuento del 15% aplicado sobre el precio
SELECT nombre,precio,ROUND(precio*0.85,2) AS precio_con_descuento
FROM productos;

### 1.5. Desviación estándar y varianza del precio del catálogo
SELECT nombre,VARIANCE(precio) AS varianza, STDDEV(precio) AS desv_estandar
FROM productos;

-- Precio máximo y mínimo.
SELECT MAX(precio) AS precio_maximo , MIN(precio) AS precio_minimo
FROM productos;

-- SELECT nombre,precio FROM productos ORDER BY precio DESC limit 1;

### 1.6. Diferencia absoluta frente a un stock objetivo (600 uds.)
SELECT nombre, stock, stock - 600 
FROM productos
WHERE stock-600 < 0
ORDER BY stock - 600 ASC;

-- bonus 3: Nombre del producto con el precio máximo
SELECT nombre,precio
FROM productos
WHERE precio = (SELECT MAX(precio) FROM productos) 
OR precio = (SELECT MIN(precio) FROM productos);

-- Ejercicios

-- 1) Calcula el stock máximo y mínimo
-- 2) Es la semana del Black Friday y vamos a sacar un listado de 
-- productos de electrónica con un descuento del 30%. Saca el listado
-- de nombre, precio antiguo, precio nuevo, categoria.
-- 3) Hemos recibido 200 unidades de cada tipo de silla. Saca un listado
-- de nombre,stock antiguo, stock nuevo y categoria.

SELECT * FROM productos;

## 2. Funciones de cadena
### 2.1. Concatenar categoría y nombre con separador usando `CONCAT_WS`
### 2.2. Extraer una subcadena del nombre de cada producto (pos. 4, longitud 5)
### 2.3. Buscar la posición de una palabra dentro del nombre (por ejemplo 'Pro')
### 2.3. Buscar la posición de una palabra dentro del nombre (por ejemplo 'Pro')
### 2.4. Invertir el nombre de cada producto
### 2.5. Rellenar a la izquierda el id_producto con ceros hasta 5 dígitos
### 2.6. Enmascarar el nombre de cliente con asteriscos según su longitud
### 2.7. Reemplazar el símbolo '@' en el email para mostrarlo “ofuscado”
## 3. Funciones de fecha
### 3.1. Obtener la fecha y hora actual (NOW)
### 3.2. Formatear la fecha de pedido como “YYYY-MM”
### 3.3. Extraer el trimestre (QUARTER) de la fecha de pedido
### 3.4. Último día del mes de cada pedido
### 3.5. Diferencia en meses desde el registro de cada cliente hasta hoy
### 3.6. Semana del año de cada pago (YEARWEEK)
### 3.7. Restar 2 horas a la fecha/hora de cada pedido (SUBTIME)
### 3.8. Sumar 10 minutos a la fecha/hora de cada pago (ADDTIME)
