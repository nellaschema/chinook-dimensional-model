-- Create FactSales
CREATE OR REPLACE TABLE d5_mart.FactSales AS

SELECT
    il.InvoiceLineID,
    il.InvoiceId,
    i.CustomerId,
    c.SupportRepId AS EmployeeId,
    il.TrackId,
    DATE(i.InvoiceDate) AS InvoiceDate,
    il.Quantity,
    il.UnitPrice,
    il.Quantity*il.UnitPrice AS LineAmount
FROM d5_clean.cleaned_invoice_line il
JOIN d5_clean.cleaned_invoice i
    ON il.InvoiceId = i.InvoiceId
JOIN d5_clean.cleaned_customer c
    ON i.CustomerId = c.CustomerId;
