create database if not exists Clique_Bait;
use Clique_Bait;

# Create Table Users
CREATE TABLE users (
  user_id INT PRIMARY KEY,
  cookie_id VARCHAR(50) UNIQUE,
  start_date DATE
);

# create table event_identifier
CREATE TABLE event_identifier (
  event_type INT PRIMARY KEY,
  event_name VARCHAR(50)
);

# create table page_hierarchy
CREATE TABLE page_hierarchy (
  page_id INT PRIMARY KEY,
  page_name VARCHAR(50),
  product_category VARCHAR(50)
);

# create table events
CREATE TABLE events (
  visit_id INT,
  cookie_id VARCHAR(50),
  page_id INT,
  event_type INT,
  sequence_number INT,
  event_time DATETIME,

  CONSTRAINT fk_events_users
    FOREIGN KEY (cookie_id)
    REFERENCES users(cookie_id),

  CONSTRAINT fk_events_event_type
    FOREIGN KEY (event_type)
    REFERENCES event_identifier(event_type),

  CONSTRAINT fk_events_page
    FOREIGN KEY (page_id)
    REFERENCES page_hierarchy(page_id)
);

# Insert Data event_identifier
INSERT INTO event_identifier VALUES
(1, 'Page View'),
(2, 'Add to Cart'),
(3, 'Purchase');

# Insert Data page_hierarchy
INSERT INTO page_hierarchy VALUES
(1, 'Home Page', NULL),
(2, 'Product Page', 'Fishing'),
(3, 'Product Page', 'Camping'),
(4, 'Checkout Page', NULL);

# Insert Data users
INSERT INTO users VALUES
(1, 'abc123', '2020-01-01'),
(2, 'def456', '2020-01-03'),
(3, 'ghi789', '2020-01-05');

# Insert Data events
INSERT INTO events VALUES
(1, 'abc123', 1, 1, 1, '2020-01-01 10:00:00'),
(1, 'abc123', 2, 1, 2, '2020-01-01 10:02:00'),
(1, 'abc123', 2, 2, 3, '2020-01-01 10:03:00'),
(1, 'abc123', 4, 3, 4, '2020-01-01 10:05:00'),

(2, 'def456', 1, 1, 1, '2020-01-03 11:00:00'),
(2, 'def456', 3, 1, 2, '2020-01-03 11:05:00'),
(2, 'def456', 3, 2, 3, '2020-01-03 11:07:00'),

(3, 'ghi789', 1, 1, 1, '2020-01-05 12:00:00'),
(3, 'ghi789', 2, 1, 2, '2020-01-05 12:05:00');

SELECT * FROM users;
SELECT * FROM events;
SELECT * FROM event_identifier;
SELECT * FROM page_hierarchy;

# ------------------------------ Section A: Digital Analysis -------------------------------

# 1. How many users are there?
select count(distinct user_id) as total_users from users;

# 2. How many cookies does each user have?
select user_id, 
		count(distinct cookie_id) as total_cookies 
from users group by user_id;

# 3. How many visits were there?
select count(distinct visit_id) as No_of_visits from events;

# 4. How many page views?
select count(distinct page_id) as Total_pages from page_hierarchy;

# 5. How many add-to-cart events?
select count(*) as add_to_cart from events as e
join
event_identifier as ei on e.event_type = ei.event_type
where ei.event_name = 'Add to Cart';

# 6. How many purchases?
select count(*) as No_of_Purchase from events as e
join
event_identifier as ei on e.event_type = ei.event_type
where event_name = 'Purchase';

# --------------------------- Section B: Product Funnel Analysis -----------------------------

# 7. How many products were viewed?
SELECT COUNT(DISTINCT page_id) AS products_viewed
FROM events e
JOIN event_identifier ei
  ON e.event_type = ei.event_type
WHERE ei.event_name = 'Page View';

# 8. How many products were added to cart?
SELECT COUNT(DISTINCT page_id) AS products_added_to_cart
FROM events e
JOIN event_identifier ei
  ON e.event_type = ei.event_type
WHERE ei.event_name = 'Add to Cart';

# 9. How many products were purchased?
SELECT COUNT(DISTINCT page_id) AS products_purchased
FROM events e
JOIN event_identifier ei
  ON e.event_type = ei.event_type
WHERE ei.event_name = 'Purchase';

# 10. Funnel conversion counts.
SELECT
  COUNT(DISTINCT visit_id) AS visits,
  COUNT(DISTINCT CASE WHEN event_type = 2 THEN visit_id END) AS add_to_cart,
  COUNT(DISTINCT CASE WHEN event_type = 3 THEN visit_id END) AS purchases
FROM events;

# 11. Visit → Purchase conversion rate.
SELECT
  ROUND(
    100 * 
    COUNT(DISTINCT CASE WHEN event_type = 3 THEN visit_id END) /
    COUNT(DISTINCT visit_id),
    2
  ) AS conversion_rate_pct
FROM events;

# --------------------------- Section D: Product Category Performance ------------------------------------

# 12. Purchases by product category.
SELECT
  ph.product_category,
  COUNT(*) AS purchases
FROM events e
JOIN event_identifier ei
  ON e.event_type = ei.event_type
JOIN page_hierarchy ph
  ON e.page_id = ph.page_id
WHERE ei.event_name = 'Purchase'
GROUP BY ph.product_category;

