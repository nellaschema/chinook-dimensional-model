CREATE OR REPLACE TABLE workspace.d5_analysis.monthly_sales_trend AS
SELECT
    dd.Year,
    dd.Month,
    MONTH(dd.InvoiceDate) AS MonthNumber,
    CONCAT(LPAD(MONTH(dd.InvoiceDate), 2, '0'), ' - ', dd.Month) AS MonthSortLabel,  -- e.g. "01 - Jan"
    SUM(f.UnitPrice * f.Quantity) AS MonthlyRevenue,
    SUM(f.UnitPrice * f.Quantity) - LAG(SUM(f.UnitPrice * f.Quantity)) 
        OVER (ORDER BY dd.Year, MONTH(dd.InvoiceDate)) AS MoM_Change,
    ROUND(
      (SUM(f.UnitPrice * f.Quantity) - LAG(SUM(f.UnitPrice * f.Quantity)) OVER (ORDER BY dd.Year, MONTH(dd.InvoiceDate)))
      / LAG(SUM(f.UnitPrice * f.Quantity)) OVER (ORDER BY dd.Year, MONTH(dd.InvoiceDate)) * 100, 1
    ) AS MoM_PctChange

FROM workspace.d5_mart.FactSales f
JOIN workspace.d5_mart.DimDate dd ON f.InvoiceDate = dd.InvoiceDate
WHERE dd.Year >= (SELECT MAX(Year) FROM workspace.d5_mart.DimDate) - 1
GROUP BY dd.Year, dd.Month, MONTH(dd.InvoiceDate)
ORDER BY dd.Year, MonthNumber;
