-- ============================================================
-- 실습 문제: JOIN
-- 1. `BORROWER` 테이블을 확인한다.
-- 2. `LOAN` 테이블을 확인한다.
-- 3. `INNER JOIN`을 실행한다.
-- 4. `LEFT JOIN`을 실행한다.
-- 5. 두 결과 차이를 해석한다.
-- ============================================================


-- 대출자 테이블을 확인한다.
SELECT *
FROM BORROWER;

-- 대출 기록 테이블을 확인한다.
SELECT *
FROM LOAN;

-- INNER JOIN: 대출 기록이 있는 대출자만 조회한다.
SELECT B.NAME, L.LOAN_DATE
FROM BORROWER B
INNER JOIN LOAN L
  ON B.BORROWER_ID = L.BORROWER_ID;

-- LEFT JOIN: 모든 대출자를 조회하고, 대출 기록이 있으면 함께 표시한다.
SELECT B.NAME, L.LOAN_DATE
FROM BORROWER B
LEFT JOIN LOAN L
  ON B.BORROWER_ID = L.BORROWER_ID;
