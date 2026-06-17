-- --------------------------------------------------------
-- LOAN 테이블 (대출 기록)
-- 컬럼: LOAN_ID, BORROWER_ID, BOOK_ID, LOAN_DATE, RETURN_DATE
-- 참고: BOOK_ID는 BOOK 테이블을 참조하지만
--       독립 실행을 위해 FK 제약 없이 생성합니다.
-- --------------------------------------------------------
CREATE TABLE LOAN (
    LOAN_ID      CHAR(4)    PRIMARY KEY,
    BORROWER_ID  CHAR(4),
    BOOK_ID      CHAR(4),
    LOAN_DATE    DATE,
    RETURN_DATE  DATE,
    FOREIGN KEY (BORROWER_ID) REFERENCES BORROWER(BORROWER_ID)
);

-- RETURN_DATE가 NULL이면 아직 반납하지 않은 대출입니다.
INSERT INTO LOAN VALUES
    ('L001', 'B001', 'B002', '2024-01-10', '2024-02-10'),
    ('L002', 'B002', 'B005', '2024-01-15',         NULL),
    ('L003', 'B001', 'B009', '2024-02-01', '2024-03-01'),
    ('L004', 'B003', 'B001', '2024-02-20',         NULL),
    ('L005', 'B002', 'B003', '2024-03-05', '2024-04-05');

-- B004, B005 (Choi Dongwoo, Jung Haerin)는 대출 기록 없음
-- → LEFT JOIN 실습에서 NULL 결과 확인용