-- Use window function to rank products by sales within each category
WITH ranked_products AS (
    SELECT 
        category,
        sku,
        style,
        SUM(amount) AS total_sales,
        SUM(qty) AS total_quantity,
        ROW_NUMBER() OVER (PARTITION BY category ORDER BY SUM(amount) DESC) AS rank
    FROM raw
    WHERE category IS NOT NULL AND sku IS NOT NULL
    GROUP BY category, sku, style
)
SELECT 
    category,
    sku,
    style,
    total_sales,
    total_quantity,
    rank
FROM ranked_products
WHERE rank <= 3
ORDER BY category, rank
LIMIT 10;
