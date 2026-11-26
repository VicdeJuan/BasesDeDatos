use sakila;
### 1. Idiomas y películas 

# Muestra el identificador y nombre de todos los idiomas, junto con el identificador y título de sus películas. Incluye los idiomas que no tengan películas. Ordena por idioma y título.

### 2. Películas y ejemplares 

# Muestra el identificador y título de todas las películas y el identificador de cada ejemplar del inventario. Incluye las películas sin ejemplares. Ordena por título y ejemplar.

### 3. Películas y reparto 

# Muestra el identificador y título de todas las películas, junto con los identificadores de los actores que participan en ellas. Incluye las películas sin actores. Ordena por título y actor.

SELECT *
FROM film_actor RIGHT JOIN film USING(film_id)
WHERE film_actor.actor_id is null;

### 4. Ciudades y direcciones 

# Muestra el identificador y nombre de todas las ciudades, junto con el identificador y texto de las direcciones registradas. Incluye ciudades sin direcciones. Ordena por ciudad y dirección.

SELECT city_id,city,address_id,address, country.*
FROM city LEFT JOIN address USING(city_id) JOIN country USING(country_id)
WHERE address_id is null
-- WHERE city like 'Lond%'
ORDER BY city_id;

-- OJO PIOJO CON ESTE EJEMPLO.


### 5. Ejemplares y alquileres 
# Muestra el identificador de todos los ejemplares, su película y el identificador de cada alquiler registrado. Incluye los ejemplares nunca alquilados. Ordena por identificador de ejemplar y alquiler.



 
### 6. Inventario de la tienda 1 
# Muestra todas las películas y los identificadores de los ejemplares disponibles en la tienda 1. Incluye las películas sin ejemplares en esa tienda, aunque tengan en otra. Ordena por título y ejemplar.


### 7. Alquileres de mayo de 2005 
# Muestra el identificador, nombre y apellidos de todos los clientes y los alquileres que realizaron en mayo de 2005, con su fecha. Incluye clientes sin alquileres ese mes. Ordena por cliente y fecha.

SELECT customer_id,count(rental_id)
FROM rental right JOIN customer USING(customer_id)
WHERE YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05
group by customer_id;

select count(*) from customer;

SELECT *
FROM rental RIGHT JOIN customer USING(customer_id)
WHERE YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05
	AND rental_id is null;

SELECT *
FROM customer ;


SELECT *
FROM rental r RIGHT JOIN customer c ON r.customer_id = c.customer_id
WHERE (rental_date is null) OR (YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05);

select year(null);


-- QUEREMOS MOVER EL FILTRO DE SITIO
SELECT *
FROM rental R RIGHT JOIN customer C ON (r.customer_id = c.customer_id AND YEAR(rental_date) = 2005 AND MONTH(rental_date) = 05);



### 8. Películas por idioma 
# Muestra todos los idiomas y las películas asociadas a cada uno, incluyendo los idiomas sin películas. Esta vez la tabla de películas debe aparecer a la izquierda del JOIN. Ordena por idioma y título.



### 9. Películas y copias 
# Muestra todas las películas y sus identificadores de inventario, incluyendo las que no tienen copias. Sitúa la tabla de inventario a la izquierda del JOIN. Ordena por película y ejemplar.

### 10. Películas y asociaciones con actores 
# Muestra todas las películas y sus identificadores de actores asociados, incluidas las que no tienen ninguno. Sitúa la tabla intermedia de actores a la izquierda. Ordena por título.

### 11. Ciudades y direcciones 
# Muestra todas las ciudades y sus direcciones, incluidas las ciudades sin direcciones. Sitúa la tabla de direcciones a la izquierda del JOIN. Ordena por ciudad y dirección.


### 12. Alquileres por ejemplar 
# Muestra cada ejemplar del inventario y los identificadores de sus alquileres, incluyendo los nunca alquilados. Sitúa rental a la izquierda del JOIN. Ordena por ejemplar y alquiler.

### 13. Ejemplares de la tienda 2 

# Muestra todas las películas y sus ejemplares de la tienda 2, incluyendo las películas que no tengan ejemplares en esa tienda. Sitúa inventory a la izquierda del JOIN. Ordena por título y ejemplar.
 
### 14. Idiomas sin películas 

# Muestra exclusivamente el identificador y nombre de los idiomas que no tienen películas asociadas. Incluye el identificador de la película en la salida para apreciar el valor nulo. Ordena por idioma.

### 15. Películas sin inventario 

# Muestra exclusivamente el identificador y título de las películas que carecen de ejemplares. Incluye también inventory_id en la salida. Utiliza 

### 16. Películas sin actores 

# Muestra exclusivamente las películas sin actores asociados. Devuelve identificador, título y el identificador del actor, y ordena por título.

### 17. Ejemplares nunca alquilados 

# Muestra exclusivamente los ejemplares que nunca se han alquilado. Devuelve el identificador del ejemplar, su película y el identificador del alquiler (nulo). Utiliza 

### 18. Ciudades sin direcciones (agrupación) 
# Muestra las ciudades que no tienen ninguna dirección registrada,
# junto con el número de direcciones y el máximo identificador de dirección. Ordena por ciudad.
SELECT city_id,city,COUNT(address_id) AS num_direcciones, MAX(address_id) AS max_identificador
FROM city LEFT JOIN address USING(city_id)
WHERE address_id IS NULL
GROUP BY city_id;




### 19. Películas con menos de 3 copias en tienda 1 
# Muestra el identificador y título de las películas que tienen menos de tres ejemplares en la tienda 1, 
# incluidos los que tienen cero. Añade el recuento de ejemplares y el máximo identificador de ejemplar. Ordena por recuento y título.

SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- Le añadimos lo de la tienda 1

SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id
WHERE i.store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- Esto es incorrecto porque falta la 14, por ejemplo.
-- La peli 14 NO TIENE COPIAS EN NINGUNA TIENDA, 
-- por tanto, no tiene copias en la tienda 1.
-- Ergo, debería salir en esta consulta.

-- SOLUCIÓN:
SELECT f.film_id,f.title,count(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND i.store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3;

-- ¿Por qué tiene que ir en el ON y no en el WHERE?  [A CONTESTAR POR EL ALUMNO]


-- otra posible solución:
SELECT f.film_id,f.title,i.inventory_id,i.store_id
FROM inventory i RIGHT JOIN film f ON i.film_id = f.film_id
WHERE store_id = 1 OR store_id is null;
-- Aquí entra al cóctel toda la tabla film y toda la tabla inventory.
-- Esto da lugar a filas con store_id 1,2 o null. Como filtro en el where,
-- esas filas con store_id = 2 van a desaparecer. Si la peli no tenía copias
-- en la tienda 1, al desaparecer han desaparecido y el count no va a poder
-- contarlas porque no están.

SELECT f.film_id,f.title,i.inventory_id,i.store_id
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND store_id = 1;
-- Aquí sin embargo, entra al cóctel toda la tabla film CON UNA PARTE de la tabla inventory.
-- Esto da lugar a filas con store_id 1 o null. No puede haber filas con store_id = 2.
-- ¿Qué store_id van a tener las filas que en la query anterior tenían un store_id = 2?
-- Esas filas tendrán un NULL en store_id. Se puede comprobar con las películas 2 y 3.
-- En la consulta anterior, la peli 2 y la peli 3 no salen (porque tenían store_id=2). En esta,
-- SÍ salen la 2 y la 3 porque se les ha puesto un null en store_id.

-- CONCLUSIÓN: 


SELECT f.film_id,f.title,count(i.inventory_id), MAX(i.inventory_id)
FROM 
inventory i RIGHT JOIN film f ON i.film_id = f.film_id AND store_id = 1
GROUP BY f.film_id
HAVING count(i.inventory_id) < 3
ORDER BY count(i.inventory_id) DESC, title;




SELECT f.film_id,f.title,i.film_id,i.inventory_id,i.store_id
FROM film f LEFT JOIN inventory i on f.film_id = i.film_id
WHERE f.film_id IN (1,2,3,4,5,14);

SELECT f.film_id,f.title,i.film_id,i.inventory_id,i.store_id
FROM film f LEFT JOIN inventory i on f.film_id = i.film_id
WHERE f.film_id IN (1,2,3,4,5,14) AND store_id = 1;


SELECT f.film_id,f.title,i.film_id,i.inventory_id,i.store_id
FROM film f LEFT JOIN inventory i on f.film_id = i.film_id  AND store_id = 1
WHERE f.film_id IN (1,2,3,4,5,14);


SELECT f.film_id,f.title
FROM film f 
WHERE film_id IN (1,2,3,4,5,14);

### 20. Películas jamás alquiladas (varios JOIN) 

# Muestra las películas que nunca se han alquilado, considerando todos sus ejemplares en las dos tiendas. 
# Devuelve identificador, título, número de alquileres y máximo identificador de alquiler. Ordena por título.

SELECT inventory_id, film_id,count(rental_id)
FROM rental RIGHT JOIN inventory USING(inventory_id)
GROUP BY inventory_id
HAVING count(rental_id) = 0;


SELECT inventory_id, film_id, rental_id
FROM rental RIGHT JOIN inventory USING(inventory_id)
WHERE rental_id is null; -- esto son los inventories que nunca se han alquilado.
-- PERO SE PIDEN PELÍCULAS

select film.film_id,  title, count(rental_id),count(inventory_id), count(distinct inventory_id)
-- from rental RIGHT JOIN inventory USING(inventory_id) RIGHT JOIN film USING(film_id)
FROM film LEFT JOIN inventory ON film.film_id = inventory.film_id LEFT JOIN rental USING(inventory_id)
GROUP BY film.film_id
HAVING count(rental_id) = 0;
-- HAVING COUNT(rental_id) != count(inventory_id);




