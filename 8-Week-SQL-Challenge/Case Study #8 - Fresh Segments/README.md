# 📊 Case Study 8: Fresh Segments (8 Week SQL Challenge)

## 📌 Overview
This project is part of the **8 Week SQL Challenge** by Danny Ma.  
The **Fresh Segments** case study focuses on **marketing analytics**, analyzing how different customer interest segments perform over time using **monthly metrics**.

The objective is to understand:
- Interest popularity
- Ranking trends
- Composition and index performance
- Time-based analysis of marketing segments

This case study represents **real-world marketing and growth analytics**.

---

## 🧰 Tools & Technologies
- **Database:** MySQL  
- **IDE:** MySQL Workbench  
- **Concepts Used:**
  - Fact & Dimension modeling
  - Composite Primary Keys
  - Foreign Keys & Relationships
  - Time-series analysis
  - Window functions
  - Ranking & aggregation

---

## 🗂️ Database Schema

### 1️⃣ interest_map (Dimension Table)
Stores metadata for each interest segment.

| Column Name | Description |
|------------|------------|
| interest_id | Unique interest identifier |
| interest_name | Name of the interest |
| interest_summary | Description of the interest |
| created_at | Interest creation date |

**Primary Key:** `interest_id`

---

### 2️⃣ interest_metrics (Fact Table)
Stores monthly performance metrics for each interest.

| Column Name | Description |
|------------|------------|
| interest_id | Interest identifier |
| month_year | Month of record |
| composition | Segment composition percentage |
| index_value | Performance index |
| ranking | Rank for the month |
| percentile_ranking | Percentile rank |

**Primary Key:** `(interest_id, month_year)`  
**Foreign Key:** `interest_id → interest_map(interest_id)`

---

## 🔗 Data Model
The schema follows a **fact–dimension design**:
- `interest_map` → Dimension table
- `interest_metrics` → Fact table with time-series data

This design ensures:
- No duplicate monthly records
- Strong data integrity
- Scalable analytics

---

## 📊 Business Questions Answered

### 🔹 Data Exploration
- Total number of interests
- Total monthly records
- Interests present in all months
- Interests appearing in fewer months

---

### 🔹 Ranking Analysis
- Top and bottom interests by average composition
- Worst-performing interests by ranking
- Interests with high average index values

---

### 🔹 Time-Based Analysis
- Top interest per month
- Interests appearing most frequently in the top 3
- Month with highest average composition

---

## 🔍 Key SQL Techniques Used
- `COUNT()`, `AVG()`, `SUM()`
- `GROUP BY` & `HAVING`
- Composite primary keys
- Window functions (`RANK() OVER`)
- Time-series aggregation
- Fact–dimension joins

---

---

## 🚀 How to Run
1. Open **MySQL Workbench**
2. Run `Fresh-Segments-Setup.sql`
3. Insert data using `Fresh-Segments-Inserts.sql`
4. Execute queries from `Fresh-Segments-Solutions.sql`
5. Validate results using SELECT queries

---

## 🧠 Key Learnings
- How to analyze marketing interest segments
- How to design time-series fact tables
- How to use window functions for ranking analysis
- How marketing analytics is performed in real businesses
- How to structure SQL projects professionally for GitHub

---

## 📎 Reference
- Official Case Study: https://8weeksqlchallenge.com/case-study-8/

---

## 👤 Author
**Mohammed Hayath RK**  
Data Analytics | MySQL
