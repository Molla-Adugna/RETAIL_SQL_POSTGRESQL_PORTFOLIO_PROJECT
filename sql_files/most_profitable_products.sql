-- Most Profitable Products
-- 💡 Insight: Which products contribute most to profitability.
SELECT p.product_name,
    SUM(s.profit) AS total_profit
FROM sales s
    JOIN products p ON s.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_profit DESC
LIMIT 10;