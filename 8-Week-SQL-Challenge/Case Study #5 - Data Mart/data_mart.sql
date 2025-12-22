create database if not exists data_mart;
use data_mart;	

CREATE TABLE weekly_sales (
  week_date DATE,
  region VARCHAR(20),
  platform VARCHAR(20),
  segment VARCHAR(20),
  customer_type VARCHAR(20),
  transactions INT,
  sales INT
);

INSERT INTO weekly_sales VALUES
('2020-06-01','ASIA','Retail','C1','New',100,5000),
('2020-06-01','ASIA','Retail','C2','Existing',80,4200),
('2020-06-01','EUROPE','Shopify','C1','New',90,4800),
('2020-06-08','ASIA','Retail','C1','Existing',120,6200),
('2020-06-08','ASIA','Shopify','C2','New',70,3500),
('2020-06-15','ASIA','Retail','C1','New',110,5800),
('2020-06-15','EUROPE','Retail','C2','Existing',95,5100),
('2020-06-22','ASIA','Shopify','C1','New',130,6900),
('2020-06-22','EUROPE','Retail','C1','Existing',85,4600),
('2020-06-29','ASIA','Retail','C2','Existing',140,7300);

SELECT * FROM weekly_sales;

# ----------------- SECTION A: Data Cleaning ---------------------

# 1. Add a week_number column
SELECT
  week_date,
  WEEK(week_date, 3) AS week_number
FROM weekly_sales;

# 2. Add month_number column
SELECT
  week_date,
  MONTH(week_date) AS month_number
FROM weekly_sales;

# 3.  Add calendar_year
SELECT
  week_date,
  YEAR(week_date) AS calendar_year
FROM weekly_sales;

# 4. Clean segment column (NULL handling)
SELECT
	*,
  COALESCE(segment, 'Unknown') AS segment
FROM weekly_sales;

# 5. Add age_band column
SELECT
  segment,
  CASE
    WHEN segment = 'C1' THEN 'Young Adults'
    WHEN segment = 'C2' THEN 'Middle Aged'
    ELSE 'Unknown'
  END AS age_band
FROM weekly_sales;

# 6. Add demographic column
SELECT
  customer_type,
  CASE
    WHEN customer_type = 'New' THEN 'New Customers'
    ELSE 'Existing Customers'
  END AS demographic
FROM weekly_sales;

# 7. Average transaction value per record
SELECT
  sales / transactions AS avg_transaction_value
FROM weekly_sales;

# ------------------------ SECTION B: Data Exploration ----------------------------

# 1. Total sales for each region
SELECT
  region,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY region;

# 2. Total sales for each platform
select platform, 
	sum(sales) as Total_sales
    from weekly_sales
group by platform;

# 3. Percentage of sales by platform.
select platform,
 ROUND(SUM(sales) / (SELECT SUM(sales) FROM weekly_sales) * 100, 2) AS sales_percentage
FROM weekly_sales
GROUP BY platform;

# 4. Percentage of sales by demographic
SELECT
  customer_type,
  ROUND(100 * SUM(sales) / (SELECT SUM(sales) FROM weekly_sales), 2) AS sales_percentage
FROM weekly_sales
GROUP BY customer_type;	

# 5. Which age_band & demographic contribute most?
SELECT
  segment,
  customer_type,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY segment, customer_type
ORDER BY total_sales DESC;

# ----------------- SECTION C: Before & After Analysis ---------------------

# 1. Total sales BEFORE & AFTER
SELECT
  CASE
    WHEN week_date < '2020-06-15' THEN 'Before'
    ELSE 'After'
  END AS period,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY period;

# 2. Sales impact (absolute & percentage)
WITH sales_period AS (
  SELECT
    CASE
      WHEN week_date < '2020-06-15' THEN 'Before'
      ELSE 'After'
    END AS period,
    SUM(sales) AS total_sales
  FROM weekly_sales
  GROUP BY period
)
SELECT
  MAX(CASE WHEN period = 'Before' THEN total_sales END) AS before_sales,
  MAX(CASE WHEN period = 'After' THEN total_sales END) AS after_sales,
  MAX(CASE WHEN period = 'After' THEN total_sales END) -
  MAX(CASE WHEN period = 'Before' THEN total_sales END) AS sales_difference,
  ROUND(
    100 * (
      MAX(CASE WHEN period = 'After' THEN total_sales END) -
      MAX(CASE WHEN period = 'Before' THEN total_sales END)
    ) /
    MAX(CASE WHEN period = 'Before' THEN total_sales END),
    2
  ) AS percentage_change
FROM sales_period;

# 3. Impact by region
SELECT
  region,
  CASE
    WHEN week_date < '2020-06-15' THEN 'Before'
    ELSE 'After'
  END AS period,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY region, period
ORDER BY region, period;

# 4. Impact by platform
SELECT
  platform,
  CASE
    WHEN week_date < '2020-06-15' THEN 'Before'
    ELSE 'After'
  END AS period,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY platform, period;

# 5. Impact by customer type
SELECT
  customer_type,
  CASE
    WHEN week_date < '2020-06-15' THEN 'Before'
    ELSE 'After'
  END AS period,
  SUM(sales) AS total_sales
FROM weekly_sales
GROUP BY customer_type, period;
