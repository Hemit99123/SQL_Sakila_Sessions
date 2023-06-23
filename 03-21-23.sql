USE sakila;

SELECT * FROM actor WHERE first_name = "Scarlett";

SELECT * FROM actor WHERE last_name = "Johansson";

SELECT DISTINCT(last_name) FROM actor;

SELECT ROUND(AVG(timestampdiff(day, rental_date, return_date))) AS rental_time_period, category.name AS category  FROM rental
JOIN inventory USING(inventory_id)
JOIN film_category USING(film_id)
JOIN category USING(category_id)
GROUP BY category.name
ORDER BY rental_time_period;

SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date);

SELECT DISTINCT name AS language FROM language
ORDER BY language;

SELECT CONCAT(first_name, " ", last_name) as actor_fullname FROM actor
WHERE last_name REGEXP "SON"
ORDER BY first_name;

SELECT *
FROM address;

UPDATE address
SET address2 = NULL
WHERE LENGTH(TRIM(address2)) = 0;


SELECT category.name, COUNT(*) as amount_of_films FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE film_id BETWEEN 55 AND 65
GROUP BY category.name
ORDER BY amount_of_films DESC;

SELECT COUNT(*) 
FROM (
    SELECT category.name, AVG(film.replacement_cost - film.rental_rate) AS avg_diff
    FROM film
    INNER JOIN film_category ON film.film_id = film_category.film_id
    INNER JOIN category ON film_category.category_id = category.category_id
    GROUP BY category.name
    HAVING avg_diff > 17
);

SELECT MAX(minimum) FROM (
   SELECT MIN(postal_code) AS minimum FROM address WHERE LENGTH(TRIM(postal_code)) > 0 GROUP BY district
) AS t;

SELECT 

CONCAT(customer.first_name, " ", customer.last_name) AS customer_name, 
CONCAT(actor.first_name, " ", actor.last_name) AS actor_name

FROM actor

JOIN customer USING(first_name)
WHERE actor_id <> 8 AND actor.first_name = (
    SELECT first_name FROM actor
    WHERE actor_id = 8
);

SELECT film.title, COUNT(*) FROM rental
JOIN inventory USING (inventory_id)
JOIN film USING (film_id)
GROUP BY film.title;

SELECT COUNT(*) as total_rented FROM rental;

SELECT COUNT(*) as not_returned FROM rental
WHERE return_date IS NULL;

SELECT COUNT(*) as overdue FROM rental
WHERE return_date > rental_date
