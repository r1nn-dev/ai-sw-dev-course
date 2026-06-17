-- --------------------------------------------------------
-- INSTRUCTOR 테이블
-- 컬럼: ID, NAME, DEPT
-- --------------------------------------------------------
DROP TABLE IF EXISTS INSTRUCTOR;

CREATE TABLE INSTRUCTOR (
    ID    CHAR(2)      PRIMARY KEY,
    NAME  VARCHAR(30),
    DEPT  VARCHAR(30)
);

INSERT INTO INSTRUCTOR VALUES
    ('A1', 'John Kim',  'Data Science'),
    ('A2', 'Jane Lee',  'SQL'),
    ('A3', 'Mike Park', 'Python');