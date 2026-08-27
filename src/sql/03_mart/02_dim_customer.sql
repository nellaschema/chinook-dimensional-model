-- Create the Customer Dimension

CREATE OR REPLACE TABLE d5_mart.DimCustomer AS
SELECT
    CustomerId,
    FirstName,
    LastName,
    Company,
    City,
    State,
    Country,
    PostalCode
FROM d5_clean.cleaned_customer;
