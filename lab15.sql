#Select the first name, last name, and email address of all the customers who have rented a movie.
use sakila;

SELECT distinct first_name, customer.last_name, customer.email
FROM rental
JOIN customer ON rental.customer_id = customer.customer_id;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS name, AVG(p.amount) AS average_amount
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, name;

#Select the name and email address of all the customers who have rented the "Action" movies.

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email, cat.name
FROM customer c
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
JOIN film_category fc USING (film_id)
JOIN category cat USING (category_id)
WHERE cat.name = 'Action'
GROUP BY 1;

#Write the query using multiple join statements

SELECT CONCAT(c.first_name, ' ', c.last_name) AS customer_name, c.email, cat.name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action'
GROUP BY customer_name, c.email, cat.name;

#Write the query using sub queries with multiple WHERE clause and IN condition

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

#Verify if the above two queries produce the same results or not
  # In the second querie it does not show the name of the movie type(action)
  
#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
#If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, 
#then it should be high.

SELECT payment_id, amount,
  CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
  END AS label
FROM payment;