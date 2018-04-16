--Create database
CREATE DATABASE super_market;

-- Create Employees Table
CREATE TABLE employees (
	employee_id INT (11) PRIMARY KEY
	,name VARCHAR(200) NOT NULL
	,hourly_pay DECIMAL(10, 2)
	,position ENUM('Manager', 'Helper', 'Cashier', 'Cleaner') NOT NULL
	,employee_contact BIGINT (10) NOT NULL
	);

-- Insert 4 employees in Table Employees
INSERT INTO employees (
	employee_id
	,name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	1
	,'David Chang'
	,9.00
	,'Manager'
	,3238888889
	);

INSERT INTO employees (
	employee_id
	,name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	2
	,'Sophia Hayat'
	,9.25
	,'Cashier'
	,8587415878
	);

INSERT INTO employees (
	employee_id
	,name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	3
	,'R Ramesh'
	,8.75
	,'Helper'
	,9963525122
	);

INSERT INTO employees (
	employee_id
	,name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	4
	,'Cheng Z'
	,9.90
	,'Cleaner'
	,8569452144
	);

--View all employees with full details at once
SELECT *
FROM employees;

-- View only first 2 entries
SELECT *
FROM employees Limit 2;

-- Only see employees whose hourly rate exceeds $9
SELECT *
FROM employees
WHERE hourly_pay > 9;

-- Update hourly pay of employee_id 1 form $9 to $10
UPDATE employees
SET hourly_pay = 10.00
WHERE employee_id = 1;

-- Insert new employee without having to specify the employee ID using ALTER TABLE
ALTER TABLE employees MODIFY employee_id INT (11) NOT NULL AUTO_INCREMENT;

-- Add employees without specifying employee ID
INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Rhea Romero'
	,12.00
	,'Manager'
	,9958212121
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Carlos S'
	,11.00
	,'Helper'
	,6595845147
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'David G'
	,8.00
	,'Cleaner'
	,9958698547
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Nisha S'
	,15.00
	,'Helper'
	,9885698547
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Michelle A'
	,21.00
	,'Helper'
	,9963241587
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Julio M'
	,9.00
	,'Manager'
	,8854784555
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Eric K'
	,7.75
	,'Cleaner'
	,9956854747
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Janet P'
	,10.50
	,'Cashier'
	,5584845612
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Chen Z'
	,11.50
	,'Helper'
	,9568147584
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Nate K'
	,13.50
	,'Cashier'
	,8854747455
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Charlie V'
	,10.00
	,'Manager'
	,9652148754
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Joy Lobo'
	,21.00
	,'Helper'
	,6625141415
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Vinod K'
	,9.00
	,'Cashier'
	,8546151541
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Jing P'
	,8.00
	,'Helper'
	,9584625151
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Salman A'
	,12.75
	,'Cleaner'
	,5152330061
	);

INSERT INTO employees (
	name
	,hourly_pay
	,position
	,employee_contact
	)
VALUES (
	'Kate V'
	,15.00
	,'Cashier'
	,4851626251
	);

-- See employees who are managers and whose hourly rate is at least $10
SELECT *
FROM employees
WHERE position = 'Manager'
	AND hourly_pay >= 10;

-- See employees who are either cashiers or managers
SELECT *
FROM employees
WHERE position = 'Manager'
	OR position = 'Cashier';

-- Rank employees by descending hourly pay
SELECT *
FROM employees
ORDER BY hourly_pay DESC;

-- Rank employees by ascending hourly pay
SELECT *
FROM employees
ORDER BY hourly_pay ASC;

-- Choose employees by ID using IN clause vs. OR
SELECT *
FROM employees
WHERE employee_id IN (
		2
		,4
		,6
		,8
		);

-- Look up names starting by 'D' using LIKE function
SELECT *
FROM employees
WHERE name LIKE 'D%';

-- Look up names ending by 'S' using LIKE function
SELECT *
FROM employees
WHERE name LIKE '%S';

-- Look up names containing 'A' using LIKE function
SELECT *
FROM employees
WHERE name LIKE '%A%';

-- Select specific fields
SELECT employees.name
	,employees.position
FROM employees;

-- See all different job titles using DISTINCT
SELECT DISTINCT position
FROM employees;

-- Use alias to rename variables
SELECT name
	,hourly_pay AS hp
FROM employees emp

-- List of employees whose ID is lesser than 15 and hourly pay less than 10
SELECT *
FROM employees
WHERE employee_id < 15
	AND hourly_pay < 10;

-- Return the newest employees
SELECT *
FROM employees
ORDER BY employee_id DESC LIMIT 5;

-- Return first 3 managers hired
SELECT *
FROM employees
WHERE position = "Manager"
ORDER BY employee_id ASC LIMIT 3;

-- Return employes whose ID are 1,3,5 or whose position is a cashier
SELECT *
FROM employees
WHERE employee_id IN (
		1
		,3
		,5
		)
	OR position = 'Cashier';

-- Return employees that are either a cashier or manager and hourly rate >$10
SELECT *
FROM employees
WHERE (
		position = 'cashier'
		OR position = 'manager'
		)
	AND hourly_pay > 10;

-- Create Items table
CREATE TABLE items (
	item_id INT (11) PRIMARY KEY AUTO_INCREMENT
	,item_name VARCHAR(200) NOT NULL
	,weight DECIMAL(10, 2) NOT NULL
	,brand VARCHAR(200) NOT NULL
	,price DECIMAL(10, 2) NOT NULL
	);

-- Insert data into Items table
INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Milk'
	,2
	,'Nestle'
	,2.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Cheese'
	,0.5
	,'Amul'
	,6.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Battery'
	,0.1
	,'EverReady'
	,1.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Chips'
	,0.5
	,'Lays'
	,3.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Coke'
	,0.5
	,'Coca Cola'
	,2.50
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Water'
	,1.00
	,'AquaFina'
	,3.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Hair Gel'
	,0.50
	,'Axe'
	,9.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Ear Phones'
	,0.2
	,'Bose'
	,125.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Cards'
	,0.05
	,'PlayEm'
	,10.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Deo'
	,0.20
	,'Fogg'
	,5.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Liquid Soap'
	,0.3
	,'Lux'
	,4.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Shaving Gel'
	,1.00
	,'Gillette'
	,15.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Hoodie'
	,5.00
	,'North Face'
	,200.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Cap'
	,0.5
	,'RF'
	,50.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Television'
	,25.00
	,'Sony'
	,1450.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Laptop'
	,3.50
	,'Lenovo'
	,1990.00
	);

INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Phone'
	,1.50
	,'LG'
	,400.00
	);

-- Create Sales table
CREATE TABLE sales (
	sales_id INT (11) PRIMARY KEY AUTO_INCREMENT
	,item_id INT (11) NOT NULL
	,employee_id INT (11) NOT NULL
	);

--Insert data into Sales table
INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,7
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,10
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,4
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,2
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,4
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,7
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,9
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,12
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,16
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,7
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,8
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,11
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,8
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,15
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,4
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,7
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,12
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,13
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,10
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,9
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,16
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,11
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,6
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,8
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,10
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,4
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,2
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,7
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,12
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,3
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,15
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,9
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,14
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,4
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,11
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,10
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,2
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,14
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,12
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,6
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,12
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,17
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,1
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,17
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,2
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,6
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,5
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,16
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,14
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,13
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,17
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,16
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,9
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,17
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,16
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,15
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,14
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,13
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	2
	,6
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	17
	,17
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	12
	,13
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	20
	,9
	);

INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	14
	,1
	);

-- Add foreign key to sales, items, employees tables to prevent data entry og non-existing items and employees
ALTER TABLE sales ADD FOREIGN KEY (item_id) REFERENCES items (item_id);

ALTER TABLE sales ADD FOREIGN KEY (employee_id) REFERENCES employees (employee_id);

-- Test of foreign key. Returns an error.
INSERT INTO sales (
	employee_id
	,item_id
	)
VALUES (
	200
	,1
	);

-- Insert new item
INSERT INTO items (
	item_name
	,weight
	,brand
	,price
	)
VALUES (
	'Candy'
	,0.5
	,'M&M'
	,2.00
	);

-- Do a left join
SELECT *
FROM items
LEFT JOIN sales ON items.item_id = sales.item_id;

-- Right join
SELECT *
FROM items
RIGHT JOIN sales ON items.item_id = sales.item_id;

--Inner Join
SELECT *
FROM sales
INNER JOIN items ON sales.item_id = items.item_id;

-- Union of items 1 and 10 sold
SELECT sales_id
	,item_id
	,employee_id
FROM sales
WHERE item_id = 1

UNION

SELECT sales_id
	,item_id
	,employee_id
FROM sales
WHERE item_id = 10;

-- Could have been written as follows too
SELECT sales_id
	,item_id
	,employee_id
FROM sales
WHERE item_id = 1
	OR item_id = 10;

-- Could have been written as follows too
SELECT sales_id
	,item_id
	,employee_id
FROM sales
WHERE item_id IN (
		1
		,10
		);

-- Sub-query of sales for cheese
SELECT *
FROM sales
WHERE item_ id IN (
		SELECT item_id
		FROM items
		WHERE item_name = 'Cheese'
		);

-- Several functions
SELECT COUNT(*)
FROM items;

SELECT SUM(price)
FROM ITEMS;

SELECT AVG(hourly_pay)
FROM employees;

SELECT MAX(hourly_pay)
FROM employees;

SELECT MIN(hourly_pay)
FROM employees;

SELECT NOW();

SELECT name
	,LENGTH(name)
FROM employees;

SELECT name
	,ROUND(hourly_pay, 1)
FROM employees;

-- Group By function
SELECT count(item_id)
FROM sales
GROUP BY item_id;

-- Having clause to list items only with more than 5 sales
SELECT item_id
	,count(*)
FROM sales
GROUP BY item_id
HAVING count(*) > 5;

-- Use of View to automate repetitive query
CREATE VIEW item_count
AS
SELECT item_id
	,count(*) AS item_count
FROM sales
GROUP BY item_id;

-- Apply VIEW
SELECT *
FROM item_count;

--Alter View
ALTER VIEW item_count
AS
SELECT item_id
	,count(*)
FROM sales
GROUP BY item_id
HAVING COUNT(*) > 5;

-- Drop View function
DROP VIEW item_count;

-- List of employees whose hourly pay is less than $10 and employee_id less than 15
SELECT *
FROM employees
WHERE employee_id < 15
	AND hourly_pay < 10;

-- Create view for above query
CREATE VIEW early_employee_lower_hourly_pay
AS
SELECT *
FROM employees
WHERE employee_id < 15
	AND hourly_pay < 10;

-- Write query using view
SELECT *
FROM early_employee_lower_hourly_pay;

-- Delete View
DROP VIEW early_employee_lower_hourly_pay;

-- Delete row from table
DELETE
FROM sales
WHERE sales_id = 1;

-- Truncate table to remove data but keep table structure
TRUNCATE TABLE employees;

-- Drop table and database to erase data and table + db structure
DROP TABLE employees;

DROP DATABASE super_market;