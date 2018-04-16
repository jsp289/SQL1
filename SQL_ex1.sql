SELECT title
	,rental_rate
FROM film
WHERE rental_rate = 0.99;

-- Select first and last names + email from Film Table
SELECT first_name
	,last_name
	,email
FROM customer
WHERE store_id = 2;

-- Count number of films renting for $0.99
SELECT count(title)
FROM film
WHERE rental_rate = 0.99;

-- Displaying how many diffrerent rental rates there are in film
SELECT title
	,rental_rate
FROM film
GROUP BY rental_rate;

SELECT count(title)
	,rental_rate
FROM film
GROUP BY rental_rate;

-- Group by 2, groups by the second variable in Select or rental rate in this case
SELECT count(title)
	,rental_rate
FROM film
GROUP BY 2;

-- Films by rating and rental price
SELECT count(title)
	,rating
	,rental_rate
FROM film
GROUP BY rating
	,rental_rate
	--Alternately: Group by 1,2
	;

-- Connect 2 tables for customer_id, names (first and last) and mailing address
SELECT customer.customer_id
	,customer.first_name
	,customer.last_name
	,address.address
FROM customer
	,address
WHERE customer.address_id = address.address_id;

-- List films by name, category and language
-- to save on space you can name the tables after the FROM command with film f, language l, film category fc, category c
SELECT film.title
	,category.name
	,LANGUAGE.name
FROM film
	,LANGUAGE
	,film_category
	,category
WHERE film.language_id = LANGUAGE.language_id
	AND film.film_id = film_category.film_id
	AND film_category.category_id = category.customer_id;

-- How many times has each movie been rented out.
SELECT fi.title
	,count(ren.rental_id)
FROM film fi
	,inventory inv
	,rental ren
WHERE fi.film_id = inv.film_id
	AND inv.inventory_id = ren.inventory_id
GROUP BY fi.title
	-- could be also 1 
	;

-- Revenue per video title // Revenue = price * number of rentals
-- add count(ren.rental_id)*fi.rental_rate as revenue // it creates a new variable instantly
-- IF error of non-aggregated column when using fi.rental_rate -> any_value(fi.rental_rate)
SELECT fi.title AS "Film Title"
	,count(ren.rental_id)
	,any_value(fi.rental_rate)
	,count(ren.rental_id) * any_value(fi.rental_rate) AS Revenue
FROM film fi
	,inventory inv
	,rental ren
WHERE fi.film_id = inv.film_id
	AND inv.inventory_id = ren.inventory_id
GROUP BY fi.title
ORDER BY 4 DESC;

-- Ranks movies by revenue in a descending order.
-- Who is our best customer and how much have they paid
SELECT p.customer_id
	,sum(p.amount)
FROM payment p
GROUP BY 1
ORDER BY 2;

-- What store has brought in the most revenue?
SELECT p.staff_id AS Store
	,sum(p.amount) AS Revenue
FROM payment p
GROUP BY 1
ORDER BY 2 DESC;

-- Alternative solution to above
SELECT i.store_id AS "Store ID"
	,sum(p.amount) AS Revenue
FROM inventory i
	,payment p
	,rental r
WHERE p.rental_id = r.rental_id
	AND r.inventory_id = i.inventory_id
GROUP BY 1
ORDER BY 2 DESC;

-- Count rentals per month
--Left function left(field, number of characters from the left for date)
SELECT left(rental_date, 7)
	,count(rental_id)
FROM rental r
GROUP BY 1
ORDER BY 2 DESC;

-- State the first and last rental dates of each movie using max() min()
SELECT f.film_title AS "Film Title"
	,min(r.rental_date) AS 'First Rental Date'
	,max(r.rental_date) AS 'Last Rental Rate'
FROM rental r
	,inventory i
	,film f
WHERE r.inventory_id = i.inventory_id
	AND i.film_id = f.film_id
GROUP BY f.film_id;

-- Every customer's last rental
SELECT CONCAT (
		c.first_name
		," "
		,c.last_name
		) AS name
	,max(ren.rental_date)
FROM customer cus
	,rental ren
WHERE cus.customer_id = ren.customer_id
GROUP BY cus.customer_id;

-- Revenue by month
SELECT left(pay.payment_date, 7) AS Month
	,sum(pay.amount) AS "Monthly Revenue"
FROM payment pay
GROUP BY 1;

-- How many distinct renters do we have per month
SELECT left(ren.rental_date, 7) AS Month
	,count(ren.rental_id) AS "Total Rentals"
	,count(DISTINCT ren.customer_id) AS "Unique Renters"
	,count(r.rental_id) / count(DISTINCT ren.customer_id) AS "Avg. number of rentals per unique customer"
FROM rental ren
GROUP BY 1;

-- The number of distinct films rented every month.
SELECT left(ren.rental_date, 7) AS Month
	,count(ren.rental_id) AS "Total Rentals"
	,count(DISTINCT fi.film_id) AS "Unique films per month"
	,count(ren.rental_id) / count(DISTINCT fi.film_id) AS "Number of rentals per film"
FROM rental ren
	,inventory inv
	,film fi
WHERE ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
GROUP BY 1;

-- The number of distinc fil rentals per month
SELECT left(ren.rental_date, 7) AS Month
	,count(ren.rental_id) AS "Total Rentals"
	,count(DISTINCT fi.film_id) AS "Unique Movies"
	,count(ren.rental_id) / count(DISTINCT fi.film_id)
FROM rental ren
	,inventory inv
	,film fi
WHERE ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
GROUP BY 1;

-- IN(), comparison operators, HAVING
-- Number of rentals in Comedy, Sports and Family
SELECT cat.name AS Category
	,c count(ren.rental_id) AS "Number of films per category"
FROM rental ren
	,i inventory inv
	,film fi
	,film_category fc
	,category cat
WHERE ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
	AND fi.film_id = fc.film_id
	AND fc.category_id = cat.category_id
	AND cat.name IN (
		"Comedy"
		,"Sports"
		,"Family"
		)
GROUP BY 1;

-- Comparison operators (> < = != -> not equal to)
-- Number of rentals not in comedy
SELECT cat.name AS Category
	,count(ren.rental_id) AS "Number of films per category"
FROM rental ren
	,inventory inv
	,film fi
	,film_category fc
	,category cat
WHERE ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
	AND fi.film_id = fc.film_id
	AND fc.category_id = cat.category_id
	AND cat.name != ("Comedy")
GROUP BY 1;

-- Users that have rented at least 3 times
-- WHERE clause cannot have a function in its statement such as count()
-- Using the HAVING function, you can use count like the filter in Excel
SELECT ren.customer_id AS Customer
	,count(ren.rental_id) AS "Number of rentals"
FROM rental ren
GROUP BY 1
HAVING count(ren.rental_id) >= 3;

-- revenue for store 1 where film is rated R or PG 13
SELECT inv.store_id AS Store
	,fi.rating AS Rating
	,sum(pay.amount)
FROM rental ren
	,inventory inv
	,film fi
	,payment pay
WHERE pay.rental_id = ren.rental_id
	AND ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
	AND inv.store_id = 1
	AND fi.rating IN (
		"PG"
		,"R"
		)
GROUP BY 1
	,2
ORDER BY 3 DESC;

-- revenue for store 1 for films rated PG 13 and R
SELECT inv.store_id AS Store
	,fi.rating AS Rating
	,sum(pay.amount)
FROM rental ren
	,inventory inv
	,film fi
	,payment pay
WHERE pay.rental_id = ren.rental_id
	AND ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
	AND inv.store_id = 1
	AND fi.rating IN (
		"PG-13"
		,"R"
		)
GROUP BY 1
	,2
ORDER BY 3 DESC;

-- create temporary table to link 2 queries, creates an invisible temp. table
-- Command: Drop temporary table if exists rentals_per_customer;
-- create temporary table rentals_per_customer
-- Rentals and revenue per user
DROP TEMPORARY TABLE

IF EXISTS rentals_per_customer;
	CREATE TEMPORARY TABLE rentals_per_customer

SELECT ren.customer_id AS customer_id
	,count(ren.rental_id) AS num_rentals
	,sum(pay.amount) AS customer_revenue
FROM Payment pay
	,rental ren
WHERE pay.rental_id = ren.rental_id
GROUP BY 1;

-- Invisible temporary table rentals_per_customer will be linked to the below query
--Revenue by users who rented X number of videos.
SELECT rpc.num_rentals
	,sum(rpc.customer_revenue) AS total_revenue
	,count(rpc.customer_id) AS num_customers
FROM rentals_per_customer rpc
GROUP BY 1;

-- Brainbuster
--Revenue by actor/actress  - actor's name, amount of revenue they produced
--1) Revenue per film
CREATE TEMPORARY TABLE rev_per_film

SELECT fi.film_id AS film_id
	,fi.rental_rate * count(ren.rental_id) AS film_revenue
FROM rental ren
	,inventory inv
	,film fi
WHERE ren.inventory_id = inv.inventory_id
	AND inv.film_id = fi.film_id
GROUP BY 1;

--Revenue per actors
SELECT ai.actor_id AS "Actor ID"
	,CONCAT (
		ai.first_name
		," "
		,ai.last_name
		) AS "Actor Name"
	,sum(rpf.film_revenue) AS "Revenue per actor"
FROM rev_per_film rpf
	,actor_info ai
	,film_actor fi
WHERE ai.actor_id = fi.actor_id
	AND fi.film_id = rpf.film_id
GROUP BY 1;

-- new indenture
SELECT ac.customer_id
	,ac.fav_color
	,rc.num_purchase
FROM active_customer ac
	,reward_customer rc
WHERE ac.customer_id = rc.customer_id;

-- Using JOIN same result as above
SELECT ac.customer_id
	,ac.fav_color
	,rc.num_purchase
FROM active_customer ac
INNER JOIN reward_customer rc ON ac.customer_id = rc.customer_id;

--Assuming we have 2 tables: on the left Active Customers and on the right, Rewards Customer if we want to find the customers
-- that only belong in Active and nor Reward, we use LEFT JOIN
SELECT ac.customer_id
	,ac.fav_color
	,rc.num_purchase
FROM active_customer ac
LEFT JOIN reward_customer rc ON ac.customer_id = rc.customer_i

-- brainbuster: create temporary table that contains customer_id, active customers  and phone numbers
/* all columns from active customers(active=1)
AND
phone number from the address table
customer_id, active, phone_number */
DROP TEMPORARY TABLE

IF EXISTS activeUsers;
	CREATE TEMPORARY TABLE activeUsers

SELECT cus.*
	,-- returns all columns in customer table
	ad.phone
FROM customer cus
INNER JOIN address ad ON cus.address_id = ad.address_id
WHERE cus.active = 1
GROUP BY 1;

/* customers with at least 30 rentals

return customer_id, number or rentals and last rental date
just using rental table
*/
DROP TEMPORARY TABLE

IF EXISTS rewardUsers;
	CREATE TEMPORARY TABLE rewardUsers

SELECT ren.customer_id
	,count(ren.rental_id) AS num_rentals
	,max(ren.rental_date)
FROM rental ren
GROUP BY 1
HAVING num_rentals >= 30;

/* reward users AND active users using the JOIN function*/
-- IF ERROR RETURNS NON-AGGREGATED COLUMNS, WRITE ANY_VALUE(table.field) to get rid of it.
SELECT any_value(au.customer_id)
	,any_value(au.email)
	,any_value(au.first_name)
FROM activeUsers au
INNER JOIN rewardUsers ru ON au.customer_id = ru.customer_id
GROUP BY 1;

-- All reward users information
SELECT ANY_VALUE(ru.customer_id)
	,any_value(cus.email)
	,any_value(au.phone)
FROM rewardUsers ru
INNER JOIN customer cus ON ru.customer_id = cus.customer_id
LEFT JOIN activeUsers au ON au.customer_id = ru.customer_id
GROUP BY 1;

-- Cohort analysis
-- Customer's first rental
DROP TEMPORARY TABLE

IF EXISTS first_rental;
	CREATE TEMPORARY TABLE first_rental

SELECT ren.customer_id AS customer_id
	,min(ren.rental_date) AS first_time
FROM rental ren
GROUP BY 1;

-- Cohort size
DROP TEMPORARY TABLE

IF EXISTS cohort_size;
	CREATE TEMPORARY TABLE cohort_size

SELECT left(first_time, 7) AS month
	,count(customer_id) AS num
FROM first_rental
GROUP BY 1;

-- Join first_time, num and pay.amount to RENTAL TABLE
-- Add first_time from first_rental, number of users per cohort (num) from cohort_size, and 
-- and payment amount from payment table to rental table
SELECT ren.*
	,left(fr.first_time, 7) AS cohort
	,cs.num AS cohort_size
	,pay.amount
FROM rental ren
INNER JOIN first_rental fr ON ren.customer_id = fr.customer_id
INNER JOIN cohort_size cs ON cs.month = left(fr.first_time, 7)
INNER JOIN payment pay ON pay.rental_id = ren.rental_id;

-- Revenue per user for each cohort and month
--Period diff returns a number of months elapsed since first_date
DROP TEMPORARY TABLE

IF EXISTS cohort;
	CREATE TEMPORARY TABLE cohort

SELECT date_format(fr.first_time, '%Y%m') AS cohort_formatted
	,date_format(ren.rental_date, '%Y%m') AS rental_date_formatted
	,cs.num AS cohort_size
	,sum(pay.amount) AS month_rev
	,sum(pay.amount) / cs.num AS RPU
FROM rental ren
INNER JOIN first_rental fr ON ren.customer_id = fr.customer_id
INNER JOIN cohort_size cs ON cs.month = left(fr.first_time, 7)
INNER JOIN payment pay ON pay.rental_id = ren.rental_id
GROUP BY 1
	,2;

-- Make pretty poney
SELECT left(STR_TO_DATE(cohort_formatted, '%Y%m'), 7) AS 'First Rental Date'
	,period_diff(rental_date_formatted, cohort_formatted) AS 'Months After Join'
	,cohort_size
	,RPU
FROM cohort
GROUP BY 1
	,2;