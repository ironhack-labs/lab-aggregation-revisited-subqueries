-- Instructions
-- Write the SQL queries to answer the following questions:
-- 1.Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT first_name, last_name, email FROM sakila.customer;

-- 2.What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT c.customer_id, concat(c.first_name, ' ', c.last_name) AS name, avg(p.amount) AS average_payment FROM sakila.customer c
JOIN sakila.payment p ON c.customer_id = p.customer_id
GROUP BY 1,2;

-- 3. Select the name and email address of all the customers who have rented the "Action" movies. Write the query using multiple join statements.
SELECT c.first_name, c.last_name, cat.name AS category_name FROM sakila.customer c
JOIN sakila.rental r ON c.customer_id = r.customer_id
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON i.film_id = f.film_id
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category cat ON cat.category_id = cat.category_id
WHERE cat.name = 'Action';

-- 4. Write the query using sub queries with multiple WHERE clause and IN condition.
SELECT c.first_name, c.last_name FROM sakila.customer c WHERE customer_id IN (
SELECT * FROM sakila.rental r WHERE r.inventory_id IN (
SELECT * FROM sakila.inventory i WHERE i.inventory_id IN (
SELECT * FROM sakila.film f WHERE f.film_id IN (
SELECT * FROM sakila.film_category fc WHERE fc.film_id IN (
SELECT * FROM sakila.category cat WHERE cat.name = 'Action')))));

-- 5. Verify if the above two queries produce the same results or not

-- 6. Use the case statement to create a new column classifying existing columns as either or high value transactions 
-- based on the amount of payment. 
-- If the amount is between 0 and 2, label should be low 
-- if the amount is between 2 and 4, the label should be medium
-- if it is more than 4, then it should be high.
SELECT concat(c.first_name, ' ', c.last_name) AS client, p.amount, 
CASE WHEN p.amount BETWEEN 0 AND 2 THEN 'Low' 
     WHEN p.amount BETWEEN 2 AND 4 THEN'Medium'
     ELSE 'High'
     END AS 'transaction_classification'
FROM sakila.customer c
JOIN sakila.payment p ON c.customer_id = p.customer_id