-- ============================================================
-- 04강 연습문제용 데이터
-- 테이블: PETRESCUE, SALES, DEPARTMENTS, EMPLOYEES
-- ============================================================

-- --------------------------------------------------------
-- PETRESCUE 테이블
-- 컬럼: ID, ANIMAL, QUANTITY, COST, RESCUEDATE
-- --------------------------------------------------------
DROP TABLE IF EXISTS PETRESCUE;

CREATE TABLE PETRESCUE (
    ID          INTEGER        PRIMARY KEY,
    ANIMAL      VARCHAR(20),
    QUANTITY    INTEGER,
    COST        DECIMAL(8, 2),
    RESCUEDATE  DATE
);

INSERT INTO PETRESCUE VALUES
    (1,  'Dog',     2, 450.00, '2021-05-15'),
    (2,  'Cat',     3, 300.00, '2021-06-20'),
    (3,  'Parrot',  1, 150.00, '2021-07-10'),
    (4,  'Dog',     1, 225.00, '2021-08-05'),
    (5,  'Rabbit',  2, 180.00, '2021-09-12'),
    (6,  'Cat',     1, 100.00, '2021-10-03'),
    (7,  'Dog',     3, 675.00, '2021-11-18'),
    (8,  'Hamster', 4, 120.00, '2021-12-01'),
    (9,  'Parrot',  2, 300.00, '2022-01-15'),
    (10, 'Cat',     2, 200.00, '2022-02-28');

-- --------------------------------------------------------
-- SALES 테이블
-- 컬럼: ID, PRODUCT, AMOUNT, SALEDATE
-- --------------------------------------------------------
DROP TABLE IF EXISTS SALES;

CREATE TABLE SALES (
    ID        INTEGER        PRIMARY KEY,
    PRODUCT   VARCHAR(50),
    AMOUNT    DECIMAL(10, 2),
    SALEDATE  DATE
);

INSERT INTO SALES VALUES
    (1,  'Laptop',   1200.00, '2023-01-15'),
    (2,  'Keyboard',  150.00, '2023-02-10'),
    (3,  'Monitor',   450.00, '2023-02-20'),
    (4,  'Laptop',   1350.00, '2023-03-05'),
    (5,  'Mouse',      80.00, '2023-03-18'),
    (6,  'Tablet',    750.00, '2023-04-12'),
    (7,  'Keyboard',  200.00, '2023-05-08'),
    (8,  'Monitor',   500.00, '2023-06-22'),
    (9,  'Laptop',   1100.00, '2023-07-14'),
    (10, 'Tablet',    820.00, '2023-08-30');

-- --------------------------------------------------------
-- DEPARTMENTS 테이블
-- 컬럼: DEPT_ID_DEP, DEP_NAME, MANAGER_ID, LOCATION
-- --------------------------------------------------------
DROP TABLE IF EXISTS EMPLOYEES;     -- 참조 관계 때문에 EMPLOYEES 먼저 삭제
DROP TABLE IF EXISTS DEPARTMENTS;

CREATE TABLE DEPARTMENTS (
    DEPT_ID_DEP  CHAR(3)      PRIMARY KEY,
    DEP_NAME     VARCHAR(30),
    MANAGER_ID   CHAR(4),
    LOCATION     VARCHAR(30)
);

INSERT INTO DEPARTMENTS VALUES
    ('D01', 'Engineering',  'E004', 'Seoul'),
    ('D02', 'Marketing',    'E005', 'New York'),
    ('D03', 'HR',           'E006', 'London'),
    ('D04', 'Data Science', 'E008', 'Beijing');

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