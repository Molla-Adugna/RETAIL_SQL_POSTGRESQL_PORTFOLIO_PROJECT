-- 1. Drop tables if they already exist
DROP TABLE IF EXISTS sales CASCADE;
DROP TABLE IF EXISTS calendar CASCADE;
DROP TABLE IF EXISTS customers CASCADE;
DROP TABLE IF EXISTS products CASCADE;
DROP TABLE IF EXISTS stores CASCADE;
-- 2. Create dimension tables
CREATE TABLE calendar (
    date DATE PRIMARY KEY,
    year INT,
    month INT,
    day INT,
    week INT,
    day_of_week INT
);
CREATE TABLE customers (
    customer_id VARCHAR(50) PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    loyalty_member BOOLEAN,
    join_date DATE
);
CREATE TABLE products (
    product_id VARCHAR(50) PRIMARY KEY,
    product_name VARCHAR(100),
    brand VARCHAR(50),
    category VARCHAR(50),
    cocoa_percent DECIMAL(5, 2),
    weight_g INT
);
CREATE TABLE stores (
    store_id VARCHAR(50) PRIMARY KEY,
    store_name VARCHAR(100),
    city VARCHAR(50),
    country VARCHAR(50),
    store_type VARCHAR(50)
);
-- 3. Create fact table (Sales)
CREATE TABLE sales (
    order_id VARCHAR(50) PRIMARY KEY,
    order_date DATE,
    product_id VARCHAR(50) REFERENCES products(product_id),
    store_id VARCHAR(50) REFERENCES stores(store_id),
    customer_id VARCHAR(50) REFERENCES customers(customer_id),
    quantity INT,
    unit_price DECIMAL(10, 2),
    discount DECIMAL(5, 2),
    revenue DECIMAL(12, 2),
    cost DECIMAL(12, 2),
    profit DECIMAL(12, 2)
);
-- 4. Import dimension tables
\ copy calendar
FROM 'C:/PostgresData/portfolio/calendar.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
\ copy customers
FROM 'C:/PostgresData/portfolio/customers.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
\ copy products
FROM 'C:/PostgresData/portfolio/products.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
\ copy stores
FROM 'C:/PostgresData/portfolio/stores.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
-- 5. Import fact table
\ copy sales
FROM 'C:/PostgresData/portfolio/sales.csv' WITH (
        FORMAT csv,
        HEADER true,
        DELIMITER ',',
        ENCODING 'UTF8'
    );
-- 6. Run diagnostics
-- Missing Products
SELECT DISTINCT s.product_id
FROM sales s
WHERE s.product_id NOT IN (
        SELECT product_id
        FROM products
    );
-- Missing Stores
SELECT DISTINCT s.store_id
FROM sales s
WHERE s.store_id NOT IN (
        SELECT store_id
        FROM stores
    );
-- Missing Customers
SELECT DISTINCT s.customer_id
FROM sales s
WHERE s.customer_id NOT IN (
        SELECT customer_id
        FROM customers
    );
-- Missing Dates
SELECT DISTINCT s.order_date
FROM sales s
WHERE s.order_date NOT IN (
        SELECT date
        FROM calendar
    );
-- Summary Dashboard
SELECT 'Missing Products' AS issue,
    COUNT(*) AS count
FROM sales s
WHERE s.product_id NOT IN (
        SELECT product_id
        FROM products
    )
UNION ALL
SELECT 'Missing Stores',
    COUNT(*)
FROM sales s
WHERE s.store_id NOT IN (
        SELECT store_id
        FROM stores
    )
UNION ALL
SELECT 'Missing Customers',
    COUNT(*)
FROM sales s
WHERE s.customer_id NOT IN (
        SELECT customer_id
        FROM customers
    )
UNION ALL
SELECT 'Missing Dates',
    COUNT(*)
FROM sales s
WHERE s.order_date NOT IN (
        SELECT date
        FROM calendar
    );