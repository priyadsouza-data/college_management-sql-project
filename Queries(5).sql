-- Query1: Top Scorers by Department
SELECT d.department_name, s.student_name, s.marks_percentage
FROM Students s
JOIN Departments d ON s.department_id = d.department_id
WHERE s.marks_percentage = (
    SELECT MAX(marks_percentage)
    FROM Students s2
    WHERE s2.department_id = s.department_id
);

-- Query2: Department wise Overall pass percentage along will number of failures 
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

-- Query3: Achievements by Event and Level
SELECT event_type, level, COUNT(*) AS total_achievements
FROM Achievements
GROUP BY event_type, level;

-- Query4: Attendance Report
SELECT s.student_name, a.total_days, a.present_days, 
       ROUND((a.present_days*100.0)/a.total_days, 2) AS attendance_percentage
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;

-- Query5: Final Promotion Status (Pass/Fail + Attendance)
SELECT s.student_name, s.marks_percentage, 
       ROUND((a.present_days*100.0)/a.total_days, 2) AS attendance_percentage,
       CASE 
           WHEN s.student_id IN (
               SELECT student_id FROM Marks GROUP BY student_id HAVING MIN(marks_obtained) < 35
           ) OR (a.present_days*100.0/a.total_days < 75) THEN 'Not Promoted'
           ELSE 'Promoted'
       END AS final_promotion_status
FROM Students s
JOIN Attendance a ON s.student_id = a.student_id;


