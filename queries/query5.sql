WITH monthly_rollup AS (
    SELECT
        DATE_TRUNC('month', DATE_PARSE(date, '%m-%d-%y')) AS sales_month,
        SUM(amount) AS monthly_revenue,
        SUM(qty) AS monthly_volume,
        COUNT(*) AS monthly_orders
    FROM raw
    WHERE date IS NOT NULL
    GROUP BY DATE_TRUNC('month', DATE_PARSE(date, '%m-%d-%y'))
),
growth_series AS (
    SELECT
        sales_month,
        monthly_revenue,
        monthly_volume,
        monthly_orders,
        LAG(monthly_revenue) OVER (ORDER BY sales_month) AS prev_revenue,
        LAG(monthly_volume) OVER (ORDER BY sales_month) AS prev_volume
    FROM monthly_rollup
)
SELECT
    sales_month,
    monthly_revenue,
    monthly_volume,
    monthly_orders,
    ROUND(((monthly_revenue - prev_revenue) / NULLIF(prev_revenue, 0)) * 100, 2) AS revenue_growth_pct,
    ROUND(((monthly_volume - prev_volume) / NULLIF(prev_volume, 0)) * 100, 2) AS volume_growth_pct
FROM growth_series
WHERE prev_revenue IS NOT NULL
ORDER BY sales_month
LIMIT 10;
