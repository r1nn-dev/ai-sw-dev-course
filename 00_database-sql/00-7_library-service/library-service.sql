-- ============================================================
-- 라이브러리 서비스 SQL 분석 
-- 1. 전체 대출자 목록을 조회한다.
-- 2. 전체 도서 목록을 조회한다.
-- 3. 아직 반납되지 않은 대출 기록을 조회한다.
-- 4. 카테고리별 도서 수를 계산한다.
-- 5. 평균 도서 가격을 계산한다.
-- 6. 가격이 평균보다 높은 도서를 조회한다.
-- 7. 대출자별 대출 횟수를 계산한다.
-- 8. 대출 기록이 있는 대출자만 조회한다.
-- 9. 대출 기록이 없는 대출자를 조회한다.
-- 10. 대출자 이름, 책 제목, 대출일을 함께 조회한다.
-- ============================================================


-- 1. 전체 대출자 목록을 조회한다.
SELECT *
FROM BORROWER;

-- 2. 전체 도서 목록을 조회한다.
SELECT *
FROM BOOK;

-- 3. 아직 반납되지 않은 대출 기록을 조회한다.
SELECT *
FROM LOAN
WHERE RETURN_DATE IS NULL;

-- 4. 카테고리별 도서 수를 계산한다.
SELECT CATEGORY, COUNT(*) AS book_count
FROM BOOK
GROUP BY CATEGORY;

-- 5. 평균 도서 가격을 계산한다.
SELECT AVG(PRICE) AS avg_price
FROM BOOK;

-- 6. 가격이 평균보다 높은 도서를 조회한다.
SELECT TITLE, PRICE
FROM BOOK
WHERE PRICE > (
    SELECT AVG(PRICE)
    FROM BOOK
);

-- 7. 대출자별 대출 횟수를 계산한다.
SELECT BORROWER_ID, COUNT(*) AS loan_count
FROM LOAN
GROUP BY BORROWER_ID;

-- 8. 대출 기록이 있는 대출자만 조회한다.
SELECT DISTINCT B.NAME
FROM BORROWER B
INNER JOIN LOAN L
  ON B.BORROWER_ID = L.BORROWER_ID;

-- 9. 대출 기록이 없는 대출자를 조회한다.
SELECT B.NAME
FROM BORROWER B
LEFT JOIN LOAN L
  ON B.BORROWER_ID = L.BORROWER_ID
WHERE L.LOAN_ID IS NULL;

-- 10. 대출자 이름, 책 제목, 대출일을 함께 조회한다.
SELECT
    B.NAME AS borrower_name,
    BK.TITLE AS book_title,
    L.LOAN_DATE
FROM LOAN L
JOIN BORROWER B
  ON L.BORROWER_ID = B.BORROWER_ID
JOIN BOOK BK
  ON L.BOOK_ID = BK.BOOK_ID;
