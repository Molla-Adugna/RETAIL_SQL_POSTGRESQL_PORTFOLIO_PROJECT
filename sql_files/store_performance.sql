--Store Performance
-- 💡 Insight: Best‑performing stores by both revenue and profit.
SELECT st.store_name,
    SUM(s.revenue) AS store_revenue,
    SUM(s.profit) AS store_profit,
    cal.year
FROM sales s
    JOIN stores st ON s.store_id = st.store_id
    JOIN calendar cal ON s.order_date = cal.date
GROUP BY st.store_name,
    cal.year
ORDER BY store_revenue DESC
LIMIT 15;