USE sakila;

-- Consulta 1: Direcciones por distrito
SELECT district AS distrito,COUNT(*) AS direcciones FROM address GROUP BY district ORDER BY direcciones DESC,distrito ASC;

-- Consulta 2: Actores de películas largas
SELECT a.first_name AS nombre,a.last_name AS apellido,f.title AS titulo,f.length AS duracion_minutos FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id JOIN film f ON fa.film_id=f.film_id WHERE f.length>=150 ORDER BY titulo ASC,apellido ASC;

-- Consulta 3: Direcciones en India y China
SELECT co.country AS pais,COUNT(DISTINCT ci.city_id) AS ciudades,COUNT(*) AS direcciones FROM country co JOIN city ci ON co.country_id=ci.country_id JOIN address ad ON ci.city_id=ad.city_id WHERE co.country IN ('India','China') GROUP BY co.country_id,co.country ORDER BY direcciones DESC;

-- Consulta 4: Películas PG-13 con reparto numeroso
SELECT f.title AS titulo,COUNT(*) AS actores FROM film f JOIN film_actor fa ON f.film_id=fa.film_id WHERE f.rating='PG-13' GROUP BY f.film_id,f.title HAVING COUNT(*)>=6 ORDER BY actores DESC,titulo ASC;

-- Consulta 5: Alquileres por día de la semana: clientes cuyo nombre empieza por S
SELECT DAYOFWEEK(r.rental_date) AS dia_semana,COUNT(*) AS alquileres,COUNT(r.return_date) AS devueltos FROM rental r JOIN customer c ON r.customer_id=c.customer_id WHERE c.first_name LIKE 'S%' GROUP BY DAYOFWEEK(r.rental_date) ORDER BY dia_semana;
