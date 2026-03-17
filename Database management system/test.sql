/* =========================================================
   DATABASE
   ========================================================= */
DROP DATABASE IF EXISTS school_management;
CREATE DATABASE school_management;
USE school_management;

/* =========================================================
   ADMIN
   ========================================================= */
CREATE TABLE admins (
    admin_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('SUPER_ADMIN','ADMIN') DEFAULT 'ADMIN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* =========================================================
   STUDENTS
   ========================================================= */
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    roll_no VARCHAR(20) NOT NULL UNIQUE,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    gender ENUM('Male','Female','Other'),
    dob DATE,
    email VARCHAR(100),
    phone VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

/* =========================================================
   TEACHERS
   ========================================================= */
CREATE TABLE teachers (
    teacher_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(15),
    hire_date DATE
);

/* =========================================================
   ACADEMIC YEAR (SESSION)
   ========================================================= */
CREATE TABLE academic_years (
    year_id INT AUTO_INCREMENT PRIMARY KEY,
    year_name VARCHAR(20) NOT NULL UNIQUE,  -- 2024-2025
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT 0
);

/* =========================================================
   CLASSES
   ========================================================= */
CREATE TABLE classes (
    class_id INT AUTO_INCREMENT PRIMARY KEY,
    class_name VARCHAR(20) NOT NULL,     -- Class 10
    section VARCHAR(10) NOT NULL,         -- A / B
    year_id INT NOT NULL,
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id)
        ON DELETE CASCADE ON UPDATE CASCADE
);

/* =========================================================
   SUBJECTS
   ========================================================= */
CREATE TABLE subjects (
    subject_id INT AUTO_INCREMENT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    subject_code VARCHAR(20) UNIQUE NOT NULL
);

/* =========================================================
   CLASS-SUBJECT-TEACHER MAPPING
   ========================================================= */
CREATE TABLE class_subjects (
    class_subject_id INT AUTO_INCREMENT PRIMARY KEY,
    class_id INT NOT NULL,
    subject_id INT NOT NULL,
    teacher_id INT NOT NULL,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
        ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON DELETE CASCADE,
    FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id)
        ON DELETE CASCADE,
    UNIQUE (class_id, subject_id)
);

/* =========================================================
   STUDENT ENROLLMENT (SESSION WISE)
   ========================================================= */
CREATE TABLE student_enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    class_id INT NOT NULL,
    year_id INT NOT NULL,
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
        ON DELETE CASCADE,
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id)
        ON DELETE CASCADE,
    UNIQUE (student_id, year_id)
);

/* =========================================================
   EXAMS
   ========================================================= */
CREATE TABLE exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_name VARCHAR(50) NOT NULL,     -- Midterm / Final
    class_id INT NOT NULL,
    year_id INT NOT NULL,
    exam_date DATE,
    FOREIGN KEY (class_id) REFERENCES classes(class_id)
        ON DELETE CASCADE,
    FOREIGN KEY (year_id) REFERENCES academic_years(year_id)
        ON DELETE CASCADE
);

/* =========================================================
   EXAM SUBJECTS
   ========================================================= */
CREATE TABLE exam_subjects (
    exam_subject_id INT AUTO_INCREMENT PRIMARY KEY,
    exam_id INT NOT NULL,
    subject_id INT NOT NULL,
    full_marks INT NOT NULL,
    pass_marks INT NOT NULL,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON DELETE CASCADE,
    UNIQUE (exam_id, subject_id)
);

/* =========================================================
   RESULTS
   ========================================================= */
CREATE TABLE results (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    exam_id INT NOT NULL,
    subject_id INT NOT NULL,
    marks_obtained INT CHECK (marks_obtained >= 0),
    grade VARCHAR(5),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
        ON DELETE CASCADE,
    FOREIGN KEY (exam_id) REFERENCES exams(exam_id)
        ON DELETE CASCADE,
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
        ON DELETE CASCADE,
    UNIQUE (student_id, exam_id, subject_id)
);

/* =========================================================
   SAMPLE DATA (OPTIONAL BUT WORKING)
   ========================================================= */

/* Academic Year */
INSERT INTO academic_years (year_name, start_date, end_date, is_active)
VALUES ('2025-2026', '2025-04-01', '2026-03-31', 1);

/* Classes */
INSERT INTO classes (class_name, section, year_id)
VALUES ('Class 10', 'A', 1);

/* Subjects */
INSERT INTO subjects (subject_name, subject_code)
VALUES 
('Mathematics', 'MTH101'),
('Science', 'SCI101'),
('English', 'ENG101');

/* Teacher */
INSERT INTO teachers (first_name, last_name, email, phone, hire_date)
VALUES ('Ram', 'Sharma', 'ram@school.com', '9800000000', '2022-01-01');

/* Assign Subject */
INSERT INTO class_subjects (class_id, subject_id, teacher_id)
VALUES (1, 1, 1);

/* Student */
INSERT INTO students (roll_no, first_name, last_name, gender)
VALUES ('10A01', 'Aamod', 'Baral', 'Male');

/* Enrollment */
INSERT INTO student_enrollments (student_id, class_id, year_id)
VALUES (1, 1, 1);

/* Exam */
INSERT INTO exams (exam_name, class_id, year_id, exam_date)
VALUES ('Final Exam', 1, 1, '2026-02-15');

/* Exam Subject */
INSERT INTO exam_subjects (exam_id, subject_id, full_marks, pass_marks)
VALUES (1, 1, 100, 40);

/* Result */
INSERT INTO results (student_id, exam_id, subject_id, marks_obtained, grade)
VALUES (1, 1, 1, 85, 'A');
