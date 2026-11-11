USE sakila;

-- Consulta 1: Películas por clasificación
SELECT rating AS clasificacion, COUNT(*) AS peliculas, ROUND(AVG(length),1) AS duracion_media FROM film GROUP BY rating ORDER BY rating;

-- Consulta 2: Clientes y ciudades
SELECT CONCAT(c.first_name,' ',c.last_name) AS nombre_completo, ci.city AS ciudad, CHAR_LENGTH(CONCAT(c.first_name,' ',c.last_name)) AS longitud_nombre FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id WHERE CHAR_LENGTH(CONCAT(c.first_name,' ',c.last_name))>=14 ORDER BY longitud_nombre DESC,nombre_completo ASC;

-- Consulta 3: Películas PG-13 por categoría
SELECT ca.name AS categoria, COUNT(*) AS peliculas, ROUND(AVG(f.length),1) AS duracion_media FROM film f JOIN film_category fc ON f.film_id=fc.film_id JOIN category ca ON fc.category_id=ca.category_id WHERE f.rating='PG-13' GROUP BY ca.category_id,ca.name ORDER BY peliculas DESC,categoria ASC;

-- Consulta 4: Actores con muchas películas
SELECT a.first_name AS nombre,a.last_name AS apellido,COUNT(*) AS peliculas FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id WHERE a.last_name LIKE 'S%' GROUP BY a.actor_id,a.first_name,a.last_name HAVING COUNT(*)>=15 ORDER BY peliculas DESC,apellido ASC;

-- Consulta 5: Cobros mensuales por empleado
SELECT s.first_name AS nombre,s.last_name AS apellido,YEAR(p.payment_date) AS anio,MONTH(p.payment_date) AS mes,COUNT(*) AS pagos,COUNT(DISTINCT p.customer_id) AS clientes,ROUND(SUM(p.amount),2) AS importe_total FROM staff s JOIN payment p ON s.staff_id=p.staff_id GROUP BY s.staff_id,s.first_name,s.last_name,YEAR(p.payment_date),MONTH(p.payment_date) ORDER BY anio,mes,apellido,nombre;
