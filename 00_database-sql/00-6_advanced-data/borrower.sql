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
