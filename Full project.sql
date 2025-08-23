CREATE DATABASE College_Management;
USE College_Management;

-- Table: Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

INSERT INTO Departments
(department_id,department_name)
VALUES
(1001,"Arts"),
(1002,"Commerce"),
(1003,"Science");

SELECT * FROM Departments;

-- Table: Students
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(100),
    gender VARCHAR(10),
    dob DATE,
    department_id INT,
    marks_percentage DECIMAL(5,2),
    minority_category VARCHAR(10),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

INSERT INTO Students
(student_id,student_name,gender,dob,department_id,marks_percentage,minority_category)
VALUES
(2001,"Aditya","Male","2001-05-21",1001,82.56,"No"),
(2002,"Anny","Female","2002-01-11",1003,92.04,"No"),
(2003,"Benita","Female","2002-09-01",1002,62.48,"Yes"),
(2004,"Calvin","Male","2002-03-02",1003,87.65,"Yes"),
(2005,"Dony","Male","2001-01-27",1002,75.40,"No"),
(2006,"Delisha","Female","2001-02-22",1001,96.50,"No"),
(2007,"Felix","Male","2002-08-04",1003,89.40,"Yes"),
(2008,"Gini","Female","2002-03-25",1002,63.66,"Yes"),
(2009,"Heena","Female","2001-09-22",1002,91.00,"No"),
(2010,"Jordan","Male","2002-05-12",1001,77.77,"No"),
(2011,"Keerthi","Female","2002-01-01",1003,96.33,"No"),
(2012,"Kenedy","Male","2002-04-14",1001,76.36,"Yes"),
(2013,"Livia","Female","2002-06-23",1002,88.89,"No"),
(2014,"Monika","Female","2002-05-31",1003,54.33,"No"),
(2015,"Neon","Male","2001-04-22",1003,32.23,"No"),
(2016,"Orion","Male","2002-02-21",1002,28.69,"No"),
(2017,"Priona","Female","2002-09-19",1001,90.23,"No"),
(2018,"Rayon","Male","2002-01-03",1001,56.23,"No"),
(2019,"Silvia","Female","2002-07-17",1003,28.22,"No"),
(2020,"Veylor","Male","2002-06-26",1002,84.46,"Yes");

SELECT * FROM Students;

-- Table: Admissions
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    student_id INT,
    admission_date DATE,
    total_fee DECIMAL(10,2),
    fee_concession DECIMAL(10,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Admissions
(admission_id,student_id,admission_date,total_fee,fee_concession)
VALUES
(3001,2001,"2025-05-15",30000.00,0.00),
(3002,2002,"2025-05-16",50000.00,10000.00),
(3003,2003,"2025-05-16",40000.00,5000.00),
(3004,2004,"2025-05-17",50000.00,3000.00),
(3005,2005,"2025-05-17",40000.00,0.00),
(3006,2006,"2025-05-16",30000.00,10000.00),
(3007,2007,"2025-05-16",50000.00,5000.00),
(3008,2008,"2025-05-17",40000.00,3000.00),
(3009,2009,"2025-05-16",40000.00,10000.00),
(3010,2010,"2025-05-15",30000.00,0.00),
(3011,2011,"2025-05-16",50000.00,10000.00),
(3012,2012,"2025-05-15",30000.00,5000.00),
(3013,2013,"2025-05-16",40000.00,0.00),
(3014,2014,"2025-05-17",50000.00,0.00),
(3015,2015,"2025-05-16",50000.00,0.00),
(3016,2016,"2025-05-17",40000.00,0.00),
(3017,2017,"2025-05-16",30000.00,5000.00),
(3018,2018,"2025-05-17",30000.00,0.00),
(3019,2019,"2025-05-17",50000.00,0.00),
(3020,2020,"2025-05-16",40000.00,5000.00);

SELECT * FROM Admissions;



-- Table: Scholarships
CREATE TABLE Scholarships (
    scholarship_id INT PRIMARY KEY,
    student_id INT,
    scholarship_type VARCHAR(50),
    amount DECIMAL(10,2),
    awarded_on DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Scholarships (scholarship_id, student_id, scholarship_type, amount, awarded_on)
SELECT 
    ROW_NUMBER() OVER (ORDER BY student_id), 
    student_id,
    CASE 
        WHEN marks_percentage >= 90 THEN 'Merit'
        ELSE 'Minority'
    END,
    CASE 
        WHEN marks_percentage >= 90 THEN 10000
        ELSE 5000
    END,
    CURRENT_DATE
FROM Students
WHERE marks_percentage >= 90 OR minority_category = 'Yes';

SELECT * FROM Scholarships;



-- Table: Subjects
CREATE TABLE Subjects (
    subject_id INT NOT NULL,
    subject_name VARCHAR(100),
    department_id INT NOT NULL,
    PRIMARY KEY (subject_id,subject_name,department_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);



INSERT INTO Subjects
(subject_id,subject_name,department_id)
VALUES
(4001,"English",1001),
(4001,"English",1002),
(4001,"English",1003),
(4002,"Economics",1001),
(4002,"Psychology",1001),
(4003,"History",1001),
(4004,"Accountancy",1002),
(4005,"Business Studies",1002),
(4002,"Economics",1002),
(4006,"Physics",1003),
(4007,"Chemistry",1003),
(4008,"Maths",1003),
(4009,"IT",1003);

SELECT * FROM Subjects;

-- Table: Marks
CREATE TABLE Marks (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks_obtained INT,
    PRIMARY KEY(student_id,subject_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- Arts Students (Dept ID = 1001)
INSERT INTO Marks VALUES (2001, 4001, 75), (2001, 4002, 68), (2001, 4003, 72);
INSERT INTO Marks VALUES (2006, 4001, 95), (2006, 4002, 92), (2006, 4003, 88);
INSERT INTO Marks VALUES (2010, 4001, 74), (2010, 4002, 70), (2010, 4003, 72);
INSERT INTO Marks VALUES (2012, 4001, 66), (2012, 4002, 65), (2012, 4003, 69);
INSERT INTO Marks VALUES (2017, 4001, 90), (2017, 4002, 89), (2017, 4003, 91);
INSERT INTO Marks VALUES (2018, 4001, 64), (2018, 4002, 61), (2018, 4003, 59);

-- Commerce Students (Dept ID = 1002)
INSERT INTO Marks VALUES (2003, 4001, 65), (2003, 4004, 70), (2003, 4005, 68), (2003, 4002, 66);
INSERT INTO Marks VALUES (2005, 4001, 72), (2005, 4004, 73), (2005, 4005, 71), (2005, 4002, 69);
INSERT INTO Marks VALUES (2008, 4001, 60), (2008, 4004, 62), (2008, 4005, 61), (2008, 4002, 63);
INSERT INTO Marks VALUES (2009, 4001, 88), (2009, 4004, 90), (2009, 4005, 89), (2009, 4002, 85);
INSERT INTO Marks VALUES (2013, 4001, 77), (2013, 4004, 79), (2013, 4005, 75), (2013, 4002, 76);
INSERT INTO Marks VALUES (2015, 4001, 50), (2015, 4004, 52), (2015, 4005, 53), (2015, 4002, 48);
INSERT INTO Marks VALUES (2016, 4001, 40), (2016, 4004, 42), (2016, 4005, 45), (2016, 4002, 41);
INSERT INTO Marks VALUES (2020, 4001, 82), (2020, 4004, 85), (2020, 4005, 80), (2020, 4002, 79);

-- Science Students (Dept ID = 1003)
INSERT INTO Marks VALUES (2002, 4001, 88), (2002, 4006, 91), (2002, 4007, 86), (2002, 4008, 89), (2002, 4009, 87);
INSERT INTO Marks VALUES (2004, 4001, 78), (2004, 4006, 81), (2004, 4007, 80), (2004, 4008, 82), (2004, 4009, 79);
INSERT INTO Marks VALUES (2007, 4001, 74), (2007, 4006, 76), (2007, 4007, 77), (2007, 4008, 75), (2007, 4009, 78);
INSERT INTO Marks VALUES (2011, 4001, 95), (2011, 4006, 97), (2011, 4007, 93), (2011, 4008, 96), (2011, 4009, 94);
INSERT INTO Marks VALUES (2014, 4001, 52), (2014, 4006, 54), (2014, 4007, 55), (2014, 4008, 53), (2014, 4009, 51);
INSERT INTO Marks VALUES (2019, 4001, 34), (2019, 4006, 35), (2019, 4007, 33), (2019, 4008, 36), (2019, 4009, 37);

SELECT * FROM MARKS;

-- Table: Achievements
CREATE TABLE Achievements (
    student_id INT PRIMARY KEY,
    event_type VARCHAR(50),
    level VARCHAR(20),
    achievement_title VARCHAR(255),
    achievement_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Achievements 
(student_id, event_type, level, achievement_title, achievement_date)
VALUES 
(2002, 'Academics', 'National', 'National Topper in Science Olympiad', '2024-12-15'),
(2006, 'Cultural', 'State', '1st Prize in State-Level Classical Dance Competition', '2024-11-10'),
(2011, 'Sports', 'College', 'Winner in College Badminton Tournament', '2024-10-05'),
(2017, 'Academics', 'State', 'Top Scorer in State-Level Math Quiz', '2025-01-20');

SELECT * FROM achievements;

-- Table: Attendance
CREATE TABLE Attendance (
    student_id INT PRIMARY KEY,
    total_days INT,
    present_days INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

INSERT INTO Attendance (student_id, total_days, present_days) VALUES
(2001, 180, 160),
(2002, 180, 172),
(2003, 180, 150),
(2004, 180, 165),
(2005, 180, 158),
(2006, 180, 174),
(2007, 180, 166),
(2008, 180, 149),
(2009, 180, 170),
(2010, 180, 155),
(2011, 180, 176),
(2012, 180, 153),
(2013, 180, 157),
(2014, 180, 145),
(2015, 180, 148),
(2016, 180, 110),  -- Low attendance (61.1%)
(2017, 180, 169),
(2018, 180, 140),
(2019, 180, 138),
(2020, 180, 160);

SELECT * FROM attendance;

-- Query: Top Scorers by Department
SELECT department_name, student_name, percentage
FROM (
    SELECT d.department_name,
           s.student_name,
           ROUND(AVG(m.marks_obtained), 2) AS percentage,
           ROW_NUMBER() OVER (
               PARTITION BY d.department_id
               ORDER BY AVG(m.marks_obtained) DESC
           ) AS rnk
    FROM Students s
    JOIN Marks m ON s.student_id = m.student_id
    JOIN Departments d ON s.department_id = d.department_id
    GROUP BY d.department_name, d.department_id, s.student_id, s.student_name
) ranked
WHERE rnk = 1;

-- Query: Department wise Overall pass percentage along with number of failures
WITH StudentFailures AS (
    SELECT DISTINCT student_id
    FROM Marks
    WHERE marks_obtained < 35
),
DeptStats AS (
    SELECT 
        d.department_name,
        s.student_id,
        CASE WHEN f.student_id IS NOT NULL THEN 1 ELSE 0 END AS is_failed
    FROM Departments d
    LEFT JOIN Students s ON d.department_id = s.department_id
    LEFT JOIN StudentFailures f ON s.student_id = f.student_id
)
SELECT 
    department_name,
    COUNT(student_id) AS total_students,
    SUM(is_failed) AS failures,
    COUNT(student_id) - SUM(is_failed) AS passes,
    ROUND(100.0 * (COUNT(student_id) - SUM(is_failed)) / NULLIF(COUNT(student_id), 0), 2) AS pass_percentage
FROM DeptStats
GROUP BY department_name;

-- Query: Achievements by Event and Level
SELECT event_type, level, COUNT(*) AS total_achievements
FROM Achievements
GROUP BY event_type, level;

-- Query: Attendance Report
SELECT s.student_name, a.total_days, a.present_days, 
       ROUND((a.present_days*100.0)/a.total_days, 2) AS attendance_percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;

-- Query: Attendance Issues and Promotion Risks
SELECT s.student_name, s.marks_percentage, 
       ROUND((a.present_days*100.0)/a.total_days, 2) AS attendance_percentage,
       CASE 
           WHEN a.present_days*100.0/a.total_days < 75 AND s.marks_percentage < 50 THEN 'Promotion Issue'
           ELSE 'Clear'
       END AS status
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;

-- Query: Final Promotion Status (Pass/Fail + Attendance)
SELECT 
    s.student_name,
    ROUND(AVG(m.marks_obtained), 2) AS percentage,
    ROUND((a.present_days * 100.0) / a.total_days, 2) AS attendance_percentage,
    CASE 
        WHEN ROUND(AVG(m.marks_obtained), 2) < 35 
             OR ROUND((a.present_days * 100.0) / a.total_days, 2) < 75 
        THEN 'Not Promoted'
        ELSE 'Promoted'
    END AS final_promotion_status
FROM Students s
JOIN Marks m ON s.student_id = m.student_id
JOIN Attendance a ON s.student_id = a.student_id
GROUP BY s.student_name, a.present_days, a.total_days;











