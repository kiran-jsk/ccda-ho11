-- Analyze impact of promotions on sales amount by category
SELECT 
    category,
    CASE 
        WHEN "promotion-ids" IS NULL OR "promotion-ids" = '' THEN 'No Promotion'
        ELSE 'With Promotion'
    END AS promotion_status,
    COUNT(*) AS order_count,
    ROUND(AVG(amount), 2) AS avg_order_amount,
    ROUND(SUM(amount), 2) AS total_sales
FROM raw
WHERE category IS NOT NULL
GROUP BY category, 
    CASE 
        WHEN "promotion-ids" IS NULL OR "promotion-ids" = '' THEN 'No Promotion'
        ELSE 'With Promotion'
    END
ORDER BY category, promotion_status
LIMIT 10;
