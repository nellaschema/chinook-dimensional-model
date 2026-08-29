-- Group customers into tiers (High, Medium, Low) based on their total spend — how many customers fall into each tier?
-- Threshold is based on the Equal Distribution (Thirds) 
-- Low: < $39 (below average)
-- Medium: $39 - $43 (average to 90th percentile)
-- High: > $43 (top 10%)

CREATE OR REPLACE TABLE d5_analysis.customer_segmentation_by_spending_tier AS
WITH customer_spending AS (
  SELECT 
    c.CustomerId,
    c.CustomerName,
    c.Country,
    SUM(f.LineAmount) AS total_spend
  FROM workspace.d5_mart.dimcustomer c
  INNER JOIN workspace.d5_mart.factsales f ON c.CustomerId = f.CustomerId
  GROUP BY c.CustomerId, c.CustomerName, c.Country
)
SELECT 
  CustomerId,
  CustomerName,
  Country,
  ROUND(total_spend, 2) AS total_spend,
  CASE 
    WHEN total_spend > 43 THEN 'High' 
    WHEN total_spend >= 39 THEN 'Medium'
    ELSE 'Low'
  END AS spending_tier
FROM customer_spending
ORDER BY total_spend DESC
