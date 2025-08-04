CREATE DATABASE College_Management;
USE College_Management;

-- Table: Departments
CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    department_name VARCHAR(100)
);

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

-- Table: Admissions
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    student_id INT,
    admission_date DATE,
    total_fee DECIMAL(10,2),
    fee_concession DECIMAL(10,2),
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Table: Scholarships
CREATE TABLE Scholarships (
    scholarship_id INT PRIMARY KEY,
    student_id INT,
    scholarship_type VARCHAR(50),
    amount DECIMAL(10,2),
    awarded_on DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Table: Subjects
CREATE TABLE Subjects (
    subject_id INT NOT NULL,
    subject_name VARCHAR(100),
    department_id INT NOT NULL,
    PRIMARY KEY (subject_id,subject_name,department_id),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- Table: Marks
CREATE TABLE Marks (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks_obtained INT,
    PRIMARY KEY(student_id,subject_id),
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (subject_id) REFERENCES Subjects(subject_id)
);

-- Table: Achievements
CREATE TABLE Achievements (
    student_id INT PRIMARY KEY,
    event_type VARCHAR(50),
    level VARCHAR(20),
    achievement_title VARCHAR(255),
    achievement_date DATE,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

-- Table: Attendance
CREATE TABLE Attendance (
    student_id INT PRIMARY KEY,
    total_days INT,
    present_days INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id)
);

