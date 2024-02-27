-- name and email
select c.first_name, c.last_name, c.email 
from sakila.customer c left join sakila.rental r on c.customer_id = r.customer_id
group by 1,2,3;

-- average payment by customer
select distinct c.customer_id, concat(first_name,' ', last_name) full_name, 
round(avg(amount),2) avg_payment 
from sakila.payment p left join sakila.customer c on p.customer_id=c.customer_id
group by 1;

-- name and email address of all the customers who have rented the "Action" movies
select distinct r.customer_id, concat(first_name,' ', last_name) full_name, c.email
from sakila.rental r
left join sakila.inventory i on r.inventory_id = i.inventory_id
left join sakila.film_category f on i.film_id = f.film_id
left join sakila.category cat on f.category_id = cat.category_id
left join sakila.customer c on r.customer_id = c.customer_id
where cat.name = "Action"
order by 1;

-- same using sub queries with multiple WHERE clause and IN condition
select customer_id, concat(first_name,' ', last_name) full_name, email
from sakila.customer
where customer_id in (select customer_id from sakila.rental where inventory_id in 
(select inventory_id from sakila.inventory where film_id in 
(select film_id from sakila.film_category where category_id in 
(select category_id from sakila.category where category.name in ("Action")))))
order by 1;

-- classifying as low, medium or high value transactions based on the amount of payment
select rental_id, amount,
case
	when amount < 2 then "low"
	when amount < 4 then "medium"
	else "high"
end class
from sakila.payment;
