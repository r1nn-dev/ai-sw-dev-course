-- --------------------------------------------------------
-- EMPLOYEES 테이블
-- 컬럼: EMP_ID, F_NAME, L_NAME, DEP_ID, SALARY, JOB_TITLE
-- --------------------------------------------------------
CREATE TABLE EMPLOYEES (
    EMP_ID     CHAR(4)        PRIMARY KEY,
    F_NAME     VARCHAR(20),
    L_NAME     VARCHAR(20),
    DEP_ID     CHAR(3),
    SALARY     DECIMAL(10, 2),
    JOB_TITLE  VARCHAR(30),
    FOREIGN KEY (DEP_ID) REFERENCES DEPARTMENTS(DEPT_ID_DEP)
);

INSERT INTO EMPLOYEES VALUES
    ('E001', 'Minjun', 'Kim',    'D01', 75000.00, 'Software Engineer'),
    ('E002', 'Soyeon', 'Lee',    'D02', 52000.00, 'Marketing Manager'),
    ('E003', 'Jinho',  'Park',   'D03', 48000.00, 'HR Specialist'),
    ('E004', 'John',   'Smith',  'D01', 82000.00, 'Senior Engineer'),
    ('E005', 'Maria',  'Garcia', 'D02', 61000.00, 'Marketing Analyst'),
    ('E006', 'James',  'Brown',  'D03', 45000.00, 'HR Manager'),
    ('E007', 'Priya',  'Sharma', 'D01', 70000.00, 'Data Engineer'),
    ('E008', 'Wei',    'Liu',    'D04', 88000.00, 'Data Scientist'),
    ('E009', 'Ana',    'Silva',  'D04', 92000.00, 'ML Engineer'),
    ('E010', 'Tom',    'Wilson', 'D03', 47000.00, 'Recruiter');
