-- ============================
-- Portfolio Projects Analysis
-- ============================
-- 1. Top-Selling Products by Revenue
SELECT p.product_name,
    SUM(s.revenue) AS total_revenue
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;
-- 2. Most Profitable Products
SELECT p.product_name,
    SUM(s.profit) AS total_profit
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 10;
-- 3. Store Performance (Revenue + Profit)
SELECT st.store_name,
    SUM(s.revenue) AS store_revenue,
    SUM(s.profit) AS store_profit
FROM sales s
    JOIN stores st ON s.store_id = st.store_id
GROUP BY st.store_name
ORDER BY store_revenue DESC;
-- 4. Customer Loyalty Impact
SELECT c.loyalty_member,
    COUNT(DISTINCT s.customer_id) AS num_customers,
    SUM(s.revenue) AS total_revenue,
    SUM(s.profit) AS total_profit
FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.loyalty_member;
-- 5. Seasonality Trends (Monthly Revenue + Profit)
SELECT cal.month,
    SUM(s.revenue) AS monthly_revenue,
    SUM(s.profit) AS monthly_profit
FROM sales s
    JOIN calendar cal ON s.order_date = cal.date
GROUP BY cal.month
ORDER BY cal.month;
-- 6. Profit Margin by Product
SELECT p.product_name,
    SUM(s.profit) / NULLIF(SUM(s.revenue), 0) AS profit_margin
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY profit_margin DESC
LIMIT 10;
-- 7. Average Customer Spend
SELECT c.customer_id,
    AVG(s.revenue) AS avg_spend
FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY avg_spend DESC
LIMIT 10;