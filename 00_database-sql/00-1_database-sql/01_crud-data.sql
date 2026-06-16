-- ============================================================
-- 01강 연습문제용 데이터
-- 테이블: EMPLOYEE, INSTRUCTOR, MEDALS
-- ============================================================

-- --------------------------------------------------------
-- EMPLOYEE 테이블
-- 컬럼: EMP_ID, NAME, DEPT, SALARY, COUNTRY
-- --------------------------------------------------------
DROP TABLE IF EXISTS EMPLOYEE;

CREATE TABLE EMPLOYEE (
    EMP_ID   CHAR(4)        NOT NULL,
    NAME     VARCHAR(30)    NOT NULL,
    DEPT     VARCHAR(20),
    SALARY   DECIMAL(10, 2),
    COUNTRY  VARCHAR(30),
    PRIMARY KEY (EMP_ID)
);

INSERT INTO EMPLOYEE VALUES
    ('E001', 'Kim Minjun',   'Engineering',  75000.00, 'Korea'),
    ('E002', 'Lee Soyeon',   'Marketing',    52000.00, 'Korea'),
    ('E003', 'Park Jinho',   'HR',           48000.00, 'Korea'),
    ('E004', 'John Smith',   'Engineering',  82000.00, 'USA'),
    ('E005', 'Maria Garcia', 'Marketing',    61000.00, 'USA'),
    ('E006', 'James Brown',  'HR',           45000.00, 'USA'),
    ('E007', 'Priya Sharma', 'Engineering',  70000.00, 'India'),
    ('E008', 'Liu Wei',      'Data Science', 88000.00, 'China'),
    ('E009', 'Ana Silva',    'Data Science', 92000.00, 'Brazil'),
    ('E010', 'Tom Wilson',   'HR',           47000.00, 'UK');

-- --------------------------------------------------------
-- INSTRUCTOR 테이블
-- 컬럼: ID, NAME, DEPT
-- --------------------------------------------------------
DROP TABLE IF EXISTS INSTRUCTOR;

CREATE TABLE INSTRUCTOR (
    ID    CHAR(2)      PRIMARY KEY,
    NAME  VARCHAR(30),
    DEPT  VARCHAR(30)
);

INSERT INTO INSTRUCTOR VALUES
    ('A1', 'John Kim',  'Data Science'),
    ('A2', 'Jane Lee',  'SQL'),
    ('A3', 'Mike Park', 'Python');

-- --------------------------------------------------------
-- MEDALS 테이블
-- 컬럼: ID, COUNTRY, YEAR, SPORT, GOLD, SILVER, BRONZE
-- --------------------------------------------------------
DROP TABLE IF EXISTS MEDALS;

CREATE TABLE MEDALS (
    ID      INTEGER      PRIMARY KEY,
    COUNTRY VARCHAR(30),
    YEAR    INTEGER,
    SPORT   VARCHAR(30),
    GOLD    INTEGER,
    SILVER  INTEGER,
    BRONZE  INTEGER
);

INSERT INTO MEDALS VALUES
    (1,  'USA',       2020, 'Athletics', 10, 8, 6),
    (2,  'China',     2020, 'Swimming',   8, 6, 4),
    (3,  'USA',       2020, 'Swimming',   6, 5, 3),
    (4,  'Japan',     2020, 'Judo',       9, 2, 1),
    (5,  'Korea',     2020, 'Archery',    4, 2, 3),
    (6,  'UK',        2020, 'Cycling',    6, 7, 6),
    (7,  'Australia', 2020, 'Swimming',   5, 3, 5),
    (8,  'France',    2020, 'Athletics',  3, 5, 4),
    (9,  'Germany',   2020, 'Rowing',     4, 3, 2),
    (10, 'Canada',    2020, 'Wrestling',  2, 4, 5);