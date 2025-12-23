# 🧥 Case Study 7: Balanced Tree Clothing Co. (8 Week SQL Challenge)

## 📌 Overview
This project is part of the **8 Week SQL Challenge** by Danny Ma.  
The **Balanced Tree Clothing Co.** case study focuses on analyzing **retail sales performance** using a structured **product hierarchy** and **transactional sales data** in **MySQL**.

The analysis demonstrates how to work with:
- Hierarchical product data
- Fact and dimension tables
- Revenue and discount calculations
- Member vs non-member analysis

---

## 🧰 Tools & Technologies
- **Database:** MySQL  
- **IDE:** MySQL Workbench  
- **Concepts Used:**
  - Primary & Foreign Keys
  - Self-referencing (hierarchical) tables
  - Fact–dimension data modeling
  - Aggregations
  - Window functions
  - Business revenue analysis

---

## 🗂️ Database Schema

### 1️⃣ product_hierarchy
Stores the full product hierarchy (Category → Segment → Product).

| Column Name | Description |
|------------|------------|
| id | Unique identifier |
| parent_id | Parent hierarchy reference |
| level_text | Level type (Category / Segment / Product) |
| level_name | Name of the level |

**Primary Key:** `id`  
**Foreign Key:** `parent_id → product_hierarchy(id)` (self-referencing)

---

### 2️⃣ product_prices
Stores pricing information for each product.

| Column Name | Description |
|------------|------------|
| product_id | Product identifier |
| price | Product price |

**Primary Key:** `product_id`  
**Foreign Key:** `product_id → product_hierarchy(id)`

---

### 3️⃣ sales (Fact Table)
Stores all transaction-level sales data.

| Column Name | Description |
|------------|------------|
| txn_id | Transaction identifier |
| prod_id | Product sold |
| qty | Quantity sold |
| price | Unit price |
| discount | Discount percentage |
| member | Member purchase flag |

**Foreign Key:** `prod_id → product_prices(product_id)`

---

## 🔗 Data Model
The schema follows a **fact–dimension design**:
- `sales` acts as the **fact table**
- `product_hierarchy` and `product_prices` act as **dimension tables**

This design ensures:
- Data integrity
- Clean joins
- Scalable analytics

---

## 📊 Business Questions Answered

### 🔹 High-Level Sales Analysis
- Total quantity sold
- Total revenue before discounts
- Total discount amount

---

### 🔹 Transaction Analysis
- Number of unique transactions
- Average products per transaction
- Average discount per transaction
- Member vs non-member transaction split

---

### 🔹 Product & Category Analysis
- Top 3 products by revenue
- Revenue by product category
- Revenue by product segment
- Top-selling product per segment
- Revenue split by membership status

---

## 🔍 Key SQL Techniques Used
- `SUM()`, `COUNT()`, `AVG()`
- `GROUP BY`
- Hierarchical joins
- Window functions (`RANK() OVER`)
- Revenue & discount calculations
- Fact–dimension joins

---

## 🚀 How to Run
1. Open **MySQL Workbench**
2. Run `Balanced-Tree-Setup.sql`
3. Insert data using `Balanced-Tree-Inserts.sql`
4. Execute queries from `Balanced-Tree-Solutions.sql`
5. Validate results using SELECT queries

---

## 🧠 Key Learnings
- How to model hierarchical product data
- How to design fact and dimension tables
- How to analyze revenue and discounts
- How to apply window functions in business analytics
- How retail analytics is performed in real-world systems

---

## 📎 Reference
- Official Case Study: https://8weeksqlchallenge.com/case-study-7/

---

## 👤 Author
**Mohammed Hayath RK**  
Data Analytics | MySQL
