-- select length('john doe') from dual;
-- select lower('JOHN doe') from dual;
-- select lower('jOHn Doe') as fname from dual;
-- select 5*6 as product from dual;
-- select curdate() from dual;
-- select now() from dual;
-- select year('2023-11-22') from dual;
-- select month('2023-11-22') from dual;
-- select day('2023-11-22') from dual;
-- select datediff('2025-11-23','2020-03-11') from dual;
-- select current_date() from dual;
-- select curdate() from dual;

CREATE DATABASE labsheet4;
USE labsheet4;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30),
    email VARCHAR(50),
    salary DECIMAL(10,2),
    join_date DATE,
    login_time DATETIME
);

INSERT INTO employees VALUES
(1, 'Ramesh', 'Prajapati', 'ramesh@gmail.com', 45000.50, '2022-01-15', '2022-01-15 09:15:30'),
(2, 'Sita', 'Shrestha', 'sita@company.com', 38000.00, '2021-07-10', '2021-07-10 10:05:20'),
(3, 'Hari', 'Thapa', 'hari@yahoo.com', 52000.75, '2020-03-22', '2020-03-22 08:55:10'),
(4, 'Gita', 'Koirala', 'gita@outlook.com', 60000.00, '2019-11-01', '2019-11-01 09:45:00');

-- 1. Display full name
SELECT CONCAT(first_name,' ',last_name) AS full_name FROM employees;

-- 2. First name in uppercase
SELECT UPPER(first_name) AS first_name_upper FROM employees;

-- 3. Last name in lowercase
SELECT LOWER(last_name) AS last_name_lower FROM employees;

-- 4. Length of email
SELECT LENGTH(email) AS email_length FROM employees;

-- 5. First 5 characters of email
SELECT SUBSTRING(email,1,5) AS email_first_5_chars FROM employees;

-- 6. Position of '@' symbol
SELECT LOCATE('@',email) AS at_position FROM employees;

-- 7. Replace gmail.com with company.com
SELECT REPLACE(email,'gmail.com','company.com') AS updated_email FROM employees;

-- 8. Trim spaces
SELECT TRIM(first_name) AS trimmed_first_name FROM employees;

-- 9. Salary rounded to nearest integer
SELECT ROUND(salary) AS rounded_salary FROM employees;

-- 10. Salary with 1 decimal place
SELECT ROUND(salary,1) AS salary_one_decimal FROM employees;

-- 11. Ceiling value of salary
SELECT CEILING(salary) AS ceiling_salary FROM employees;

-- 12. Floor value of salary
SELECT FLOOR(salary) AS floor_salary FROM employees;

-- 13. Annual salary
SELECT first_name, salary*12 AS annual_salary FROM employees;

-- 14. Absolute value of -1500
SELECT ABS(-1500) AS absolute_value;

-- 15. Volume of cube (length = 35)
SELECT POWER(35,3) AS cube_volume;

-- 16. Display current date
SELECT CURDATE() AS today_date;

-- 17. Display current time
-- SELECT CURTIME() AS current_time;

-- 18. Display current date and time
-- SELECT NOW() AS current_datetime;

-- 19. Extract joining year
-- SELECT YEAR(join_date) AS joining_year FROM employees;

-- 20. Extract joining month
-- SELECT MONTH(join_date) AS joining_month FROM employees;

-- 21. Extract joining day
-- SELECT DAY(join_date) AS joining_day FROM employees;

-- 22. Work experience in days
-- SELECT DATEDIFF(CURDATE(), join_date) AS experience_days FROM employees;

-- 17. Display current time
SELECT CURTIME() AS system_time;

-- 18. Display current date and time
SELECT NOW() AS system_datetime;

-- 19. Extract joining year
SELECT YEAR(join_date) AS join_year FROM employees;

-- 20. Extract joining month
SELECT MONTH(join_date) AS join_month FROM employees;

-- 21. Extract joining day
SELECT DAY(join_date) AS join_day FROM employees;

-- 22. Calculate work experience in days
SELECT DATEDIFF(CURDATE(), join_date) AS experience_days FROM employees;