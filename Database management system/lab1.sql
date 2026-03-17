-- 1. Create Database
CREATE DATABASE COLLEGE_MGMT; 
USE COLLEGE_MGMT;

-- 2. Create Student Table
CREATE TABLE STUDENT (
    crn INT PRIMARY KEY,
    fullname VARCHAR(100),
    address VARCHAR(100),
    cgpa DECIMAL(3, 2),
    dob DATE,
    gender CHAR(1),
    status VARCHAR(10)
);

-- Show Description
DESC STUDENT;

INSERT INTO STUDENT (crn, fullname, address, cgpa, dob, gender, status) VALUES 
(1001, 'Laxman Shrestha', 'Pokhara', 3.4, '1995-05-18', 'm', 'Active'),
(1002, 'Gita Sharma', 'Kathmandu', 3.2, '1992-06-20', 'f', 'Active'),
(1003, 'Sita Baraili', 'Pokhara', 2.5, '1995-02-11', 'f', 'Inactive'),
(1004, 'Dipendra Shahi', 'Kailali', 3.1, '1996-12-11', 'm', 'Active'),
(1005, 'Hari Dhakal', 'Makawanpur', 2.2, '1996-10-04', 'm', 'Inactive');

-- 4. Display all records
SELECT * FROM STUDENT;

-- 5. Fullname and address of students from Pokhara
SELECT fullname, address FROM STUDENT WHERE address = 'Pokhara';

-- 6. Male students who are active
SELECT * FROM STUDENT WHERE gender = 'm' AND status = 'Active';

-- 7. Students with CGPA > 3.0
SELECT * FROM STUDENT WHERE cgpa > 3.0;

-- 8. Update address for crn 1001
UPDATE STUDENT SET address = 'Bhaktapur' WHERE crn = 1001;

-- 9. Update status to Active for CGPA > 3.0
UPDATE STUDENT SET status = 'Active' WHERE cgpa > 3.0;

-- 10. Add email column
ALTER TABLE STUDENT ADD email VARCHAR(50);

-- 11. Rename address column to district
ALTER TABLE STUDENT CHANGE address district VARCHAR(100);

-- 12. Rename table to student_info
RENAME TABLE STUDENT TO student_info;

-- 13. Remove district column
ALTER TABLE student_info DROP COLUMN district;

-- 14. Delete record with crn 1005
DELETE FROM student_info WHERE crn = 1005;

-- 15. Delete inactive students
DELETE FROM student_info WHERE status = 'Inactive';

-- 16. Delete all records from the table
TRUNCATE TABLE student_info;

-- 17. Delete the table
DROP TABLE student_info;

-- 18. Delete the database
DROP DATABASE COLLEGE_MGMT;