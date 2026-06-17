-- --------------------------------------------------------
-- JOBS 테이블
-- 컬럼: JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
-- --------------------------------------------------------
DROP TABLE IF EXISTS JOBS;

CREATE TABLE JOBS (
    JOB_ID      CHAR(4)        PRIMARY KEY,
    JOB_TITLE   VARCHAR(50),
    MIN_SALARY  DECIMAL(10, 2),
    MAX_SALARY  DECIMAL(10, 2)
);

INSERT INTO JOBS VALUES
    ('J001', 'Software Engineer',  60000.00, 120000.00),
    ('J002', 'Marketing Manager',  45000.00,  85000.00),
    ('J003', 'HR Specialist',      40000.00,  70000.00),
    ('J004', 'Data Scientist',     75000.00, 150000.00),
    ('J005', 'Recruiter',          38000.00,  65000.00),
    ('J006', 'Senior Engineer',    80000.00, 140000.00),
    ('J007', 'ML Engineer',        85000.00, 160000.00);
