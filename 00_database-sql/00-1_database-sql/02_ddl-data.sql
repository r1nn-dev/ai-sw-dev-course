-- ============================================================
-- 02강 연습문제용 데이터
-- 테이블: AUTHOR, BOOK
-- 03강 연습문제도 이 파일을 사용합니다.
-- ============================================================

-- --------------------------------------------------------
-- AUTHOR 테이블
-- 컬럼: AUTHOR_ID, FIRSTNAME, LASTNAME, COUNTRY, BIRTHDATE
-- --------------------------------------------------------
DROP TABLE IF EXISTS BOOK;       -- BOOK이 AUTHOR를 참조하므로 먼저 삭제
DROP TABLE IF EXISTS AUTHOR;

CREATE TABLE AUTHOR (
    AUTHOR_ID  CHAR(2)       PRIMARY KEY,
    FIRSTNAME  VARCHAR(20),
    LASTNAME   VARCHAR(20),
    COUNTRY    VARCHAR(20),
    BIRTHDATE  DATE
);

INSERT INTO AUTHOR VALUES
    ('A1', 'Patrick',  'Modiano',  'France',    '1945-07-30'),
    ('A2', 'Haruki',   'Murakami', 'Japan',     '1949-01-12'),
    ('A3', 'Gabriel',  'Silva',    'Brazil',    '1960-03-15'),
    ('A4', 'Jane',     'Smith',    'Australia', '1975-06-22'),
    ('A5', 'Carlos',   'Santos',   'Spain',     '1958-09-08'),
    ('A6', 'Emma',     'Stone',    'Canada',    '1980-11-14'),
    ('A7', 'Raj',      'Sharma',   'India',     '1965-02-28'),
    ('A8', 'Sophie',   'Martin',   'France',    '1972-08-19');

-- --------------------------------------------------------
-- BOOK 테이블
-- 컬럼: BOOK_ID, TITLE, AUTHOR_ID, PRICE, YEAR_PUBLISHED
-- --------------------------------------------------------
CREATE TABLE BOOK (
    BOOK_ID        CHAR(4)        PRIMARY KEY,
    TITLE          VARCHAR(100),
    AUTHOR_ID      CHAR(2),
    PRICE          DECIMAL(6, 2),
    YEAR_PUBLISHED INTEGER,
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID)
);

INSERT INTO BOOK VALUES
    ('B001', 'The Night Watch',   'A1', 15.99, 1999),
    ('B002', 'Norwegian Wood',    'A2', 18.50, 1987),
    ('B003', 'Ocean Echoes',      'A3', 12.00, 2005),
    ('B004', 'Red Summer',        'A4', 22.00, 2018),
    ('B005', 'Dark Wind',         'A5', 19.99, 2010),
    ('B006', 'Morning Light',     'A6', 14.50, 2015),
    ('B007', 'Silver Thread',     'A7', 16.75, 2012),
    ('B008', 'Paris Letters',     'A1', 21.00, 2008),
    ('B009', 'Tokyo Dreams',      'A2', 24.99, 2002),
    ('B010', 'Mountain Road',     'A4', 11.00, 2020);