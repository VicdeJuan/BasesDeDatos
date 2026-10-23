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

-- Camino: actor -> film_actor -> film -> film_category
SELECT CONCAT(first_name,' ',last_name) AS nombre,film_id,category_id
FROM 
	actor JOIN film_actor USING(actor_id) 
		JOIN film USING(film_id)
        JOIN film_category USING(film_id)
ORDER BY nombre;
	
SELECT CONCAT(first_name,' ',last_name) AS nombre,COUNT(category_id)
FROM 
	actor JOIN film_actor USING(actor_id) 
		JOIN film USING(film_id)
        JOIN film_category USING(film_id)
GROUP BY actor_id;
-- EN REALIDAD, ESTO ESTÁ CONTANDO PELÍCULAS. POR ESO EL DISTINCT

SELECT 
    actor_id, -- está en el group by. OK
    CONCAT(first_name, ' ', last_name) AS nombre, -- Ni agregado ni group by. ¿OK? Porque conociendo el actor_id, el nombre se 
    -- conoce unívocamente. (*)
    COUNT(category_id) AS num_peliculas,-- agregado. OK
    COUNT(DISTINCT category_id) AS num_categorias-- agregado. OK
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
GROUP BY actor_id;
-- (*) este campo es de una tabla cuya clave primaria está en el group by.
-- SIN TERMINAR. SEGUIMOS MÁS ABAJO (VER ***)


-- REPASO DEL ERROR 1055

SELECT name,count(distinct film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;

SELECT category_id,name,count(distinct film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY category_id;

SELECT name,count(distinct film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;


SELECT category_id, name,count(distinct film_id)
FROM film_category
	-- JOIN category ON film_category.category_id = category.category_id;
    JOIN category USING(category_id)
GROUP BY name;

-- (***) SOLUCIÓN: FALTA EL "CON MÁS DE 7 CATEGORÍAS"
SELECT 
    actor_id, CONCAT(first_name, ' ', last_name) AS nombre, COUNT(DISTINCT category_id) AS num_categorias
FROM
    actor
        JOIN
    film_actor USING (actor_id)
        JOIN
    film USING (film_id)
        JOIN
    film_category USING (film_id)
GROUP BY actor_id
HAVING COUNT(DISTINCT category_id) > 7
-- ORDER BY COUNT(DISTINCT category_id) DESC -- Esto es más correcto, pero es de pedantes.
ORDER BY num_categorias DESC;

-- Película que tiene más copias físicas (inventory_id)
-- Tablas: inventory -- (film_id) --> film

SELECT title, COUNT(inventory_id), COUNT(distinct inventory_id)
FROM film JOIN inventory ON film.film_id = inventory.inventory_id
GROUP BY film_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

SELECT *
FROM film JOIN inventory ON film.film_id = inventory.inventory_id
LIMIT 1;

SELECT title, COUNT(inventory_id), COUNT(distinct inventory_id)
FROM film JOIN inventory ON film.film_id = inventory.inventory_id
GROUP BY film.film_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

SELECT title, COUNT(inventory_id), COUNT(distinct inventory_id)
-- FROM film JOIN inventory ON film.film_id = inventory.inventory_id -- ERROR. ES UN EJEMPLO DE COSAS QUE PERMITE EL ON QUE NO PERMITE USING
FROM film JOIN inventory ON film.film_id = inventory.film_id
GROUP BY film.film_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

SELECT title, COUNT(inventory_id), COUNT(distinct inventory_id)
FROM film JOIN inventory USING(film_id)
GROUP BY film_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

SELECT title, inventory_id
FROM film JOIN inventory USING(film_id);

SELECT title, COUNT(inventory_id), COUNT(distinct inventory_id), COUNT(title), COUNT(*)
FROM film JOIN inventory USING(film_id)
GROUP BY film_id
ORDER BY COUNT(inventory_id) DESC
LIMIT 1;

-- EJEMPLO PARA DAVID: UN JOIN ABSURDO
SELECT *
FROM actor JOIN customer ON actor.actor_id = customer.customer_id;

-- ejemplo útil
SELECT film_id,title,film.language_id,film.original_language_id,language.language_id,name
FROM film JOIN language ON film.language_id = language.language_id;

SELECT film_id,title,film.language_id,film.original_language_id,language.language_id,name
FROM film LEFT JOIN language ON film.original_language_id = language.language_id;

-- Actores que empiezan por 'J' y han trabajado en categorías que empiezan por 'A'.
-- TABLAS: actor -> film_actor -> film -> film_category -> category

SELECT distinct CONCAT(first_name,' ',last_name) AS nombre, category.name
FROM actor JOIN film_actor USING(actor_id)
	JOIN film USING(film_id)
    JOIN film_category USING(film_id)
    JOIN category USING(category_id)
WHERE first_name LIKE 'J%' AND name LIKE 'A%'
ORDER BY nombre;

-- PARA CORREGIR EL JUEVES 22/10
-- 2) País con más clientes
/*country -> city -> address -> customer*/
SELECT country.country AS pais, count(customer_id) AS num_clientes, count(DISTINCT customer_id) AS num_clientes
FROM 
	country JOIN city USING(country_id)
			JOIN address USING(city_id)
			JOIN customer USING(address_id)
GROUP BY country.country_id
ORDER BY count(customer_id)  DESC
LIMIT 1;

-- PARANOIA

SELECT country.country AS pais, count(customer_id) AS num_clientes, count(DISTINCT customer_id) AS num_clientes
FROM 
	country JOIN city USING(country_id)
			JOIN address USING(city_id)
			JOIN store USING(address_id)
            JOIN customer USING(store_id)
GROUP BY country.country_id
ORDER BY count(customer_id)  DESC;
-- Incorrecto porque...


-- 3) Tres películas con mayores ingresos por alquiler
-- film -> inventory -> rental -> payment
-- resuelvo en pasos intermedios
SELECT * -- esto para ver que el join está bien hecho.
FROM 		film
		JOIN inventory USING(film_id)
        JOIN rental USING(inventory_id)
        JOIN payment USING(rental_id);

-- saco solo columnas útiles para ver que voy por buen camino.
SELECT 
    film.film_id, rental_id, film.title, payment.amount
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id);


SELECT 
    film.film_id, film.title, SUM(payment.amount) AS ingresos_totales, AVG(payment.amount) AS ingresos_medios
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY film_id
order by SUM(payment.amount) desc
LIMIT 3;


SELECT 
    film.film_id, film.title, AVG(payment.amount) AS ingresos_medios
FROM
    film
        JOIN
    inventory USING (film_id)
        JOIN
    rental USING (inventory_id)
        JOIN
    payment USING (rental_id)
GROUP BY film_id
order by AVG(payment.amount) desc
LIMIT 3;

-- 4) Cliente que más ha gastado

-- customer -> payment
SELECT CONCAT(customer.first_name, ' ' , customer.last_name) AS nombre, SUM(payment.amount) AS gasto_total
FROM customer JOIN payment USING(customer_id)
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 2;

-- no hay empate, así que limit 1.
SELECT CONCAT(customer.first_name, ' ' , customer.last_name) AS nombre, SUM(payment.amount) AS gasto_total
FROM customer JOIN payment USING(customer_id)
GROUP BY customer.customer_id
ORDER BY SUM(payment.amount) DESC
LIMIT 1;


-- 11) Películas con más de tres actores y duración menor a 90 minutos
SELECT 
    title, length, COUNT(actor_id)
FROM
    film_actor
        JOIN
    film ON film_actor.film_id = film.film_id
        AND film.length < 90
GROUP BY film.film_id
HAVING COUNT(actor_id) > 3;


-- PARA EL VIERNES 23/10
-- 5) Ingreso promedio por alquiler en cada tienda

/*POSIBLES CAMINOS:
OP1: payment -> customer -> [address] -> store
OP2: payment -> staff -(store_id)-> store 
OP3: payment -> staff -(manager_staff_id)-> store. ¿Qué pasa con los pagos que gestiona un staff que no es manager? (ver más abajo. (?))
OP4: payment -> rental -> inventory -> store
OP5: payment -> rental -> staff -(store_id)-> store 
OP6: payment -> rental -> staff -(manager_staff_id)-> store ¿Qué pasa con los alquileres que gestiona un staff que no es manager?
*/
-- OP1: payment -> customer -> Store
SELECT store_id, avg(amount), count(amount), sum(amount) -- saco count y sum para comparar
FROM payment JOIN customer using(customer_id) JOIN store USING(store_id)
GROUP BY store_id;
-- invalidada si encuentro un customer que ha hecho pagos/rentals en tiendas distintas
-- invalidada si un cliente se ha cambiado de tienda en un momento dado.

-- pagos en una tienda distinta a la tienda asignada.
SELECT customer.customer_id,customer.store_id AS tienda_asignada, inventory.store_id AS tienda_utilizada
FROM customer JOIN payment USING(customer_id) JOIN rental USING(rental_id) 
JOIN inventory USING(inventory_id)
WHERE customer.store_id !=  inventory.store_id;

-- rentals en una tienda distinta a la tienda asignada.
SELECT customer.customer_id,customer.store_id AS tienda_asignada, inventory.store_id AS tienda_utilizada
FROM customer JOIN rental USING(customer_id) 
JOIN inventory USING(inventory_id)
WHERE customer.store_id !=  inventory.store_id;
-- CONCLUSIÓN: La opción 1 es incorrecta.

-- El problema de Víctor
SELECT p.payment_id,p.customer_id,p.rental_id,r.rental_id,r.inventory_id,r.customer_id
FROM payment p JOIN rental r ON p.customer_id = r.customer_id;

-- OTRO OJO PIOJO: Muy interesante esto. Gracias por la pregunta.

-- OP2: payment -> staff -(store_id)-> store 
SELECT store_id, avg(amount), count(amount), sum(amount) -- saco count y sum para comparar
FROM payment JOIN staff USING(staff_id) JOIN store USING(store_id)
GROUP BY store_id;
-- invalidada si encuentro un staff que ha gestionado pagos/rentals en tiendas distintas
-- invalidada si un staff se ha cambiado de tienda en un momento dado.
-- Trabajo para el alumno: encuentra la consulta para invalidar esta opción 2.

-- OJO PIOJO: Cuando estudies para el examen, asegúrate de que has entendido este ejemplo bien.
-- Tanto las soluciones como la esencia del problema.
-- Si no lo estás entendiendo, pregunta.

-- OP4: payment -> rental -> inventory -> store
SELECT store_id, avg(amount), count(amount), sum(amount) -- saco count y sum para comparar
FROM payment JOIN rental USING(rental_id)  JOIN inventory USING(inventory_id) JOIN store USING(store_id)
GROUP BY store_id;
-- Esta es la correcta. La mayoría tenía razón, lo siento, Adrián.



-- ***********************************
-- OP5: payment -> rental -> staff -(store_id)-> store 
SELECT store_id, avg(amount), count(amount), sum(amount) -- saco count y sum para comparar
FROM payment JOIN rental USING(rental_id) JOIN staff USING(staff_id) JOIN store USING(store_id)
GROUP BY store_id;
-- ¿Será esta correcta?


-- 6) Ventas totales por categoría ordenadas
-- Camino: payment -> ... -> category
SELECT name,count(*) AS num_ventas_totales,sum(amount) AS ingresos_totales
FROM category JOIN film_category USING(category_id)
	JOIN film USING(film_id) JOIN inventory USING(film_id)
    JOIN rental USING(inventory_id) JOIN payment USING(rental_id)
GROUP BY category_id
ORDER BY sum(amount);

-- ¿Cuál es la correcta? Lo dijo muy clarito Víctor en clase. Menos mal que lo apuntaste en tus apuntes.

-- 7) Actores con al menos diez películas de categorías distintas
-- RESPUESTA A: Las 2 consultas juntas
SELECT CONCAT(first_name, ' ', last_name) AS actor, COUNT(DISTINCT category_id),COUNT(category_id)
FROM actor JOIN film_actor USING(actor_id) JOIN film USING(film_id)
	JOIN film_category USING(film_id)
GROUP BY actor_id
HAVING COUNT(DISTINCT category_id) > 10;
-- esto contesta a "Actores que han trabajado en, al menos, 10 categorías distintas.
-- Depende: ¿una película puede tener varias categorías? Vamos a verlo:

SELECT film_id, COUNT(category_id)
FROM film_category
GROUP BY film_id
HAVING COUNT(category_id) > 1;

-- RESPUESTA B:
SELECT CONCAT(first_name, ' ', last_name) AS actor, COUNT(DISTINCT category_id),COUNT(distinct film_id)
FROM actor JOIN film_actor USING(actor_id) JOIN film USING(film_id)
	JOIN film_category USING(film_id)
GROUP BY actor_id
HAVING COUNT(DISTINCT category_id) > 10 AND COUNT(distinct film_id) > 10;


-- (?)

-- OP2: payment -> staff -(store_id)-> store 
SELECT *
FROM payment JOIN staff USING(staff_id) JOIN store USING(store_id);


SELECT *
FROM payment JOIN staff USING(staff_id) JOIN store USING(store_id)
WHERE manager_staff_id != staff_id;

-- OP3: payment -> staff -(manager_staff_id)-> store
SELECT *
FROM payment JOIN staff USING(staff_id) JOIN store USING(manager_staff_id) ;
-- error porque store.manager_staff_id no existe

SELECT *
FROM payment JOIN staff USING(staff_id) JOIN store ON store.manager_staff_id = staff.staff_id;

SELECT *
FROM payment JOIN staff USING(staff_id) JOIN store ON store.manager_staff_id = staff.staff_id
WHERE manager_staff_id != staff_id;
-- ¿Por qué no sale ninguno? ¿Será que solo hay 2 staffs y cada uno es manager de una tienda?

-- ¿Será que ...?
select * from staff;

-- ya VEREMOS:
-- 8) Tiendas con más stock disponible
-- 9) Películas que nunca han sido alquiladas
-- 10) Diez películas con mayor diferencia entre coste de reposición y tarifa de alquiler
