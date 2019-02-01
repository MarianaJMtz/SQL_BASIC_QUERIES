USE sakila;

#1a
SELECT first_name, last_name FROM actor;

#1b
ALTER TABLE actor ADD `Actor Name` VARCHAR(40);
UPDATE actor SET `Actor Name`= CONCAT(first_name, " ", last_name);

#2a
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = "Joe";

#2b
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

#2c
SELECT actor_id, last_name, first_name FROM actor WHERE last_name LIKE '%LI%';

#2d
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3a
ALTER TABLE actor ADD description BLOB;

#3b
ALTER TABLE actor DROP description;

#4a
SELECT last_name, COUNT(*) FROM actor GROUP BY last_name;

#4b
SELECT last_name, COUNT(*) FROM actor Group BY last_name HAVING COUNT(*) >=2;

#4c
UPDATE actor SET first_name = "Harpo" WHERE first_name = "Groucho" AND last_name = "Williams";

#4d
UPDATE actor SET first_name = "Groucho" WHERE first_name = "Harpo";

#5a
SELECT DISTINCT TABLE_SCHEMA FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME = 'address';

#6a
SELECT staff.first_name, staff.last_name, address.address 
	FROM staff 
    INNER JOIN address ON
	staff.address_id = address.address_id;

#6b
SELECT staff.first_name, staff.last_name, SUM(payment.amount) 
	FROM payment 
	INNER JOIN staff ON
	staff.staff_id = payment.staff_id 
    WHERE payment.payment_date LIKE '%2005-08%' 
    GROUP BY staff.first_name;

#6c
SELECT film.title, COUNT(film_actor.actor_id) 
	FROM film 
    INNER JOIN film_actor ON 
	film.film_id = film_actor.film_id 
    GROUP BY film.title;

#6d
SELECT film.title, COUNT(inventory_id) 
	FROM film 
    INNER JOIN inventory ON
	film.film_id = inventory.film_id 
    WHERE film.title = "Hunchback Impossible";

#6e
SELECT customer.first_name, customer.last_name, SUM(payment.amount) 
	FROM customer 
	INNER JOIN payment ON
	customer.customer_id = payment.customer_id 
    GROUP BY customer.last_name;

#7a
SELECT title, (SELECT language_id FROM `language` WHERE `language`.`name` = "English" AND 
	film.language_id = `language`.language_id) AS "Language ID" FROM film WHERE film.title LIKE '%K%' OR
	film.title LIKE '%Q%'; 

#7b
SELECT first_name, last_name FROM actor WHERE actor_id IN (
	SELECT actor_id FROM film_actor WHERE film_id IN (
		SELECT film_id FROM film WHERE title = "Alone Trip"));
    
#7c
SELECT customer.first_name, customer.last_name
	FROM customer
    INNER JOIN address ON
    customer.address_id = address.address_id
    INNER JOIN city ON
    address.city_id = city.city_id
    INNER JOIN country ON
	city.country_id = country.country_id
    WHERE country.country = "Canada";

#7d
SELECT title FROM film WHERE film_id IN (
	SELECT film_id FROM film_category WHERE category_id IN (
		SELECT category_id FROM category WHERE `name` = "Family"));

#7e
SELECT film.title, COUNT(inventory.film_id) AS "Rental times"
	FROM film 
	INNER JOIN inventory ON
	film.film_id = inventory.film_id 
	INNER JOIN rental ON
	inventory.inventory_id = rental.inventory_id
	GROUP BY film.title ORDER BY `Rental times` DESC;

#7f
SELECT staff.store_id, SUM(payment.amount) AS "Total Revenues"
	FROM staff
	INNER JOIN payment ON
	staff.staff_id = payment.staff_id
	GROUP BY staff.store_id;

#7g
SELECT store.store_id, city.city, country.country 
	FROM store
	INNER JOIN address ON
	store.address_id = address.address_id
	INNER JOIN city ON
    address.city_id = city.city_id
    INNER JOIN country ON
    city.country_id = country.country_id;

#7h
SELECT category.`name`, SUM(payment.amount) AS "TOTAL"
	FROM category
    INNER JOIN film_category ON
    category.category_id = film_category.category_id
    INNER JOIN inventory ON
    film_category.film_id = inventory.film_id
    INNER JOIN rental ON
    inventory.inventory_id = rental.inventory_id
    INNER JOIN payment ON
	rental.rental_id = payment.rental_id
	GROUP BY category.`name` ORDER BY TOTAL DESC;
    
#8a
CREATE VIEW `Top Five Genres` AS SELECT category.`name`, SUM(payment.amount) AS "TOTAL"
	FROM category
    INNER JOIN film_category ON
    category.category_id = film_category.category_id
    INNER JOIN inventory ON
    film_category.film_id = inventory.film_id
    INNER JOIN rental ON
    inventory.inventory_id = rental.inventory_id
    INNER JOIN payment ON
	rental.rental_id = payment.rental_id
	GROUP BY category.`name` ORDER BY TOTAL DESC;
    
#8b
SELECT * FROM `Top Five Genres`;

#8c
DROP VIEW `Top Five Genres`;