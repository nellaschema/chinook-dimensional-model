CREATE OR REPLACE TABLE workspace.d5_analysis.sales_employee_performance AS

-- Calculate revenue per employee per quarter
WITH employee_sales AS (
    SELECT
        dd.Year,
        dd.QuarterName AS Quarter,
        CONCAT(de.FirstName, ' ', de.LastName) AS Employee_Name,
        SUM(fs.LineAmount) AS Total_Revenue
    FROM d5_mart.FactSales fs
    JOIN d5_mart.DimDate dd
        ON fs.InvoiceDate = dd.InvoiceDate
    JOIN d5_mart.DimEmployee de
        ON fs.EmployeeId = de.EmployeeId
    GROUP BY
        dd.Year,
        dd.QuarterName,
        CONCAT(de.FirstName, ' ', de.LastName)
),

-- Rank employees within each year and quarter
ranked_sales AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY Year, Quarter
            ORDER BY Total_Revenue DESC
        ) AS Revenue_Rank
    FROM employee_sales
)

SELECT
    CONCAT(Year, ' ', Quarter) AS Year_Quarter,
    Employee_Name,
    Total_Revenue,
    Revenue_Rank
FROM ranked_sales
ORDER BY
    Year,
    Quarter;
