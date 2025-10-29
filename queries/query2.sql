-- Since we don't have profit, we'll analyze problem orders (cancelled/pending) by state
SELECT 
    "ship-state" AS state,
    COUNT(*) AS problem_order_count,
    SUM(amount) AS total_amount_affected,
    ROUND(AVG(amount), 2) AS avg_order_value
FROM raw
WHERE status IN ('Cancelled', 'Pending', 'Pending - Waiting for Pick Up')
GROUP BY "ship-state"
ORDER BY problem_order_count DESC
LIMIT 10;
