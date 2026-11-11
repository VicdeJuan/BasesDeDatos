USE sakila;

-- Consulta 1: Tarifas según el plazo de alquiler
SELECT rental_duration AS dias,COUNT(*) AS peliculas,ROUND(AVG(rental_rate),2) AS tarifa_media FROM film GROUP BY rental_duration ORDER BY dias;

-- Consulta 2: Clientes y longitud de su apellido
SELECT c.first_name AS nombre,c.last_name AS apellido,ci.city AS ciudad,CHAR_LENGTH(c.last_name) AS longitud_apellido FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id WHERE c.active=1 AND CHAR_LENGTH(c.last_name)>=10 ORDER BY longitud_apellido DESC,apellido,nombre;

-- Consulta 3: Películas G por categoría
SELECT ca.name AS categoria,COUNT(*) AS peliculas,ROUND(AVG(f.replacement_cost),2) AS coste_medio FROM film f JOIN film_category fc ON f.film_id=fc.film_id JOIN category ca ON fc.category_id=ca.category_id WHERE f.rating='G' GROUP BY ca.category_id,ca.name ORDER BY peliculas DESC,categoria;

-- Consulta 4: Actores con nombre iniciado por D
SELECT a.first_name AS nombre,a.last_name AS apellido,COUNT(*) AS peliculas FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id WHERE a.first_name LIKE 'D%' GROUP BY a.actor_id,a.first_name,a.last_name HAVING COUNT(*)>=15 ORDER BY peliculas DESC,apellido,nombre;

-- Consulta 5: Alquileres y películas diferentes por tienda y mes
SELECT i.store_id,YEAR(r.rental_date) AS anio,MONTH(r.rental_date) AS mes,COUNT(*) AS alquileres,COUNT(DISTINCT i.film_id) AS peliculas FROM rental r JOIN inventory i ON r.inventory_id=i.inventory_id GROUP BY i.store_id,YEAR(r.rental_date),MONTH(r.rental_date) ORDER BY anio,mes,i.store_id;

-- Consulta 6: Pagos según su importe
SELECT amount AS importe,COUNT(*) AS pagos,SUM(amount) AS total FROM payment GROUP BY amount ORDER BY amount;

-- Consulta 7: Películas y coste de alquiler por día
SELECT f.title AS titulo,l.name AS idioma,f.rental_rate AS tarifa,f.rental_duration AS dias,ROUND(f.rental_rate/f.rental_duration,2) AS coste_por_dia FROM film f JOIN language l ON f.language_id=l.language_id WHERE f.rental_rate/f.rental_duration>1 ORDER BY coste_por_dia DESC,titulo;

-- Consulta 8: Clientes por ciudad de la India
SELECT ci.city AS ciudad,COUNT(*) AS clientes FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id JOIN country co ON ci.country_id=co.country_id WHERE co.country='India' GROUP BY ci.city_id,ci.city ORDER BY clientes DESC,ciudad;

-- Consulta 9: Categorías con películas de más de dos horas
SELECT ca.name AS categoria,COUNT(*) AS peliculas,ROUND(AVG(f.length),1) AS duracion_media FROM film f JOIN film_category fc ON f.film_id=fc.film_id JOIN category ca ON fc.category_id=ca.category_id WHERE f.length>120 GROUP BY ca.category_id,ca.name HAVING COUNT(*)>=10 ORDER BY peliculas DESC,categoria;

-- Consulta 10: Cobros superiores a tres unidades por empleado y mes
SELECT s.first_name AS nombre,s.last_name AS apellido,YEAR(p.payment_date) AS anio,MONTH(p.payment_date) AS mes,COUNT(*) AS pagos,COUNT(DISTINCT p.customer_id) AS clientes,ROUND(SUM(p.amount),2) AS importe_total FROM payment p JOIN staff s ON p.staff_id=s.staff_id WHERE p.amount>3 GROUP BY s.staff_id,s.first_name,s.last_name,YEAR(p.payment_date),MONTH(p.payment_date) ORDER BY anio,mes,apellido,nombre;

-- Consulta 11: Clientes activos e inactivos por tienda
SELECT store_id,COUNT(*) AS clientes,SUM(active=1) AS activos,SUM(active=0) AS inactivos FROM customer GROUP BY store_id ORDER BY store_id;

-- Consulta 12: Pagos de importe elevado
SELECT CONCAT(c.first_name,' ',c.last_name) AS cliente,p.payment_date AS fecha_pago,p.amount AS importe,CONCAT(s.first_name,' ',s.last_name) AS empleado FROM payment p JOIN customer c ON p.customer_id=c.customer_id JOIN staff s ON p.staff_id=s.staff_id WHERE p.amount>=8 ORDER BY importe DESC,fecha_pago ASC;

-- Consulta 13: Alquileres devueltos por tienda y clasificación
SELECT i.store_id,f.rating AS clasificacion,COUNT(*) AS alquileres_devueltos,ROUND(AVG(f.length),1) AS duracion_media FROM rental r JOIN inventory i ON r.inventory_id=i.inventory_id JOIN film f ON i.film_id=f.film_id WHERE r.return_date IS NOT NULL GROUP BY i.store_id,f.rating ORDER BY i.store_id,clasificacion;

-- Consulta 14: Países con al menos diez clientes activos
SELECT co.country AS pais,COUNT(*) AS clientes_activos FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id JOIN country co ON ci.country_id=co.country_id WHERE c.active=1 GROUP BY co.country_id,co.country HAVING COUNT(*)>=10 ORDER BY clientes_activos DESC,pais;

-- Consulta 15: Alquileres de clientes cuyo nombre empieza por A, según día de la semana
SELECT s.first_name AS nombre,s.last_name AS apellido,DAYOFWEEK(r.rental_date) AS dia_semana,COUNT(*) AS alquileres,COUNT(DISTINCT r.customer_id) AS clientes FROM rental r JOIN customer c ON r.customer_id=c.customer_id JOIN staff s ON r.staff_id=s.staff_id WHERE c.first_name LIKE 'A%' GROUP BY s.staff_id,s.first_name,s.last_name,DAYOFWEEK(r.rental_date) ORDER BY apellido,nombre,dia_semana;

-- Consulta 16: Alquileres por año y mes
SELECT YEAR(rental_date) AS anio,MONTH(rental_date) AS mes,COUNT(*) AS alquileres,COUNT(return_date) AS devueltos,COUNT(*)-COUNT(return_date) AS pendientes FROM rental GROUP BY YEAR(rental_date),MONTH(rental_date) ORDER BY anio,mes;

-- Consulta 17: Clientes de países terminados en a
SELECT c.first_name AS nombre,c.last_name AS apellido,c.email AS correo,ci.city AS ciudad,co.country AS pais FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id JOIN country co ON ci.country_id=co.country_id WHERE c.active=1 AND LOWER(co.country) LIKE '%a' ORDER BY pais,ciudad,apellido;

-- Consulta 18: Alquileres de la tienda 2 desde junio de 2005
SELECT f.rating AS clasificacion,COUNT(*) AS alquileres,ROUND(AVG(f.rental_rate),2) AS tarifa_media FROM rental r JOIN inventory i ON r.inventory_id=i.inventory_id JOIN film f ON i.film_id=f.film_id WHERE i.store_id=2 AND r.rental_date>='2005-06-01' GROUP BY f.rating ORDER BY clasificacion;

-- Consulta 19: Actores cuyo nombre empieza por M en películas PG-13
SELECT a.first_name AS nombre,a.last_name AS apellido,COUNT(*) AS peliculas,ROUND(AVG(f.length),1) AS duracion_media FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id JOIN film f ON fa.film_id=f.film_id WHERE a.first_name LIKE 'M%' AND f.rating='PG-13' GROUP BY a.actor_id,a.first_name,a.last_name HAVING COUNT(*)>=4 ORDER BY peliculas DESC,apellido,nombre;

-- Consulta 20: Alquileres y clientes diferentes por clasificación y mes
SELECT f.rating AS clasificacion,YEAR(r.rental_date) AS anio,MONTH(r.rental_date) AS mes,COUNT(*) AS alquileres,COUNT(DISTINCT r.customer_id) AS clientes FROM rental r JOIN inventory i ON r.inventory_id=i.inventory_id JOIN film f ON i.film_id=f.film_id GROUP BY f.rating,YEAR(r.rental_date),MONTH(r.rental_date) ORDER BY anio,mes,clasificacion;
