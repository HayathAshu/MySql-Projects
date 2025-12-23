# 🛍️ Case Study 6: Clique Bait (8 Week SQL Challenge)

## 📌 Overview
This project is part of the **8 Week SQL Challenge** by Danny Ma.  
The **Clique Bait** case study focuses on **event-based analytics** for an online retail business, analyzing how users move through the product funnel from **page views → add to cart → purchases** using **MySQL**.

This case study closely mirrors **real-world product analytics** problems.

---

## 🧰 Tools & Technologies
- **Database:** MySQL  
- **IDE:** MySQL Workbench  
- **Concepts Used:**
  - Table relationships & foreign keys
  - Event-based data modeling
  - Funnel analysis
  - Conditional aggregation
  - Conversion rate calculation
  - Joins across multiple tables

---

## 🗂️ Database Schema

### 1️⃣ users
Stores user-level information.

| Column Name | Description |
|-----------|-------------|
| user_id | Unique user identifier |
| cookie_id | Unique browser cookie |
| start_date | User signup date |

**Primary Key:** `user_id`  
**Unique:** `cookie_id`

---

### 2️⃣ event_identifier
Maps numeric event codes to readable event names.

| Column Name | Description |
|-----------|-------------|
| event_type | Event code |
| event_name | Event description |

**Primary Key:** `event_type`

---

### 3️⃣ page_hierarchy
Stores page and product category information.

| Column Name | Description |
|-----------|-------------|
| page_id | Unique page identifier |
| page_name | Page name |
| product_category | Product category |

**Primary Key:** `page_id`

---

### 4️⃣ events (Fact Table)
Captures all user interactions.

| Column Name | Description |
|-----------|-------------|
| visit_id | User session identifier |
| cookie_id | Links to users |
| page_id | Links to page hierarchy |
| event_type | Links to event identifier |
| sequence_number | Order of events in visit |
| event_time | Timestamp of event |

**Foreign Keys:**
- `cookie_id → users(cookie_id)`
- `event_type → event_identifier(event_type)`
- `page_id → page_hierarchy(page_id)`

---

## 🔗 Data Model
The schema follows a **fact–dimension structure**:
- `events` acts as the **fact table**
- `users`, `event_identifier`, and `page_hierarchy` act as **dimension tables**

This design ensures **data integrity and scalable analytics**.

---

## 📊 Business Questions Answered (12 Total)

### 🔹 Section A: Digital Analysis
1. Total number of users  
2. Number of cookies per user  
3. Total visits  
4. Total page views  
5. Add-to-cart events  
6. Purchases  

---

### 🔹 Section B: Product Funnel Analysis
7. Products viewed  
8. Products added to cart  
9. Products purchased  

---

### 🔹 Section C: Conversion Analysis
10. Funnel counts (Visit → Add to Cart → Purchase)  
11. Visit-to-purchase conversion rate  
12. Purchases by product category  

---

## 🔍 Key SQL Techniques Used
- `COUNT(DISTINCT ...)`
- Conditional aggregation using `CASE`
- Multi-table joins
- Funnel analysis logic
- Conversion rate calculation
- Fact & dimension table modeling
