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
