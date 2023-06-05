use sakila;

# Select the first name, last name, and email address of all the customers who have rented a movie.

select 
c.first_name as first_name, c.last_name as last_name, c.email as email
from rental r
join customer c using (customer_id)
group by 1,2
;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).

select
c.customer_id as Customer_ID, CONCAT(c.first_name, ' ', c.last_name) as Customer_Name, avg(p.amount)
from customer c
join  payment p using (customer_id)
group by 1
;

#Select the name and email address of all the customers who have rented the "Action" movies.
# Write the query using multiple join statements

select
CONCAT(c.first_name, ' ', c.last_name) as Customer_Name, c.email as Email, cat.name
from rental r
join inventory i using (inventory_id)
join film_category f using (film_id)
join category cat using (category_id)
join customer c using (customer_id)
where cat.name="Action"
group by 1
;

#Write the query using sub queries with multiple WHERE clause and IN condition

select CONCAT(c.first_name, ' ',c.last_name) as customer_name, email
from customer c
where customer_id in (
    select r.customer_id
    from rental r
    where r.inventory_id in (
        select i.inventory_id
        from inventory i
        where i.film_id in (
            select f.film_id
            from film f
            where f.film_id in (
                select film_id
                from film_category
                where category_id in (
                    select category_id
                    from category
                    where name = 'Action'
                )
            )
        )
    )
);

# Use the case statement to create a new column classifying existing columns as either or high value transactions based on the amount of payment. 
# If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be medium, and if it is more than 4, then it should be high.

select *, 
case 
	when (p.amount >=0) and (p.amount <2) then "Low"
    when (p.amount >=2) and (p.amount <4) then "Medium"
    when (p.amount >=4) then "High"
    end as Transaction_value
 from payment p;





