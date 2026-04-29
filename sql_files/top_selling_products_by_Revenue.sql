-- Top‑Selling Products by Revenue
-- 💡 Insight: Which products generate the most revenue.
SELECT p.product_name,
    SUM(s.revenue) AS total_revenue
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_revenue DESC
LIMIT 10;