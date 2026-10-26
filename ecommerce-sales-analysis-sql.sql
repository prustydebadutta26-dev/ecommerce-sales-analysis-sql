USE ecommerce_db;

-- 1. Check total customers, products, and orders
SELECT
    (SELECT COUNT(*) FROM customers) AS total_customers,
    (SELECT COUNT(*) FROM products) AS total_products,
    (SELECT COUNT(*) FROM orders) AS total_orders;

-- 2. Calculate total sales revenue
SELECT SUM(p.price * o.quantity) AS total_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id;

-- 3. Find best-selling products
SELECT
    p.product_name,
    SUM(o.quantity) AS total_quantity_sold
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY p.product_id, p.product_name
ORDER BY total_quantity_sold DESC;

-- 4. Calculate monthly revenue
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m') AS sales_month,
    SUM(p.price * o.quantity) AS monthly_revenue
FROM orders AS o
JOIN products AS p
    ON o.product_id = p.product_id
GROUP BY DATE_FORMAT(o.order_date, '%Y-%m')
ORDER BY sales_month;

-- 5. Calculate average order value
SELECT ROUND(AVG(order_revenue), 2) AS average_order_value
FROM (
    SELECT
        o.order_id,
        SUM(p.price * o.quantity) AS order_revenue
    FROM orders AS o
    JOIN products AS p
        ON o.product_id = p.product_id
    GROUP BY o.order_id
) AS order_totals;