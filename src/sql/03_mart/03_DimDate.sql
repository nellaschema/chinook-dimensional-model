CREATE OR REPLACE TABLE d5_mart.DimDate AS
SELECT DISTINCT
    DATE(InvoiceDate) AS InvoiceDate,
    YEAR(InvoiceDate) AS Year,
    QUARTER(InvoiceDate) AS QuarterNumber,
    CONCAT('Q',QUARTER(InvoiceDate)) AS QuarterName,
    MONTHNAME(InvoiceDate) AS Month,
    MONTH(InvoiceDate) AS MonthNumber
FROM d5_clean.cleaned_invoice;
