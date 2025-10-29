SELECT
    "ship-state" AS ship_state,
    COUNT(*) AS flagged_orders,
    SUM(amount) AS impacted_sales,
    ROUND(AVG(amount), 2) AS typical_order_value
FROM raw
WHERE status IN ('Cancelled', 'Pending', 'Pending - Waiting for Pick Up')
GROUP BY "ship-state"
ORDER BY flagged_orders DESC
LIMIT 10;
