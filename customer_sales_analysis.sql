CREATE DATABASE customer_sales_analysis;
USE customer_sales_analysis;

CREATE TABLE customers (
customer_id INT PRIMARY KEY,
customer_name VARCHAR(100),
city VARCHAR(50),
street VARCHAR(100)
);

CREATE TABLE orders (
order_id INT PRIMARY KEY,
customer_id INT,
order_date DATE,
product VARCHAR(50),
units INT,
revenue DECIMAL(10,2),
profit DECIMAL(10,2),
FOREIGN KEY (customer_id)
REFERENCES customers(customer_id)
);

-- View customer details
SELECT * FROM customers;

-- View order details
SELECT * FROM orders;

-- Join customer and order information
SELECT
c.customer_name,
c.city,
c.street,
o.order_id,
o.order_date,
o.product,
o.units,
o.revenue,
o.profit
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- Revenue by city
SELECT
c.city,
SUM(o.revenue) AS total_revenue
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- Revenue and profit by customer
SELECT
c.customer_name,
SUM(o.revenue) AS total_revenue,
SUM(o.profit) AS total_profit
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- Best-selling products
SELECT
product,
SUM(units) AS total_units
FROM orders
GROUP BY product
ORDER BY total_units DESC;
