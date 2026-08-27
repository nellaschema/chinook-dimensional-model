-- Apply Invoice fixes, type-casting, and join with InvoiceLine to create the combined cleaned Sales table

-- ==================================================
-- Issues found in Invoice profiling, fixed below:
-- a. BillingCity: "Edinburgh " had a trailing space -> TRIM(BillingCity) fixes it
-- b. BillingCity: "Sidney" was a typo for "Sydney" -> CASE corrects it
-- c. BillingState: "Dublin" was a city, not a valid state -> set to NULL
-- Also: type-casting enforced on all fields, TRIM applied to text fields
-- No other changes: BillingState (other), BillingPostalCode nulls kept as-is (expected/optional)
-- Invoice_Line: no issues found, joined as-is
-- Join: Invoice 1-to-many InvoiceLine via InvoiceId
-- ==================================================

CREATE OR REPLACE TABLE d5_clean.cleaned_sales AS
SELECT
    CAST(il.InvoiceLineId AS INT) AS InvoiceLineId,
    CAST(i.InvoiceId AS INT) AS InvoiceId,
    CAST(i.CustomerId AS INT) AS CustomerId,
    CAST(i.InvoiceDate AS TIMESTAMP) AS InvoiceDate,
    TRIM(i.BillingAddress) AS BillingAddress,
    CASE 
        WHEN TRIM(i.BillingCity) = 'Sidney' THEN 'Sydney'   -- fix: typo correction
        ELSE TRIM(i.BillingCity)                            -- fix: remove trailing/leading whitespace
    END AS BillingCity,
    CASE 
        WHEN TRIM(i.BillingState) = 'Dublin' THEN NULL      -- fix: invalid city-as-state value
        ELSE TRIM(i.BillingState)
    END AS BillingState,
    TRIM(i.BillingCountry) AS BillingCountry,
    TRIM(i.BillingPostalCode) AS BillingPostalCode,
    CAST(i.Total AS DECIMAL(10,2)) AS Total,
    CAST(il.TrackId AS INT) AS TrackId,
    CAST(il.UnitPrice AS DECIMAL(10,2)) AS UnitPrice,
    CAST(il.Quantity AS INT) AS Quantity
FROM d5_raw.raw_invoice i
JOIN d5_raw.raw_invoiceline il
    ON i.InvoiceId = il.InvoiceId;
