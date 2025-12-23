create database if not exists fresh_segment;
use fresh_segment;

# Create Table interest_map
CREATE TABLE interest_map (
  interest_id INT PRIMARY KEY,
  interest_name VARCHAR(100),
  interest_summary VARCHAR(255),
  created_at DATE
);

# Create table interest_metrics
CREATE TABLE interest_metrics (
  interest_id INT,
  month_year DATE,
  composition DECIMAL(5,2),
  index_value DECIMAL(5,2),
  ranking INT,
  percentile_ranking DECIMAL(5,2),

  PRIMARY KEY (interest_id, month_year),

  CONSTRAINT fk_interest_metrics_interest
    FOREIGN KEY (interest_id)
    REFERENCES interest_map(interest_id)
);

 # Insert into interest_map
 INSERT INTO interest_map VALUES
(1, 'Fitness Enthusiasts', 'Users interested in fitness and workouts', '2019-01-01'),
(2, 'Healthy Eating', 'Users interested in nutrition and healthy food', '2019-01-05'),
(3, 'Tech Savvy', 'Users interested in technology and gadgets', '2019-02-01'),
(4, 'Travel Lovers', 'Users interested in travel and experiences', '2019-02-10'),
(5, 'Online Shoppers', 'Users frequently shopping online', '2019-03-01');

# Insert into interest_metrics
INSERT INTO interest_metrics VALUES
-- January 2020
(1, '2020-01-01', 12.5, 110.2, 3, 85.4),
(2, '2020-01-01', 15.2, 125.6, 1, 92.1),
(3, '2020-01-01', 10.1, 98.4, 5, 70.3),
(4, '2020-01-01', 9.8, 95.7, 6, 68.9),
(5, '2020-01-01', 14.3, 120.8, 2, 90.5),

-- February 2020
(1, '2020-02-01', 13.1, 112.4, 2, 88.6),
(2, '2020-02-01', 14.8, 123.1, 1, 91.8),
(3, '2020-02-01', 11.4, 102.9, 4, 75.2),
(4, '2020-02-01', 10.5, 97.3, 5, 72.6),
(5, '2020-02-01', 13.9, 118.7, 3, 87.4),

-- March 2020
(1, '2020-03-01', 14.0, 115.9, 1, 91.2),
(2, '2020-03-01', 13.5, 118.4, 3, 86.1),
(3, '2020-03-01', 12.7, 105.6, 4, 78.9),
(4, '2020-03-01', 11.9, 101.3, 5, 76.4),
(5, '2020-03-01', 13.2, 116.8, 2, 89.5);


select * from interest_map;
select * from interest_metrics;

# ----------------------------------------------  Section A: Data Exploration --------------------------------------------

# 1. How many unique interests are there?
select count(distinct interest_name) as Total_intrest from interest_map;

# 2. How many monthly records exist in the dataset?
select count(*) as monthly_records from interest_map;

# 3. Which interests have been present in all months?
SELECT
  im.interest_id,
  i.interest_name
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY im.interest_id, i.interest_name
HAVING COUNT(DISTINCT month_year) = (
  SELECT COUNT(DISTINCT month_year)
  FROM interest_metrics
);

# 4. Which interests appear in fewer than 3 months?
SELECT
  im.interest_id,
  i.interest_name,
  COUNT(DISTINCT month_year) AS months_present
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY im.interest_id, i.interest_name
HAVING COUNT(DISTINCT month_year) < 3;

# ----------------------------------------------  Section B: Ranking Analysis --------------------------------------------

# 5. Top 10 interests by average composition
SELECT
  i.interest_name,
  ROUND(AVG(im.composition), 2) AS avg_composition
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY i.interest_name
ORDER BY avg_composition DESC
LIMIT 10;

# 6. Bottom 10 interests by average composition
SELECT
  i.interest_name,
  ROUND(AVG(im.composition), 2) AS avg_composition
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY i.interest_name
ORDER BY avg_composition ASC
LIMIT 10;

# 7. Which interest has the highest average ranking (worst rank)?
SELECT
  i.interest_name,
  ROUND(AVG(im.ranking), 2) AS avg_ranking
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY i.interest_name
ORDER BY avg_ranking DESC
LIMIT 1;

# ----------------------------------------------  Section C: Month‑by‑Month Analysis --------------------------------------------

# 8. Top interest per month by composition
SELECT
  month_year,
  interest_name,
  composition
FROM (
  SELECT
    im.month_year,
    i.interest_name,
    im.composition,
    RANK() OVER (
      PARTITION BY im.month_year
      ORDER BY im.composition DESC
    ) AS rnk
  FROM interest_metrics im
  JOIN interest_map i
    ON im.interest_id = i.interest_id
) ranked
WHERE rnk = 1;

# 9.  Which interest appears most frequently in the top 3 per month?
SELECT
  interest_name,
  COUNT(*) AS top_3_appearances
FROM (
  SELECT
    im.month_year,
    i.interest_name,
    RANK() OVER (
      PARTITION BY im.month_year
      ORDER BY im.composition DESC
    ) AS rnk
  FROM interest_metrics im
  JOIN interest_map i
    ON im.interest_id = i.interest_id
) ranked
WHERE rnk <= 3
GROUP BY interest_name
ORDER BY top_3_appearances DESC
LIMIT 1;

# ----------------------------------------------  Section D: Segment Performance --------------------------------------------

# 10. Average composition & index value for each interest
SELECT
  i.interest_name,
  ROUND(AVG(im.composition), 2) AS avg_composition,
  ROUND(AVG(im.index_value), 2) AS avg_index
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY i.interest_name;

# 11. Which interests have an average index value > 110?
SELECT
  i.interest_name,
  ROUND(AVG(im.index_value), 2) AS avg_index
FROM interest_metrics im
JOIN interest_map i
  ON im.interest_id = i.interest_id
GROUP BY i.interest_name
HAVING AVG(im.index_value) > 110;

# Which month has the highest average composition across all interests?
SELECT
  month_year,
  ROUND(AVG(composition), 2) AS avg_composition
FROM interest_metrics
GROUP BY month_year
ORDER BY avg_composition DESC
LIMIT 1;