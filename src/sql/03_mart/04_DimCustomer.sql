
-- Create the Customer dimension table from cleaned Customer data

CREATE OR REPLACE TABLE workspace.d5_mart.DimCustomer AS
SELECT
    CustomerId,
    CONCAT(FirstName, ' ', LastName) AS CustomerName,
    Company,
    City,
    State,
    Country,
    PostalCode
FROM workspace.d5_clean.cleaned_customer;
