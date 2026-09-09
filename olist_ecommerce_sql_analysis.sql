-- OLIST E-COMMERCE SQL ANALYSIS
-- Core SQL Practice Questions
-- Cleaned Version: 35 Core Questions
-- Original analytical SQL statements are preserved as practiced.

USE olist_ecommerce;

-- ============================================================================
-- QUESTION 1
-- How many unique customers are present in the customers table?
-- ============================================================================
SELECT COUNT(DISTINCT customer_id) FROM customers;

-- ============================================================================
-- QUESTION 2
-- How many customers are located in the state of São Paulo (SP)?
-- ============================================================================
SELECT COUNT(customer_state)
FROM customers
WHERE customer_state = 'SP';

-- ============================================================================
-- QUESTION 3
-- How many customers are there in each state?
-- ============================================================================
SELECT customer_state, COUNT(*)
FROM customers
GROUP BY customer_state;

-- ============================================================================
-- QUESTION 4
-- Which states have more than 5,000 customers?
-- ============================================================================
SELECT customer_state, COUNT(*)
FROM customers
GROUP BY customer_state
HAVING COUNT(*) > 5000;

-- ============================================================================
-- QUESTION 5
-- What are the top 5 states with the highest number of customers?
-- ============================================================================
SELECT customer_state, COUNT(*) AS customer_count
FROM customers
GROUP BY customer_state
ORDER BY customer_count DESC
LIMIT 5;

-- ============================================================================
-- QUESTION 6
-- Find the customer city and order status for each order.
-- ============================================================================
select
	customers.customer_city,
    orders.order_status
from customers
join orders
on customers.customer_id=orders.customer_id
limit 10;

-- ============================================================================
-- QUESTION 7
-- For each order, identify the product sold and its corresponding price.
-- ============================================================================
SELECT 
    orders.order_id,
    order_items.product_id,
    order_items.price
FROM orders
JOIN order_items
    ON orders.order_id=order_items.order_id
JOIN products
    ON order_items.product_id=products.product_id;

-- ============================================================================
-- QUESTION 8
-- Find orders where the product price is greater than 100, ordered from highest to lowest price.
-- ============================================================================
select 
	orders.order_id,
    order_items.price,
    order_items.product_id
from orders
join order_items
on orders.order_id=order_items.order_id
JOIN products
ON order_items.product_id = products.product_id
where order_items.price>100
order by order_items.price desc;

-- ============================================================================
-- QUESTION 9
-- Calculate the total product value for each order.
-- ============================================================================
SELECT 
    orders.order_id,
    SUM(order_items.price) AS total_value
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY orders.order_id;

-- ============================================================================
-- QUESTION 10
-- Find the top 5 orders based on total product value.
-- ============================================================================
SELECT 
    orders.order_id,
    SUM(order_items.price) AS total_value
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY orders.order_id
ORDER BY total_value DESC
LIMIT 5;

-- ============================================================================
-- QUESTION 11
-- Find products whose average selling price is greater than 100.
-- ============================================================================
select 
	order_items.product_id,
    AVG(order_items.price) as average_price
from order_items
join products
	on order_items.product_id=products.product_id
group by order_items.product_id
having average_price > 100
order by average_price desc
limit 5;

-- ============================================================================
-- QUESTION 12
-- Find sellers who have sold products in more than 100 unique orders.
-- ============================================================================
select
	order_items. seller_id,
    count(distinct order_items.order_id) as order_count
from order_items
join sellers
	on order_items.seller_id= sellers.seller_id
group by order_items.seller_id
having order_count >100
order by order_count desc;

-- ============================================================================
-- QUESTION 13
-- For each seller, calculate unique orders and total sales, showing sellers whose total sales exceed 10,000.
-- ============================================================================
select
	order_items.seller_id,
    count(distinct order_items.order_id) as order_count,
    sum(order_items.price) as total_value
from order_items
join sellers
	on order_items.seller_id=sellers.seller_id
group by order_items.seller_id
having total_value > 10000
order by total_value desc;

-- ============================================================================
-- QUESTION 14
-- For each product category, calculate the number of distinct products and average selling price, showing categories with more than 100 products.
-- ============================================================================
SELECT 
    product_category_translation.product_category_name_english,
    COUNT(DISTINCT order_items.product_id) AS product_count,
    AVG(order_items.price) AS average_price
FROM order_items
JOIN products
    ON order_items.product_id = products.product_id
JOIN product_category_translation
    ON products.product_category_name =
       product_category_translation.product_category_name
GROUP BY product_category_translation.product_category_name_english
HAVING COUNT(DISTINCT order_items.product_id) > 100
ORDER BY product_count DESC;

-- ============================================================================
-- QUESTION 15
-- List every seller with their city and number of unique orders, including sellers with no orders.
-- ============================================================================
SELECT
    sellers.seller_id,
    sellers.seller_city,
    COUNT(DISTINCT order_items.order_id) AS order_count
FROM sellers
LEFT JOIN order_items
    ON order_items.seller_id = sellers.seller_id
GROUP BY sellers.seller_id, sellers.seller_city;

-- ============================================================================
-- QUESTION 16
-- Find sellers whose total sales exceed 10,000 using a LEFT JOIN.
-- ============================================================================
SELECT 
    sellers.seller_id,
    sellers.seller_city,
    SUM(order_items.price) AS total_sales
FROM sellers
LEFT JOIN order_items
    ON sellers.seller_id = order_items.seller_id
GROUP BY sellers.seller_id, sellers.seller_city
HAVING SUM(order_items.price) > 10000
ORDER BY total_sales DESC;

-- ============================================================================
-- QUESTION 17
-- Classify each order based on total product value: High Value above 500, Medium Value from 200 to 500, and Low Value below 200.
-- ============================================================================
SELECT
    orders.order_id,
    SUM(order_items.price) AS total_value,
    CASE
        WHEN SUM(order_items.price) > 500 THEN 'High Value'
        WHEN SUM(order_items.price) BETWEEN 200 AND 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS order_category
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY orders.order_id;

-- ============================================================================
-- QUESTION 18
-- Classify each seller based on total sales: Top Seller above 50,000, Good Seller from 20,000 to 50,000, and Small Seller below 20,000.
-- ============================================================================
SELECT
    sellers.seller_id,
    SUM(order_items.price) AS total_sales,
    CASE
        WHEN SUM(order_items.price) > 50000 THEN 'Top Seller'
        WHEN SUM(order_items.price) BETWEEN 20000 AND 50000 THEN 'Good Seller'
        ELSE 'Small Seller'
    END AS seller_category
FROM sellers
JOIN order_items
    ON sellers.seller_id = order_items.seller_id
GROUP BY sellers.seller_id;

-- ============================================================================
-- QUESTION 19
-- For each order status, calculate the number of orders and classify the status as Completed, In Progress, or Other.
-- ============================================================================
select 
       order_status,
       count(*) as status_count,
       CASE
       WHEN order_status = 'delivered' THEN 'Completed'
       WHEN order_status IN ('shipped', 'invoiced', 'processing') THEN 'In Progress'
       ELSE 'Other'
       END as status_category
from orders
group by order_status;

-- ============================================================================
-- QUESTION 20
-- Calculate the number of orders placed in each month and year.
-- ============================================================================
SELECT 
    YEAR(order_purchase_timestamp) AS year,
    MONTHNAME(order_purchase_timestamp) AS month,
    COUNT(*) AS order_count
FROM orders
GROUP BY 
    YEAR(order_purchase_timestamp), 
    MONTHNAME(order_purchase_timestamp)
ORDER BY 
    YEAR(order_purchase_timestamp), 
    MONTHNAME(order_purchase_timestamp);

-- ============================================================================
-- QUESTION 21
-- Calculate the total product sales value for each month and year.
-- ============================================================================
select
	year(order_purchase_timestamp) as year,
    month(order_purchase_timestamp) as month,
    sum(order_items.price) as total_value
from orders
join order_items
	on orders.order_id=order_items.order_id
group by 
	year(order_purchase_timestamp),
    month(order_purchase_timestamp)
order by
	year(order_purchase_timestamp),
    month(order_purchase_timestamp);

-- ============================================================================
-- QUESTION 22
-- For each month, calculate total orders, total sales value, and average order value.
-- ============================================================================
SELECT
    YEAR(orders.order_purchase_timestamp) AS year,
    MONTH(orders.order_purchase_timestamp) AS month,
    COUNT(DISTINCT orders.order_id) AS order_count,
    SUM(order_items.price) AS total_sales,
    SUM(order_items.price) / COUNT(DISTINCT orders.order_id) AS average_order_value
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
GROUP BY
    YEAR(orders.order_purchase_timestamp),
    MONTH(orders.order_purchase_timestamp)
ORDER BY
    year,
    month;

-- ============================================================================
-- QUESTION 23
-- For 2018, calculate the number of unique orders and total sales for each month.
-- ============================================================================
SELECT
    MONTH(order_purchase_timestamp) AS month,
    COUNT(DISTINCT orders.order_id) AS order_count,
    SUM(order_items.price) AS total_sales
FROM orders
JOIN order_items
    ON orders.order_id=order_items.order_id
WHERE YEAR(order_purchase_timestamp)=2018
GROUP BY MONTH(order_purchase_timestamp)
ORDER BY month;

-- ============================================================================
-- QUESTION 24
-- For January 2018, calculate the number of unique orders and total sales.
-- ============================================================================
SELECT 
    COUNT(DISTINCT orders.order_id) AS order_count,
    SUM(order_items.price) AS total_value
FROM orders
JOIN order_items
    ON orders.order_id = order_items.order_id
WHERE orders.order_purchase_timestamp >= '2018-01-01'
  AND orders.order_purchase_timestamp < '2018-02-01';

-- ============================================================================
-- QUESTION 25
-- Find each customer's total spending.
-- ============================================================================
select 
	orders.customer_id,
    customers.customer_city,
    sum(order_items.price) as total_spending
from order_items
join orders
	on order_items.order_id=orders.order_id
join customers
	on orders.customer_id=customers.customer_id
group by orders.customer_id, customers.customer_city;

-- ============================================================================
-- QUESTION 26
-- Find the top 10 customers who spent the most money.
-- ============================================================================
select 
	orders.customer_id,
    customers.customer_city,
    sum(order_items.price) as total_spending
from order_items
join orders
	on order_items.order_id=orders.order_id
join customers
	on orders.customer_id=customers.customer_id
group by orders.customer_id, customers.customer_city
order by total_spending desc
limit 10;

-- ============================================================================
-- QUESTION 27
-- For each customer, calculate the number of unique orders and total spending.
-- ============================================================================
select 
	orders.customer_id,
    customers.customer_city,
    count(distinct orders.order_id) as order_count,
    sum(order_items.price) as total_spending
from orders
join order_items
	on orders.order_id=order_items.order_id
join customers
	on orders.customer_id=customers.customer_id
group by orders.customer_id, customers.customer_city;

-- ============================================================================
-- QUESTION 28
-- Find customers whose total spending is more than 5,000.
-- ============================================================================
select
	orders.customer_id,
    customers.customer_city,
    sum(order_items.price) as total_spending
from orders
join order_items
	on orders.order_id=order_items.order_id
join customers
	on orders.customer_id=customers.customer_id
group by orders.customer_id, customers.customer_city
having total_spending>5000
order by total_spending desc;

-- ============================================================================
-- QUESTION 29
-- Calculate the Average Order Value (AOV) for each customer.
-- ============================================================================
select
	orders.customer_id,
    customers.customer_city,
    sum(order_items.price) / count(distinct orders.order_id) as AOV
from orders
join order_items
	on orders.order_id=order_items.order_id
join customers
	on orders.customer_id=customers.customer_id
group by orders.customer_id, customers.customer_city
order by AOV desc;

-- ============================================================================
-- QUESTION 30
-- For each month, find the number of delivered, shipped, and canceled orders.
-- ============================================================================
select
	year(order_purchase_timestamp) as year,
    month(order_purchase_timestamp) as month,
    orders.order_status,
    count(*) as order_count
from orders
where order_status in ('delivered', 'shipped', 'canceled')
group by year(order_purchase_timestamp), month(order_purchase_timestamp), orders.order_status
order by year(order_purchase_timestamp), month(order_purchase_timestamp), orders.order_status;

-- ============================================================================
-- QUESTION 31
-- Calculate monthly revenue using only delivered orders.
-- ============================================================================
select 
	year(order_purchase_timestamp) as year,
    month(order_purchase_timestamp) as month,
    sum(order_items.price) as total_sales
from orders
join order_items
	on orders.order_id=order_items.order_id
where order_status='delivered'
group by year(order_purchase_timestamp), month(order_purchase_timestamp)
order by year(order_purchase_timestamp), month(order_purchase_timestamp);

-- ============================================================================
-- QUESTION 32
-- Calculate total sales for each product category using the English category name.
-- ============================================================================
select 
	product_category_translation.product_category_name_english,
    sum(order_items.price) as total_sales
from order_items
join products 
	on order_items.product_id=products.product_id
join product_category_translation
	on products.product_category_name=product_category_translation.product_category_name
group by product_category_translation.product_category_name_english;

-- ============================================================================
-- QUESTION 33
-- Find the top 10 product categories with the highest total sales.
-- ============================================================================
select 
	product_category_translation.product_category_name_english,
    sum(order_items.price) as total_sales
from order_items
join products 
	on order_items.product_id=products.product_id
join product_category_translation
	on products.product_category_name=product_category_translation.product_category_name
group by product_category_translation.product_category_name_english
order by total_sales desc
limit 10;

-- ============================================================================
-- QUESTION 34
-- Find the top 10 sellers based on total sales, including their unique order count and seller city.
-- ============================================================================
select 
	order_items.seller_id,
    sellers.seller_city,
    count(distinct order_items.order_id) as order_count,
    sum(order_items.price) as total_sales
from order_items
join sellers
	on order_items.seller_id=sellers.seller_id
group by order_items.seller_id, sellers.seller_city
order by total_sales desc
limit 10;

-- ============================================================================
-- QUESTION 35
-- Calculate the total number of customers, orders, order items, and products in a single result.
-- ============================================================================
SELECT
    (SELECT COUNT(*) FROM customers) AS customers_count,
    (SELECT COUNT(*) FROM orders) AS orders_count,
    (SELECT COUNT(*) FROM order_items) AS order_items_count,
    (SELECT COUNT(*) FROM products) AS products_count;
