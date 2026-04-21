-- Specifying the main database for the myfitness tracking system
-- Designing database section

-- Creating table to save users personal information
USE myfitness_database_tracker;
CREATE TABLE Username
(Username int,
FirstName varchar(50),
LastName varchar(50),
Password varchar(20),
DOB DATE
)
;

-- Creating table to save health data
CREATE TABLE User_health_data
(Username int,
Age int,
Weight int,
Height int,
Gender varchar(50)
);

-- Creating table to save fitness goals and targets
CREATE TABLE User_Goal
(Username int,
Weight_Goal int,
Daily_Calories_Target int,
Target_BMI int
);

-- Adding unique identifier as primary key to users_health_data table
ALTER TABLE User_health_data
ADD COLUMN UserID INT PRIMARY KEY AUTO_INCREMENT FIRST;

-- linking User_Goal to User_health_data

ALTER TABLE User_Goal
ADD COLUMN WeightID INT PRIMARY KEY AUTO_INCREMENT FIRST,
ADD COLUMN UserID int,
ADD FOREIGN KEY (UserID) REFERENCES User_health_data(UserID);

-- Creating table to save progress updates 
CREATE Table User_Progress
(Username int,
Progress_Date DATE,
Current_Calorie_intake int,
Current_BMI int,
Current_Weight int
);

-- Creating table to save exercise details and daily step count
CREATE TABLE User_daily_exercise_checkin
(Username int,
Exercise_name Varchar(50),
Exercise_type Varchar(50),
Exercise_duration TIME,
Steps_Count int
);

-- Adding email field to User_info table
ALTER TABLE User_info
ADD email Varchar(50);

-- Cleaning the data to remove any duplicates and linking User_daily_exercise_checkin table and User_Progress
-- normalising the data and adding primary and foreign keys to link the tables
ALTER TABLE User_Progress
ADD COLUMN Client_ID INT PRIMARY KEY AUTO_INCREMENT FIRST;

ALTER TABLE User_daily_exercise_checkin
ADD COLUMN E_type INT PRIMARY KEY AUTO_INCREMENT FIRST,
ADD COLUMN Client_ID int,
ADD FOREIGN KEY (Client_ID) REFERENCES User_Progress(Client_ID);

CREATE TABLE Exercise_name 
(Exercise_name_id INT PRIMARY KEY AUTO_INCREMENT,
Exercise_name VARCHAR(50) NOT NULL
);

ALTER TABLE User_Progress
ADD COLUMN Exercise_name_id INT,
ADD FOREIGN KEY (Exercise_name_id) REFERENCES Exercise_name (Exercise_name_id);

-- Inputing Users data into the tables 
INSERT INTO User_info VALUES
(14891, 'Maria', 'Arman' , 'London100%', '2000-06-09', 'mariaarman@outlook.com'),
(14892, 'Lilly', 'Harriet', 'Bristol200%', '2001-01-01','LHariiet@outlook.com'),
(14893, 'Amira', 'Muscat', 'Dundee1300%', '2003-07-29', 'AmiraM@yahoo.com'),
(14894, 'Elizabeth', 'Orwell', 'Manchester400%', '2004-08-5', 'ElizabethOrwell@outlook.com'),
(14895, 'Harry', 'Osmon', 'Brighton500%', '2005-09-15', 'HarryO@outlook.com'),
(14896, 'George', 'Davidson', 'Andrews600%','2005-02-14','Georgeson@gmail.com'),
(14897, 'Noah','Clark', 'Kings700%', '1999-06-20','NoahClark@hotmail.com'),
(14898, 'Samira', 'James', 'Paris800%', '2007-07-09', 'Samra121@outlook.com');

INSERT INTO User_health_data VALUES
(14891, 25, 50, 165, 'Female'),
(14892, 24, 45, 160, 'Female'),
(14893, 23, 60, 170, 'Female'),
(14894, 22, 70, 160, 'Female'),
(14895, 21, 90, 185, 'Male'),
(14896, 21, 120, 180, 'Male'),
(14897, 27, 150, 183, 'Male'),
(14898, 19, 37, 150, 'Female');

INSERT INTO User_Goal VALUES
(14891, 45, 1900, 21),
(14892, 50, 2200, 23),
(14893, 48, 1850, 19),
(14894, 55, 1800, 20),
(14895, 80, 3000, 24),
(14896, 70, 2400, 24),
(14897, 90, 2200, 22),
(14898, 45, 3000, 23);

-- Changing weight data type to decimals as more appropriate

ALTER TABLE User_Progress
MODIFY Current_Weight DECIMAL(5,1);

INSERT INTO User_Progress VALUES
(14891,'2026-01-25', 1900, 19, 47.8),
(14892, '2026-03-19', 1800, 18, 49.3),
(14893,'2026-07-10', 2000, 21, 58.2),
(14894, '2026-03-18', 2900, 23, 60),
(14895,'2026-03-18', 2300, 22, 78.5),
(14896, '2026-02-27', 2200, 22, 88.9),
(14897, '2026-07-28', 1900, 24, 85.0),
(14898, '2026-08-16', 2900, 19, 49.0);

INSERT INTO User_daily_exercise_checkin VALUES
(14891,'Running', 'Cardio','00:35:00', 3000),
(14892, 'Squats', 'Strength','00:15:00', 1000),
(14893,'Yoga', 'Flexibility','00:45:00', 500),
(14894, 'Cycling', 'Cardio','00:55:00', 7000),
(14895,'Planks', 'Core','00:10:00', 300),
(14896, 'Pilates', 'Core','00:45:00', 1000),
(14897, 'Barre', 'Strength','00:50:00', 800),
(14898, 'HIIT', 'Cardio', '00:55:00', 10000);












