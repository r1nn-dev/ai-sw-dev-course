-- ============================================================
-- 실습 문제
-- 1. 가격이 10~25 사이인 책을 조회한다.
-- 2. 특정 국가 목록에 속한 저자를 조회한다.
-- 3. 제목이 특정 문자로 시작하는 책을 조회한다.
-- 4. 국가별 저자 수를 계산한다.
-- 5. 저자 수가 2명 이상인 국가만 조회한다.
-- ============================================================


-- 1. 가격이 10~25 사이인 책을 조회한다.
SELECT *
FROM BOOK
WHERE PRICE BETWEEN 10 AND 25;

-- 2. 특정 국가 목록에 속한 저자를 조회한다.
SELECT *
FROM AUTHOR
WHERE COUNTRY IN ('Australia', 'Canada', 'India');

-- 3. 제목이 The로 시작하는 책을 조회한다.
SELECT *
FROM BOOK
WHERE TITLE LIKE 'The%';

-- 4. 국가별 저자 수를 계산한다.
SELECT COUNTRY, COUNT(*) AS author_count
FROM AUTHOR
GROUP BY COUNTRY;

-- 5. 저자 수가 2명 이상인 국가만 조회한다.
SELECT COUNTRY, COUNT(*) AS author_count
FROM AUTHOR
GROUP BY COUNTRY
HAVING COUNT(*) >= 2;
