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
