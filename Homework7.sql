use sakila;

-- 1a
SELECT 
    first_name, last_name
FROM
    actor;

-- 1b
SELECT 
    CONCAT(UPPER(first_name), ' ', UPPER(last_name)) AS 'Actor Name'
FROM
    actor;

-- 2a
SELECT 
    actor_id, first_name, last_name
FROM
    actor
WHERE
    LOWER(first_name) = 'joe';
    
-- 2b
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    LOWER(last_name) LIKE '%gen%';
    
-- 2c
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    LOWER(last_name) LIKE '%li%'
ORDER BY last_name , first_name;
    
-- 2d
SELECT 
    country_id, country
FROM
    country
WHERE
    country IN ('Afghanistan' , 'Bangladesh', 'China');
    
-- 3a
ALTER TABLE actor
ADD COLUMN description BLOB;

-- 3b
ALTER TABLE actor
DROP COLUMN description;

-- 4a
SELECT 
    last_name, COUNT(*)
FROM
    actor
GROUP BY last_name;
    
-- 4b
SELECT 
    last_name, COUNT(*)
FROM
    actor
GROUP BY last_name
HAVING COUNT(*) >= 2;
    
-- 4c

UPDATE actor 
SET 
    first_name = IF(first_name = 'GROUCHO',
        'HARPO',
        first_name)
WHERE
    last_name = 'WILLIAMS';

-- 4d 
UPDATE actor 
SET 
    first_name = IF(first_name = 'HARPO',
        'GROUCHO',
        first_name)
WHERE
    last_name = 'WILLIAMS';

-- 5a
SHOW CREATE TABLE address;

-- 6a
SELECT 
    s.first_name, s.last_name, a.address
FROM
    staff s
        LEFT JOIN
    address a ON s.address_id = a.address_id;

-- 6b
SELECT 
    s.first_name, s.last_name, SUM(p.amount)
FROM
    payment p
        LEFT JOIN
    staff s ON p.staff_id = s.staff_id
WHERE
    payment_date >= '2005-08-01 00:00:00'
        AND payment_date < '2005-08-31 00:00:00'
GROUP BY s.staff_id;

-- 6c
SELECT 
    f.title, COUNT(fa.actor_id)
FROM
    film f
        INNER JOIN
    film_actor fa ON f.film_id = fa.film_id
GROUP BY f.title;

-- 6d
SELECT 
    f.title,
    COUNT(i.inventory_id) AS 'Inventory Number'
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id
WHERE
    LOWER(f.title) = 'hunchback impossible';

-- 6e
SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS 'Total Payments'
FROM
    customer c
        INNER JOIN
    payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY c.last_name;

-- 7a 
SELECT 
    title
FROM
    film
WHERE
    LOWER(title) LIKE 'k%'
        OR LOWER(title) LIKE 'q%'
        AND language_id = (SELECT 
            language_id
        FROM
            language
        WHERE
            LOWER(name) = 'english');

-- 7b
SELECT 
    first_name, last_name
FROM
    actor
WHERE
    actor_id IN (SELECT 
            actor_id
        FROM
            film_actor
        WHERE
            film_id = (SELECT 
                    film_id
                FROM
                    film
                WHERE
                    LOWER(title) = 'alone trip'));
                    
-- 7c 
 SELECT 
    cu.first_name, cu.last_name, cu.email
FROM
    customer cu
        INNER JOIN
    address a ON cu.address_id = a.address_id
        INNER JOIN
    city ci ON a.city_id = ci.city_id
        INNER JOIN
    country co ON ci.country_id = co.country_id
WHERE
    LOWER(co.country) = 'canada';
 
 -- 7d
 SELECT 
    title, rating
FROM
    film
WHERE
    rating IN ('G' , 'PG', 'PG-13');
    
-- 7e
SELECT 
    f.title, COUNT(r.inventory_id) as "Times Rented"
FROM
    film f
        INNER JOIN
    inventory i ON f.film_id = i.film_id
        INNER JOIN
    rental r ON i.inventory_id = r.inventory_id
GROUP BY f.title
ORDER BY COUNT(r.inventory_id) DESC;
 
-- 7f
SELECT 
    st.store_id, SUM(p.amount) AS 'Total Sales'
FROM
    store st
        INNER JOIN
    staff sf ON st.store_id = sf.store_id
        INNER JOIN
    rental r ON sf.staff_id = r.staff_id
        INNER JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY st.store_id;

-- 7g
SELECT 
    s.store_id, ci.city, co.country
FROM
    store s
        INNER JOIN
    address a ON s.address_id = a.address_id
        INNER JOIN
    city ci ON a.city_id = ci.city_id
        INNER JOIN
    country co ON ci.country_id = co.country_id;

-- 7h
SELECT 
    c.name AS 'Category', SUM(p.amount) AS 'Gross Sales'
FROM
    category c
        INNER JOIN
    film_category f ON c.category_id = f.category_id
        INNER JOIN
    inventory i ON f.film_id = i.film_id
        INNER JOIN
    rental r ON i.inventory_id = r.inventory_id
        INNER JOIN
    payment p ON r.rental_id = p.rental_id
GROUP BY c.name
ORDER BY SUM(p.amount) DESC
LIMIT 5;

-- 8a
CREATE VIEW top_5 AS
    SELECT 
        c.name AS 'Category', SUM(p.amount) AS 'Gross Sales'
    FROM
        category c
            INNER JOIN
        film_category f ON c.category_id = f.category_id
            INNER JOIN
        inventory i ON f.film_id = i.film_id
            INNER JOIN
        rental r ON i.inventory_id = r.inventory_id
            INNER JOIN
        payment p ON r.rental_id = p.rental_id
    GROUP BY c.name
    ORDER BY SUM(p.amount) DESC
    LIMIT 5;
    
-- 8b 
SELECT 
    *
FROM
    top_5;

-- 8c
DROP VIEW top_5;