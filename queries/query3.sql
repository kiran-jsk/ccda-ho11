WITH promo_flagged AS (
    SELECT
        category,
        CASE
            WHEN "promotion-ids" IS NULL OR "promotion-ids" = '' THEN 'No Promotion'
            ELSE 'Promotion Applied'
        END AS promo_group,
        amount
    FROM raw
    WHERE category IS NOT NULL
)
SELECT
    category,
    promo_group,
    COUNT(*) AS orders_placed,
    ROUND(AVG(amount), 2) AS mean_ticket,
    ROUND(SUM(amount), 2) AS gross_sales
FROM promo_flagged
GROUP BY category, promo_group
ORDER BY category, promo_group
LIMIT 10;
