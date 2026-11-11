USE sakila;

-- Consulta 1: Existencias por tienda
SELECT store_id,COUNT(*) AS ejemplares,COUNT(DISTINCT film_id) AS titulos FROM inventory GROUP BY store_id ORDER BY store_id;

-- Consulta 2: Diferencia de coste e idioma
SELECT f.title AS titulo,l.name AS idioma,f.replacement_cost AS coste_reposicion,f.rental_rate AS tarifa_alquiler,f.replacement_cost-f.rental_rate AS diferencia_coste FROM film f JOIN language l ON f.language_id=l.language_id WHERE f.replacement_cost-f.rental_rate>20 ORDER BY diferencia_coste DESC,titulo ASC;

-- Consulta 3: Ciudades de Canadá e India
SELECT co.country AS pais,COUNT(*) AS ciudades FROM country co JOIN city ci ON co.country_id=ci.country_id WHERE co.country IN ('Canada','India') GROUP BY co.country_id,co.country ORDER BY ciudades DESC,pais ASC;

-- Consulta 4: Actores con apellidos largos y muchas películas
SELECT a.first_name AS nombre,a.last_name AS apellido,COUNT(*) AS peliculas FROM actor a JOIN film_actor fa ON a.actor_id=fa.actor_id WHERE CHAR_LENGTH(a.last_name)>=8 GROUP BY a.actor_id,a.first_name,a.last_name HAVING COUNT(*)>=25 ORDER BY peliculas DESC,apellido ASC;

-- Consulta 5: Alquileres mensuales de clientes cuyo nombre empieza por M
SELECT YEAR(r.rental_date) AS anio,MONTH(r.rental_date) AS mes,COUNT(*) AS alquileres,COUNT(r.return_date) AS devueltos FROM rental r JOIN customer c ON r.customer_id=c.customer_id WHERE c.first_name LIKE 'M%' GROUP BY YEAR(r.rental_date),MONTH(r.rental_date) ORDER BY anio,mes;
