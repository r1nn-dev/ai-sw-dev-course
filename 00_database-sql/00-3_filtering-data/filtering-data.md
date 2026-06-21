# 03. 필터링, 정렬, 그룹화

## 학습 목표

- `LIKE`, `BETWEEN`, `IN`으로 다양한 조건식을 작성한다.
- `ORDER BY`로 결과를 원하는 순서로 정렬한다.
- `GROUP BY`와 집계 함수(`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)로 그룹별 분석을 수행한다.
- `HAVING`과 `WHERE`의 차이를 이해하고 올바르게 사용한다.

---

## 파일

- 테이블: `author.sql`, `book.sql`
- 실행 파일: `filtering-data_1.sql`, `filtering-data_2.sql`

---

## 테이블 구조

- **AUTHOR:** AUTHOR_ID, FIRSTNAME, LASTNAME, COUNTRY, BIRTHDATE
- **BOOK:** BOOK_ID, TITLE, AUTHOR_ID, PRICE, YEAR_PUBLISHED

---

## 실행 순서 

### 1. LIKE: 이름 패턴 검색

- AUTHOR 테이블에서 성(LASTNAME)이 'S'로 시작하는 저자 모두 조회하기.
- `LIKE 'S%'` — `%`는 0개 이상의 임의 문자를 의미한다.


### 2. LIKE: 제목 내 특정 단어 포함

- BOOK 테이블에서 제목(TITLE)에 'Wood' 또는 'Light'가 포함된 책 조회하기.


### 3. BETWEEN: 범위 조건

- BOOK 테이블에서 가격(PRICE)이 15.00 이상 20.00 이하인 책의 제목과 가격 조회하기.
- `BETWEEN a AND b`는 양 끝 값을 포함한다.


### 4. IN: 집합 조건

- AUTHOR 테이블에서 국가(COUNTRY)가 France, Japan, India 중 하나인 저자 조회하기.


### 5. ORDER BY: 오름차순 정렬

- BOOK 테이블에서 모든 책을 가격(PRICE) 오름차순으로 정렬해 조회하기.


### 6. ORDER BY: 내림차순 다중 정렬

- BOOK 테이블에서 출판연도(YEAR_PUBLISHED) 내림차순으로 정렬하되, 같은 연도 내에서는 가격(PRICE) 오름차순으로 정렬하기.


### 7. GROUP BY + COUNT

- AUTHOR 테이블에서 국가(COUNTRY)별 저자 수 구하기.
- 결과 컬럼명은 `author_count`로 지정하고, 저자 수 내림차순으로 정렬하기.


### 8. GROUP BY + AVG

- BOOK 테이블에서 저자(AUTHOR_ID)별 책의 평균 가격 구하기.
- 평균 가격을 소수점 둘째 자리까지 표시하고, 내림차순으로 정렬한다.
- `AVG()`, `ROUND()`, `ORDER BY`를 함께 사용한다.


### 9. HAVING: 그룹 결과 필터링

- AUTHOR 테이블에서 저자가 2명 이상인 국가만 조회하기.
- **핵심:** 
    - `WHERE COUNT(*) >= 2`처럼 WHERE에 집계 함수를 직접 쓸 수 없다.
    - ` `절을 사용해야 한다.


### 10. 복합 쿼리: WHERE + GROUP BY + HAVING + ORDER BY

- BOOK 테이블에서 아래 조건을 모두 만족하는 쿼리 작성하기.
    1. 2000년 이후에 출판된 책만 대상으로 (WHERE)
    2. 저자별로 그룹화하여 책 수와 평균 가격을 계산 (GROUP BY)
    3. 책이 1권 이상인 저자만 포함 (HAVING)
    4. 평균 가격 내림차순으로 정렬 (ORDER BY)

---

## 통합 실습 — 분석 쿼리

- 다음에 만족하는 SQL 작성하기.
    - "S 또는 M으로 시작하는 성(LASTNAME)을 가진 저자들의 국가별 평균 책 가격을 구하되, 평균 가격이 15 이상인 국가만 내림차순으로 보여준다."
- AUTHOR와 BOOK 테이블을 연결해야 한다 
    - `AUTHOR_ID` 컬럼 이용.


---

## 핵심 정리

| 구문 | 사용 상황 | 예시 |
|------|----------|------|
| `LIKE 'S%'` | S로 시작하는 값 | `WHERE LASTNAME LIKE 'S%'` |
| `LIKE '%ile%'` | 중간에 포함된 값 | `WHERE TITLE LIKE '%ile%'` |
| `BETWEEN a AND b` | 범위 조건 (양 끝 포함) | `WHERE PRICE BETWEEN 10 AND 25` |
| `IN (a, b, c)` | 여러 값 중 하나 | `WHERE COUNTRY IN ('France', 'Japan')` |
| `ORDER BY col ASC` | 오름차순 정렬 | 기본값 |
| `ORDER BY col DESC` | 내림차순 정렬 | |
| `GROUP BY col` | 그룹별 집계 | `SELECT DEPT, COUNT(*) FROM EMP GROUP BY DEPT` |
| `HAVING 조건` | 그룹 결과 필터링 | 집계 함수 조건에 사용 |