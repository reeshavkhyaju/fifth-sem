CREATE DATABASE IF NOT EXISTS company;
USE company;

CREATE TABLE IF NOT EXISTS manager(
	mid int(4),
    mname varchar(30),
    did int(4),
    gender enum('m','f'),
    salary float(7,2)
    );

CREATE TABLE IF NOT EXISTS employee(
	empno int(4),
    empname varchar(30),
    designation varchar(20),
    did int(4),
    gender enum('m','f'),
    salary float(7,2),
    mid int(4)
    );

CREATE TABLE IF NOT EXISTS department(
	did int(4),
    departname varchar(30),
    departcode varchar(4),
    email varchar(30)
    );
    
ALTER TABLE employee ADD PRIMARY KEY(empno);
ALTER TABLE manager ADD PRIMARY KEY(mid);
ALTER TABLE department ADD PRIMARY KEY(did);

ALTER TABLE employee ADD CONSTRAINT dept_fkey FOREIGN KEY(did) REFERENCES department(did) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE manager ADD CONSTRAINT mdept_fkey FOREIGN KEY(did)REFERENCES department(did) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE employee ADD CONSTRAINT mid_fkey FOREIGN KEY(mid) REFERENCES manager(mid) ON UPDATE CASCADE ON DELETE CASCADE;
ALTER TABLE department ADD CONSTRAINT dcode_ukey UNIQUE KEY(departcode);

INSERT INTO department VALUES
	(301, "Information Technology", "IT","it@ourmail.com"),
    (302, "Human Resource", "HR","hr@ourmail.com"),
    (303, "Finance", "FI","fi@ourmail.com"),
    (304, "Marketing", "MK","mk@ourmail.com"),
    (305, "Sales", "SL","sl@ourmail.com");

INSERT INTO manager VALUES
	(601,"Rohit Sharma", 301, 'm', 38000),
    (603,"Geeta Chand", 303, 'f', 45000),
    (604,"Raj Shrestha", 304, 'm', 38000),
    (602,"Mukunda Ghimire", 302, 'm', 50000),
    (605,"Sushil Shah", null, 'm', 60000);

INSERT INTO employee VALUES
	(601,"Rohit Sharma","Manager", 301, 'm', 38000, 602),
    (603,"Geeta Chand", "Manager", 303, 'f', 45000, 602),
	(504,"Sameer Sharma", "Officer", 301, 'm', 38000,601),
    (510,"Rakshya Acharya", "Accountant", 303, 'f', 45000,603),
    (505,"Krishna Devkota", "Officer", 301, 'm', 38000,601),
    (509,"Ram Yadav", "Salesperson", 304, 'm', 35000,604),
    (503,"Sunita Chaudhary", "Salesperson", 305, 'f', 35000, null),
    (506,"Ashmita Lama", "Salesperson", 305, 'f', 35000, null);

---
-- LAB WORKS 4 SELECT QUERIES
---

-- 1a. UNION
SELECT empno, empname, salary FROM employee 
UNION 
SELECT mid, mname, salary FROM manager;

-- 1b. UNION ALL
SELECT empno, empname, salary FROM employee 
UNION ALL 
SELECT mid, mname, salary FROM manager;

-- 2. Unique names from both tables
SELECT empname FROM employee 
UNION 
SELECT mname FROM manager;

-- 3. Filtered UNION
SELECT empname FROM employee WHERE gender = 'f' 
UNION 
SELECT mname FROM manager WHERE gender = 'm';

-- 4. Unique salary list
SELECT salary FROM employee 
UNION 
SELECT salary FROM manager;

-- 5. CROSS JOIN (Corrected to 'departname')
SELECT e.empno, e.empname, d.did, d.departname 
FROM employee AS e 
CROSS JOIN department AS d;

-- 6. NATURAL JOIN
SELECT * FROM manager 
NATURAL JOIN department;

-- 7. INNER JOIN (Corrected to 'departname')
SELECT e.empname, d.departname 
FROM employee AS e 
JOIN department AS d ON e.did = d.did;

-- 8. INNER JOIN (Employee and Manager)
SELECT e.empname, m.mname 
FROM employee AS e 
JOIN manager AS m ON e.mid = m.mid;

-- 9. LEFT JOIN (Corrected to 'departname')
SELECT e.empname, d.departname 
FROM employee AS e 
LEFT JOIN department AS d ON e.did = d.did;

-- 10. LEFT JOIN (Employee and Manager)
SELECT e.empname, m.mname 
FROM employee AS e 
LEFT JOIN manager AS m ON e.mid = m.mid;

-- 11. LEFT JOIN (Corrected to 'departname')
SELECT d.departname, m.mname 
FROM department AS d 
LEFT JOIN manager AS m ON d.did = m.did;

-- 12. Distinct IDs
SELECT DISTINCT mid FROM employee WHERE mid IS NOT NULL;

-- 13. Find employees who do NOT have a manager assigned
SELECT e.empname 
FROM employee AS e 
LEFT JOIN manager AS m ON e.mid = m.mid 
WHERE m.mid IS NULL;

-- 14. COMPREHENSIVE JOIN (Corrected to 'departcode' and 'departname')
SELECT 
    d.departcode, 
    d.departname, 
    m.mname, 
    e.empname, 
    e.designation
FROM employee AS e
LEFT JOIN department AS d ON e.did = d.did
LEFT JOIN manager AS m ON e.mid = m.mid;