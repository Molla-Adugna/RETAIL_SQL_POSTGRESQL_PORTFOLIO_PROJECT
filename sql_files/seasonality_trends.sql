-- Seasonality Trends
-- 💡 Insight: Identify peak months for sales and profit.
SELECT cal.month,
    SUM(s.revenue) AS monthly_revenue,
    SUM(s.profit) AS monthly_profit
FROM sales s
    JOIN calendar cal ON s.order_date = cal.date
GROUP BY cal.month
ORDER BY cal.month;