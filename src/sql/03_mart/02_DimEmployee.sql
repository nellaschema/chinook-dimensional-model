-- Create Employee Dimension
CREATE OR REPLACE TABLE d5_mart.DimEmployee AS
SELECT
    EmployeeId,
    FirstName,
    LastName,
    Title,
    HireDate
FROM d5_clean.cleaned_employee;
