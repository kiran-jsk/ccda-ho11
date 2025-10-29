
-- Calculate month-over-month growth rates for sales
WITH monthly_metrics AS (
    SELECT 
        DATE_TRUNC('month', DATE_PARSE(date, '%m-%d-%y')) AS month,
        SUM(amount) AS total_sales,
        SUM(qty) AS total_quantity,
        COUNT(*) AS order_count
    FROM raw
    WHERE date IS NOT NULL
    GROUP BY DATE_TRUNC('month', DATE_PARSE(date, '%m-%d-%y'))
),
growth_calc AS (
    SELECT 
        month,
        total_sales,
        total_quantity,
        order_count,
        LAG(total_sales) OVER (ORDER BY month) AS prev_month_sales,
        LAG(total_quantity) OVER (ORDER BY month) AS prev_month_qty
    FROM monthly_metrics
)
SELECT 
    month,
    total_sales,
    total_quantity,
    order_count,
    ROUND(((total_sales - prev_month_sales) / NULLIF(prev_month_sales, 0)) * 100, 2) AS sales_growth_pct,
    ROUND(((total_quantity - prev_month_qty) / NULLIF(prev_month_qty, 0)) * 100, 2) AS qty_growth_pct
FROM growth_calc
WHERE prev_month_sales IS NOT NULL
ORDER BY month
LIMIT 10;
