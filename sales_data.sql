-- sql retail sales analysis -- p1


SELECT * FROM sales_data ;


-- Data Cleaning
SELECT * FROM sales_data  
WHERE
transaction_id IS NULL 
OR
gender  IS NULL 
OR
sale_date IS NULL
OR 
sale_time IS NULL 
OR 
customer_id IS NULL
OR 
age IS NULL 
OR 
category IS NULL 
OR 
quantiy IS NULL 
OR 
price_per_unit IS NULL 
OR 
cogs IS NULL
OR 
total_sale IS NULL ;

--

DELETE FROM  sales_data 
WHERE
transaction_id IS NULL 
OR
gender  IS NULL 
OR
sale_date IS NULL
OR 
sale_time IS NULL 
OR 
customer_id IS NULL
OR 
age IS NULL 
OR 
category IS NULL 
OR 
quantiy IS NULL 
OR 
price_per_unit IS NULL 
OR 
cogs IS NULL
OR 
total_sale IS NULL ;

-- Data Exploration

-- How many sales we have?
SELECT COUNT(*) FROM sales_data ;

-- How many customers we have?
SELECT  COUNT(DISTINCT customer_id) AS Total_Sales FROM sales_data ;

SELECT  DISTINCT category  AS Total_Sales FROM sales_data ;

-- Data Analysis & Business Key Problems & Answers

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05
-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4in the month of Nov-2022
-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.
-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.
-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year
-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 
-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.
-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <=12, Afternoon Between 12 & 17, Evening >17)

-- Q.1 Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM sales_data 
WHERE sale_date = '2022-11-05' ;


-- Q.2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 10 in the month of Nov-2022

SELECT * 
FROM sales_data  
WHERE category = 'clothing'
  AND quantiy= 4
  AND DATE_FORMAT(sale_date, '%Y-%m') = '2022-11'
;


-- Q.3 Write a SQL query to calculate the total sales (total_sale) for each category.

   SELECT 
   category,
   SUM(total_sale) as net_sale,
  COUNT(*) as total_orders 
 FROM sales_data
  GROUP BY category;
  
  

-- Q.4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.

SELECT AVG(age) AS avg_age
FROM sales_data
WHERE category = 'Beauty';




-- Q.5 Write a SQL query to find all transactions where the total_sale is greater than 1000.
SELECT 
*  FROM sales_data 
WHERE total_sale >1000 ;



-- Q.6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT 
    category, 
    gender, 
    COUNT(transaction_id) AS total_trans
FROM sales_data 
GROUP BY category, gender;




-- Q.7 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

SELECT 
EXTRACT( YEAR FROM sale_date)as Year , 
EXTRACT(MONTH  FROM sale_date)as Month ,
AVG(total_sale ) AS Avg_Sales 
FROM sales_data 
GROUP BY 1,2
ORDER BY 1,2 ;



-- Q.8 Write a SQL query to find the top 5 customers based on the highest total sales 

SELECT 
customer_id ,
SUM(total_sale) As Total_Sales
 FROM sales_data 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5 ;



-- Q.9 Write a SQL query to find the number of unique customers who purchased items from each category.

SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM sales_data
GROUP BY category ;



-- Q.10 Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)

SELECT 
    CASE 
        WHEN HOUR(sale_time) < 12 THEN 'Morning'
        WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift,
    COUNT(*) AS total_orders
FROM sales_data
GROUP BY shift;

