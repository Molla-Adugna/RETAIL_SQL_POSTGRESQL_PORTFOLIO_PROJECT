-- Validate data integrity and consistency in the database
-- Count rows in each table
SELECT 'customers' AS table,
    COUNT(*)
FROM customers
UNION ALL
SELECT 'products',
    COUNT(*)
FROM products
UNION ALL
SELECT 'stores',
    COUNT(*)
FROM stores
UNION ALL
SELECT 'sales',
    COUNT(*)
FROM sales
UNION ALL
SELECT 'calendar',
    COUNT(*)
FROM calendar;
-- Check for missing foreign keys
SELECT COUNT(*)
FROM sales
WHERE customer_id IS NULL;
SELECT COUNT(*)
FROM sales
WHERE product_id IS NULL;
SELECT COUNT(*)
FROM sales
WHERE store_id IS NULL;