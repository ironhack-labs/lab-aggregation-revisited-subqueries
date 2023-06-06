-- Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT first_name, last_name, email
FROM sakila.customer;

-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT c.customer_id, concat(c.first_name," ",c.last_name) as customer, avg(p.amount) as average_payment
FROM sakila.customer c
LEFT JOIN sakila.payment p ON c.customer_id = p.customer_id
GROUP BY 1,2;

-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
--  Write the query using multiple join statements
--  Write the query using sub queries with multiple WHERE clause and IN condition
-- Verify if the above two queries produce the same results or not


WITH cte_3 AS (
  SELECT r.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS full_name
  FROM sakila.rental r
  JOIN sakila.customer c ON r.customer_id = c.customer_id
  LEFT JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
  JOIN sakila.film_category f ON i.film_id = f.film_id
  JOIN sakila.category ca ON f.category_id = ca.category_id
  WHERE ca.name = 'Action'
  GROUP BY 1,2
)
SELECT full_name
FROM cte_3;



-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based 
-- on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
-- the label should be medium, and if it is more than 4, then it should be high.

SELECT p.payment_id,
  CASE
    WHEN MAX(amount) < 2 THEN 'Low'
    WHEN MAX(amount) >= 2 AND MAX(amount) < 4 THEN 'Medium'
    WHEN MAX(amount) >= 4 THEN 'High'
  END AS label
FROM sakila.payment p
GROUP BY p.payment_id
ORDER BY p.payment_id;
