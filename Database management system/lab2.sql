-- 1. Create database
CREATE DATABASE EMPLOYEE_MGMT;
USE EMPLOYEE_MGMT;

-- 2. Create DEPARTMENT table
CREATE TABLE DEPARTMENT (
    did INT PRIMARY KEY,
    departname VARCHAR(50),
    departcode VARCHAR(10) NOT NULL UNIQUE,
    email VARCHAR(50)
);

-- 3. Create EMPLOYEE table
CREATE TABLE EMPLOYEE (
    empno INT PRIMARY KEY,
    empname VARCHAR(50),
    designation VARCHAR(50),
    departid INT,
    licensno VARCHAR(20) NOT NULL UNIQUE,
    gender CHAR(1),
    salary DECIMAL(10,2),
    FOREIGN KEY (departid) REFERENCES DEPARTMENT(did)
);

DESC DEPARTMENT;
DESC EMPLOYEE;
-- 4. Insert records into DEPARTMENT
INSERT INTO DEPARTMENT (did, departname, departcode, email) VALUES
(301, 'Information Technology', 'IT', 'it@ourmail.com'),
(302, 'Human Resource', 'HR', 'hr@ourmail.com'),
(303, 'Finance', 'FI', 'fi@ourmail.com'),
(304, 'Marketing', 'MK', 'mk@ourmail.com'),
(305, 'Sales', 'SL', 'sl@ourmail.com');

-- 5. Insert records into EMPLOYEE
INSERT INTO EMPLOYEE (empno, empname, designation, departid, licensno, gender, salary) VALUES
(5004, 'Sameer Sharma', 'Officer', 301, '323-525', 'm', 38000),
(5010, 'Rakshya Acharya', 'Manager', 303, '987-321', 'f', 45000),
(5005, 'Krishna Devkota', 'Officer', 301, '547-685', 'm', 38000),
(5009, 'Ram Yadav', 'Salesperson', 304, '342-154', 'm', 35000),
(5003, 'Sunita Chaudhary', 'Salesperson', 305, '241-654', 'f', 35000);

SELECT * FROM DEPARTMENT;
SELECT * FROM EMPLOYEE;

ALTER TABLE EMPLOYEE
ADD CONSTRAINT chk_salary CHECK (salary > 15000);

ALTER TABLE EMPLOYEE
ALTER COLUMN departid SET DEFAULT 302;

INSERT INTO DEPARTMENT (did, departname, departcode, email)
VALUES (306, 'Account', 'AC', 'ac@ourmail.com');

INSERT INTO EMPLOYEE (empno, empname, designation, departid, licensno, gender, salary)
VALUES (5011, 'Anil Sharma', 'Accountant', 306, '654-321', 'm', 40000);

UPDATE EMPLOYEE
SET departid = 306
WHERE empno = 5010;

UPDATE DEPARTMENT
SET did = 308
WHERE did = 306;
 
SELECT empno, empname, departid, salary FROM EMPLOYEE;

-- Update employees who belong to Account department (did = 308) to another department, e.g., 302 (HR)
UPDATE EMPLOYEE SET departid = 302 WHERE departid = 308;

-- Delete Account department
DELETE FROM DEPARTMENT WHERE did = 308;
-- View all employee records
SELECT * FROM EMPLOYEE;

-- 1. Create Salesman table
CREATE TABLE Salesman (
    s_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    email VARCHAR(50) UNIQUE
);

-- 2. Create Customer table
CREATE TABLE Customer (
    c_id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    city VARCHAR(50),
    contact VARCHAR(20) UNIQUE
);

-- 3. Create Orders table
CREATE TABLE Orders (
    ord_no INT PRIMARY KEY,
    prch_amt DECIMAL(10,2)CHECK (prch_amt > 0),
    ord_date DATE NOT NULL,
    c_id INT,
    s_id INT,
    FOREIGN KEY (c_id) REFERENCES Customer(c_id),
    FOREIGN KEY (s_id) REFERENCES Salesman(s_id)
);



