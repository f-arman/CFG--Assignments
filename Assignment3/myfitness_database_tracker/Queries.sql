-- Data filtering by slecting specific records from the table and filtering the data using the WHERE clause
-- only users that meet the specified condition are returned acoording to the given constraints in the WHERE clause

-- Retrieving users data by their date of birth to allow the system to identify and keep track young fitness, notice patterns to draw conclusions regarding young fitness members and to apply aged based conditions when needed

SELECT * 
FROM myfitness_database_tracker.User_info
WHERE DOB > '2001-12-31'
;

SELECT * 
FROM myfitness_database_tracker.User_info
WHERE DOB >= '2002-12-31'
;
SELECT * 
FROM myfitness_database_tracker.User_info
WHERE DOB <= '2000-12-31'
;
SELECT * 
FROM myfitness_database_tracker.User_health_data
WHERE Weight = 150
;

SELECT * 
FROM myfitness_database_tracker.User_health_data
WHERE Weight > 50 and Height > 180
;

SELECT * 
FROM myfitness_database_tracker.User_info
WHERE Email like '%outlook.com'
;

SELECT * 
FROM myfitness_database_tracker.User_health_data
WHERE Age between 18 and 21
;
SELECT * 
FROM myfitness_database_tracker.User_progress
WHERE Current_BMI is not null
;
SELECT *
FROM myfitness_database_tracker.User_daily_exercise_checkin
order by Exercise_duration and Steps_Count desc 
;

-- cleaning the data to remove any duplicates 
-- -- Viewing all the data stored in user_progress table, then deleting a specific user
-- using the WHERE clause to target the user with ID 14895.
-- LIMIT 1 ensures that only one matching row is removed for safety, to not delete all the data.
SELECT *
From myfitness_database_tracker.User_progress;
DELETE FROM myfitness_database_tracker.User_progress
WHERE Username = 14895
LIMIT 1
;

-- Deleting Username table as it is a duplicate of User_info so it is not needed in the database, 
--so its best to remove it to avoid any data duplicates and to keep the database clean and organised to aovid any confusion when retrieving data from the database in order to keep clean database efficient and avoid data redundacy
DROP TABLE Username;

-- GROUP BY takes rows with the same value in a column and groups them together to calculate statistics per group.
-- HAVING filters groups after the aggregate functions are calculated

SELECT Gender, AVG(age), Max(age), MIN(age), Count(age)
FROM User_health_data
GROUP BY Gender
;

SELECT Username, Daily_Calories_Target, Weight_Goal
FROM User_Goal
GROUP BY Username, Daily_Calories_Target, Weight_Goal;

SELECT Weight, AVG(Weight)
FROM User_health_data
GROUP BY Weight
HAVING AVG(Weight)>70 
;
SELECT Exercise_type , AVG(Exercise_duration)
FROM User_daily_exercise_checkin
WHERE Exercise_type  LIKE '%Cardio%'
GROUP BY Exercise_type 
HAVING AVG(Exercise_duration)>'00:45:00' 
;


-- ORDER BY
SELECT *
From User_health_data
ORDER BY Gender, Age
;

-- ORDER BY
SELECT *
FROM User_info
ORDER BY 2,5
;

-- Limit & Aliasing 

SELECT * 
FROM User_health_data
ORDER BY Age DESC
LIMIT 3, 1
;

SELECT Height, AVG(Height) AS avg_Height
FROM User_health_data
GROUP BY Height
HAVING avg_Height > 165
;

SELECT *
FROM User_info;

SELECT *
FROM User_health_data;

-- joining tables to retrieve data from multiple data tables in a single query for a comprehensive view of data to draw conclusions and make informed decisions on related data

SELECT info.Username, FirstName, Age, Weight
FROM User_info AS info
INNER JOIN User_health_data AS health
    ON info.Username = health.Username
    ;
    
SELECT info.Username, LastName, Height, Gender
FROM User_info AS info
LEFT JOIN User_health_data AS health
    ON info.Username = health.Username
;

SELECT *
FROM User_info AS info
RIGHT JOIN User_health_data AS health
    ON info.Username = health.Username
;

SELECT U1.Username AS User_partner,
U1.FirstName AS FirstName_partner,
U1.LastName AS LastName_partner,
U2.Username AS ID,
U2.FirstName AS FirstName_ID,
U2.LastName AS LastName_ID
FROM User_info U1
JOIN User_info U2
   ON U1.Username +1  = U2.Username
;

-- union operator to combine the data from multiple tables into a single table

SELECT Username, 'FIT' AS LABEL
From User_Progress
WHERE Current_BMI <22 AND Current_Weight > 50
UNION
SELECT Username, 'Active' AS Label
FROM User_Progress
WHERE Current_BMI > 20 AND Current_Weight < 100
UNION
SELECT Username, 'Healthy' AS Label
FROM User_daily_exercise_checkin 
WHERE Steps_Count > 7000 OR Exercise_duration > '00:25:00'
;

-- String Functions to manipulate and format the data to make it more readble and to get specific parts of the data

SELECT FirstName, LENGTH(FirstName)
FROM User_info
ORDER BY 2
;

SELECT LastName, UPPER(LastName)
FROM User_info
;

SELECT FirstName,
LEFT(FirstName, 2),
SUBSTRING(FirstName,3,2),
DOB,
SUBSTRING(DOB,6,2) AS DOB_month
FROM User_info
;

SELECT FirstName ,REPLACE (FirstName,'a','f')
FROM User_info
;

SELECT LastName, LOCATE('on', LastName)
FROM User_info
;

-- concat function to combine the first name and last name into a full name 
SELECT FirstName,LastName,
CONCAT(FirstName,'  ',LastName) AS Full_name
FROM User_info
;

-- Delimiter to change the statement terminator to allow for the creation of stored procedures that contain multiple statements without prematurely finisinng the procedure definition
DELIMITER $$
CREATE PROCEDURE Above_Avg_Height2()
BEGIN
  SELECT *
FROM User_health_data
Where Height >= 165;
SELECT *
FROM User_health_data
WHERE Height > 170;
END $$
DELIMITER ;

--calling the stored procedure to execute the defined queries and retrieve the data of users with height above average to draw conclusions and make informed decisions regarding the users with above average height
CALL Above_Avg_Height2();

 



