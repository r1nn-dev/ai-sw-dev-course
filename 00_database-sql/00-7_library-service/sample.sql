-- ============================================================
-- 샘플 데이터 삽입 
-- ============================================================


-- 대출자 데이터 삽입
INSERT INTO BORROWER (BORROWER_ID, NAME, EMAIL)
VALUES
    (1, 'Kim', 'kim@example.com'),
    (2, 'Lee', 'lee@example.com'),
    (3, 'Park', 'park@example.com');

-- 도서 데이터 삽입
INSERT INTO BOOK (BOOK_ID, TITLE, CATEGORY, PRICE)
VALUES
    (101, 'SQL Basics', 'Database', 25000),
    (102, 'Python Analysis', 'Programming', 30000),
    (103, 'Data Modeling', 'Database', 28000),
    (104, 'Web Backend', 'Programming', 32000);

-- 대출 기록 데이터 삽입
INSERT INTO LOAN (LOAN_ID, BORROWER_ID, BOOK_ID, LOAN_DATE, RETURN_DATE)
VALUES
    (1001, 1, 101, '2026-06-01', '2026-06-10'),
    (1002, 1, 102, '2026-06-03', NULL),
    (1003, 2, 103, '2026-06-05', '2026-06-12');
