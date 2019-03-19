use sakila;

-- 1a
select first_name, last_name from actor;

-- 1b
select concat(upper(first_name), " ", upper(last_name)) 
	as "Actor Name"
	from actor;

-- 2a
select actor_id, first_name, last_name 
	from actor where lower(first_name) = "joe";
    
-- 2b
select first_name, last_name 
	from actor
    where lower(last_name) like "%gen%";
    
-- 2c
select first_name, last_name 
	from actor
    where lower(last_name) like "%li%"
    order by last_name, first_name;
    
-- 2d
select country_id, country 
	from country
    where country in ("Afghanistan", "Bangladesh", "China");
    
-- 3a
alter table actor
add column description blob;

-- 3b
alter table actor
drop column description;

-- 4a
select last_name, count(*) 
	from actor group by last_name;
    
-- 4b
select last_name, count(*) 
	from actor group by last_name having count(*) >= 2;
    
-- 4c
select first_name, last_name, actor_id from actor
where lower(last_name) = 'williams';

-- Use ID found from last query: 172
UPDATE actor 
SET first_name = 'HARPO' 
WHERE actor_id = '172';

-- 4d 
UPDATE actor
SET first_name = 
IF ( first_name = 'HARPO', 'GROUCHO', first_name )
WHERE actor_id = 172;

-- 5a
show create table address;

-- 6a
select st.first_name, st.last_name, ad.address 
from staff st
left join address ad
on st.address_id = ad.address_id;

-- 6b

select st.first_name, st.last_name,  sum(py.amount)
from payment py 
left join staff st
on py.staff_id = st.staff_id
WHERE payment_date >='2005-08-01 00:00:00'
AND payment_date <'2005-08-31 00:00:00'
group by st.staff_id;

-- 6c
select film.title, count(fa.actor_id)
from film
inner join film_actor fa on film.film_id = fa.film_id
group by film.title;

-- 6d
select film.title, count(inventory.inventory_id) as 'Inventory Number'
from film
inner join inventory on film.film_id = inventory.film_id
where lower(film.title) = 'hunchback impossible';

-- 6e
select cust.first_name, cust.last_name, sum(pay.amount) as 'Total Payments'
from customer cust
inner join payment pay on cust.customer_id = pay.customer_id
group by cust.customer_id
order by cust.last_name;



