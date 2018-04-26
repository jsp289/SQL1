-- Find the names of all the tracks for the album "Californication".
SELECT tr.trackID
	,tr.name
FROM Tracks AS tr
LEFT JOIN Albums AS al ON tr.AlbumId = al.AlbumId
WHERE al.title = 'Californication'
GROUP BY 1;

-- Find the total number of invoices for each customer along with the customer's full name, city and email.
SELECT cust.firstname
	,cust.lastname
	,cust.email
	,count(inv.invoiceid)
FROM customers AS cust
LEFT JOIN invoices AS inv ON cust.customerid = inv.customerid
GROUP BY cust.customerid;

-- What is the song title of trackID 12 from the "For Those About to Rock We Salute You" album?
SELECT tr.name
	,al.title
	,al.artistid
	,tr.trackid
FROM Tracks AS tr
LEFT JOIN Albums AS al ON tr.albumid = al.albumid
WHERE tr.trackid = 12
	AND al.title = "For Those About to Rock We Salute";

-- Retrieve a list with the managers last name, and the last name of the employees who report to Mitchell.
SELECT emp1.lastname
FROM employees AS emp1
INNER JOIN employees AS emp2 ON emp1.employeeid = emp2.employeeid
WHERE emp2.reportsto = 6;

-- Find the name and ID of the artists who do not have albums.
-- determine what is the last name of the 6th record? Enter it below. Remember to order things in descending order to be sure to get the correct answer.
SELECT lastname
	,firstname
FROM employees

UNION

SELECT lastname
	,firstname
FROM customers
ORDER BY lastname DESC;

SELECT count(*)
FROM customers AS cust
LEFT JOIN Invoices AS inv ON cust.customerid = inv.customerid
WHERE cust.customerid = inv.customerid
	AND cust.city != inv.billingcity;

--  Pull customerId 16 with the customer’s full name, and address, along with combining their city and country together. Be sure to make a space in between these two and make it UPPER CASE
SELECT customerID
	,firstname
	,lastname
	,address
	,UPPER(city || " " || country) AS City_Country
FROM Customers
WHERE customerid = 16;

-- Create a new employee user id by combining the first 4 letter of the employee’s first name with the first 2 letters of the employee’s last name. Make the new field lower case and pull each individual step to show your work.
SELECT lower(substr(firstname, 1, 4) || substr(lastname, 1, 2)) AS newid
FROM Customers
WHERE firstname = 'Robert'
	AND lastname = 'King';

-- Show a list of employees who have worked for the company for 15 or more years using the current date function. Sort by lastname ascending.
SELECT lastname
FROM Employees
WHERE DATE ("now" - hiredate) >= 15
ORDER BY 1 DESC;

-- Return the name of fields that return a NULL value from Customers table
SELECT sum(CASE 
			WHEN address IS NULL
				THEN 1
			ELSE 0
			END) AS Address
	,sum(CASE 
			WHEN postalcode IS NULL
				THEN 1
			ELSE 0
			END) AS Postal_Code
	,sum(CASE 
			WHEN fax IS NULL
				THEN 1
			ELSE 0
			END) AS Fax
	,sum(CASE 
			WHEN Company IS NULL
				THEN 1
			ELSE 0
			END) AS Company
	,sum(CASE 
			WHEN Firstname IS NULL
				THEN 1
			ELSE 0
			END) AS First_Name
	,sum(CASE 
			WHEN lastname IS NULL
				THEN 1
			ELSE 0
			END) AS Last_Name
FROM customers;

-- 
SELECT cust.firstname || cust.lastname || inv.invoiceid AS new_id
FROM customers AS cust
	,invoices AS inv
WHERE cust.customerid = inv.customerid
ORDER BY 1 ASC;