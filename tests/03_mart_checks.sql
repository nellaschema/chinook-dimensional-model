SELECT
    'DimCustomer' AS table_name,
    COUNT(*) AS total_rows,
    COUNT(DISTINCT CustomerId) AS distinct_keys,
    SUM(CASE WHEN CustomerId IS NULL THEN 1 ELSE 0 END) AS null_keys,
    COUNT(*) - COUNT(DISTINCT CustomerId) AS duplicate_keys
FROM d5_mart.DimCustomer

UNION ALL

SELECT
    'DimEmployee',
    COUNT(*),
    COUNT(DISTINCT EmployeeId),
    SUM(CASE WHEN EmployeeId IS NULL THEN 1 ELSE 0 END),
    COUNT(*) - COUNT(DISTINCT EmployeeId)
FROM d5_mart.dimemployee

UNION ALL

SELECT
    'DimMusic',
    COUNT(*),
    COUNT(DISTINCT TrackId),
    SUM(CASE WHEN TrackId IS NULL THEN 1 ELSE 0 END),
    COUNT(*) - COUNT(DISTINCT TrackId)
FROM d5_mart.dimmusic

UNION ALL

SELECT
    'DimDate',
    COUNT(*),
    COUNT(DISTINCT InvoiceDate),
    SUM(CASE WHEN InvoiceDate IS NULL THEN 1 ELSE 0 END),
    COUNT(*) - COUNT(DISTINCT InvoiceDate)
FROM d5_mart.dimdate

UNION ALL

SELECT
    'FactSales',
    COUNT(*),
    COUNT(DISTINCT InvoiceLineId),
    SUM(CASE WHEN InvoiceLineId IS NULL THEN 1 ELSE 0 END),
    COUNT(*) - COUNT(DISTINCT InvoiceLineId)
FROM d5_mart.factsales

UNION ALL

-- Check orphan CustomerId
SELECT
    'fact_sales - orphan_customer',
    COUNT(*),
    NULL,
    NULL,
    NULL
FROM d5_mart.factsales f
LEFT JOIN d5_mart.dimcustomer c
    ON f.CustomerId = c.CustomerId
WHERE c.CustomerId IS NULL

UNION ALL

-- Check orphan EmployeeId
SELECT
    'fact_sales - orphan_employee',
    COUNT(*),
    NULL,
    NULL,
    NULL
FROM d5_mart.FactSales f
LEFT JOIN d5_mart.dimemployee e
    ON f.EmployeeId = e.EmployeeId
WHERE e.EmployeeId IS NULL

UNION ALL

-- Check orphan TrackId
SELECT
    'fact_sales - orphan_music',
    COUNT(*),
    NULL,
    NULL,
    NULL
FROM d5_mart.FactSales f
LEFT JOIN d5_mart.DimMusic m
    ON f.TrackId = m.TrackId
WHERE m.TrackId IS NULL

UNION ALL

-- Check orphan date
SELECT
    'fact_sales - orphan_date',
    COUNT(*),
    NULL,
    NULL,
    NULL
FROM d5_mart.FactSales f
LEFT JOIN d5_mart.DimDate d
    ON f.InvoiceDate = d.InvoiceDate
WHERE d.InvoiceDate IS NULL;
