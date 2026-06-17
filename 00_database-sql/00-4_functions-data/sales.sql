-- --------------------------------------------------------
-- SALES 테이블
-- 컬럼: ID, PRODUCT, AMOUNT, SALEDATE
-- --------------------------------------------------------
DROP TABLE IF EXISTS SALES;

CREATE TABLE SALES (
    ID        INTEGER        PRIMARY KEY,
    PRODUCT   VARCHAR(50),
    AMOUNT    DECIMAL(10, 2),
    SALEDATE  DATE
);

INSERT INTO SALES VALUES
    (1,  'Laptop',   1200.00, '2023-01-15'),
    (2,  'Keyboard',  150.00, '2023-02-10'),
    (3,  'Monitor',   450.00, '2023-02-20'),
    (4,  'Laptop',   1350.00, '2023-03-05'),
    (5,  'Mouse',      80.00, '2023-03-18'),
    (6,  'Tablet',    750.00, '2023-04-12'),
    (7,  'Keyboard',  200.00, '2023-05-08'),
    (8,  'Monitor',   500.00, '2023-06-22'),
    (9,  'Laptop',   1100.00, '2023-07-14'),
    (10, 'Tablet',    820.00, '2023-08-30');
