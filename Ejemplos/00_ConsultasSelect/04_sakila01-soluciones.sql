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
/*
Tablas: 
	category (por el nombre de la categoría)
    film_category
    ¿film? No hace falta
*/
select * from category;
SELECT category.name,count(film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY category.name;

SELECT name,count(film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;

SELECT name,count(*)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;


SELECT name,count(distinct film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;

-- ¿Cuántas películas tienen más de una categoría?
select * from film_category;
-- vamos a sacar cuántas categorías tiene cada película
SELECT 
    film_id, COUNT(category_id)
FROM
    film_category
GROUP BY film_id;
-- Y ahora hay que filtrar. Filtrar es un WHERE. Pero, queremos un filtro
-- DESPUÉS de haber agrupado y WHERE filtra antes de agrupar. Por eso,
-- WHERE no nos sirve y SQL ofrece una palabra reservada: HAVING
SELECT 
    film_id, COUNT(category_id)
FROM
    film_category
GROUP BY film_id
HAVING COUNT(category_id) > 1;

-- Rta: no hay ninguna película con más de una categoría.
-- Obtén el top 3 de categorías con más películas
SELECT category_id,name,count(film_id) AS num_peliculas
FROM film_category JOIN category USING(category_id)
GROUP BY category_id
ORDER BY count(film_id) DESC
LIMIT 3;

SELECT category_id,name,count(film_id) AS num_peliculas
FROM film_category JOIN category USING(category_id)
GROUP BY name
ORDER BY count(film_id) DESC
LIMIT 3;

-- DIFERENCIA ENTRE JOIN USING Y JOIN ON
SELECT * 
FROM category JOIN film_category USING(category_id) limit 3;

SELECT * 
FROM category JOIN film_category ON category.category_id = film_category.category_id limit 3;

-- Víctor explicó las diferencias. Lo contó genial con coloritos rojos en la pizarra.
-- ¡Menos mal que fui un alumno responsable y tomé un montón de apuntes de eso! 
-- Además, estuvo mucho rato contetando todas las preguntas que salieron.

-- Obtén el listado de categorías que tienen más de 60 películas
/*
	film_category
    category
*/
SELECT name,fc.category_id,count(film_id)
FROM film_category fc JOIN category c ON fc.category_id = c.category_id
GROUP BY fc.category_id
HAVING count(film_id) > 60;

-- Obtén el listado de categorías que tienen más de 5 películas que empiezan por la letra 'A'
SELECT category_id,name,count(film_id)
FROM film JOIN film_category USING(film_id) 
	JOIN category USING(category_id)
WHERE title like 'A%'
GROUP BY category_id
HAVING count(film_id) > 5;

SELECT category_id,name,count(film_id)
FROM film JOIN film_category USING(film_id)
	JOIN category USING(category_id)
GROUP BY category_id
HAVING film.title LIKE 'A%';
-- Esto da error. Para más información, preguntar a David que ha escrito un libro sobre este ejemplo.alter

-- 2 consultas parecidas: ¿qué pasa si quiero categorías que empiezan por A? ¿WHERE O HAVING?

SELECT category_id,name,count(film_id)
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
GROUP BY category_id
HAVING name LIKE 'A%';

SELECT category_id,name,count(film_id)
FROM film JOIN film_category USING(film_id) JOIN category USING(category_id)
WHERE name LIKE 'A%'
GROUP BY category_id;
-- Funcionan las 2 aunque es más eficiente la segunda. La primera agrupa datos innecesarios, bla bla bla bla




-- Obtén un listado de nombre del actor, película en la que ha trabajado y categoría de esa película
/*necesito: actor.first_name, actor.last_name, film.title, category.name
Tablas: actor, film, category
auxiliares para unir: film_actor y film_category

CAMINO: actor -(actor_id)-> film_actor -(film_id)-> film -(film_id)-> film_category -(category_id)-> category
*/

SELECT first_name,last_name, title, name
FROM actor JOIN film_actor USING(actor_id) 
		JOIN film USING(film_id)
        JOIN film_category USING(film_id) 
        JOIN category USING(category_id);

-- vamos a hacerla más bonita        
SELECT CONCAT(first_name,' ',last_name) AS actor, title AS pelicula, name AS categoria
FROM actor JOIN film_actor USING(actor_id) 
		JOIN film USING(film_id)
        JOIN film_category USING(film_id) 
        JOIN category USING(category_id);

-- Cuántos actores DISTINTOS han trabajado en cada categoría.
SELECT name,count(actor_id),count(distinct actor_id)
FROM category JOIN film_category USING(category_id)
			JOIN film USING(film_id)
            JOIN film_actor USING(film_id)
GROUP BY category_id;
-- ¿Por qué agrupo por category_id si no está en el select?

-- Para corregir el miércoles 21/10:
-- Nombre de actores que han trabajado en más de 7 categorías
-- Película que tiene más copias físicas (inventory_id)
-- Actores que empiezan por 'J' y han trabajado en categorías que empiezan por 'A'.

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