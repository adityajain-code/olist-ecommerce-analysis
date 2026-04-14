# Olist E-Commerce SQL Analysis

Exploratory data analysis of 100,000+ real Brazilian e-commerce orders using MySQL.
Dataset sourced from [Kaggle](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce).

## Business Questions & Key Findings

### 1. Sales & Revenue Trends
**How has monthly revenue trended over time?**

Revenue grew consistently from late 2016 through 2017, peaking at ~R$1.15M in
November 2017 — likely driven by Black Friday. Growth plateaued through early 2018
with monthly revenue stabilizing between R$966K and R$1.13M before the dataset ends
in August 2018.

### 2. Delivery Performance
**How often are orders delivered late, and which states have the worst on-time delivery rate?**

Out of 96,478 delivered orders, 7,826 (8.1%) were delivered late. The states with
the highest late delivery rates were AL (23.93%), MA (19.67%), and PI (15.97%) —
all in Brazil's northeastern region, suggesting a regional logistics gap.

### 3. Customer Satisfaction
**What is the relationship between delivery time and review scores?**

A clear inverse relationship exists between delivery time and satisfaction. Customers
who gave 1-star reviews waited an average of 21.3 days, while 5-star reviewers waited
only 10.6 days — a 2x difference. Faster delivery is the single strongest driver of
positive reviews in this dataset.

### 4. Seller Performance
**Who are the top 10 sellers by revenue, and how do their review scores compare?**

The top seller generated R$245,165 in revenue with a 4.14 avg review score. Notably,
high revenue does not guarantee high satisfaction — the 2nd highest seller earned
R$235,865 but had a below-average score of 3.35, suggesting volume-quality tradeoffs
among top performers.

### 5. Running Total of Monthly Revenue
**What is the cumulative revenue growth over time?**

Total cumulative revenue reached ~R$15.4M by August 2018. The running total shows
the steepest growth period was between January and November 2017, where cumulative
revenue grew from R$174K to R$6.1M — the core expansion phase of the business.

### 6. Seller Revenue Rank
**How do all sellers rank against each other by total revenue?**

2,951 active sellers were ranked by total revenue. The top seller generated R$247,007
while the revenue drop-off is steep — by rank 20 revenue falls to R$83,031, suggesting
a small group of high-performing sellers drives a disproportionate share of total sales.

### 7. Month-over-Month Revenue Growth
**How did revenue change month over month?**

The most explosive growth occurred in January 2017 (+649,557%) as the platform was
just gaining traction from near-zero. After stabilizing, growth was mostly positive
through mid-2017 before plateauing in 2018 with growth rates fluctuating between
-10% and +16%, indicating a maturing business with consistent but slower expansion.

## Database
- Tool: MySQL 8
- Tables: 9
- Rows: ~500,000+

## Structure
```text
sql/
├── schema.sql
├── load_data.sql
└── analysis/
    ├── 01_sales_revenue_trends.sql
    ├── 02_delivery_performance.sql
    ├── 03_customer_satisfaction.sql
    └── 04_seller_performance.sql
```

## Dataset
[Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)