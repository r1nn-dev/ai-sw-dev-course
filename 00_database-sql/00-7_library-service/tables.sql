-- ============================================================
-- 데이터베이스 테이블 구조
-- `BORROWER`: 대출자 정보
-- `BOOK`: 책 정보
-- `LOAN`: 대출 기록
-- ============================================================


-- 기존 테이블이 있다면 삭제한다. 
-- 외래 키 관계가 있으므로 자식 테이블인 LOAN을 먼저 삭제한다. 
DROP TABLE IF EXISTS LOAN; 
DROP TABLE IF EXISTS BOOK; 
DROP TABLE IF EXISTS BORROWER;

-- 대출자 테이블 
CREATE TABLE BORROWER ( 
		BORROWER_ID INTEGER PRIMARY KEY, 
		NAME VARCHAR(50), 
		EMAIL VARCHAR(100) 
);

-- 도서 테이블 
CREATE TABLE BOOK ( 
		BOOK_ID INTEGER PRIMARY KEY, 
		TITLE VARCHAR(100), 
		CATEGORY VARCHAR(50), 
		PRICE DECIMAL(10, 2) 
); 

-- 대출 기록 테이블 
CREATE TABLE LOAN ( 
		LOAN_ID INTEGER PRIMARY KEY, 
		BORROWER_ID INTEGER, 
		BOOK_ID INTEGER, 
		LOAN_DATE DATE, 
		RETURN_DATE DATE, 
		FOREIGN KEY (BORROWER_ID) REFERENCES BORROWER(BORROWER_ID), 
		FOREIGN KEY (BOOK_ID) REFERENCES BOOK(BOOK_ID) 
);
