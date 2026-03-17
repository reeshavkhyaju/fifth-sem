-- CREATE DATABASE companydb;
-- USE companydb;

-- CREATE TABLE employee (
--     eid INT PRIMARY KEY,
--     ename VARCHAR(50),
--     age INT,
--     dept VARCHAR(50)
-- );

-- CREATE TABLE company (
--     compid INT PRIMARY KEY,
--     companyname VARCHAR(50),
--     city VARCHAR(50)
-- );

-- CREATE TABLE works (
--     eid INT,
--     compid INT,
--     salary DECIMAL(10,2),
--     FOREIGN KEY (eid) REFERENCES employee(eid),
--     FOREIGN KEY (compid) REFERENCES company(compid)
-- );

-- INSERT INTO employee (eid, ename, age, dept) VALUES
-- (1, 'Employee1', 25, 'IT'),
-- (2, 'Employee2', 28, 'HR'),
-- (3, 'Employee3', 30, 'Finance'),
-- (4, 'Employee4', 27, 'Marketing'),
-- (5, 'Employee5', 29, 'IT'),
-- (6, 'Employee6', 32, 'HR'),
-- (7, 'Employee7', 26, 'Finance'),
-- (8, 'Employee8', 31, 'Marketing'),
-- (9, 'Employee9', 24, 'IT'),
-- (10, 'Employee10', 33, 'Finance'),

-- (11, 'Employee11', 28, 'HR'),
-- (12, 'Employee12', 35, 'IT'),
-- (13, 'Employee13', 29, 'Marketing'),
-- (14, 'Employee14', 27, 'Finance'),
-- (15, 'Employee15', 30, 'IT'),
-- (16, 'Employee16', 26, 'HR'),
-- (17, 'Employee17', 34, 'Finance'),
-- (18, 'Employee18', 25, 'Marketing'),
-- (19, 'Employee19', 31, 'IT'),
-- (20, 'Employee20', 29, 'HR'),

-- (21, 'Employee21', 27, 'Finance'),
-- (22, 'Employee22', 33, 'Marketing'),
-- (23, 'Employee23', 24, 'IT'),
-- (24, 'Employee24', 36, 'Finance'),
-- (25, 'Employee25', 28, 'HR'),
-- (26, 'Employee26', 30, 'IT'),
-- (27, 'Employee27', 32, 'Marketing'),
-- (28, 'Employee28', 26, 'Finance'),
-- (29, 'Employee29', 29, 'IT'),
-- (30, 'Employee30', 35, 'HR'),

-- (31, 'Employee31', 27, 'Finance'),
-- (32, 'Employee32', 31, 'Marketing'),
-- (33, 'Employee33', 25, 'IT'),
-- (34, 'Employee34', 34, 'Finance'),
-- (35, 'Employee35', 28, 'HR'),
-- (36, 'Employee36', 30, 'IT'),
-- (37, 'Employee37', 26, 'Marketing'),
-- (38, 'Employee38', 33, 'Finance'),
-- (39, 'Employee39', 29, 'IT'),
-- (40, 'Employee40', 32, 'HR'),

-- (41, 'Employee41', 24, 'Finance'),
-- (42, 'Employee42', 35, 'Marketing'),
-- (43, 'Employee43', 27, 'IT'),
-- (44, 'Employee44', 31, 'HR'),
-- (45, 'Employee45', 28, 'Finance'),
-- (46, 'Employee46', 30, 'IT'),
-- (47, 'Employee47', 26, 'Marketing'),
-- (48, 'Employee48', 34, 'Finance'),
-- (49, 'Employee49', 29, 'HR'),
-- (50, 'Employee50', 33, 'IT');

-- INSERT INTO company (compid, companyname, city) VALUES
-- (101, 'NMB Bank', 'Kathmandu'),
-- (102, 'WorldLink', 'Lalitpur'),
-- (103, 'F1Soft', 'Kathmandu'),
-- (104, 'Leapfrog', 'Bhaktapur'),
-- (105, 'Deerwalk', 'Bhaktapur');

-- INSERT INTO works (eid, compid, salary) VALUES
-- (1,101,42000),(2,102,43000),(3,103,46000),(4,104,39000),(5,105,48000),
-- (6,101,51000),(7,102,40000),(8,103,53000),(9,104,37000),(10,105,56000),

-- (11,101,42000),(12,102,61000),(13,103,44000),(14,104,43000),(15,105,49000),
-- (16,101,38000),(17,102,59000),(18,103,36000),(19,104,52000),(20,105,45000),

-- (21,101,47000),(22,102,55000),(23,103,35000),(24,104,63000),(25,105,44000),
-- (26,101,50000),(27,102,53000),(28,103,41000),(29,104,48000),(30,105,62000),

-- (31,101,46000),(32,102,54000),(33,103,37000),(34,104,60000),(35,105,43000),
-- (36,101,51000),(37,102,40000),(38,103,57000),(39,104,49000),(40,105,53000),

-- (41,101,38000),(42,102,61000),(43,103,45000),(44,104,52000),(45,105,47000),
-- (46,101,50000),(47,102,39000),(48,103,58000),(49,104,46000),(50,105,56000);


DROP VIEW IF EXISTS emp_basic_view;
DROP VIEW IF EXISTS emp_it_view;
DROP VIEW IF EXISTS emp_company_view;
DROP VIEW IF EXISTS dept_avg_salary_view;
DROP VIEW IF EXISTS works_view;
DROP VIEW IF EXISTS company_view;

show databases;
use companydb;

-- 1. Create simple view containing id, name, age, department
CREATE VIEW emp_basic_view AS SELECT eid, ename, age, dept FROM employee;

-- 2. Create simple view for IT department employees only
CREATE VIEW emp_it_view AS SELECT eid, ename, age FROM employee WHERE dept='IT';

-- 3. Create complex view showing employee, company and salary details
CREATE VIEW emp_company_view AS SELECT e.eid, e.ename, c.companyname, c.city, w.salary FROM employee e JOIN works w ON e.eid=w.eid JOIN company c ON w.compid=c.compid;

-- 4. Create complex view showing department name and average salary
CREATE VIEW dept_avg_salary_view AS SELECT e.dept, AVG(w.salary) AS avg_salary FROM employee e JOIN works w ON e.eid=w.eid GROUP BY e.dept;

-- 5. Read names of employees with age greater than 25 from IT view
SELECT ename FROM emp_it_view WHERE age>25;

-- 6. Create a view from WORKS relation and update salary by 3000 for company id 102
CREATE VIEW works_view AS SELECT * FROM works;
UPDATE works_view SET salary=salary+3000 WHERE compid=102;

-- 7. Create simple view of company and update city of 'F1Soft'
CREATE VIEW company_view AS SELECT * FROM company;

SET SQL_SAFE_UPDATES = 0;
UPDATE company_view SET city='Kavre' WHERE companyname='F1Soft';
SET SQL_SAFE_UPDATES = 1;

-- 8. Add new company record through company view
INSERT INTO company_view (compid,companyname,city) VALUES (109,'TechNepal','Kathmandu');

-- 9. Insert a record of new employee through emp_basic_view
INSERT INTO emp_basic_view (eid,ename,age,dept) VALUES (54,'Employee51',27,'IT');

-- 10. Delete employees with age less than 25 working in IT department
SET SQL_SAFE_UPDATES = 0;
-- Disable FK checks
SET FOREIGN_KEY_CHECKS=0;

DELETE FROM emp_basic_view WHERE age<25 AND dept='IT';

-- Re-enable FK checks
SET FOREIGN_KEY_CHECKS=1;
SET SQL_SAFE_UPDATES = 1;

-- 11. Delete company record added in Qn 8
DELETE FROM company_view WHERE compid=106;

-- 12. Remove all created views
DROP VIEW IF EXISTS emp_basic_view;
DROP VIEW IF EXISTS emp_it_view;
DROP VIEW IF EXISTS emp_company_view;
DROP VIEW IF EXISTS dept_avg_salary_view;
DROP VIEW IF EXISTS works_view;
DROP VIEW IF EXISTS company_view;
