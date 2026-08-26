
-- SILVER TABLE CREATION
-- All source columns are retained in the Silver layer.
-- Source quality checks and issue investigations are documented separately in tests/source_checks.sql.

-- Modify/create remaining tables at the end of this query.


-- Create clean_track
-- Note:
-- Two Track records have missing UnitPrice values (TrackId 3475 and 3477). 
-- These values are retained as NULL because revenue analysis uses the transaction-level UnitPrice from InvoiceLine.
-- Therefore, the missing Track-level UnitPrice values do not affect the revenue analysis.

-- TrackId = 3477 has a valid transaction-level UnitPrice of 0.99 in InvoiceLine.
-- TrackId = 3475 has no corresponding InvoiceLine record.
--
CREATE OR REPLACE TABLE workspace.d5_silver.clean_track AS
SELECT
    TrackId,
    Name,
    AlbumId,
    MediaTypeId,
    GenreId,
    Composer,
    Milliseconds,
    Bytes,
    UnitPrice
FROM workspace.d5_raw.raw_track;

-- Create clean_invoice
CREATE OR REPLACE TABLE workspace.d5_silver.clean_invoice AS
SELECT
    InvoiceId,
    CustomerId,
    InvoiceDate,
    BillingAddress,
    BillingCity,
    BillingState,
    BillingCountry,
    BillingPostalCode,
    BillingPhone
FROM workspace.d5_raw.raw_invoice;

-- Create clean_invoiceline
CREATE OR REPLACE TABLE workspace.d5_silver.clean_invoiceline AS
SELECT
    InvoiceLineId,
    InvoiceId,
    TrackId,
    UnitPrice,
    Quantity
FROM workspace.d5_raw.raw_invoiceline;

-- Create clean_genre
CREATE OR REPLACE TABLE workspace.d5_silver.clean_genre AS
SELECT
    GenreId,
    Name
FROM workspace.d5_raw.raw_genre;


--Count all rows from all tables
SELECT 'clean_track' AS table_name, COUNT(*) AS row_count
FROM workspace.d5_silver.clean_track

UNION ALL

SELECT 'clean_invoice' AS table_name,  COUNT(*) AS row_count
FROM workspace.d5_silver.clean_invoice

UNION ALL

SELECT  'clean_invoiceline' AS table_name, COUNT(*) AS row_count
FROM workspace.d5_silver.clean_invoiceline

UNION ALL

SELECT  'clean_genre' AS table_name, COUNT(*) AS row_count
FROM workspace.d5_silver.clean_genre


-- Continue creating below.
