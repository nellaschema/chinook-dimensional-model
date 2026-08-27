-- TOP-GROSSING GENRE BY CUSTOMER COUNTRY
-- Purpose:
--   Identify the genre with the highest total revenue within each customer country.
--
-- Logic:
--   1. Join Genre to Track to determine the genre of each track.
--   2. Join Track to InvoiceLine to calculate revenue.
--   3. Join InvoiceLine to Invoice to identify the customer.
--   4. Join Invoice to Customer to obtain the customer's country.
--   5. Aggregate revenue by genre and customer country.
--   6. Rank genres within each country based on total revenue.
--   7. Return the highest-revenue genre(s) per country.
--
-- Note:
--   Customer.Country is used instead of Invoice.BillingCountry because Country is already available in DimCustomer.
--   This avoids duplicating country information in the fact table.
--   Therefore, the result represents revenue by CUSTOMER COUNTRY, not necessarily invoice billing country.
--
--   RANK() is used so that all genres tied for the highest revenue within a country are retained.

-- Highest TOTAL REVENUE per GENRE per COUNTRY - replace table names
SELECT *
FROM (
    SELECT
        customer_country,
        genre,
        total_revenue,
        RANK() OVER (PARTITION BY customer_country ORDER BY total_revenue DESC) AS revenue_rank
    FROM (
        SELECT  
            genre.GenreName AS genre, 
            ROUND(SUM(inv_line.UnitPrice * inv_line.Quantity),2) AS total_revenue,
            customer.Country AS customer_country
        FROM workspace.d5_clean.cleaned_genre AS genre
        INNER JOIN workspace.d5_clean.cleaned_track AS track
            ON genre.GenreId = track.GenreId
        INNER JOIN workspace.d5_clean.cleaned_invoice_line AS inv_line
            ON track.TrackID = inv_line.TrackId
        INNER JOIN workspace.d5_clean.cleaned_invoice AS invoice
            ON invoice.InvoiceId = inv_line.InvoiceId
        INNER JOIN workspace.d5_clean.cleaned_customer AS customer
            ON invoice.CustomerId = customer.CustomerId
        GROUP BY genre.GenreName, customer.Country
        HAVING SUM(inv_line.UnitPrice * inv_line.Quantity) > 0
    ) AS sub 
) AS ranked
WHERE revenue_rank = 1
ORDER BY total_revenue DESC;
