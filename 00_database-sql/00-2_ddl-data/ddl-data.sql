-- --------------------------------------------------------
-- 실습 문제
-- 1. `BOOK` 테이블을 생성한다.
-- 2. `AUTHOR` 테이블을 생성한다.
-- 3. `BOOK`에 기본 키를 지정한다.
-- 4. `BOOK`과 `AUTHOR` 사이에 외래 키 관계를 설정한다.
-- 5. `AUTHOR`에 `EMAIL` 컬럼을 추가한다.
-- 6. `TEST` 테이블을 삭제한다.
-- --------------------------------------------------------


-- 기존 테이블이 있으면 삭제한다.
-- 외래 키 관계가 있다면 자식 테이블을 먼저 삭제한다.
DROP TABLE IF EXISTS BOOK;
DROP TABLE IF EXISTS AUTHOR;

-- 저자 테이블을 생성한다.
CREATE TABLE AUTHOR (
    AUTHOR_ID CHAR(2) PRIMARY KEY,
    FIRSTNAME VARCHAR(20),
    LASTNAME VARCHAR(20)
);

-- 도서 테이블을 생성한다.
CREATE TABLE BOOK (
    BOOK_ID INTEGER PRIMARY KEY,
    TITLE VARCHAR(100),
    PRICE DECIMAL(10, 2),
    AUTHOR_ID CHAR(2),
    FOREIGN KEY (AUTHOR_ID) REFERENCES AUTHOR(AUTHOR_ID)
);

-- AUTHOR 테이블에 이메일 컬럼을 추가한다.
ALTER TABLE AUTHOR
ADD COLUMN EMAIL VARCHAR(50);

-- TEST 테이블이 있으면 삭제한다.
DROP TABLE IF EXISTS TEST;