-- Select the first name, last name, and email address of all the customers who have rented a movie
select distinct(rent.customer_id), cust.first_name, cust.last_name, cust.email
from sakila.rental as rent
left join sakila.customer as cust
on rent.customer_id = cust.customer_id;

-- Average payment made by each customer
select sub.customer_id, cust.first_name, cust.last_name, sub.average_payment
from ( select customer_id, avg(amount) as average_payment
		from sakila.payment
		group by customer_id ) sub
left join sakila.customer as cust
on sub.customer_id = cust.customer_id;

-- Name and email address of all the customers who have rented the "Action" movies (using multiple join statements)
select distinct(rent.customer_id), cust.first_name, cust.last_name, cust.email
from sakila.rental as rent
left join sakila.inventory as inve
on rent.inventory_id = inve.inventory_id
left join sakila.film_category as fica
on inve.film_id = fica.film_id
left join sakila.category as cate
on fica.category_id = cate.category_id
left join sakila.customer as cust
on rent.customer_id = cust.customer_id
where cate.name = "Action"
order by 1;

-- Name and email address of all the customers who have rented the "Action" movies (using sub queries with multiple WHERE clause and IN condition)
select customer_id, first_name, last_name, email
from sakila.customer
where customer_id in (
		select customer_id
		from sakila.rental
		where inventory_id in (
				select inventory_id
				from sakila.inventory
						where film_id in (
						select film_id
						from sakila.film_category
						where category_id in (
								select category_id
								from sakila.category
								where category.name in ("Action")
								)
						)
				)
		)
order by 1;

-- Classifying existing columns as either or high value transactions based on the amount of payment
select *,
case
	when amount < 2 then "low"
	when amount < 4 then "medium"
	else "high"
end as classification
from sakila.payment;