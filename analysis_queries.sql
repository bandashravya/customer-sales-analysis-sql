USE customer_sales_analysis;

-- 1. Match customer details with their orders
SELECT
c.customer_name,
c.city,
c.street,
o.order_id,
o.product,
o.units,
o.revenue
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id;

-- 2. Find total revenue by city
SELECT
c.city,
SUM(o.revenue) AS total_revenue
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.city
ORDER BY total_revenue DESC;

-- 3. Find total revenue and profit by customer
SELECT
c.customer_name,
SUM(o.revenue) AS total_revenue,
SUM(o.profit) AS total_profit
FROM customers AS c
INNER JOIN orders AS o
ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
ORDER BY total_revenue DESC;

-- 4. Find best-selling products
SELECT
product,
SUM(units) AS total_units_sold,
SUM(revenue) AS total_revenue
FROM orders
GROUP BY product
ORDER BY total_units_sold DESC;

-- 5. Find customers who have no orders
SELECT
c.customer_name,
c.city
FROM customers AS c
LEFT JOIN orders AS o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;
