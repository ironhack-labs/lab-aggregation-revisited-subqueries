# Lab | Aggregation Revisited - Subqueries

# In this lab, you will be using the [Sakila](https://dev.mysql.com/doc/sakila/en/) database of movie rentals. You have been using this database for a couple labs already, but if you need to get the data again, refer to the official [installation link](https://dev.mysql.com/doc/sakila/en/sakila-installation.html).

### Instructions

#Write the SQL queries to answer the following questions:

USE sakila;

 # - Select the first name, last name, and email address of all the customers who have rented a movie.
 
 SELECT 
	c.first_name, 
    c.last_name, 
    c.email
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id;

 # - What is the average payment made by each customer (display the *customer id*, *customer name* (concatenated), and the *average payment made*).
 
SELECT 
	c.customer_id, 
    CONCAT(c.first_name, ' ', c.last_name) AS Customer_Name, 
    AVG(p.amount) AS avg_Payment
FROM customer AS c
JOIN payment AS p ON c.customer_id = p.customer_id
GROUP BY 1, 2;

 
  #- Select the *name* and *email* address of all the customers who have rented the "Action" movies.

SELECT 
	c.first_name, 
    c.last_name, 
    c.email
FROM customer AS c
JOIN rental AS r ON c.customer_id = r.customer_id
JOIN inventory AS i ON r.inventory_id = i.inventory_id
JOIN film_category as fc  ON i.film_id = fc.film_id
JOIN category as cat  ON cat.category_id = fc.category_id
WHERE cat.name = 'Action';


  #- Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
  #If the amount is between 0 and 2, label should be `low` and if the amount is between 2 and 4, the label should be `medium`, and if it is more than 4,
  #then it should be `high`.
  
  SELECT payment_id, amount,
  CASE
    WHEN amount BETWEEN 0 AND 2 THEN 'low'
    WHEN amount BETWEEN 2 AND 4 THEN 'medium'
    WHEN amount > 4 THEN 'high'
  END AS transaction_label
FROM payment;


