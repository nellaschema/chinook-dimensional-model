-- Apply all identified fixes and create the cleaned Customer table

-- ==================================================
-- Issues found in customer profiling, fixed below:
-- a. City: "Edinburgh " had a trailing space -> TRIM(City) fixes it
-- b. City: "Sidney" was a typo for "Sydney" -> CASE corrects it
-- c. State: "Dublin" was a city, not a valid state -> set to NULL
-- No other changes: Company, State (other), Fax, Phone, PostalCode nulls kept as-is (expected/optional)
-- ==================================================

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
