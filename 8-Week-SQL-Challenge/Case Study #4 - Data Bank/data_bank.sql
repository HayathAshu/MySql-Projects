-- Create database
CREATE DATABASE IF NOT EXISTS data_bank;
USE data_bank;

-- Drop existing tables
DROP TABLE IF EXISTS transactions;
DROP TABLE IF EXISTS customer_nodes;
DROP TABLE IF EXISTS regions;

-- 1️. Create regions table
CREATE TABLE regions (
  region_id INT PRIMARY KEY,
  region_name VARCHAR(50)
);

-- 2️. Create customers node table
CREATE TABLE customer_nodes (
  customer_id INT,
  region_id INT,
  node_id INT,
  start_date DATE,
  end_date DATE,

  PRIMARY KEY (customer_id, node_id, start_date),
  FOREIGN KEY (region_id) REFERENCES regions(region_id)
);

-- 3️. Create customer transactions table
CREATE TABLE customer_transactions (
  txn_id INT AUTO_INCREMENT PRIMARY KEY,
  customer_id INT,
  txn_date DATE,
  txn_type VARCHAR(20),
  txn_amount INT
);

-- 4️. Insert data into regions table
INSERT INTO regions (region_id, region_name) VALUES
(1, 'Australia'),
(2, 'America'),
(3, 'Africa'),
(4, 'Asia'),
(5, 'Europe');

-- 5️.Insert sample customers nodes (for illustration; dataset has 500 total)

INSERT INTO customer_nodes (customer_id, region_id, node_id, start_date, end_date) VALUES
(1, 3, 4, '2020-01-02', '2020-01-03'),
(1, 3, 2, '2020-01-03', '2020-01-06'),
(2, 3, 5, '2020-01-04', '2020-01-14'),
(3, 5, 4, '2020-01-08', '2020-01-11'),
(3, 5, 1, '2020-01-11', '2020-01-17'),
(4, 1, 4, '2020-01-20', '2020-01-22'),
(4, 1, 5, '2020-01-22', '2020-01-25'),
(5, 2, 3, '2020-01-18', '2020-01-19'),
(6, 2, 1, '2020-01-24', '2020-01-27'),
(7, 4, 4, '2020-01-11', '2020-01-14'),
(8, 4, 2, '2020-01-15', '2020-01-20'),
(9, 1, 1, '2020-01-10', '2020-01-15'),
(10, 5, 3, '2020-01-22', '2020-01-28');

-- 6️. Insert sample transactions (for illustration; dataset has many rows)
INSERT INTO customer_transactions (customer_id, txn_date, txn_type, txn_amount) VALUES
(1, '2020-01-02', 'deposit', 312),
(1, '2020-01-04', 'purchase', 200),
(1, '2020-01-05', 'withdrawal', 100),
(2, '2020-01-03', 'deposit', 500),
(2, '2020-01-08', 'purchase', 120),
(3, '2020-01-10', 'deposit', 200),
(3, '2020-01-12', 'withdrawal', 80),
(4, '2020-01-15', 'deposit', 1000),
(4, '2020-01-20', 'purchase', 300),
(5, '2020-01-18', 'deposit', 150),
(5, '2020-01-19', 'withdrawal', 50),
(6, '2020-01-24', 'deposit', 400),
(6, '2020-01-26', 'purchase', 150),
(7, '2020-01-11', 'deposit', 250),
(8, '2020-01-15', 'deposit', 600),
(9, '2020-01-10', 'deposit', 700),
(10, '2020-01-22', 'deposit', 900);

# ---------- Section A. Customer Nodes Exploration ----------

# 1. How many unique nodes are there on the Data Bank system?

select count(distinct customer_id) as unique_nodes from customer_nodes;

# 2. What is the number of nodes per region?
select region_name, 
count(distinct node_id) as node_count
from customer_nodes as c 
join
regions as r on r.region_id = c.region_id
group by r.region_name;

# 3. How many Customer are allocated to each regoin?
select r.region_name, 
count(distinct c.customer_id) as Total_Customers from customer_nodes as c
join
regions as r on c.region_id = r.region_id
group by r.region_name;

# 4. How many days on the average are customers reallocated to a different node?
select round(avg(datediff(end_date, start_date)), 2) as avg_date from customer_nodes where end_date is not null;

# 5. What is the median, 80th and 95th percentile for this same reallocation days metric for each region?

with node_days as(
	select
		region_id,
        datediff(end_date, start_date) as days,
        row_number() over (partition by region_id order by datediff(end_date, start_date)) as rn,
        count(*) over (partition by region_id) as total_count
        from customer_nodes
        where end_date is not null
)

select 
	region_id, 
    max(case when rn = floor(total_count * 0.5) then days end) as median,
    max(case when rn = floor(total_count * 0.8) then days end) as p80,
    max(case when rn = floor(total_count * 0.95) then days end) as p95
    from node_days
    group by region_id;
    
# ---------- Section A. Customer Transactions ----------

# 1. What is the unique count and total amount for each transaction type?
 
 select count(*) as Count_of_Transactions, sum(txn_amount)as Total_transactions from customer_transactions group by txn_type;
 
 # 2. Average total historical deposite counts & amounts per customers
 
select 
	avg(deposite_counts) as avg_deposit_count,
    avg(deposite_amount) as avg_deposit_amount
from(

select 
	customer_id, 
    count(*) as deposite_counts,
    sum(txn_amount) as deposite_amount
from customer_transactions
where txn_type = 'Deposite' 
group by customer_id
) as t;

# 3. For each month - how many Data Bank customers make more than 1 deposit and either 1 purchase or 1 withdrawal in a single month?

select customer_id, txn_month
from(
	select
		customer_id, 
        date_format(txn_date, '%Y-%m') as txn_month,
        sum(txn_type = 'deposit') as deposits,
        sum(txn_type in ('purchase', 'withdrawal')) 
        as other_txns
	from customer_transactions
    group by customer_id, txn_month
) t
where deposits > 1
	and other_txns >= 1;
    
# 4. What is the closing balance for each customer at the end of the month?

with balance_calc as (
select 
	customer_id,
    txn_date,
    date_format(txn_date, '%Y-%m') as month,
    sum(
		case 
			when txn_type = 'deposit' then txn_amount
            else -txn_amount
            end
		) over (partition by customer_id
				order by txn_date
				) as running_balance 
			from customer_transactions
)

select customer_id, month, max(running_balance) as closing_balance
from balance_calc
group by customer_id, month;

# What is the percentage of customers who increase their closing balance by more than 5%?

WITH balances AS (
  SELECT 
    customer_id,
    MIN(running_balance) AS start_balance,
    MAX(running_balance) AS end_balance
  FROM (
    SELECT
      customer_id,
      SUM(
        CASE 
          WHEN txn_type = 'deposit' THEN txn_amount
          ELSE -txn_amount
        END
      ) OVER (PARTITION BY customer_id ORDER BY txn_date) AS running_balance
    FROM customer_transactions
  ) t
  GROUP BY customer_id
)
SELECT
  ROUND(100 * SUM((end_balance - start_balance) / start_balance > 0.05) / COUNT(*), 2) AS increased_pct,
  ROUND(100 * SUM((start_balance - end_balance) / start_balance > 0.05) / COUNT(*), 2) AS decreased_pct,
  ROUND(100 * SUM(ABS(end_balance - start_balance) / start_balance <= 0.05) / COUNT(*), 2) AS no_change_pct
FROM balances;