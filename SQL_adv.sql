-- Select the first name, last name, and email address of all the customers who have rented a movie

Select c.first_name, c.last_name, c.email from sakila.rental r
left join sakila.customer c
on r.customer_id=c.customer_id
group by 1,2,3;

-- What is the average payment made by each customer (display the customer id, customer name (concatenated), 
-- and the average payment made).

select  distinct c.customer_id, concat(c.first_name,' ', c.last_name) name , round(avg(p.amount),2) avg_payment from sakila.payment p
left join sakila.customer c
on p.customer_id=c.customer_id
group by 1;

-- Select the name and email address of all the customers who have rented the "Action" movies.
-- Write the query using multiple join statements
-- Write the query using sub queries with multiple WHERE clause and IN condition
-- Verify if the above two queries produce the same results or not

select cu.first_name, cu.email from sakila.rental re
left join sakila.customer cu
on re.customer_id=cu.customer_id
left join sakila.inventory inv
on re.inventory_id= inv.inventory_id
left join sakila.film_category fc
on inv.film_id = fc.film_id
left join sakila.category cat
on cat.category_id = fc.category_id
where name in (select name from sakila.category
where name like 'Action')
group by 1,2
order by 1 ;

-- Use the case statement to create a new column classifying existing columns as either or high value transactions 
-- based on the amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, 
-- the label should be medium, and if it is more than 4, then it should be high.

select label, count(label) count_label
from (select amount , case when amount between 0 and 2 then 'low'
			when amount between 2 and 4 then 'medium'
			else 'high' end label
from sakila.payment)sub1
group by 1
order by 2;


