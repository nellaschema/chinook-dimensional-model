CREATE OR REPLACE TABLE workspace.d5_clean.cleaned_customer AS
SELECT
    CustomerId,
    FirstName,
    LastName,
    Company,
    Address,
    CASE 
        WHEN TRIM(City) = 'Sidney' THEN 'Sydney'   -- fix: typo correction
        ELSE TRIM(City)                            -- fix: remove trailing/leading whitespace
    END AS City,
    CASE 
        WHEN State = 'Dublin' THEN NULL            -- fix: invalid city-as-state value
        ELSE State
    END AS State,
    Country,
    PostalCode,
    Phone,
    Fax,
    Email,
    SupportRepId
FROM d5_raw.raw_customer;

