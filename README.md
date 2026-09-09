# Olist E-Commerce SQL Analysis

## Project Overview

This project is a practical SQL analysis of the **Brazilian E-Commerce Public Dataset by Olist**.

The project contains **35 core SQL analysis questions**, progressing from basic customer and order analysis to seller, product category, customer spending, and time-based business analysis.

The complete analysis was performed using **MySQL / MySQL Workbench**.

---

## Dataset

**Dataset:** Brazilian E-Commerce Public Dataset by Olist

The dataset contains information about an e-commerce marketplace in Brazil, including:

- Customers
- Orders
- Order Items
- Products
- Sellers
- Order Payments
- Order Reviews
- Product Category Translation
- Geolocation

The original dataset is not included in this repository. It should be downloaded separately from its original Kaggle source.

---

## Tools & Technologies

- **MySQL**
- **MySQL Workbench**
- **SQL**
- **Git**
- **GitHub**
- **Brazilian E-Commerce Public Dataset by Olist**

---

## Database Tables

The project works with the following 9 tables:

| Table | Purpose |
|---|---|
| `customers` | Stores customer information and location |
| `orders` | Stores order details, status, and timestamps |
| `order_items` | Stores products, sellers, prices, and order-item details |
| `products` | Stores product information and categories |
| `sellers` | Stores seller information and location |
| `order_payments` | Stores payment information |
| `order_reviews` | Stores customer review information |
| `product_category_translation` | Maps Portuguese product categories to English |
| `geolocation` | Contains geographical location data |

---

## Main Table Relationships

```text
customers
    |
    | customer_id
    v
orders
    |
    | order_id
    v
order_items
    |
    +------------------+
    |                  |
    | product_id       | seller_id
    v                  v
products            sellers
    |
    | product_category_name
    v
product_category_translation

orders
    |
    +--------------------+
    |                    |
    | order_id           | order_id
    v                    v
order_payments      order_reviews
```

---

# Analysis Covered

The project contains 35 core questions divided into major analytical areas.

## 1. Customer Analysis

The customer analysis covers:

- Number of unique customers
- Customers in São Paulo (`SP`)
- Customer count by state
- States with more than 5,000 customers
- Top 5 states by customer count
- Customer city and order status
- Total spending per customer
- Top 10 customers by spending
- Customer order count and total spending
- Customers spending more than 5,000
- Customer Average Order Value (AOV)

---

## 2. Order Analysis

The order analysis covers:

- Product and price information for each order
- Orders containing products priced above 100
- Total product value per order
- Top 5 orders by total product value
- Order value classification
- Order status classification
- Monthly order counts
- Monthly sales
- Monthly Average Order Value
- 2018 monthly order and sales analysis
- January 2018 order and sales analysis
- Monthly delivered, shipped, and canceled orders
- Monthly revenue from delivered orders

---

## 3. Product & Category Analysis

The project analyzes:

- Average selling price of products
- Products with average prices above 100
- Number of distinct products per category
- Average selling price by category
- Category-wise total sales
- Top 10 product categories by sales
- English product category names using category translation

---

## 4. Seller Analysis

Seller performance is analyzed using:

- Unique order count per seller
- Sellers with more than 100 unique orders
- Seller total sales
- Sellers with total sales above 10,000
- Seller performance classification
- Top 10 sellers by total sales
- Seller city, unique orders, and total sales

---

# 35 Core SQL Questions

The SQL analysis covers the following questions:

1. How many unique customers are present?
2. How many customers are located in São Paulo?
3. How many customers are there in each state?
4. Which states have more than 5,000 customers?
5. What are the top 5 states by customer count?
6. What are the customer city and order status for each order?
7. Which product was sold in each order and at what price?
8. Which orders contain products priced above 100?
9. What is the total product value of each order?
10. Which are the top 5 orders by total product value?
11. Which products have an average selling price above 100?
12. Which sellers have sold products in more than 100 unique orders?
13. Which sellers have total sales above 10,000?
14. Which product categories contain more than 100 distinct products, and what is their average selling price?
15. What are the unique order counts for all sellers, including sellers with no orders?
16. Which sellers have total sales above 10,000 using a LEFT JOIN?
17. How should orders be classified based on total product value?
18. How should sellers be classified based on total sales?
19. How should order statuses be classified?
20. How many orders were placed in each month and year?
21. What is the total product sales value for each month and year?
22. What are the monthly order count, total sales, and Average Order Value?
23. What were the monthly orders and sales during 2018?
24. How many unique orders and how much sales occurred in January 2018?
25. What is the total spending of each customer?
26. Who are the top 10 customers by total spending?
27. How many unique orders did each customer place and how much did they spend?
28. Which customers spent more than 5,000?
29. What is the Average Order Value for each customer?
30. How many delivered, shipped, and canceled orders occurred each month?
31. What was the monthly revenue from delivered orders?
32. What are the total sales for each product category?
33. Which are the top 10 product categories by sales?
34. Which are the top 10 sellers by total sales?
35. What are the overall row counts for customers, orders, order items, and products?

---

# SQL Concepts Demonstrated

This project demonstrates practical use of:

- `SELECT`
- `WHERE`
- `JOIN`
- `LEFT JOIN`
- `GROUP BY`
- `HAVING`
- `ORDER BY`
- `LIMIT`
- `COUNT()`
- `COUNT(DISTINCT ...)`
- `SUM()`
- `AVG()`
- `CASE`
- `IN`
- `DISTINCT`
- Subqueries
- Aggregate functions
- Date functions
- `YEAR()`
- `MONTH()`
- `MONTHNAME()`

---

# Business Metrics

Several common e-commerce metrics are calculated in the project.

### Total Sales

```text
SUM(order_items.price)
```

### Order Count

```text
COUNT(DISTINCT orders.order_id)
```

### Average Order Value

```text
Total Sales / Number of Unique Orders
```

### Customer Spending

```text
SUM(order_items.price)
```

These metrics are used to understand customer behavior, order performance, seller performance, and product-category sales.

---

# Project Workflow

```text
Olist Dataset
      ↓
MySQL Database
      ↓
Import CSV Tables
      ↓
Understand Table Relationships
      ↓
Customer Analysis
      ↓
Order Analysis
      ↓
Product & Category Analysis
      ↓
Seller Analysis
      ↓
Time-Based Analysis
      ↓
Business Metrics
      ↓
E-Commerce Insights
```

---

# How to Run the Project

## 1. Install MySQL

Install:

- MySQL Server
- MySQL Workbench

## 2. Download the Dataset

Download the Brazilian E-Commerce Public Dataset by Olist from its original source.

## 3. Create the Database

Run:

```sql
CREATE DATABASE olist_ecommerce;
USE olist_ecommerce;
```

## 4. Import the CSV Files

Import the dataset CSV files into the corresponding MySQL tables:

```text
customers
geolocation
order_items
order_payments
order_reviews
orders
product_category_translation
products
sellers
```

## 5. Open the SQL File

Open:

```text
olist_ecommerce_sql_analysis_35_core_questions.sql
```

in MySQL Workbench.

## 6. Execute the Queries

Select the query you want to execute and click the **Execute (⚡)** button in MySQL Workbench.

---

# Repository Structure

A clean GitHub repository can be organized as:

```text
olist-ecommerce-sql-analysis/
│
├── README.md
│
├── sql/
│   └── olist_ecommerce_sql_analysis_35_core_questions.sql
│
├── screenshots/
│   ├── database_schema.png
│   ├── query_results.png
│   └── insights.png
│
└── dataset/
    └── README.md
```

The original dataset CSV files do not need to be uploaded to GitHub.

---

# Project Objective

The objective of this project is to demonstrate how SQL can be used to analyze a real-world e-commerce dataset and answer practical business questions.

The project focuses on transforming raw relational data into useful information about:

- Customer behavior
- Order trends
- Product pricing
- Product categories
- Seller performance
- Sales performance
- Monthly business trends

---

# Key Learning Outcomes

By completing this project, the following practical skills are demonstrated:

1. Working with a multi-table relational database.
2. Understanding relationships between tables.
3. Joining multiple tables using common keys.
4. Performing aggregation and grouping.
5. Filtering aggregated results using `HAVING`.
6. Using `CASE` for business classification.
7. Performing customer and seller analysis.
8. Performing product and category analysis.
9. Performing time-based analysis.
10. Calculating business metrics such as total sales and AOV.
11. Writing SQL queries for real-world business questions.
12. Organizing SQL analysis into a structured project.

---

## Author

**Bhavendra Singh Gehlot**

**Project:** Olist E-Commerce SQL Analysis

**Database:** MySQL

**Dataset:** Brazilian E-Commerce Public Dataset by Olist
