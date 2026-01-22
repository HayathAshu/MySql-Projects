create database if not exists Cereals;
use cereals;

select * from cereals_data;

# 1. Add index name fast on name.
create index Fast on cereals_data(name(50));
select * from cereals_data;

# 2. Describe the schema of table.
desc cereals_data;

# 3. Create view name as see where users can not see type column [first run appropriate query then create view]
create view see as
select name, mfr, type, calories, protein, fat, sodium, fiber, carbo, sugars, potass, vitamins, shelf, weight, cups, rating
FROM cereals_data;

select * from see;

# 4. Rename the view as saw 
rename view see to SAW;

drop view see;

create view SAW as 
select name, mfr, type, calories, protein, fat, sodium, fiber, carbo, sugars, potass, vitamins, shelf, weight, cups, rating 
from cereals_data;

select * from saw;

# 5. Count how many are cold cereals.
select * from cereals_data;

select count(*) from cereals_data where type = 'c';

# 6. Count how many cereals are kept in shelf 3  
select count(*) from cereals_data where shelf = 3;

# 7. Arrange the table from high to low according to ratings  
select * from cereals_data order by rating desc; 

# 8. Suggest some column/s which can be Primary key  
select name, COUNT(*) from cereals_data group by name having COUNT(*) > 1;  # checks that do name have repeated more than once.

select * from cereals_data;
alter table cereals_data add primary key (name(50));

# 9. Find average of calories of hot cereal and cold cereal in one query  
select type, avg(calories) as average_calories from cereals_data group by type;

# 10. Add new column as HL_Calories where more than average calories should be categorized as 
# HIGH and less than average calories should be categorized as LOW 
select * from cereals_data;

alter table cereals_data add column HL_Calories VARCHAR(10);

SET @avg_calories = (SELECT AVG(calories) FROM cereals_data);

update cereals_data set HL_Calories = case when calories > @avg_calories
then 'HIGH' else 'LOW' end;	

select *, 
case 
	when calories > (select avg(calories) from cereals_data) then "High" else "low"
	end as HL_Calories from cereals_data;
    
# 11. List only those cereals whose name begins with B 
select * from cereals_data where name like "b%"; 

#12. List only those cereals whose name begins with F 
select * from cereals_data where name like "f%";

# 13. List only those cereals whose name ends with s.
select * from cereals_data where name like "%s";

# 14.  Select only those records which are HIGH in column HL_calories
select * from cereals_data;
select * from cereals_data where HL_Calories = 'HIGH';

# 15. Find maximum of ratings 
select max(rating) as Max_Ratings from cereals_data;

# 16. Find average ratings of those were High and Low calories
select avg(rating) as Avg_Ratings from cereals_data group by HL_Calories;

#17. Create two examples of Sub Queries of your choice and give explanation in the script 
#  itself with remarks by using #  

-- Example 1: Find cereals with calories higher than the average calories of cold cereals
SELECT name, calories
FROM cereals_data
WHERE calories > (
    # This subquery calculates the average calories of cold cereals
    SELECT AVG(calories)
    FROM cereals_data
    WHERE type = 'Cold'  # Assuming 'Cold' represents cold cereals
)
AND type = 'Cold';  # Filter only cold cereals

-- Example 2: Find cereals with ratings higher than the rating of 'Frosted Flakes'
SELECT name, rating
FROM cereals_data
WHERE rating > (
    # This subquery finds the rating of 'Frosted Flakes'
    SELECT rating
    FROM cereals_data
    WHERE name = 'Frosted Flakes'
);

# 18. Remove column fat 
alter table cereals_data drop column fat;
select * from cereals_data;

# 19. Count records for each manufacturer [mfr]  
select mfr, count(mfr) as Each_Manufacture from cereals_data group by mfr;

# 20. Select name, calories and ratings only  
select name, calories, rating from cereals_data;




























