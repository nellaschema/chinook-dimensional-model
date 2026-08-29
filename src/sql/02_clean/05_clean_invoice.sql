CREATE OR REPLACE TABLE workspace.d5_clean.cleaned_track AS
SELECT DISTINCT
    CAST(TrackId AS INT) AS TrackId,
    Name AS TrackName,
    CAST(AlbumId AS INT) AS AlbumId,
    CAST(MediaTypeId AS INT) AS MediaTypeId,
    CAST(GenreId AS INT) AS GenreId,
    Composer,
    CAST(Milliseconds AS INT) AS Milliseconds,
    CAST(UnitPrice AS DECIMAL(10,2)) AS UnitPrice
FROM workspace.d5_raw.raw_track
WHERE TrackId IS NOT NULL
  AND UnitPrice IS NOT NULL;
