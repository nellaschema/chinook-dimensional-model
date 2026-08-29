

-- TOP 20 TRACKS BY QUANTITY SOLD
-- What are the top 20 tracks by total quantity sold, and which albums/artists do they belong to?

-- RANKING / TIE-BREAKING RULES:
-- 1. Primary:   Total quantity sold DESC
-- 2. Tie-break: Total revenue DESC
-- 3. Tie-break: TrackId ASC

-- STEP 1: Aggregate sales by track
CREATE OR REPLACE TABLE d5_analysis.top_tracks_by_quantity AS
WITH track_sales AS (
    SELECT
        fs.TrackId,
        SUM(fs.Quantity) AS total_units_sold,  -- Add all quantities sold for the track
        SUM(fs.LineAmount) AS total_revenue -- total revenue by each track
    FROM workspace.d5_mart.factsales fs
    WHERE fs.Quantity IS NOT NULL
    GROUP BY fs.TrackId    -- We need one aggregated result per track
),

-- STEP 2: Add track, album, and artist information
-- DimTrack is our DIMENSION table.
-- We only need: FactSales & DimTrack because TrackId is the common key.

track_with_dimensions AS (
    SELECT
        ts.TrackId,
        dm.TrackName,
        dm.AlbumTitle,
        dm.ArtistName,
        ts.total_units_sold,   -- Aggregated sales information from FactSales
        ts.total_revenue 
    FROM track_sales ts
    INNER JOIN workspace.d5_mart.dimmusic dm
        ON ts.TrackId = dm.TrackId
),

-- STEP 3: Rank the tracks
-- ROW_NUMBER() assigns a unique rank to every track. The primary ranking criterion is total_units_sold
-- TrackId is used as a tie-breaker so that the ranking remains deterministic when two tracks have the same quantity sold.

ranked_tracks AS (
    SELECT
        ROW_NUMBER() OVER (
            ORDER BY
                total_units_sold DESC,
                total_revenue DESC,
                TrackId ASC
        ) AS sales_rank,
        TrackId,
        TrackName,
        AlbumTitle,
        ArtistName,
        total_units_sold,
        total_revenue
    FROM track_with_dimensions
)

-- STEP 4: Return only the top 20 tracks
SELECT
    sales_rank,
    TrackId,
    TrackName,
    AlbumTitle,
    ArtistName,
    total_units_sold,
    total_revenue
FROM ranked_tracks
WHERE sales_rank <= 20
ORDER BY sales_rank;

--SELECT *
--FROM workspace.d5_analysis.top_tracks_by_quantity
--ORDER BY sales_rank;
