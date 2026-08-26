-- ============================================
-- WEEK 05: SOURCE INSPECTION
-- Dataset: Chinook
-- ============================================


-- ============================================
-- 1. ALBUM
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Album.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 2. ARTIST
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Artist.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 3. CUSTOMER
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Customer.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 4. EMPLOYEE
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Employee.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 5. GENRE
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Genre.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 6. INVOICE
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Invoice.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 7. INVOICE LINE
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/InvoiceLine.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 8. MEDIA TYPE
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/MediaType.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 9. PLAYLIST
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Playlist.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 10. PLAYLIST TRACK
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/PlaylistTrack.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;


-- ============================================
-- 11. TRACK
-- ============================================

SELECT *
FROM read_files(
    '/Volumes/workspace/default/chinook/shared/week05/chinook_csv/Track.csv',
    format => 'csv',
    header => true,
    inferSchema => true
)
LIMIT 5;