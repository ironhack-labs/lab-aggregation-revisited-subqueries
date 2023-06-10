use sakila;

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id;

SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS customer_name, AVG(p.amount) AS average_payment
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id;

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
JOIN film f ON i.film_id = f.film_id
JOIN film_category fc ON f.film_id = fc.film_id
JOIN category cat ON fc.category_id = cat.category_id
WHERE cat.name = 'Action';

SELECT c.first_name, c.last_name, c.email
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
WHERE r.inventory_id IN (
    SELECT i.inventory_id
    FROM inventory i
    WHERE i.film_id IN (
        SELECT f.film_id
        FROM film f
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category cat ON fc.category_id = cat.category_id
        WHERE cat.name = 'Action'
    )
);

SELECT p.payment_id, p.amount,
    CASE
        WHEN p.amount >= 0 AND p.amount <= 2 THEN 'low'
        WHEN p.amount > 2 AND p.amount <= 4 THEN 'medium'
        ELSE 'high'
    END AS payment_label
FROM payment p;