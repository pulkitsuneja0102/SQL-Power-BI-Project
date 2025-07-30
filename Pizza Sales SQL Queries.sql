CREATE TABLE pizza_sales (
    pizza_id INT,    
    order_id INT,
    pizza_name_id VARCHAR(50),
    quantity SMALLINT,
    order_date DATE,
    order_time TIME,
    unit_price FLOAT,
    total_price FLOAT,
    pizza_size VARCHAR(50),
    pizza_category VARCHAR(50),
    pizza_ingredients VARCHAR(200),
    pizza_name VARCHAR(50)
);



SELECT * FROM pizza_sales

--KPIs requirement

--Total Revenue

SELECT ROUND(SUM(total_price):: numeric, 2) AS total_revenue 
FROM pizza_sales; 


--Average Order Value 

SELECT ROUND(
            SUM(total_price):: numeric/
                                     COUNT(DISTINCT order_id):: numeric, 2) AS average_order_value
FROM pizza_sales;


--Total pizzas sold 

SELECT SUM(quantity) AS total_pizzas_sold
FROM pizza_sales;


--Total Orders 
 
SELECT COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales;


--Average pizzas per order 

SELECT ROUND
        (SUM(quantity):: numeric/
                               COUNT(DISTINCT order_id):: numeric, 2) AS average_pizzas_per_order
FROM pizza_sales;


--Daily trend for total orders

SELECT TO_CHAR(order_date, 'Day') AS order_day, 
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales
GROUP BY to_char(order_date, 'Day')
ORDER BY 2 DESC;


--Monthly trend for total orders

SELECT TO_CHAR(order_date, 'Month') AS month_name,
       COUNT(DISTINCT order_id) AS total_orders
FROM pizza_sales	   
GROUP BY TO_CHAR(order_date, 'Month')
ORDER BY 2 DESC;


--Percentage of sales by pizza category

SELECT pizza_category, 
       ROUND(SUM(total_price):: numeric, 2) AS total_sales, 
       CAST(SUM(total_price) * 100/
	   (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10, 2)) AS percentage_of_sales
FROM pizza_sales
GROUP BY 1;


-- Percentage of Sales by Pizza Size 

SELECT pizza_size, 
       ROUND(SUM(total_price):: numeric, 2) AS total_sales, 
       CAST(SUM(total_price) * 100/
	   (SELECT SUM(total_price) FROM pizza_sales) AS DECIMAL(10,2)) AS percentage_of_sales
FROM pizza_sales
GROUP BY 1
ORDER BY percentage_of_sales DESC;

 
--Total Pizzas Sold by Pizza Category

SELECT pizza_category, 
       SUM(quantity) AS total_quantity_sold
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC;


--Top 5 Pizzas by Revenue

SELECT pizza_name, 
       SUM(total_price) AS total_revenue
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Bottom 5 Pizzas by Revenue

SELECT pizza_name, 
       ROUND(SUM(total_price):: numeric, 2) AS total_revenue
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;


--Top 5 Pizzas by Quantity

SELECT pizza_name, 
       SUM(quantity) AS total_pizzas_sold
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Bottom 5 Pizzas by Quantity

SELECT pizza_name, 
       SUM(quantity) AS total_pizzas_sold
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;


--Top 5 Pizzas by Total Orders

SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

--Bottom 5 Pizzas by Total Orders

SELECT pizza_name, 
       COUNT(DISTINCT order_id) AS total_orders 
FROM pizza_sales 
GROUP BY 1
ORDER BY 2 ASC
LIMIT 5;































































































































