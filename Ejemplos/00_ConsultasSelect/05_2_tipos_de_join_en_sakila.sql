use sakila;

-- ojo que hay copias físicas que no se han devuelto.
SELECT * 
FROM inventory JOIN rental USING(inventory_id) where inventory_id = 2047;

-- 1) Saca el listado de copias físicas de películas que nunca han sido alquiladas.
SELECT * 
FROM inventory LEFT JOIN rental USING(inventory_id)
WHERE rental_id IS NULL;

-- Comprobaciones para asegurar que lo estoy haciendo bien porque todavía no sé mucho SQL.
SELECT * 
FROM inventory LEFT JOIN rental USING(inventory_id)
WHERE inventory_id = 5;

SELECT * 
FROM rental 
where inventory_id = 5;
-- Conclusión: correcto, la copia física 5 no se ha alquilado.



-- 3) Saca el listado de los nombres de películas que no tienen copias físicas.
SELECT * 
FROM film LEFT JOIN inventory USING(film_id)
where inventory_id is null;

SELECT * 
FROM inventory where film_id = 38;


-- Preguntas:
-- a) ¿La peli 14 tiene algún rental?
SELECT *
-- FROM rental LEFT|RIGHT JOIN inventory USING(inventory_id)
WHERE film_id = 14;

SELECT *
FROM rental RIGHT JOIN inventory USING(inventory_id)
WHERE film_id = 14;

SELECT *
FROM rental LEFT JOIN inventory USING(inventory_id)
WHERE film_id = 14;


-- 2) Saca el listado de los nombres de películas que nunca han sido alquiladas

-- Academy dinosaur que no tiene rental_id pero sí inventory_id
-- La film_id 14,33,36,38... todas las de la consulta anterior

-- SELECT f.film_id,f.title,i.inventory_id,i.film_id,r.rental_id,r.inventory_id
SELECT f.film_id,f.title,i.inventory_id,i.film_id,r.*
FROM
	film f LEFT JOIN inventory i ON f.film_id = i.film_id
			LEFT JOIN rental r ON r.inventory_id = i.inventory_id;
-- WHERE rental_id is null;
    

SELECT f.film_id,f.title,COUNT(rental_id)
FROM
	film f LEFT JOIN inventory i ON f.film_id = i.film_id
			LEFT JOIN rental r ON r.inventory_id = i.inventory_id
-- WHERE r.rental_id is null;
GROUP BY f.film_id
HAVING COUNT(rental_id) = 0; 

SELECT f.title
FROM
	film f LEFT JOIN inventory i ON f.film_id = i.film_id
			LEFT JOIN rental r ON r.inventory_id = i.inventory_id
WHERE r.rental_id is null;





