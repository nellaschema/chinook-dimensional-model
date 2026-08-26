--- github

-- Create artist table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_artist AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Artist.csv',
format => 'csv',
header => true,
schema => 'ArtistId INT, Name STRING'
);

-- Create album table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_album AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Album.csv',
format => 'csv',
header => true,
schema => 'AlbumId INT, Title STRING, ArtistId INT'
);


-- Create customer table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_customer AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Customer.csv',
format => 'csv',
header => true,
schema => 'CustomerId INT, FirstName STRING,LastName STRING,Company STRING,Address STRING,City STRING,State STRING,Country STRING,PostalCode INT,Phone STRING, Fax STRING, Email STRING,SupportRepId INT'
);

-- Create employee table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_employee AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Employee.csv',
format => 'csv',
header => true,
schema => 'EmployeeId INT, LastName STRING, FirstName STRING, Title STRING, ReportsTo INT, BirthDate DATE, HireDate DATE, Address STRING, City STRING, State STRING, Country STRING, PostalCode STRING, Phone STRING, Fax STRING, Email STRING'
);


-- Create genre table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_genre AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Genre.csv',
format => 'csv',
header => true,
schema => 'GenreId INT, Name STRING'
);


-- Create invoice table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_invoice AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Invoice.csv',
format => 'csv',
header => true,
schema => 'InvoiceId INT, CustomerId INT, InvoiceDate DATE, BillingAddress STRING, BillingCity STRING, BillingState STRING, BillingCountry STRING, BillingPostalCode STRING, Total DOUBLE'
);


-- Create invoice line table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_invoiceline AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/InvoiceLine.csv',
format => 'csv',
header => true,
schema => 'InvoiceLineId INT, InvoiceId INT, TrackId INT, UnitPrice DOUBLE, Quantity INT'
);


-- Create media type table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_mediatype AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/MediaType.csv',
format => 'csv',
header => true,
schema => 'MediaTypeId INT, Name STRING'
);

-- Count rows
SELECT DISTINCT COUNT(*) as row_count
FROM workspace.d5_raw.raw_mediatype;


-- Create playlist table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_playlist AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Playlist.csv',
format => 'csv',
header => true,
schema => 'PlaylistId INT, Name STRING'
);


-- Create playlist track table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_playlisttrack AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/PlaylistTrack.csv',
format => 'csv',
header => true,
schema => 'PlaylistId INT, TrackId INT'
);



-- Create track table
CREATE OR REPLACE TABLE workspace.d5_raw.raw_track AS
SELECT *
FROM read_files(
'/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Track.csv',
format => 'csv',
header => true,
schema => 'TrackId INT, Name STRING, AlbumId INT, MediaTypeId INT, GenreId INT, Composer STRING, Milliseconds INT, Bytes INT, UnitPrice DOUBLE'
);



-- Count all rows from all tables
SELECT 'raw_track' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_track

UNION ALL

SELECT 'raw_playlisttrack' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_playlisttrack

UNION ALL

SELECT 'raw_playlist' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_playlist

UNION ALL

SELECT 'raw_mediatype' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_mediatype

UNION ALL

SELECT 'raw_invoiceline' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_invoiceline

UNION ALL

SELECT 'raw_invoice' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_invoice

UNION ALL

SELECT 'raw_genre' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_genre

UNION ALL

SELECT 'raw_employee' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_employee

UNION ALL

SELECT 'raw_customer' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_customer

UNION ALL

SELECT 'raw_album' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_album

UNION ALL

SELECT 'raw_artist' AS table_name, COUNT(*) as row_count
FROM workspace.d5_raw.raw_artist;