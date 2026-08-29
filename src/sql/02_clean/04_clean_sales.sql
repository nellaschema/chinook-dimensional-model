
CREATE OR REPLACE TABLE workspace.d5_clean.cleaned_mediatype AS(
SELECT
   MediaTypeId ,
    Name 
FROM workspace.d5_raw.raw_mediatype

)


