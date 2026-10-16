use sakila;

select * from actor;

select * from film;

-- 0) Saca el nombre de los actores que han salido en "AGENT TRUMAN"
/* Tablas que necesito:
		- film (nombre de la peli)
        - actor (nombre del actor)
        - film_actor para unirlas
*/
SELECT first_name,last_name
FROM film
		JOIN film_actor USING(film_id)
        JOIN actor USING(actor_id)
WHERE title = 'AGENT TRUMAN';

-- 1) Cinco actores con más películas
/* Tablas que necesito:
		- actor
        - film_actor
        - ¿film? No es necesaria porque ya tengo film_id en film_actor.
	Agrupo por actor_id
    Cuento film_id
*/
SELECT actor_id,first_name,last_name,film_id
FROM actor JOIN film_actor USING(actor_id);

SELECT actor_id,first_name,last_name,count(film_id) AS num_peliculas
FROM actor JOIN film_actor USING(actor_id)
GROUP BY actor_id
ORDER BY count(film_id) DESC
LIMIT 5;

-- Para corregir el viernes 16/10:
-- Cuántas películas hay por categoría


-- Obtén un listado de nombre del actor, película en la que ha trabajado y categoría de esa película
-- Cuántos actores DISTINTOS han trabajado en cada categoría.


-- 2) País con más clientes
-- 3) Tres películas con mayores ingresos por alquiler
-- 4) Cliente que más ha gastado
-- 5) Ingreso promedio por alquiler en cada tienda
-- 6) Ventas totales por categoría ordenadas
-- 7) Actores con al menos diez películas de categorías distintas
-- 8) Tiendas con más stock disponible
-- 9) Películas que nunca han sido alquiladas
-- 10) Diez películas con mayor diferencia entre coste de reposición y tarifa de alquiler
-- 11) Películas con más de tres actores y duración menor a 90 minutos