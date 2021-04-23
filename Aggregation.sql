-- Lab | Aggregation Revisited - Sub queries

use sakila;

-- Select the first name, last name, and email address of all the customers who have rented a movie.
select * from rental;
select * from customer;

select c.first_name, c.last_name, c.email -- , count(r.rental_id)
from customer c 
join rental r on c.customer_id = r.customer_id
group by c.customer_id
order by count(r.rental_id) ; -- all customers have rentad a movie 

-- What is the average payment made by each customer 
-- (display the customer id, customer name (concatenated), and the average payment made).
select * from payment;

select pay.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, round(avg(amount), 2) as avg_amount
from payment pay 
join customer c on pay.customer_id = c.customer_id
group by pay.customer_id;

-- Select the name and email address of all the customers who have rented the "Action" movies.
select concat(c.first_name, ' ', c.last_name) as full_name, c.email from customer c
join rental r on c.customer_id = r.customer_id
join inventory i on r.inventory_id = i.inventory_id
join film f on i.film_id = f.film_id 
join film_category fc on f.film_id = fc.film_id 
join category cat on fc.category_id = cat.category_id
where cat.name = 'Action'
group by c.customer_id;

/* Use the case statement to create a new column classifying existing columns as either or high
value transactions based on the amount of payment. If the amount is between 0 and 2, label 
should be low and if the amount is between 2 and 4, the label should be medium, and if it is 
more than 4, then it should be high. */

select pay.customer_id, concat(c.first_name, ' ', c.last_name) as full_name, round(avg(amount), 2) as avg_amount,
case 
	when round(avg(amount), 2) <= 2 then 'low'
	when round(avg(amount), 2) between 2.01 and 4 then 'medium'
	else 'high'
end as expense_category
from payment pay 
join customer c on pay.customer_id = c.customer_id
group by pay.customer_id;
