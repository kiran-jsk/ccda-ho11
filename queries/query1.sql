SELECT
    date AS sale_date,
    amount AS daily_revenue,
    SUM(amount) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_sales_total
FROM raw
WHERE date LIKE '%-22'
ORDER BY sale_date
LIMIT 10;
