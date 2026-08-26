-- Modify this file/add queries as long as you're doing quality checks on the raw tables.

-- raw_invoice quality check
SELECT 
    COUNT(*) AS row_count,
    COUNT(DISTINCT InvoiceId) AS unique_invoiceid,
    COUNT(DISTINCT BillingCountry) AS unique_country,
    COUNT_IF(BillingCountry IS NULL) AS missing_countries,
    COUNT_IF(InvoiceDate IS NULL) AS missing_dates,
    COUNT_IF(InvoiceId IS NULL) AS missing_invoiceid
FROM workspace.d5_raw.raw_invoice;


-- raw_invoiceline quality check
SELECT 
    COUNT(*) AS row_count,
    COUNT(DISTINCT InvoiceLineId) AS unique_invoicelineid,
    COUNT(DISTINCT InvoiceId) AS unique_invoiceid,
    COUNT_IF(InvoiceLineId IS NULL) AS missing_invoicelineid,
    COUNT_IF(TrackId IS NULL) AS missing_trackid,
    COUNT_IF(InvoiceId IS NULL) AS missing_invoiceid,
    COUNT_IF(UnitPrice IS NULL) AS missing_unitprice,
    COUNT_IF(Quantity IS NULL) AS missing_quantity,
    COUNT_IF(UnitPrice < 0) AS negative_unitprice,
    COUNT_IF(Quantity <= 0) AS non_positive_quantity,
    COUNT_IF(UnitPrice * Quantity < 0) AS negative_line_revenue,
    MAX(Quantity) AS max_quantity,
    MIN(Quantity) AS min_quantity,
    AVG(Quantity) AS avg_quantity,
    MAX(UnitPrice) AS max_unitprice,
    MIN(UnitPrice) AS min_unitprice,
    AVG(UnitPrice) AS avg_unitprice
FROM workspace.d5_raw.raw_invoiceline;

-- Distribution of line-level revenue
SELECT 
    UnitPrice * Quantity AS line_revenue,
    COUNT(*) AS row_count
FROM workspace.d5_raw.raw_invoiceline
GROUP BY line_revenue;


-- raw_genre quality check
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT GenreId) AS unique_genreid,
    COUNT(DISTINCT Name) AS unique_genrename,
    COUNT_IF(GenreId IS NULL) AS missing_genreid,
    COUNT_IF(Name IS NULL) AS missing_genrename
FROM workspace.d5_raw.raw_genre;


-- raw_track quality check
SELECT
    COUNT(*) AS row_count,
    COUNT(DISTINCT TrackId) AS unique_trackid,
    COUNT(DISTINCT Name) AS unique_trackname,
    COUNT(DISTINCT AlbumId) AS unique_albumid,
    COUNT(DISTINCT MediaTypeId) AS unique_mediatypeid,
    COUNT(DISTINCT GenreId) AS unique_genreid,
    COUNT(DISTINCT Composer) AS unique_composer,
    COUNT(DISTINCT Milliseconds) AS unique_milliseconds,
    COUNT(DISTINCT Bytes) AS unique_bytes,
    COUNT(DISTINCT UnitPrice) AS unique_unitprice,
    COUNT_IF(TrackId IS NULL) AS missing_trackid,
    COUNT_IF(Name IS NULL) AS missing_trackname,
    COUNT_IF(AlbumId IS NULL) AS missing_albumid,
    COUNT_IF(MediaTypeId IS NULL) AS missing_mediatypeid,
    COUNT_IF(GenreId IS NULL) AS missing_genreid,
    COUNT_IF(Composer IS NULL) AS missing_composer,
    COUNT_IF(Milliseconds IS NULL) AS missing_milliseconds,
    COUNT_IF(Bytes IS NULL) AS missing_bytes,
    COUNT_IF(UnitPrice IS NULL) AS missing_unitprice
FROM workspace.d5_raw.raw_track

-- missing_albumid:     4
--missing_mediatypeid:  2
-- missing_composer:    977
-- missing_milliseconds: 1
-- missing_bytes:       4
-- missing_unitprice:   2


-- Investigate missing unit price
SELECT *
FROM workspace.d5_raw.raw_track
WHERE UnitPrice IS NULL;

-- Are these two tracks actually present in InvoiceLine?
SELECT *
FROM workspace.d5_raw.raw_invoiceline
WHERE TrackId = 3475 OR TrackId = 3477;

--TrackId = 3477 has a missing Track-level UnitPrice, but a valid transaction-level UnitPrice of 0.99 exists in InvoiceLine. Since revenue is calculated using InvoiceLine.UnitPrice, the missing Track-level UnitPrice does not affect the analysis.
-- For TrackId = 3475: No corresponding InvoiceLine exists, so the missing Track-level UnitPrice does not affect the revenue analysis.
