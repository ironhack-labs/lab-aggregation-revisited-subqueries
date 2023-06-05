use sakila;

# Lab | Aggregation Revisited - Subqueries

# Instructions

# Write the SQL queries to answer the following questions:

# Select the first name, last name, and email address of all the customers who have rented a movie.

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r USING(customer_id)
;

# What is the average payment made by each customer (display the customer id, customer name (concatenated), 
# and the average payment made).

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p USING (customer_id)
GROUP BY c.customer_id, customer_name;

# Select the name and email address of all the customers who have rented the "Action" movies.

# Write the query using multiple join statements

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email, cat.name
FROM customer c
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category cat USING (category_id)
WHERE cat.name = 'Action'
GROUP BY customer_name, c.email, cat.name;

# Write the query using sub queries with multiple WHERE clause and IN condition

SELECT CONCAT(c.first_name, ' ',c.last_name) AS customer_name, email
FROM customer c
WHERE customer_id IN (
    SELECT r.customer_id
    FROM rental r
    WHERE r.inventory_id IN (
        SELECT i.inventory_id
        FROM inventory i
        WHERE i.film_id IN (
            SELECT f.film_id
            FROM film f
            WHERE f.film_id IN (
                SELECT film_id
                FROM film_category
                WHERE category_id IN (
                    SELECT category_id
                    FROM category
                    WHERE name = 'Action'
                    GROUP BY c.email
                )
            )
        )
    )
);

# Verify if the above two queries produce the same results or not

# They're the same

# Use the case statement to create a new column classifying existing columns as either or high value 
# transactions based on the amount of payment. If the amount is between 0 and 2, label should be low and if 
# the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

SELECT customer_id, amount,
    CASE
        WHEN amount BETWEEN 0 AND 2 THEN 'Low'
        WHEN amount BETWEEN 2 AND 4 THEN 'Medium'
        WHEN amount > 4 THEN 'High'
    END AS classification
FROM payment;