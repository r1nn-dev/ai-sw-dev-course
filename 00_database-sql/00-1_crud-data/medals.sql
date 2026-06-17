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
