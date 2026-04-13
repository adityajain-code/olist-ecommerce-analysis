# Olist E-Commerce SQL Analysis

Exploratory data analysis of 100k+ real Brazilian e-commerce orders
using MySQL. Dataset sourced from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

## Business Questions

1. **Sales & Revenue Trends** — How has monthly revenue trended over time, and which months were strongest?
2. **Delivery Performance** — How often are orders delivered late, and which states have the worst performance?
3. **Customer Satisfaction** — What is the relationship between delivery time and review scores?
4. **Seller Performance** — Who are the top sellers by revenue, and how do their review scores compare?

## Database
- Tool: MySQL 8
- Tables: 9
- Rows: ~500,000+

## Structure
- `sql/schema.sql` — Database and table definitions
- `sql/load_data.sql` — Load data into tables
- `sql/analysis/` — Analysis queries by business question