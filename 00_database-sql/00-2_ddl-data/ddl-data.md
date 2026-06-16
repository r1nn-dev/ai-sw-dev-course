# 02. 테이블 설계와 DDL

## 학습 목표

- `CREATE TABLE`로 데이터 타입과 제약 조건을 지정해 테이블을 만든다.
- `ALTER TABLE`로 기존 테이블 구조를 변경한다.
- `DROP TABLE`과 `TRUNCATE TABLE`의 차이를 구분하고 안전하게 사용한다.
- 기본 키(Primary Key)와 외래 키(Foreign Key) 제약 조건의 역할을 이해한다.

## 사전 준비

이 연습문제는 테이블을 **직접 만드는** 것이 목적입니다.
완성된 예시는 `data/02_ddl_data.sql`에서 확인할 수 있습니다.

---

## 연습 문제

### 문제 1 — CREATE TABLE: AUTHOR

**과제:** 아래 사양에 맞는 AUTHOR 테이블을 생성하세요.

| 컬럼 | 타입 | 제약 조건 |
|------|------|----------|
| AUTHOR_ID | CHAR(2) | Primary Key |
| FIRSTNAME | VARCHAR(20) | - |
| LASTNAME | VARCHAR(20) | - |
| COUNTRY | VARCHAR(20) | - |
| BIRTHDATE | DATE | - |

```sql
-- 여기에 작성하세요



```

---

### 문제 2 — CREATE TABLE: BOOK (외래 키 포함)

**과제:** 아래 사양에 맞는 BOOK 테이블을 생성하세요.
AUTHOR_ID는 AUTHOR 테이블의 AUTHOR_ID를 참조하는 외래 키입니다.

| 컬럼 | 타입 | 제약 조건 |
|------|------|----------|
| BOOK_ID | CHAR(4) | Primary Key |
| TITLE | VARCHAR(100) | - |
| AUTHOR_ID | CHAR(2) | Foreign Key → AUTHOR(AUTHOR_ID) |
| PRICE | DECIMAL(6, 2) | - |
| YEAR_PUBLISHED | INTEGER | - |

> **힌트:** 외래 키는 `FOREIGN KEY (컬럼명) REFERENCES 참조테이블(참조컬럼)`

```sql
-- 여기에 작성하세요



```

---

### 문제 3 — INSERT: AUTHOR 데이터 삽입

**과제:** AUTHOR 테이블에 아래 저자 3명을 삽입하세요.

| AUTHOR_ID | FIRSTNAME | LASTNAME | COUNTRY | BIRTHDATE |
|-----------|-----------|----------|---------|-----------|
| A1 | Patrick | Modiano | France | 1945-07-30 |
| A2 | Haruki | Murakami | Japan | 1949-01-12 |
| A3 | Gabriel | Silva | Brazil | 1960-03-15 |

```sql
-- 여기에 작성하세요 (삽입 후 SELECT로 확인까지)



```

---

### 문제 4 — INSERT: BOOK 데이터 삽입

**과제:** BOOK 테이블에 아래 책 2권을 삽입하세요.

| BOOK_ID | TITLE | AUTHOR_ID | PRICE | YEAR_PUBLISHED |
|---------|-------|-----------|-------|----------------|
| B001 | The Night Watch | A1 | 15.99 | 1999 |
| B002 | Norwegian Wood | A2 | 18.50 | 1987 |

```sql
-- 여기에 작성하세요



```

---

### 문제 5 — ALTER TABLE: 열 추가

**과제:** AUTHOR 테이블에 `EMAIL` 컬럼(`VARCHAR(50)`)을 추가하세요.

```sql
-- 여기에 작성하세요 (추가 후 SELECT * 로 구조 확인)



```

---

### 문제 6 — ALTER TABLE: 기존 열 타입 변경

**과제:** AUTHOR 테이블의 EMAIL 컬럼 타입을 `VARCHAR(100)`으로 변경하세요.

> **참고:** DBMS마다 문법이 다릅니다. 사용 중인 환경에 맞게 작성하세요.
> - MySQL: `MODIFY`
> - Db2: `ALTER COLUMN ... SET DATA TYPE`
> - SQLite: 직접 변경 불가 (방법을 검색해보세요)

```sql
-- 여기에 작성하세요



```

---

### 문제 7 — DROP TABLE IF EXISTS

**과제:** 아래 순서를 수행하세요.

1. TEST 테이블 생성 (ID INTEGER, NOTE VARCHAR(50))
2. 데이터 2행 삽입
3. TEST 테이블 삭제 (`IF EXISTS` 포함)
4. 다시 같은 이름으로 테이블을 만들어도 오류가 없도록 스크립트 작성

```sql
-- 1단계: 테이블 생성



-- 2단계: 데이터 삽입 및 확인



-- 3단계: 안전하게 삭제



-- 4단계: 다시 만들 수 있는지 확인



```

---

### 문제 8 — TRUNCATE TABLE

**과제:** BOOK 테이블의 모든 데이터를 삭제하되, 테이블 구조(스키마)는 유지하세요.
실행 전후에 `SELECT COUNT(*)`로 확인하세요.

> **참고:** SQLite에서는 `TRUNCATE TABLE` 대신 `DELETE FROM 테이블명;`을 사용합니다.

```sql
-- 실행 전 확인



-- TRUNCATE 실행



-- 실행 후 확인 (구조 남아 있는지)



```

---

### 문제 9 — 제약 조건 위반 테스트

**과제:** AUTHOR 테이블에 이미 존재하는 AUTHOR_ID('A1')로 새 행을 삽입하면
어떤 오류가 발생하는지 직접 확인하고, 오류 내용을 아래에 메모하세요.

```sql
-- 아래 쿼리를 실행하고 오류 메시지를 확인하세요
INSERT INTO AUTHOR (AUTHOR_ID, FIRSTNAME, LASTNAME, COUNTRY, BIRTHDATE)
VALUES ('A1', 'Duplicate', 'Author', 'USA', '2000-01-01');
```

**발생한 오류:**
```
(여기에 오류 메시지를 기록하세요)
```

**이 오류가 발생하는 이유:**
```
(여기에 설명을 적어보세요)
```

---

## 통합 문제 — SQL Script 작성

**과제:** 반복 실행 가능한 완전한 SQL 스크립트를 작성하세요.

요구 사항:
1. 기존 BOOK, AUTHOR 테이블을 안전하게 삭제 (오류 없이)
2. AUTHOR 테이블 생성 (위 사양과 동일)
3. BOOK 테이블 생성 (FK 포함)
4. AUTHOR 데이터 3행 삽입
5. BOOK 데이터 2행 삽입
6. 두 테이블 SELECT로 최종 확인

> **힌트:** 외래 키 관계가 있으면 삭제는 자식(BOOK)부터, 생성은 부모(AUTHOR)부터입니다.

```sql
-- 여기에 전체 스크립트를 작성하세요



```

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