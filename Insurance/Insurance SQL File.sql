create database if not exists Insurance;
use Insurance;

select * from insurance;

# 1. Count for each categories of ‘region.
select count(region) as R from insurance;
select region, count(*) as count from insurance group by region;


# 2. Find 50 records of highest ‘age’ and export data/table to desktop 
select * from insurance order by age desc limit 50;

# 3. Add index name ‘quick’ on ‘id’.
create index quick on insurance(id);

# 4.Describe the schema of table 
desc insurance;

# 5. Create view name as ‘gender’ where users can not see ‘sex’ 
# [Hint: first run appropriate query then create view] 
select * from insurance;

select sex as gender
from insurance;
 
create view gender AS
select sex as gender
from insurance;

# 6. Rename the view as ‘type’ 
rename view gender to type; 
alter view gender rename to type;

select * from insurance;

# 7. Count how many are ‘northwest’ insurance holders.
select count(*) as Count_of_Northwwst from insurance where region = 'northwest';

# 8. Count how many insurance holders were ‘female’.
select count(*) as gender from insurance where sex = 'female';

# 9. Create Primary key on a suitable column
select * from  insurance;
alter table insurance add primary key (id);

# 10. Create a new column ‘ratio’ which is age multiply by bmi.
alter table insurance add column Ratio decimal(10,2);

update insurance set ratio = age * bmi;

# 11. Arrange the table from high to low according to charges.
select * from insurance order by charges desc;

# 12. Find Max of 'Charges'.
select max(charges) as Maximum from insurance;

# 13. Find MIN of ‘charges’.
select min(charges) as Minimum from insurance;

# 14. Find average of ‘charges’ of male and female.
select avg(charges) as Average from insurance group by sex;

# 15. Write a Query to rename column name sex to Gender
alter table insurance rename column sex to Gender;
select * from insurance;

# 16. Add new column as HL_Charges where more than average charges should be 
# categorized as HIGH and less than average charges should be categorized as LOW 
alter table insurance add column HL_Charges varchar(10);

select * from insurance;

SET @avg_charges = (SELECT AVG(charges) FROM insurance);
update insurance as i set HL_charges = case when charges > (select avg(charges) from insurance) 
then 'High' else 'Low' end;

# 17. Change location/position of ‘smoker’ and bring before ‘children’ .
select * from insurance;

alter table insurance modify column smoker varchar(10) after bmi;

# 18. Show top 20 records   
select * from insurance limit 20;

# 19. Show bottom 20 records.
select * from insurance order by id desc limit 20;

# 20. Randomly select 20% of records and export to desktop
select * from insurance where (
SELECT COUNT(*) * 0.2 FROM insurance);

# 21. Remove column ‘ratio’
alter table insurance drop column ratio;
select * from insurance;

# 22. create one example of Sub Queries involving ‘bmi’ and ‘sex’ 
# and give explanation in the script itself with remarks by using #  
select sex, bmi from insurance i where bmi > (select avg (bmi) from insurance where sex = i.sex);

# Explanation:
# The subquery calculates the average BMI for each sex.
# The main query then selects the records where the BMI is greater than the average BMI 
		#for the respective sex.
# This is an example of a correlated subquery, where the subquery is executed 
		#for each row in the main query.
        
# 23. Create a view called Female_HL_Charges that shows only those data where 
#   HL_Charges is High, Female, Smokers and with 0 children  
create view Female_HL_Charges as select * from insurance where HL_Charges = 'HIGH' and gender = 'female'
and smoker = 'yes' and children = 0;

#24. Update children column if there is 0 children then make it as Zero Children, 
# if 1 then one_children, if 2 then two_children, if 3 then three_children, 
# if 4 then four_children if 5 then five_children else print it as More_than_five_children. 
select * from insurance;	
alter table insurance modify children varchar(20);

update insurance set children =
case 
when children = 0 then 'Zero_children'
when children = 1 then 'One_children'
when children = 2 then 'Two_children'
when children = 3 then 'Three_children'
when children = 4 then 'Four_children'
when children = 5 then 'five_children'
else 'More_than_five_children'
end;













