CREATE OR REPLACE TABLE d5_analysis.regional_pricing_insights AS

-- Calculate average unit price and volume per country
WITH country_pricing AS (
    SELECT
        dc.Country,
        CAST(ROUND(AVG(fs.UnitPrice), 2) AS DECIMAL(10,2)) AS avg_unit_price,
        COUNT(*) AS line_item_count
    FROM d5_mart.FactSales fs
    JOIN d5_mart.DimCustomer dc
        ON fs.CustomerId = dc.CustomerId
    GROUP BY dc.Country
),

-- Calculate the overall benchmark price across all countries
benchmark AS (
    SELECT AVG(avg_unit_price) AS overall_avg_price
    FROM country_pricing
)

-- Combine country prices with the benchmark and flag how each compares
SELECT
    cp.Country,
    cp.avg_unit_price,
    cp.line_item_count,
    b.overall_avg_price,
    CAST(ROUND((cp.avg_unit_price / b.overall_avg_price) * 100, 1) AS DECIMAL(10,1)) AS price_index,
    CAST(ROUND(((cp.avg_unit_price / b.overall_avg_price) - 1) * 100, 1) AS DECIMAL(10,1)) AS pct_vs_benchmark,
    CASE
        WHEN cp.avg_unit_price > b.overall_avg_price * 1.02 THEN 'Above Benchmark'
        WHEN cp.avg_unit_price < b.overall_avg_price * 0.98 THEN 'Below Benchmark'
        ELSE 'Near Benchmark'
    END AS benchmark_category
FROM country_pricing cp
CROSS JOIN benchmark b
ORDER BY cp.avg_unit_price DESC;
