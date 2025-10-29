WITH category_rankings AS (
    SELECT
        category,
        sku,
        style,
        SUM(amount) AS category_sales,
        SUM(qty) AS units_sold,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(amount) DESC) AS position_in_category
    FROM raw
    WHERE category IS NOT NULL AND sku IS NOT NULL
    GROUP BY category, sku, style
)
SELECT
    category,
    sku,
    style,
    category_sales,
    units_sold,
    position_in_category
FROM category_rankings
WHERE position_in_category <= 3
ORDER BY category, position_in_category
LIMIT 10;
