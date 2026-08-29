CREATE OR REPLACE TABLE workspace.d5_clean.cleaned_playlist AS
SELECT
    PlaylistId,
    Name
FROM workspace.d5_raw.raw_playlist

