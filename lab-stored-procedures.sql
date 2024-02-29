
-- Select the name and the mail address of all costumers who have rented the "action" movies

DELIMITER //
create procedure client_category()
begin
	select c.first_name, c.last_name, c.email
	from sakila.customer c
	join sakila.rental r on c.customer_id = r.customer_id
	join sakila.inventory i on i.inventory_id = r.inventory_id
	join sakila.film f on f.film_id = i.film_id
	join sakila.film_category fc on fc.film_id = i.film_id
	join sakila.category ca on ca.category_id = fc.category_id
	where ca.name = 'Action';
end //
DELIMITER ;

call client_category();


--  Update the stored procedure in a such manner that it can take a string argument for the category name and return the results for all customers that rented movie of that category/genre

DELIMITER //
create procedure client_per_category(in category_name varchar(20))
begin
    select c.first_name, c.last_name, c.email
    from sakila.customer c
    join sakila.rental r on c.customer_id = r.customer_id
    join sakila.inventory i on i.inventory_id = r.inventory_id
    join sakila.film f on f.film_id = i.film_id
    join sakila.film_category fc on fc.film_id = i.film_id
    join sakila.category ca on ca.category_id = fc.category_id
    where ca.name = category_name;
end //

DELIMITER ;

CALL client_per_category('Classics');



-- Write a query to check the number of movies released in each movie category. 

select c.name, COUNT(fc.film_id) as n_release
from sakila.category c
join sakila.film_category fc on fc.category_id = c.category_id
group by c.name
having COUNT(fc.film_id) > 50;


-- Coverting the previous query in a stored procedure


DELIMITER //
create procedure num_release (in x int)
begin
    select c.name, count(fc.film_id)
    from sakila.category c
    join sakila.film_category fc on fc.category_id = c.category_id
    group by c.name
    having count(fc.film_id) > x;
    
end //
DELIMITER ;


CALL num_release(50);

