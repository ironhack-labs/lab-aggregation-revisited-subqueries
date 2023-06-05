USE sakila;

# Select the first name, last name, and email address of all the customers who have rented a movie.
SELECT
	c.first_name,
    c.last_name,
    c.email
FROM customer c
RIGHT JOIN rental r ON r.customer_id = c.customer_id
GROUP BY 1,2,3
;

# What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
SELECT
	c.customer_id,
    concat(c.first_name,' ',c.last_name) as name,
    avg(p.amount) as average_amount
FROM customer c
LEFT JOIN payment  p ON p.customer_id = c.customer_id
GROUP BY 1,2
ORDER BY 1
;

# Select the name and email address of all the customers who have rented the "Action" movies.
# 	- Write the query using multiple join statements
SELECT
	c.customer_id,
    concat(c.first_name,' ',c.last_name) as name,
    c.email
FROM customer c
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
JOIN film_category fc USING (film_id)
JOIN category ca USING (category_id)
WHERE ca.name = 'Action'
GROUP BY 1,2,3
ORDER BY 1
;

# 	- Write the query using sub queries with multiple WHERE clause and IN condition
SELECT
	c.customer_id,
    concat(c.first_name,' ',c.last_name) as name,
    c.email
FROM customer c
WHERE c.customer_id IN (
	SELECT r.customer_id
	FROM rental r
    WHERE r.inventory_id IN (
		SELECT i.inventory_id
        FROM inventory i
        WHERE i.film_id IN (
			SELECT fc.film_id
            FROM film_category fc
            WHERE fc.category_id IN (
				SELECT ca.category_id
                FROM category ca
                WHERE ca.name = 'Action'
                )
			)
		)
	)
ORDER BY 1
;
# 	- Verify if the above two queries produce the same results or not
# The result is the same


# Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
# If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4,
# then it should be high.
SELECT
	payment_id,
    amount,
    CASE WHEN amount <= 2 then 'low'
    WHEN amount <= 4 then 'medium'
    else 'high'
    end as type
FROM payment p
;