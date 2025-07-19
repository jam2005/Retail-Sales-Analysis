CREATE DATABASE project1;
USE project1;
DROP TABLE IF exists retail_sales;
CREATE TABLE retail_sales (
    transactions_id INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id INT,
    gender VARCHAR(10),
    age INT,
    category VARCHAR(25),
    quantity INT,
    price_per_unit FLOAT,
    cogs FLOAT,
    total_sale FLOAT
);

SELECT 
    *
FROM
    retail_sales
LIMIT 10;

-- DATA CLEANING
SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date IS NULL OR sale_time IS NULL
        OR customer_id IS NULL
        OR gender IS NULL
        OR age IS NULL
        OR category IS NULL
        OR quantity IS NULL
        OR price_per_unit IS NULL
        OR cogs IS NULL
        OR total_sale IS NULL;

DELETE FROM retail_sales 
WHERE
    sale_date IS NULL OR sale_time IS NULL
    OR customer_id IS NULL
    OR gender IS NULL
    OR age IS NULL
    OR category IS NULL
    OR quantity IS NULL
    OR price_per_unit IS NULL
    OR cogs IS NULL
    OR total_sale IS NULL;


-- DATA EXPLORATION
-- how many sales do we have?
SELECT 
    COUNT(total_sale) AS tsale
FROM
    retail_sales;
-- how many customers do we have?
SELECT 
    COUNT(DISTINCT customer_id) AS customers
FROM
    retail_sales;
-- on which date the max sales were observed?
SELECT 
    MAX(sale_date)
FROM
    retail_sales;
-- who are the regular customer male or female?
SELECT 
    MAX(gender)
FROM
    retail_sales;
-- which category is being sold most?
SELECT 
    MAX(category)
FROM
    retail_sales;


-- DATA ANALYSIS (BUSINESS PROBLEMS)
-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022
-- --Q.3 Write a SQL query to calculate the total sales (total sale) for each category,
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000,
-- Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 write a SQL query to find the top 5 customers based on the highest total sales
-- Q.9 Write a SQL query to find the numer of unique customers who purchased items from each category,
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening 217)

SELECT 
    *
FROM
    retail_sales
WHERE
    sale_date = '2022-11-05';
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 3 in the month of Nov-2022
SELECT 
    *
FROM
    retail_sales
WHERE
    category = 'Clothing' AND quantity > 3
        AND sale_date BETWEEN '2022-11-01' AND '2022-11-30';
-- --Q.3 Write a SQL query to calculate the total sales (total sale) for each category,
SELECT 
    category, COUNT(*) AS total_orders, SUM(total_sale)
FROM
    retail_sales
GROUP BY category;
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
SELECT 
    ROUND(AVG(age))
FROM
    retail_sales
WHERE
    category = 'Beauty';
-- Q.5 Write a SQL query to find all transactions where the total sale is greater than 1000,
SELECT 
    *
FROM
    retail_sales
WHERE
    total_sale > 1000;
-- Q.6 Write a SQL query to find the total number of transactions (transaction id) made by each gender in each category.
SELECT 
    category, gender, COUNT(*) AS total_transacttions
FROM
    retail_sales
GROUP BY category , gender
ORDER BY category;
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
SELECT 
    YEAR(sale_date) AS year,
    MONTH(sale_date) AS month,
    ROUND(AVG(total_sale)) AS avg_sales
FROM
    retail_sales
GROUP BY year , month
ORDER BY year , avg_sales DESC;

-- Q.8 write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
    customer_id, SUM(total_sale) AS total_sales
FROM
    retail_sales
GROUP BY customer_id
ORDER BY total_sales DESC
LIMIT 5;

-- Q.9 Write a SQL query to find the numer of unique customers who purchased items from each category,
SELECT 
    Category, COUNT(DISTINCT customer_id) AS total_customers
FROM
    retail_sales
GROUP BY category;

-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening 217)
WITH hourly_sale AS (
    SELECT *,
        CASE 
            WHEN HOUR(sale_time) < 12 THEN 'morning'
            WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'afternoon'
            ELSE 'evening'
        END AS shift
    FROM retail_sales
)

SELECT 
    shift, COUNT(*)
FROM
    hourly_sale		
GROUP BY shift;

-- end of project