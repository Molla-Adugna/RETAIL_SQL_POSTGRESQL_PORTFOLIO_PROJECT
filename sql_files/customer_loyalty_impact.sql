-- Customer Loyalty Impact
-- 💡 Insight: Compare loyal vs non‑loyal customers in terms of spending and profitability.
SELECT c.loyalty_member,
    COUNT(DISTINCT s.customer_id) AS num_customers,
    SUM(s.revenue) AS total_revenue,
    SUM(s.profit) AS total_profit
FROM sales s
    JOIN customers c ON s.customer_id = c.customer_id
GROUP BY c.loyalty_member;