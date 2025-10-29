
SELECT 
    date,
    amount,
    SUM(amount) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS cumulative_sales
FROM raw
WHERE date LIKE '%-22'
ORDER BY date
LIMIT 10;
