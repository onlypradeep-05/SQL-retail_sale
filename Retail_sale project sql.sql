-- SQL Retail Sales Analysis -- P1

-- Create Table --
CREATE TABLE retail_sales
(
             transaction_id INT PRIMARY KEY,
             sale_date DATE,
             sale_time TIME,
             customer_id INT,
             gender VARCHAR(15),
             age INT,
             category VARCHAR(15),
             quantity INT,
             price_per_unit FLOAT,
             cogs FLOAT,
             total_sale FLOAT
);

select * from retail_sales;

select count(*) from retail_sales;


-- DATA CLEANING
select * from retail_sales
where transaction_id is null;

select * from retail_sales
where sale_date is null;

select * from retail_sales
where sale_time is null;

select * from retail_sales
where transaction_id is null 
or sale_date is null
or sale_time is null
or gender is null
or category is null
or quantity is null
or cogs is null
or total_sale is null
or price_per_unit is null
or customer_id is null;


DELEte from retail_sales
where transaction_id is null 
or 
sale_date is null
or 
sale_time is null
or 
gender is null
or 
category is null
or 
quantity is null
or 
cogs is null
or 
total_sale is null
or 
price_per_unit is null
or 
customer_id is null;

-- DATA EXPLORATION

-- How many sales we have ?
SELECT COUNT(*) as total_sale FROM retail_sales;

-- How many unique customers we have ?
SELECT COUNT(DISTINCT customer_id) as total_sale from retail_sales;

-- How many unique category we have ? 
SELECT DISTINCT category from retail_sales;


-- Data Analysis & Business Key Problems & Answers
-- My Analysis & Findings

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a sQl query to retrieve all transactions where the category is 'Clothing' and the quantity sale is more than 10 in the month of Nov-2022
-- Q.3 write a sol query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQl query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Mrite a sQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 write a sQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a sQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a sQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evenin



-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05

SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';


-- Q.2 Write a sQl query to retrieve all transactions where the category is 'Clothing' and the quantity sale is more than 10 in the month of Nov-2022

SELECT 
      *
FROM retail_sales
WHERE category = 'Clothing'
     AND
	 TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
     AND
	 quantity >= 4;


-- Q.3 write a sql query to calculate the total sales (total_sale) for each category.

SELECT
      category,
      SUM(total_sale) as net_sale,
	  COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1;


-- Q.4 Write a SQl query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT 
     ROUND(AVG(age), 2) as average_age
FROM retail_sales
WHERE category = 'Beauty';


-- Q.5 Write a sQL query to find all transactions where the total_sale is greater than 1000.

SELECT *
FROM retail_sales
WHERE total_sale > 1000;


-- Q.6 write a sQL query to find the total number of transactions (transaction_id) made by each gender in each category.

SELECT
     category,
	 gender,
	 COUNT(*) as total_trans
FROM retail_sales
GROUP BY category,
     gender;


-- Q.7 Write a sQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT * FROM
(
SELECT 
       EXTRACT (YEAR FROM sale_date) as year,
	   EXTRACT (MONTH FROM sale_date) as month,
	   AVG(total_sale) as avg_sale,
	   RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC)
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;
-- ORDER BY 1, 3 DESC;


-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales

SELECT 
      customer_id,
	  SUM(total_sale)	  
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;


-- Q.9 write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
      category,
      COUNT(DISTINCT customer_id) as unique_customer
FROM retail_sales
GROUP BY category;


-- Q.10 Write a sQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evenin

WITH hourly_sale
AS(
SELECT *,
    CASE
		WHEN EXTRACT(HOUR FROM sale_time) <= 12 THEN 'Morning'
		WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
		ELSE 'EVENING'
    END as shift
FROM retail_sales
)
SELECT
      shift,
      COUNT(*) as total_orders
FROM hourly_sale
GROUP BY shift;


-- END OF THIS PROJECT --








