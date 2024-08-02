--  Select the first name, last name, and email address of all the customers who have rented a movie.	
SELECT DISTINCT(R.CUSTOMER_ID), CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS CUSTOMER_NAME, C.EMAIL
FROM SAKILA.RENTAL R 
LEFT JOIN SAKILA.CUSTOMER C
ON R.CUSTOMER_ID = C.CUSTOMER_ID;

-- What is the average payment made by each customer 
-- (display the customer id, customer name (concatenated), and the average payment made).
SELECT P.CUSTOMER_ID, CONCAT(C.FIRST_NAME, ' ', C.LAST_NAME) AS CUSTOMER_NAME, AVG(P.AMOUNT) AS AVG_PAYMENT
FROM SAKILA.PAYMENT P 
LEFT JOIN SAKILA.CUSTOMER C
ON P.CUSTOMER_ID = C.CUSTOMER_ID
GROUP BY 1, 2 
ORDER BY 3;

-- Select the name and email address of all the customers who have rented the "Action" movies.
SELECT DISTINCT(CONCAT(C.FIRST_NAME, ' ' , C.LAST_NAME)) AS CUSTOMER_NAME, C.EMAIL
FROM SAKILA.CUSTOMER C
LEFT JOIN SAKILA.RENTAL R 
ON C.CUSTOMER_ID = R.CUSTOMER_ID
LEFT JOIN SAKILA.INVENTORY I 
ON R.INVENTORY_ID = I.INVENTORY_ID
LEFT JOIN SAKILA.FILM_CATEGORY FC
ON I.FILM_ID = FC.FILM_ID
LEFT JOIN SAKILA.CATEGORY CA
ON FC.CATEGORY_ID = CA.CATEGORY_ID
WHERE CA.NAME = 'ACTION';

-- Use the case statement to create a new column classifying existing columns 
-- as either or high value transactions based on the amount of payment.
SELECT *,
CASE
WHEN AMOUNT < 2 THEN 'low' 
WHEN AMOUNT > 4 THEN 'medium'
ELSE 'high'
END AS amount_level
FROM SAKILA.PAYMENT;
