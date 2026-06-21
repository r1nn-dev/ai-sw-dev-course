# 02. 테이블 설계와 DDL

## 학습 목표

- `CREATE TABLE`로 데이터 타입과 제약 조건을 지정해 테이블을 만든다.
- `ALTER TABLE`로 기존 테이블 구조를 변경한다.
- `DROP TABLE`과 `TRUNCATE TABLE`의 차이를 구분하고 안전하게 사용한다.
- 기본 키(Primary Key)와 외래 키(Foreign Key) 제약 조건의 역할을 이해한다.

---

## 테이블 생성

- 테이블: `author.sql`, `book.sql`
- 실행 파일: `ddl-data.sql`


### 1. CREATE TABLE: AUTHOR

| 컬럼 | 타입 | 제약 조건 |
|------|------|----------|
| AUTHOR_ID | CHAR(2) | Primary Key |
| FIRSTNAME | VARCHAR(20) | - |
| LASTNAME | VARCHAR(20) | - |
| COUNTRY | VARCHAR(20) | - |
| BIRTHDATE | DATE | - |


### 2. CREATE TABLE: BOOK (외래 키 포함)

| 컬럼 | 타입 | 제약 조건 |
|------|------|----------|
| BOOK_ID | CHAR(4) | Primary Key |
| TITLE | VARCHAR(100) | - |
| AUTHOR_ID | CHAR(2) | Foreign Key → AUTHOR(AUTHOR_ID) |
| PRICE | DECIMAL(6, 2) | - |
| YEAR_PUBLISHED | INTEGER | - |

- 외래 키: `FOREIGN KEY (컬럼명) REFERENCES 참조테이블(참조컬럼)`
- AUTHOR_ID는 AUTHOR 테이블의 AUTHOR_ID를 참조하는 외래 키이다.


### 3. INSERT: AUTHOR 데이터 삽입

| AUTHOR_ID | FIRSTNAME | LASTNAME | COUNTRY | BIRTHDATE |
|-----------|-----------|----------|---------|-----------|
| A1 | Patrick | Modiano | France | 1945-07-30 |
| A2 | Haruki | Murakami | Japan | 1949-01-12 |
| A3 | Gabriel | Silva | Brazil | 1960-03-15 |


### 4. INSERT: BOOK 데이터 삽입

| BOOK_ID | TITLE | AUTHOR_ID | PRICE | YEAR_PUBLISHED |
|---------|-------|-----------|-------|----------------|
| B001 | The Night Watch | A1 | 15.99 | 1999 |
| B002 | Norwegian Wood | A2 | 18.50 | 1987 |


### 5. ALTER TABLE: 열 추가

- AUTHOR 테이블에 `EMAIL` 컬럼(`VARCHAR(50)`) 추가.


### 6. ALTER TABLE: 기존 열 타입 변경

- AUTHOR 테이블의 EMAIL 컬럼 타입을 `VARCHAR(100)`으로 변경.

> - **참고:** DBMS마다 문법이 다르므로 사용 중인 환경에 맞게 작성해야 한다.
>   - MySQL: `MODIFY`
>   - Db2: `ALTER COLUMN ... SET DATA TYPE`
>   - SQLite: 직접 변경 불가 


### 7. DROP TABLE IF EXISTS

1. TEST 테이블 생성 (ID INTEGER, NOTE VARCHAR(50))
2. 데이터 2행 삽입
3. TEST 테이블 삭제 (`IF EXISTS` 포함)
4. 다시 같은 이름으로 테이블을 만들어도 오류가 없도록 스크립트 작성

```sql
-- 테이블 생성
-- 데이터 삽입 및 확인
-- 안전하게 삭제
-- 다시 만들 수 있는지 확인
```

### 8. TRUNCATE TABLE

- BOOK 테이블의 모든 데이터를 삭제하되, 테이블 구조(스키마)는 유지.
- 실행 전후에 `SELECT COUNT(*)`로 확인.

```sql
-- 실행 전 확인
-- TRUNCATE 실행
-- 실행 후 확인 (구조 남아 있는지)
```
> **참고:** SQLite에서는 `TRUNCATE TABLE` 대신 `DELETE FROM 테이블명;`을 사용합니다.


### 9. 제약 조건 위반 테스트

- AUTHOR 테이블에 이미 존재하는 AUTHOR_ID('A1')로 새 행을 삽입하면 어떤 오류가 발생하는지 확인.

```sql
-- 아래 쿼리를 실행 후 오류 메시지 확인하기 
INSERT INTO AUTHOR (AUTHOR_ID, FIRSTNAME, LASTNAME, COUNTRY, BIRTHDATE)
VALUES ('A1', 'Duplicate', 'Author', 'USA', '2000-01-01');
```
- 발생한 오류:

- 이 오류가 발생하는 이유:

---

## 통합 문제 — SQL Script 작성

- 반복 실행 가능한 완전한 SQL 스크립트 작성하기.
- 요구 사항:
    1. 기존 BOOK, AUTHOR 테이블을 안전하게 삭제 (오류 없이)
    2. AUTHOR 테이블 생성 (위 사양과 동일)
    3. BOOK 테이블 생성 (FK 포함)
    4. AUTHOR 데이터 3행 삽입
    5. BOOK 데이터 2행 삽입
    6. 두 테이블 SELECT로 최종 확인
- **힌트:** 외래 키 관계가 있으면 삭제는 자식(BOOK)부터, 생성은 부모(AUTHOR)부터이다.

---

## 핵심 정리

| 명령어 | 역할 | 주의점 |
|--------|------|--------|
| `CREATE TABLE` | 테이블 생성 | 부모 테이블 먼저 생성 |
| `ALTER TABLE ADD COLUMN` | 열 추가 | 기존 행은 NULL로 채워짐 |
| `ALTER TABLE MODIFY` | 열 타입 변경 | DBMS마다 문법 다름 |
| `DROP TABLE IF EXISTS` | 테이블 삭제 | 구조 + 데이터 모두 삭제 |
| `TRUNCATE TABLE` | 데이터만 삭제 | 구조 유지, 빠름 |
| `PRIMARY KEY` | 행 고유 식별 | 중복·NULL 불가 |
| `FOREIGN KEY` | 테이블 간 관계 | 참조 무결성 강제 |