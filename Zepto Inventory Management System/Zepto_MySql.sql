create database if not exists zepto_inventory;
use zepto_inventory;

select * from zepto_v2;

# # ----------- Data Exploration -----------

# Count of rows
select 
	count(*) 
from zepto_v2;

# Null values
select 
	* 
from zepto_v2 
	where category is null 
	or
    name is null
    or
    mrp is null
    or
    discountPercent is null
    or
    availableQuantity is null
    or
    discountedSellingPrice is null
    or
    weightInGms is null
    or
    outOfStock is null
    or
    quantity is null;
    
# Different product categories 
select 
	distinct category 
from zepto_v2 
	order by category;

# product in-stock vs out-of-stock
select 
	outOfStock, 
    count(outOfStock) 
from zepto_v2 
	group by outOfStock;

# product names present multiple times
select 
	name, 
    count(*) as 'Number of SKUs' 
from zepto_v2
	group by name
	having count(*) > 1
	order by count(*) desc;

# ----------- data cleaning -----------

# product with price = 0
select * 
from zepto_v2 
	where mrp = 0 or discountedSellingPrice = 0;

delete from zepto_v2 where mrp = 0;

# convert paise to rupees
update zepto_v2 
	set mrp = mrp / 100.0,
	discountedSellingPrice = discountedSellingPrice / 100.0;

select 
	mrp, 
	discountedSellingPrice 
from zepto_v2;

# ----------------------------------------------------------------------------------------------------------#

# Q1. Find the top 10 best-value product based on the discount percentage.
select 
	distinct name, 
    mrp, 
    discountPercent 
from zepto_v2 
	order by discountPercent desc 
    limit 10;

# Q2. What are the products with high mrp but out of stock
select 
	distinct name, 
    mrp 
from zepto_v2
	where outOfStock = 'True' and mrp > 300
	order by mrp desc;

# Q3. Calculate estimated revenue for each category
select 
	distinct category, 
	sum(discountedSellingPrice * availableQuantity) as Total_Revenue 
from zepto_v2
	group by category
	order by total_revenue;
    
# Q4. Find all the products where MRP is greater than Rs.500 and discount is less than 10%.
select 
	distinct name, 
    mrp, 
    discountedSellingPrice 
from zepto_v2
	where 
		mrp > 500 and discountedSellingPrice < 0.1;
        
# Q5. Identify the top 5 categories offering the highest avg discount percentage.
select 
	distinct category, 
    round(avg(discountedSellingPrice),2) as Avg_Discount_percentage
from zepto_v2
	group by category 
    order by category desc
    limit 5;
    
# Q6. Find the price per gram for the products above 100g and sort by best value.
select 
	distinct name, 
    weightInGms, 
    discountedSellingPrice, 
    round(discountedSellingPrice / weightInGms, 2) as price_per_gram
from zepto_v2
	where weightInGms >= 100
    order by price_per_gram;

# Q7. Group the products into categories like Low, Medium, Bulk
select 
	distinct name,
    weightInGms,
		case
			when 
				weightInGms < 1000 then "Low" 
			when
				weightInGms < 5000 then "Medium"
			else
				"Bulk"
		end as weight_category
from zepto_v2;

# Q8. What is the Total Inventory weight per Catagory
select 
	category,
    sum(weightInGms * availableQuantity) as Total_Weight
from zepto_v2
	group by category
    order by total_weight;
