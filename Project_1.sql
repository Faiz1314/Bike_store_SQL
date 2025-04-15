-- 1. Create Database
create database BikeStores

-- 2. Use Database
use BikeStores

-- 3. Create Schema
	
	-- 3.1 production
create schema production
go
	
	-- 3.2 sales
create schema sales
go

-- 4. Create Tables

   --4.1 categories
CREATE TABLE production.categories (
category_id INT IDENTITY (1,1) PRIMARY KEY,
category_name VARCHAR (255) NOT NULL )

   --4.2 products
CREATE TABLE production.products (
product_id INT IDENTITY (1,1) PRIMARY KEY,
product_name VARCHAR (255) NOT NULL,
brand_id INT NOT NULL,
category_id INT NOT NULL,
model_year SMALLINT NOT NULL,
list_price DECIMAL (10,2) NOT NULL)

-- 5. Seeing The Table
SELECT * FROM production.categories
SELECT * FROM production.products

-- 6. Insert Values Into Tables

    -- 6.1 Insert Into production.categories 
INSERT INTO production.categories(category_name)
values
('Children Bicycles'),
('Comfort Bicycles'),
('Cruisers Bicycles'),
('Cyclocross Bicycles'),
('Electric Bikes'),
('Mountain Bikes'),
('Road Bikes')

    -- 6.1 Insert Into production.products
BULK INSERT production.products
FROM "C:\Users\LENOVO\Desktop\vs_coding\Coaching DS\SQL\products (1).csv"
WITH (
FIELDTERMINATOR = ',' , --Field/Column is terminated/changed where "," is present
ROWTERMINATOR = '\n',
FIRSTROW = 2)			--From data is pulled from row 2, because first one is header file which was created by us already

    -- 6.3 Directly Pull The Data From system

-- right click on database you created then go to 'tasks' then go to 'import flat file'
-- then browse the database, then select the schema in which you want to save then click 'next'
-- select the datatype and constraints the click 'next' then click 'finish'

-- we pull customers and put it in sales schema
-- we pull and put it in schema



-- 7. Seeing The Table
SELECT * FROM production.categories
SELECT * FROM production.products
SELECT * FROM sales.customers


-- 8. Truncating The Table (We will excecute this line if we accidently enter the values two times)

TRUNCATE TABLE production.categories


-- 9. Selecting Only Specific Column Of A Table

SELECT 
	product_name,
	model_year,
	list_price
FROM production.products

-- 10. Distinct Values

SELECT
	product_name		-- 321 rows
FROM production.products

SELECT
	DISTINCT product_name		-- 291 rows
FROM production.products

-- 11. WHERE CLAUSE

	-- 11.1 Finding Rows By Using A Simple Equality
SELECT 
	DISTINCT product_name,
	model_year,
	list_price
FROM production.products
WHERE model_year = 2018

	-- 11.2 Finding Rows That Meet Two Conditions
SELECT 
	DISTINCT product_name,
	model_year,
	list_price
FROM production.products
WHERE model_year = 2018
AND brand_id = 9

	-- 11.3 Finding Rows By Using A Comparison Operator
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000

	-- 11.4 Finding Rows That Meet Any Of Two Conditions
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)

-- 12. USING ORDER BY CLAUSE FOR SORTING

	-- 12.1 ASCENDING ORDER SINGLE COLUMN
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)
ORDER BY list_price 

	-- 12.2 DESCENDING ORDER SINGLE COLUMN
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)
ORDER BY list_price DESC

	-- 12.3 ORDERING MULTIPLE COLUMN
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)
ORDER BY 
	list_price DESC,
	category_id ASC

	-- 12.4 ORDERING BASED ON AN EXPRESSION OR MATAHEMATICAL FORMULAE WHICH IS NOT IN TABLE
SELECT 
	product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)
ORDER BY
	LEN(product_name) DESC


-- 13. AS OPERATOR
SELECT 
	DISTINCT product_name,
	LEN(product_name) as Length_of_ProductName,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND (category_id = 5 OR category_id = 6)
ORDER BY
	LEN(product_name) DESC


--14. NOT OPERATOR
SELECT 
	DISTINCT product_name,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND brand_id = 9
AND list_price >= 1000
AND category_id <> 5  -- It can also be written as "AND NOT category_id = 5"
ORDER BY 
	list_price DESC


--15. IN OPERATOR
SELECT 
	product_name,
	product_id,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND product_id IN (111,115,118,119,125,166,205)
ORDER BY list_price DESC


--16. SUB QUERIES (QUERY INSIDE THE QUERY)
SELECT 
	product_name,
	product_id,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE product_id IN 
(
SELECT
	product_id
	FROM production.products
	WHERE model_year = 2018
	AND brand_id = 9
)
ORDER BY product_id

-- 17. BETWEEN OPERATOR

	--17.1 For Numbers
SELECT 
	product_name,
	product_id,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year BETWEEN 2017 and 2018  -- "model_year = 2018 OR model_year = 2017" or "model_year IN (2017,2018)"
AND list_price BETWEEN 1000 AND 2000
ORDER BY list_price DESC

	-- 17.2 For Text
SELECT 
	product_name,
	product_id,
	model_year,
	list_price,
	brand_id,
	category_id
FROM production.products
WHERE model_year = 2018
AND product_name BETWEEN 'Trek 1120 - 2018' AND 'Trek CrossRip+ - 2018'
ORDER BY product_id


											--EXAMPLES

-- Create a query for getting following things year 2018 and 2019, brand id 5, category id 4 and 6
SELECT 
	product_name,
	product_id
	FROM production.products
	WHERE model_year IN (2017,2019)
AND brand_id = 7
AND category_id IN (4,6)

-- Create a query for getting following things distinct name, lives in garden city and amsterdam, phone nummber is null
SELECT 
DISTINCT first_name,
city,
customer_id
FROM sales.customers
WHERE city IN ('Garden City' , 'Amsterdam')
AND phone = 'NULL'


-- 18 LIKE OPERATOR
-- 18.1 Wildcard - not the letter in ther range through X
SELECT first_name from sales.customers
WHERE first_name LIKE '[^A-X]%'
ORDER BY first_name

-- 18.2 Wildcard - Return all street that contain the phrase "NORTH"
SELECT DISTINCT street FROM sales.customers
WHERE street LIKE '%North%'
ORDER BY street

--18.3 Wildcard - Return all the city starting from 'B',
-- followed by  any 3 characters , ending with 'X'
SELECT DISTINCT City FROM sales.customers
WHERE City LIKE 'B___X'
Order BY city

--18.4 Wildcard - Return all the city starting from 'B','X','a'
SELECT DISTINCT City FROM sales.customers
WHERE City LIKE 'B''X''a'
ORDER BY city





-- Q.1. Give the list of products name, category name and its list price with their brands name also ? (categories and products table)

		SELECT p.product_name, c.category_name, p.list_price, b.brand_name
		FROM production.products p
		INNER JOIN production.categories c
		ON c.category_id = p.category_id
		INNER JOIN production.brands b
		ON b.brand_id = p.brand_id
		ORDER BY product_name DESC

-- Q.2. Give the list of products that have not been sold to any customer yet ? (product which have not order id)

		SELECT p.product_name, p.product_id, o.order_id
		FROM production.products p
		LEFT JOIN sales.orders_items o
		ON o.product_id = p.product_id
		WHERE o.order_id IS NULL
		ORDER BY product_id

-- Q.3. Give the product name along with its order detail like order id, its item id and the order date ?

		SELECT p.product_name, o.order_id, i.item_id, o.order_date
		FROM production.products p
		LEFT JOIN sales.orders_items i
		ON i.product_id = p.product_id
		LEFT JOIN sales.orders o
		ON o.order_id = i.order_id

-- Q.4. Filter out the products that do not have the sale using RIGHT JOIN .

		SELECT p.product_name, o.order_id
		FROM sales.orders_items o
		RIGHT JOIN production.products p
		ON o.product_id = p.product_id
		WHERE order_id IS NULL
		ORDER BY p.product_name

-- Q.5. Who reports to whom ?

		-- since there is a null written in the manager id which can't be an interger data type
		-- so we execute following code to remove it
		UPDATE sales.staffs
		SET manager_id = ' '
		WHERE staff_id = 1

		SELECT e.staff_id, e.first_name, e.manager_id
		FROM sales.staffs e, sales.staffs m
		WHERE m.staff_id = e.manager_id


		SELECT e.staff_id, e.first_name, e.manager_id
		FROM sales.staffs e      --(EMPLOYEE)
		LEFT JOIN sales.staffs m  --(MANAGER)
		ON m.staff_id = e.manager_id

		SELECT 
		e.first_name + ' ' + e.last_name employee, -- make temp table employee from sales.staffs table
		m.first_name + ' ' + m.last_name manager -- make temp table manager from sales.staffs table
		FROM sales.staffs e --Employee
		LEFT JOIN sales.staffs m --Manager
		ON m.staff_id = e.manager_id
		ORDER BY manager