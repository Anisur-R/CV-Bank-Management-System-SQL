CREATE DATABASE CV_Bank;
GO
USE CV_Bank;
GO

--Users Table

CREATE TABLE Users (
    user_id INT IDENTITY(1,1) PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(20),
    gender VARCHAR(10),
    date_of_birth DATE,
    created_at DATETIME DEFAULT GETDATE()
);

--CV_Details Table

CREATE TABLE CV_Details (
    cv_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT UNIQUE,
    career_objective VARCHAR(500),
    current_status VARCHAR(50),
    expected_salary DECIMAL(10,2),
    created_at DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--Education Table

CREATE TABLE Education (
    edu_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    degree VARCHAR(100),
    institution VARCHAR(150),
    passing_year INT,
    result VARCHAR(20),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--Experience Table

CREATE TABLE Experience (
    exp_id INT IDENTITY(1,1) PRIMARY KEY,
    user_id INT NOT NULL,
    company_name VARCHAR(150),
    job_title VARCHAR(100),
    years_of_experience INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--Skills Table

CREATE TABLE Skills (
    skill_id INT IDENTITY(1,1) PRIMARY KEY,
    skill_name VARCHAR(100) NOT NULL
);

--User_Skills Table

CREATE TABLE User_Skills (
    user_id INT,
    skill_id INT,
    skill_level VARCHAR(50),
    PRIMARY KEY (user_id, skill_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (skill_id) REFERENCES Skills(skill_id)
);

--Companies Table

CREATE TABLE Companies (
    company_id INT IDENTITY(1,1) PRIMARY KEY,
    company_name VARCHAR(150),
    location VARCHAR(100)
);

-- CV_Requests Table

CREATE TABLE CV_Requests (
    request_id INT IDENTITY(1,1) PRIMARY KEY,
    company_id INT,
    user_id INT,
    request_date DATETIME DEFAULT GETDATE(),
    status VARCHAR(50),
    FOREIGN KEY (company_id) REFERENCES Companies(company_id),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

--Sample Data Insertion

INSERT INTO Users (full_name, email, phone, gender, date_of_birth)
VALUES
('Anisur Rahaman', 'contact.anisur@email.com', '01700000000', 'Male', '1999-05-10'),
('Sara Khan', 'sara@email.com', '01800000000', 'Female', '2000-02-15'),
('Abdur Awal', 'contact.abdurawal@email.com', '01900000000', 'Male', '1995-05-10'),
('Aurchi Faria', 'aurchi@email.com', '01300000000', 'Female', '1992-05-10'),
('Marzia Musanna', 'marzia@email.com', '01500000000', 'Female', '1996-02-15');

INSERT INTO Skills (skill_name)
VALUES ('SQL'), ('Python'), ('Machine Learning');

INSERT INTO User_Skills (user_id, skill_id, skill_level)
VALUES 
(1, 1, 'Advanced'),
(1, 2, 'Intermediate'),
(2, 1, 'Beginner');

INSERT INTO Experience (user_id, company_name, job_title, years_of_experience)
VALUES (1, 'TechSoft', 'Data Analyst', 3);

INSERT INTO Companies (company_name, location)
VALUES ('ABC Tech', 'Dhaka');

SELECT * FROM Users;

--SELECT with WHERE Clause

SELECT * FROM Users WHERE gender = 'Male';

--INNER JOIN

SELECT U.full_name, S.skill_name
FROM Users U
INNER JOIN User_Skills US ON U.user_id = US.user_id
INNER JOIN Skills S ON US.skill_id = S.skill_id;

-- LEFT JOIN

SELECT U.full_name, E.company_name
FROM Users U
LEFT JOIN Experience E ON U.user_id = E.user_id;

--RIGHT JOIN

SELECT C.company_name, R.status
FROM Companies C
RIGHT JOIN CV_Requests R ON C.company_id = R.company_id;

--GROUP BY + HAVING

SELECT S.skill_name, COUNT(US.user_id) AS TotalUsers
FROM Skills S
JOIN User_Skills US ON S.skill_id = US.skill_id
GROUP BY S.skill_name
HAVING COUNT(US.user_id) > 0;

--ORDER BY + TOP

SELECT TOP 1 * FROM Users ORDER BY created_at DESC;

--DISTINCT

SELECT DISTINCT gender FROM Users;

--CASE

SELECT U.full_name,
CASE
  WHEN E.years_of_experience >= 5 THEN 'Senior'
  WHEN E.years_of_experience >= 2 THEN 'Mid'
  ELSE 'Junior'
END AS Experience_Level
FROM Users U
LEFT JOIN Experience E ON U.user_id = E.user_id;


--ISNULL

SELECT full_name, ISNULL(phone, 'Not Provided') AS phone
FROM Users;


--UNION

SELECT user_id FROM Experience
UNION
SELECT user_id FROM Education;


--EXCEPT

SELECT user_id FROM Users
EXCEPT
SELECT user_id FROM CV_Details;


--Stored Procedure

CREATE PROCEDURE SearchCandidateBySkill
    @SkillName VARCHAR(100)
AS
BEGIN
    SELECT U.full_name, S.skill_name, US.skill_level
    FROM Users U
    JOIN User_Skills US ON U.user_id = US.user_id
    JOIN Skills S ON US.skill_id = S.skill_id
    WHERE S.skill_name = @SkillName;
END;


--Run Stored Procedure

EXEC SearchCandidateBySkill 'SQL';
