#Lab | Aggregation Revisited - Subqueries
#In this lab, you will be using the Sakila database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official installation link.

#Instructions
#Write the SQL queries to answer the following questions:

#Select the first name, last name, and email address of all the customers who have rented a movie.

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

#Select the name and email address of all the customers who have rented the "Action" movies.

#Write the query using multiple join statements
#Write the query using sub queries with multiple WHERE clause and IN condition
#Verify if the above two queries produce the same results or not
#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.







#Select the first name, last name, and email address of all the customers who have rented a movie.
use sakila;

SELECT first_name, last_name, email
FROM sakila.customer
;


#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT p.customer_id, CONCAT(c.first_name, ' ',c.last_name) as customer_name, AVG(p.amount) as average_payment
From sakila.customer c
JOIN sakila.payment p ON c.customer_id = p.customer_id
Group by 1,2
;

#Select the name and email address of all the customers who have rented the "Action" movies.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';





#Write the query using multiple join statements
SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email
FROM customer c
WHERE customer_id IN (
SELECT customer_id
FROM rental
WHERE inventory_id IN (
SELECT inventory_id
FROM inventory
WHERE film_id IN (
SELECT film_id
FROM film
WHERE film_id IN (
SELECT film_id
FROM film_category
WHERE category_id IN (
SELECT category_id
FROM category
WHERE name = 'Action'
)))))
;


#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.
SELECT payment_id, amount,
CASE
WHEN amount BETWEEN 0 AND 2 THEN 'low'
WHEN amount BETWEEN 2 AND 4 THEN 'medium'
ELSE 'high'
END AS label
FROM payment;
