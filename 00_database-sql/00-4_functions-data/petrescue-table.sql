-- --------------------------------------------------------
-- PETRESCUE 테이블
-- 컬럼: ID, ANIMAL, QUANTITY, COST, RESCUEDATE
-- --------------------------------------------------------
DROP TABLE IF EXISTS PETRESCUE;

CREATE TABLE PETRESCUE (
    ID          INTEGER        PRIMARY KEY,
    ANIMAL      VARCHAR(20),
    QUANTITY    INTEGER,
    COST        DECIMAL(8, 2),
    RESCUEDATE  DATE
);

INSERT INTO PETRESCUE VALUES
    (1,  'Dog',     2, 450.00, '2021-05-15'),
    (2,  'Cat',     3, 300.00, '2021-06-20'),
    (3,  'Parrot',  1, 150.00, '2021-07-10'),
    (4,  'Dog',     1, 225.00, '2021-08-05'),
    (5,  'Rabbit',  2, 180.00, '2021-09-12'),
    (6,  'Cat',     1, 100.00, '2021-10-03'),
    (7,  'Dog',     3, 675.00, '2021-11-18'),
    (8,  'Hamster', 4, 120.00, '2021-12-01'),
    (9,  'Parrot',  2, 300.00, '2022-01-15'),
    (10, 'Cat',     2, 200.00, '2022-02-28');
