-- ============================================================
-- 06강 연습문제용 데이터
-- 테이블: JOBS, BORROWER, LOAN
-- 추가로 DEPARTMENTS, EMPLOYEES 테이블도 필요합니다.
-- → 04_functions_data.sql 을 먼저 실행하거나
--   all_setup.sql 을 사용하세요.
-- ============================================================

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

-- --------------------------------------------------------
-- BORROWER 테이블 (도서관 대출자)
-- 컬럼: BORROWER_ID, NAME, EMAIL, CITY
-- --------------------------------------------------------
DROP TABLE IF EXISTS LOAN;       -- 참조 관계 때문에 먼저 삭제
DROP TABLE IF EXISTS BORROWER;

CREATE TABLE BORROWER (
    BORROWER_ID  CHAR(4)        PRIMARY KEY,
    NAME         VARCHAR(30),
    EMAIL        VARCHAR(50),
    CITY         VARCHAR(30)
);

INSERT INTO BORROWER VALUES
    ('B001', 'Kim Jiyeon',   'jiyeon@email.com',   'Seoul'),
    ('B002', 'Park Sungmin', 'sungmin@email.com',  'Busan'),
    ('B003', 'Lee Narae',    'narae@email.com',    'Seoul'),
    ('B004', 'Choi Dongwoo', 'dongwoo@email.com',  'Incheon'),
    ('B005', 'Jung Haerin',  'haerin@email.com',   'Daejeon');

-- --------------------------------------------------------
-- LOAN 테이블 (대출 기록)
-- 컬럼: LOAN_ID, BORROWER_ID, BOOK_ID, LOAN_DATE, RETURN_DATE
-- 참고: BOOK_ID는 BOOK 테이블을 참조하지만
--       독립 실행을 위해 FK 제약 없이 생성합니다.
-- --------------------------------------------------------
CREATE TABLE LOAN (
    LOAN_ID      CHAR(4)    PRIMARY KEY,
    BORROWER_ID  CHAR(4),
    BOOK_ID      CHAR(4),
    LOAN_DATE    DATE,
    RETURN_DATE  DATE,
    FOREIGN KEY (BORROWER_ID) REFERENCES BORROWER(BORROWER_ID)
);

-- RETURN_DATE가 NULL이면 아직 반납하지 않은 대출입니다.
INSERT INTO LOAN VALUES
    ('L001', 'B001', 'B002', '2024-01-10', '2024-02-10'),
    ('L002', 'B002', 'B005', '2024-01-15',         NULL),
    ('L003', 'B001', 'B009', '2024-02-01', '2024-03-01'),
    ('L004', 'B003', 'B001', '2024-02-20',         NULL),
    ('L005', 'B002', 'B003', '2024-03-05', '2024-04-05');

-- B004, B005 (Choi Dongwoo, Jung Haerin)는 대출 기록 없음
-- → LEFT JOIN 실습에서 NULL 결과 확인용