#Lab | Aggregation Revisited - Subqueries

use sakila;

#Select the first name, last name, and email address of all the customers who have rented a movie.


select distinct first_name, last_name, email
from sakila.customer c
join sakila.rental r ON c.customer_id = r.customer_id
order by 1;

#What is the average payment made by each customer (display the customer id, customer name (concatenated), and the average payment made).
select c.customer_id, concat(c.first_name, ' ', c.last_name) as customer_name, avg(p.amount) as average_amount
from customer as c
join payment as p on c.customer_id = p.customer_id
group by c.customer_id, customer_name;

#Select the name and email address of all the customers who have rented the "Action" movies.
#Write the query using multiple join statements

select concat(c.first_name, ' ', c.last_name) as customer_name, c.email, cat.name
from customer c
join rental r using (customer_id)
join inventory i using (inventory_id)
join film f using (film_id)
join film_category fc using (film_id)
join category cat using (category_id)
where cat.name = 'Action'
group by 1;

#Write the query using sub queries with multiple WHERE clause and IN condition
select concat(c.first_name, ' ',c.last_name) as customer_name, email
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
                    group by c.email
                )
            )
        )
    )
);

#Verify if the above two queries produce the same results or not
#They have different results

#Use the case statement to create a new column classifying existing columns as either or high value transactions based on the 
#amount of payment. If the amount is between 0 and 2, label should be low and if the amount is between 2 and 4, the label should be 
#medium, and if it is more than 4, then it should be high.

select customer_id, amount,
    case
        when amount between 0 and 2 then 'Low'
        when amount between 2 and 4 then 'Medium'
        when amount > 4 then 'High'
    end as classification
from payment;
