# Chinook Dimensional Model

Group homework project converting the normalized Chinook dataset into a
star schema to answer business questions, following a
Raw → Clean → Mart pipeline in Databricks.

## Structure
- `sql/02_clean/` — cleaning scripts (nulls, dedup, standardization)
- `sql/03_mart/` — dimension and fact table definitions
- `sql/04_analysis/` — one query per business question

## Star Schema
See `schema_diagram.png` for the current agreed model.

Fact table grain: one row per invoice line.

Dimensions: Customer, Employee, Track, Date

## Business Questions
1. Top Revenue by Genre per Country
2. Customer Segmentation by Spending Tier
3. Monthly Sales Trend
4. Employee Sales Performance
5. Popular Tracks by Quantity Sold
6. Regional Pricing Insights

## Workflow
1. Pull latest `main` before starting
2. Branch per task
3. Match table names to what's already in `sql/03_mart/`
4. Push + PR before merging
