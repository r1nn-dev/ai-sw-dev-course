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
