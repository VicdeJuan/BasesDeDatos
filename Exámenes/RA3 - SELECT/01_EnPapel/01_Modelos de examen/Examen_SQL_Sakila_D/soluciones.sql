USE sakila;

-- Consulta 1: Alquileres procesados por empleado
SELECT staff_id,COUNT(*) AS alquileres,COUNT(return_date) AS devueltos,COUNT(*)-COUNT(return_date) AS pendientes FROM rental GROUP BY staff_id ORDER BY staff_id;

-- Consulta 2: Películas largas y sus categorías
SELECT f.title AS titulo,c.name AS categoria,ROUND(f.length/60,2) AS duracion_horas FROM film f JOIN film_category fc ON f.film_id=fc.film_id JOIN category c ON fc.category_id=c.category_id WHERE f.length/60>2.50 ORDER BY duracion_horas DESC,titulo ASC;

-- Consulta 3: Copias de películas R por tienda
SELECT i.store_id,COUNT(*) AS ejemplares,ROUND(SUM(f.replacement_cost),2) AS coste_reposicion_total FROM inventory i JOIN film f ON i.film_id=f.film_id WHERE f.rating='R' GROUP BY i.store_id ORDER BY i.store_id;

-- Consulta 4: Países con suficientes clientes activos
SELECT co.country AS pais,COUNT(*) AS clientes_activos,COUNT(DISTINCT ci.city_id) AS ciudades FROM customer c JOIN address a ON c.address_id=a.address_id JOIN city ci ON a.city_id=ci.city_id JOIN country co ON ci.country_id=co.country_id WHERE c.active=1 GROUP BY co.country_id,co.country HAVING COUNT(*)>=5 ORDER BY clientes_activos DESC,pais ASC;

-- Consulta 5: Pagos mensuales de clientes cuyo nombre empieza por B
SELECT YEAR(p.payment_date) AS anio,MONTH(p.payment_date) AS mes,COUNT(*) AS pagos,ROUND(AVG(p.amount),2) AS importe_medio FROM payment p JOIN customer c ON p.customer_id=c.customer_id WHERE c.first_name LIKE 'B%' GROUP BY YEAR(p.payment_date),MONTH(p.payment_date) ORDER BY anio,mes;
