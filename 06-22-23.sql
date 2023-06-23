USE sakila;

-- Write a query that filters the films by the rating of PG-13
SELECT *
FROM film
WHERE rating = 'PG-13';

-- Write a query that shows the films that have the category of Comedy and they are rated either in PG or PG-13
SELECT title, category.name, rating
FROM film
JOIN film_category USING(film_id)
JOIN category USING(category_id)
WHERE category.name = 'Comedy'
    AND rating IN ('PG', 'PG-13');

-- Write a query that gives me all the first names that start with J and live in El Alto city.
SELECT first_name, last_name, city
FROM customer
JOIN address USING(address_id)
JOIN city USING(city_id)
WHERE first_name LIKE 'J%'
    AND city = 'El Alto';

-- Write a query that finds the customers who rented movies more than 10 times and put their names
-- and emails, as they are eligable for a discount!
SELECT first_name, last_name, COUNT(*) AS times_rented, email
FROM customer
JOIN rental USING(customer_id)
GROUP BY customer.customer_id
HAVING COUNT(*) > 10;

-- Retrieve all the films that have a rental duration between 3 and 5 days (inclusive) and are rated 'R'
SELECT title, release_year
FROM film
WHERE rental_duration BETWEEN 3 AND 5
    AND rating = 'R';

-- Write a query that finds all the customers that rented out movies in June 2005
SELECT first_name, last_name
FROM customer
JOIN rental USING(customer_id)
WHERE MONTH(rental_date) = 6
  AND YEAR(rental_date) = 2005;

-- Give me the name of the customer that was the first one to rent a movie at this store and what movie he/she rented out
SELECT first_name, last_name, title
FROM customer
JOIN rental USING(customer_id)
JOIN inventory USING(inventory_id)
JOIN film USING(film_id)
WHERE rental_date = (SELECT MIN(rental_date) FROM rental)
