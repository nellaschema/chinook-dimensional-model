-- Highest TOTAL REVENUE per GENRE per COUNTRY

CREATE OR REPLACE TABLE workspace.d5_analysis.top_genre_by_customer_country AS

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
