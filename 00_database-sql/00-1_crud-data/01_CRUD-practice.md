# 01. 데이터베이스와 SQL 기본 CRUD

## 학습 목표

- `SELECT`, `WHERE`, `COUNT`, `DISTINCT`, `LIMIT`로 데이터를 조회한다.
- `INSERT`, `UPDATE`, `DELETE`로 데이터를 조작한다.
- `UPDATE`와 `DELETE` 전에 `SELECT`로 대상을 확인하는 습관을 익힌다.

## 사전 준비

```sql
-- data/01_crud_data.sql 을 먼저 실행하세요.
```

## 테이블 구조

### EMPLOYEE

| 컬럼 | 타입 | 설명 |
|------|------|------|
| EMP_ID | CHAR(4) | 직원 ID (PK) |
| NAME | VARCHAR(30) | 이름 |
| DEPT | VARCHAR(20) | 부서 |
| SALARY | DECIMAL(10,2) | 급여 |
| COUNTRY | VARCHAR(30) | 국가 |

### MEDALS

| 컬럼 | 타입 | 설명 |
|------|------|------|
| ID | INTEGER | (PK) |
| COUNTRY | VARCHAR(30) | 국가 |
| YEAR | INTEGER | 연도 |
| SPORT | VARCHAR(30) | 종목 |
| GOLD / SILVER / BRONZE | INTEGER | 메달 수 |

### INSTRUCTOR

| 컬럼 | 타입 | 설명 |
|------|------|------|
| ID | CHAR(2) | (PK) |
| NAME | VARCHAR(30) | 이름 |
| DEPT | VARCHAR(30) | 담당 과목 |

---

## 연습 문제

### 문제 1 — 전체 조회

**과제:** EMPLOYEE 테이블의 모든 행과 열을 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 2 — 특정 열만 조회

**과제:** 모든 직원의 이름(NAME)과 부서(DEPT)만 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 3 — WHERE 조건 (숫자)

**과제:** 급여(SALARY)가 60000 이상인 직원의 이름과 급여를 조회하세요.

> **힌트:** `>=` 연산자를 사용합니다.

```sql
-- 여기에 작성하세요



```

---

### 문제 4 — WHERE 조건 (문자열)

**과제:** HR 부서(DEPT = 'HR')에 속한 직원 전체를 조회하세요.

> **힌트:** 문자열 값은 작은따옴표로 감쌉니다.

```sql
-- 여기에 작성하세요



```

---

### 문제 5 — COUNT

**과제:** EMPLOYEE 테이블의 전체 직원 수를 구하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 6 — DISTINCT

**과제:** MEDALS 테이블에서 국가(COUNTRY) 목록을 중복 없이 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 7 — LIMIT

**과제:** EMPLOYEE 테이블에서 처음 3행만 조회하세요.

```sql
-- 여기에 작성하세요



```

---

### 문제 8 — INSERT

**과제:** 아래 정보를 가진 새 직원을 EMPLOYEE 테이블에 추가하세요.

- ID: E011, 이름: Yuna Kim, 부서: Marketing, 급여: 55000, 국가: Korea

```sql
-- 여기에 작성하세요 (삽입 후 SELECT로 확인까지)



```

---

### 문제 9 — UPDATE

**과제:** Priya Sharma(E007)의 급여를 75000으로 수정하세요.
수정 전에 반드시 SELECT로 대상을 먼저 확인하세요.

> **주의:** `WHERE` 없이 UPDATE를 실행하면 모든 행이 바뀝니다.

```sql
-- 1단계: 수정 전 SELECT 확인



-- 2단계: UPDATE 실행



-- 3단계: 수정 후 SELECT 확인



```

---

### 문제 10 — DELETE

**과제:** INSTRUCTOR 테이블에서 ID가 'A3'인 강사를 삭제하세요.
삭제 전후에 SELECT로 확인하세요.

```sql
-- 1단계: 삭제 전 확인



-- 2단계: DELETE 실행



-- 3단계: 삭제 후 확인



```

---

## 통합 문제

**과제:** 아래 조건을 모두 만족하는 쿼리를 하나 작성하세요.

1. `MEDALS` 테이블에서 Swimming 종목을 **제외**한 데이터 조회
2. 금메달(GOLD) 수가 5개 이상인 국가만 필터링
3. 결과에 COUNTRY, SPORT, GOLD 컬럼만 표시
4. 금메달 수 내림차순으로 정렬

```sql
-- 여기에 작성하세요



```

---

## 핵심 정리

| 구문 | 역할 | 주의점 |
|------|------|--------|
| `SELECT *` | 전체 열 조회 | 큰 테이블에서는 비효율 |
| `WHERE` | 행 필터링 | 문자열은 `''`, 숫자는 그냥 씀 |
| `COUNT(*)` | 행 수 계산 | NULL 포함 |
| `DISTINCT` | 중복 제거 | |
| `LIMIT n` | 결과 n행만 반환 | DBMS별 문법 다름 |
| `INSERT INTO` | 행 추가 | 컬럼명 명시 권장 |
| `UPDATE SET` | 행 수정 | **`WHERE` 필수** |
| `DELETE FROM` | 행 삭제 | **`WHERE` 필수** |