# 🛒 Case Study 5: Data Mart (8 Week SQL Challenge)

## 📌 Overview
This project is part of the **8 Week SQL Challenge** by Danny Ma.  
The **Data Mart** case study focuses on analyzing weekly sales data to measure the **business impact of changes** using **MySQL**.

The analysis covers:
- Data cleaning
- Sales performance analysis
- Before vs After comparison
- Business impact storytelling using SQL

---

## 🧰 Tools & Technologies
- **Database:** MySQL
- **IDE:** MySQL Workbench
- **Concepts Used:**
  - Aggregations
  - Date functions
  - Conditional logic (`CASE`)
  - CTEs
  - Percentage calculations
  - Business impact analysis

---

## 🗂️ Dataset Description

### Table: `weekly_sales`

| Column Name | Description |
|------------|-------------|
| week_date | Start date of the sales week |
| region | Sales region |
| platform | Retail or Shopify |
| segment | Customer segment (C1, C2, etc.) |
| customer_type | New or Existing customer |
| transactions | Number of transactions |
| sales | Total sales value |

Each row represents **weekly sales performance by customer segment**.

---

## 🔹 Section A: Data Cleaning
The following transformations were applied:
- Extracted:
  - Week number
  - Month number
  - Calendar year
- Handled NULL values using `COALESCE`
- Created derived columns:
  - `age_band`
  - `demographic`
- Calculated average transaction value

---

## 🔹 Section B: Data Exploration
Key business insights generated:
- Total sales by region
- Total and percentage sales by platform
- Sales contribution by customer type
- Performance by customer segment

---

## 🔹 Section C: Before & After Analysis
A major business change occurred on **2020-06-15**.

Analysis includes:
- Total sales before vs after the change
- Absolute and percentage sales impact
- Sales comparison by:
  - Region
  - Platform
  - Customer type

This section demonstrates **real-world business impact analysis**.

---

## 🔍 Key SQL Techniques Used
- `SUM()`, `COUNT()`
- `GROUP BY`
- `CASE WHEN`
- `COALESCE()`
- Date functions: `WEEK()`, `MONTH()`, `YEAR()`
- Common Table Expressions (CTEs)
- Percentage change calculations
