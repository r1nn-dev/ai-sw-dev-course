# 03. 필터링, 정렬, 그룹화

## 학습 목표

- `LIKE`, `BETWEEN`, `IN`으로 다양한 조건식을 작성한다.
- `ORDER BY`로 결과를 원하는 순서로 정렬한다.
- `GROUP BY`와 집계 함수(`COUNT`, `SUM`, `AVG`, `MIN`, `MAX`)로 그룹별 분석을 수행한다.
- `HAVING`과 `WHERE`의 차이를 이해하고 올바르게 사용한다.

## 사전 준비

```sql
-- data/03_filtering_data.sql 실행
```

## 테이블 구조

**AUTHOR:** AUTHOR_ID, FIRSTNAME, LASTNAME, COUNTRY, BIRTHDATE

**BOOK:** BOOK_ID, TITLE, AUTHOR_ID, PRICE, YEAR_PUBLISHED

---

## 연습 문제

### 문제 1 — LIKE: 이름 패턴 검색

**과제:** AUTHOR 테이블에서 성(LASTNAME)이 'S'로 시작하는 저자를 모두 조회하세요.

> **힌트:** `LIKE 'S%'` — `%`는 0개 이상의 임의 문자를 의미합니다.

```sql
-- 여기에 작성하세요



```

---

### 문제 2 — LIKE: 제목 내 특정 단어 포함

**과제:** BOOK 테이블에서 제목(TITLE)에 'Wood' 또는 'Light'가 포함된 책을 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 3 — BETWEEN: 범위 조건

**과제:** BOOK 테이블에서 가격(PRICE)이 15.00 이상 20.00 이하인 책의 제목과 가격을 조회하세요.

> **힌트:** `BETWEEN a AND b`는 양 끝 값을 포함합니다.

```sql
-- 여기에 작성하세요



```

---

### 문제 4 — IN: 집합 조건

**과제:** AUTHOR 테이블에서 국가(COUNTRY)가 France, Japan, India 중 하나인 저자를 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 5 — ORDER BY: 오름차순 정렬

**과제:** BOOK 테이블에서 모든 책을 가격(PRICE) 오름차순으로 정렬해 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 6 — ORDER BY: 내림차순 다중 정렬

**과제:** BOOK 테이블에서 출판연도(YEAR_PUBLISHED) 내림차순으로 정렬하되,
같은 연도 내에서는 가격(PRICE) 오름차순으로 정렬하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 7 — GROUP BY + COUNT

**과제:** AUTHOR 테이블에서 국가(COUNTRY)별 저자 수를 구하세요.
결과 컬럼명은 `author_count`로 지정하고, 저자 수 내림차순으로 정렬하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 8 — GROUP BY + AVG

**과제:** BOOK 테이블에서 저자(AUTHOR_ID)별 책의 평균 가격을 구하세요.
평균 가격을 소수점 둘째 자리까지 표시하고, 내림차순으로 정렬하세요.

> **힌트:** `AVG()`, `ROUND()`, `ORDER BY`를 함께 사용합니다.

```sql
-- 여기에 작성하세요



```

---

### 문제 9 — HAVING: 그룹 결과 필터링

**과제:** AUTHOR 테이블에서 저자가 2명 이상인 국가만 조회하세요.

> **핵심:** `WHERE COUNT(*) >= 2`처럼 WHERE에 집계 함수를 직접 쓸 수 없습니다.
> 어떤 절을 사용해야 할까요?

```sql
-- 여기에 작성하세요



```

---

### 문제 10 — 복합 쿼리: WHERE + GROUP BY + HAVING + ORDER BY

**과제:** BOOK 테이블에서 아래 조건을 모두 만족하는 쿼리를 작성하세요.

1. 2000년 이후에 출판된 책만 대상으로 (WHERE)
2. 저자별로 그룹화하여 책 수와 평균 가격을 계산 (GROUP BY)
3. 책이 1권 이상인 저자만 포함 (HAVING)
4. 평균 가격 내림차순으로 정렬 (ORDER BY)

```sql
-- 여기에 작성하세요



```

---

## 통합 문제 — 분석 쿼리

**과제:** 다음 분석 질문에 답하는 SQL을 작성하세요.

**질문:** "S 또는 M으로 시작하는 성(LASTNAME)을 가진 저자들의 국가별 평균 책 가격을 구하되, 평균 가격이 15 이상인 국가만 내림차순으로 보여주세요."

> **힌트:** AUTHOR와 BOOK 테이블을 연결해야 합니다 (`AUTHOR_ID` 컬럼 이용).

```sql
-- 여기에 작성하세요



```

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