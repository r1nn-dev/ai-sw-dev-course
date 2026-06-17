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
