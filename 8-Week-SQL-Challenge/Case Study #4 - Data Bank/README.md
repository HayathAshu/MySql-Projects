# 🏦 Case Study 4: Data Bank (8 Week SQL Challenge)

## 📌 Overview
This project is part of the **8 Week SQL Challenge** by Danny Ma.  
The **Data Bank** case study focuses on analyzing customer movements and transaction behavior in a fictional digital bank using **MySQL**.

The goal is to practice **real-world SQL analytics**, including:
- Customer allocation tracking
- Transaction analysis
- Running balances
- Percentiles and advanced window functions

---

## 🧰 Tools & Technologies
- **Database:** MySQL
- **Environment:** MySQL Workbench
- **Concepts:**  
  - Joins  
  - Aggregations  
  - Window Functions  
  - CTEs  
  - Date functions  
  - Percentile calculations  

---

## 🗂️ Database Schema

### 1️⃣ regions
Stores region information.

| Column Name | Data Type |
|------------|-----------|
| region_id  | INT (PK)  |
| region_name | VARCHAR |

---

### 2️⃣ customer_nodes
Tracks customer allocation to nodes over time.

| Column Name | Data Type |
|------------|-----------|
| customer_id | INT |
| region_id | INT (FK) |
| node_id | INT |
| start_date | DATE |
| end_date | DATE |

**Primary Key:** `(customer_id, node_id, start_date)`  
**Foreign Key:** `region_id → regions(region_id)`

---

### 3️⃣ customer_transactions
Stores all customer transactions.

| Column Name | Data Type |
|------------|-----------|
| txn_id | INT (PK, Auto Increment) |
| customer_id | INT |
| txn_date | DATE |
| txn_type | VARCHAR |
| txn_amount | INT |

---

## 📊 Business Questions Answered

### Section A: Customer Nodes Exploration
- Total number of unique nodes
- Nodes count per region
- Customers allocated per region
- Average reallocation days
- Median, 80th & 95th percentile of reallocation days per region

---

### Section B: Customer Transactions
- Transaction count and total amount by type
- Average deposit behavior per customer
- Monthly customer activity analysis
- Closing balance per customer per month
- Percentage of customers with:
  - Balance increase > 5%
  - Balance decrease > 5%
  - No significant balance change

---

## 🔍 Key SQL Techniques Used
- `COUNT(DISTINCT ...)`
- `DATEDIFF()`
- Conditional aggregation using `CASE`
- Window functions:
  - `SUM() OVER()`
  - `ROW_NUMBER()`
  - `RANK()`
- Common Table Expressions (CTEs)
- Percentile calculation without built-in functions (MySQL workaround)
