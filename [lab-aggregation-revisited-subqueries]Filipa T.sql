-- Select the first name, last name, and email address of all the customers who have rented a movie.

select distinct(r.customer_id) as id, c.first_name, c.last_name, c.email
from sakila.rental as r
left join sakila.customer as c
on r.customer_id = c.customer_id
;



-- What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select p.customer_id, concat(c.first_name, ' ', c.last_name) as name, avg(p.amount) as avg_payment
from sakila.payment p 
left join sakila.customer c
on p.customer_id = c.customer_id
group by 1
;



-- Select the name and email address of all the customers who have rented the "Action" movies.

-- Write the query using multiple join statements

select distinct(c.customer_id), concat(c.first_name, ' ', c.last_name) as customer_name, c.email, cat.name
from sakila.customer c
left join sakila.rental r
on c.customer_id = r.customer_id
left join sakila.inventory i
on r.inventory_id = i.inventory_id
left join sakila.film_category f
on i.film_id = f.film_id
left join sakila.category cat
on f.category_id = cat.category_id 
where cat.name = 'action'
;

-- Write the query using sub queries with multiple WHERE clause and IN condition

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

-- Verify if the above two queries produce the same results or not
-- Use the case statement to create a new column classifying existing columns as either or 
-- high value transactions based on the amount of payment. If the amount is between 0 and 2, 
-- label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.


select *,
case 
when amount < 2 then 'low'
when amount < 4 then 'medium'
else 'high'
end as value
from sakila.payment 
;
