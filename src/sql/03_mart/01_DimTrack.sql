
--updated
CREATE OR REPLACE TABLE d5_mart.dimmusic AS
SELECT
    t.TrackId,
    t.TrackName,
    CASE 
        WHEN al.AlbumTitle IS NULL THEN 'Unknown'
        ELSE al.AlbumTitle
    END AS AlbumTitle,
    CASE 
        WHEN ar.Name IS NULL THEN 'Unknown'
        ELSE ar.Name
    END AS ArtistName,
    CASE
        WHEN g.GenreName IS NULL THEN 'Unknown'
        ELSE g.GenreName
    END AS GenreName,
    mt.Name AS MediaTypeName
FROM workspace.d5_clean.cleaned_track t
JOIN workspace.d5_clean.cleaned_album al    ON t.AlbumId = al.AlbumId
JOIN workspace.d5_clean.cleaned_artist ar   ON al.ArtistId = ar.ArtistID
JOIN workspace.d5_clean.cleaned_genre g     ON t.GenreId = g.GenreId
JOIN workspace.d5_clean.cleaned_mediatype mt ON t.MediaTypeId = mt.MediaTypeId;
