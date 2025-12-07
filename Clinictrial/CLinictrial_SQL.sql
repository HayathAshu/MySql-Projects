create database if not exists clinical;
use clinical;

select * from clinictrial;

ALTER TABLE clinictrial RENAME TO clinical_table;

select * from clinical_table;


# 1. Add index name fast on Name

CREATE INDEX idx_name ON clinical_table(Name);

SHOW INDEX FROM clinical_table;

# 2. Describe the schema of table

Desc clinical_table;

# 3. Find average of Age

select avg(age) as Average_Age from clinical_table;

# 4. Find minimum of Age

select min(age) as Minimum_Age from clinical_table;

# 5. Find maximum of Age

select max(age) as Maximum_Age from clinical_table;

# 6. Find average age of those were pregnant and not pregnant

select Pregnant,avg(age) as Average_Age from clinical_table group by Pregnant;

# 7. Find average blood pressure of those had drug reaction and did not had drug reaction

select Drug_Reaction, avg(BP) as Average_BP from clinical_table group by Drug_Reaction;

# 8. Add new column name as ‘Age_group’ and those having age between 16 & 21
# should be categorized as Low, more than 21 and less than 35 should be
# categorized as Middle and above 35 should be categorized as High.

ALTER TABLE clinical_table ADD COLUMN Age_group VARCHAR(10);

UPDATE clinical_table
SET Age_group = 
    CASE 
        WHEN Age BETWEEN 16 AND 21 THEN 'Low'
        WHEN Age > 21 AND Age < 35 THEN 'Middle'
        ELSE 'High'
    END;
    
    SELECT Name, Age, Age_group FROM clinical_table;
    
# 9. Change ‘Age’ of Reetika to 32

UPDATE clinical_table 
SET Age = 32 
WHERE Name = 'Reetika';

# 10. Change name of Reena as Shara’

UPDATE clinical_table 
SET Name = 'Shara' 
WHERE Name = 'Reena';

# 11. Remove Chlstrl column

ALTER TABLE clinical_table DROP COLUMN Chlstrl;

select * from clinical_table;

# 12. Select only Name, Age and BP

select name,age,bp from clinical_table;

# 13. Select ladies whose first name starts with ‘E’

SELECT * FROM clinical_table WHERE Name LIKE 'E%';

# 14. Select ladies whose Age_group were Low

SELECT * FROM clinical_table WHERE Age_group = 'Low';

# 15. Select ladies whose Age_group were High

SELECT * FROM clinical_table WHERE Age_group = 'High';

# 16. Select ladies whose name starts with ‘A’ and those were pregnant

SELECT * FROM clinical_table WHERE Name LIKE 'A%' AND Pregnant = 'yes';

# 17. Identify ladies whose BP was more than 120

SELECT * FROM clinical_table WHERE BP > 120;

# 18. Identify ladies whose BP was between 100 and 120

select * from clinical_table where bp between 100 and 120;

# 19. Identify ladies who had low anxiety aged less than 30

SELECT * FROM clinical_table WHERE Anxty_LH = 'no' AND Age < 30;

# 20. Select ladies whose name ends with ‘i’

SELECT * FROM clinical_table WHERE Name LIKE '%i';

# 21. Select ladies whose name ends with ‘a’
SELECT * FROM clinical_table WHERE Name LIKE '%a';

# 22. Select ladies whose name starts with ‘K’
SELECT * FROM clinical_table WHERE Name LIKE 'K%';

# 23. Select ladies whose name has ‘a’ anywhere
SELECT * FROM clinical_table WHERE Name LIKE '%a%';

# 24. Order ladies in ascending order based on ‘BP’
SELECT * FROM clinical_table ORDER BY BP ASC;

# 25. Order ladies in descending order based on ‘Age’
SELECT * FROM clinical_table ORDER BY Age DESC;