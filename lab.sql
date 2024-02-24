-- 1. Select the first name, last name, and email address of all the customers who have rented a movie.	
select distinct(r.customer_id) as id, c.first_name, c.last_name, c.email 
from sakila.rental as r
left join sakila.customer as c
on r.customer_id = c.customer_id
;

-- 2. What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select pay.customer_id, concat(cust.first_name, ' ', cust.last_name) as name, avg(pay.amount) as avg_payment
from sakila.payment as pay
left join sakila.customer as cust
on pay.customer_id = cust.customer_id
group by 1
;

-- 3. Select the name and email address of all the customers who have rented the "Action" movies.
-- a) Write the query using multiple join statements
select distinct(concat(cust.first_name, ' ', cust.last_name)) as name, cust.email
from sakila.customer as cust
left join sakila.rental as r
on cust.customer_id = r.customer_id
left join sakila.inventory as i
on i.inventory_id = r.inventory_id
left join sakila.film_category as fc
on fc.film_id = i.film_id
left join sakila.category as c
on c.category_id = fc.category_id
where c.name = 'action'
;

-- b) Write the query using sub queries with multiple WHERE clause and IN condition
select concat(cust.first_name, ' ', cust.last_name) as name, cust.email
from sakila.customer as cust
where cust.customer_id in (
    select r.customer_id
    from sakila.rental as r
    join sakila.inventory as i 
    on i.inventory_id = r.inventory_id
    join sakila.film_category as fc 
    on fc.film_id = i.film_id
    join sakila.category as c 
    on c.category_id = fc.category_id
    where c.name = 'action'
)
;
-- 4. Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount 
-- of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, 
-- and if it is more than 4, then it should be high.

select *, 
case
	when amount < 2 then 'low'
    when amount < 4 then 'medium'
    else 'high'
    end as level
from sakila.payment
;