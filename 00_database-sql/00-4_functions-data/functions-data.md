# 04. SQL 함수, 서브쿼리, 여러 테이블

## 학습 목표

- 집계 함수(`SUM`, `AVG`, `MIN`, `MAX`)와 스칼라 함수(`ROUND`, `LENGTH`, `UCASE`)를 사용한다.
- 날짜 함수로 날짜 데이터를 다룬다.
- `WHERE`, `SELECT`, `FROM` 절에 서브쿼리(subquery)를 사용한다.
- 두 테이블을 서브쿼리 또는 암시적 조인으로 연결한다.

---

## 실습 파일

- 테이블: `petrescue.sql`, `sales.sql`, `departments.sql`, `employee.sql`
- 실행 파일: `functions-data.sql`

---

## 테이블 구조

- **PETRESCUE:** ID, ANIMAL, QUANTITY, COST, RESCUEDATE
- **SALES:** ID, PRODUCT, AMOUNT, SALEDATE
- **DEPARTMENTS:** DEPT_ID_DEP, DEP_NAME, MANAGER_ID, LOCATION
- **EMPLOYEES:** EMP_ID, F_NAME, L_NAME, DEP_ID, SALARY, JOB_TITLE

---

## 실습 순서

### 1. 집계 함수

- SALES 테이블에서 아래 값을 한 쿼리로 모두 구하기.
    - 총 매출액 합계 (`total_sales`)
    - 평균 거래 금액 (`avg_sale`, 소수점 둘째 자리까지)
    - 최소 거래 금액 (`min_sale`)
    - 최대 거래 금액 (`max_sale`)


### 2. GROUP BY + 집계 함수

- SALES 테이블에서 상품(PRODUCT)별로 총 매출액과 거래 횟수 구하기.
- 총 매출액 내림차순으로 정렬한다.


### 3. ROUND + LENGTH: 스칼라 함수

- PETRESCUE 테이블에서 아래 정보 조회하기.
    - ANIMAL 이름
    - COST 값 (소수점 없이 반올림)
    - ANIMAL 이름의 글자 수
    - ANIMAL 이름 대문자 변환
- SQLite에서는 `UCASE()` 대신 `UPPER()`를 사용한다.


### 4. 날짜 함수

- PETRESCUE 테이블에서 구조 날짜(RESCUEDATE)에서 월(MONTH)만 추출해 조회하기.
- 2021년에 구조된 기록만 필터링한다.
- **참고:** 
    - MySQL은 `YEAR()`, `MONTH()` 사용. 
    - SQLite는 `strftime('%Y', col)` 사용.

```sql
-- MySQL / Db2 버전
-- SQLite 버전
```


### 5. 서브쿼리 (WHERE): 평균보다 낮은 급여

- EMPLOYEES 테이블에서 전체 평균 급여보다 낮은 급여를 받는 직원의
이름(F_NAME, L_NAME)과 급여 조회하기.
- **핵심:** 
    - `WHERE SALARY < AVG(SALARY)`처럼 WHERE에 집계 함수를 직접 쓸 수 없다.
    - 서브쿼리 사용하기.


### 6. 서브쿼리 (SELECT): 개인 급여 vs 전체 평균

- EMPLOYEES 테이블에서 각 직원의 이름, 급여, 전체 평균 급여, 그리고 개인 급여와 평균의 차이를 함께 조회하기.


### 7. 서브쿼리 (FROM): 파생 테이블

- EMPLOYEES 테이블에서 부서별 평균 급여를 먼저 계산한 뒤, 그 결과에서 평균 급여가 65000 이상인 부서만 조회하기.
- `FROM` 절의 서브쿼리 결과에 반드시 별칭(alias)을 붙여야 한다.


### 8. 여러 테이블: 서브쿼리로 연결

- DEPARTMENTS 테이블에 존재하는 부서 ID에 해당하는 직원만 조회하기.
- 서브쿼리와 `IN`을 사용한다.


### 9. 암시적 조인

- EMPLOYEES와 DEPARTMENTS 테이블을 연결하여 직원 이름(F_NAME, L_NAME), 부서명(DEP_NAME), 위치(LOCATION) 함께 조회하기.
- **핵심**
    - `FROM` 절에 두 테이블을 나열하고, `WHERE`로 연결 조건을 지정한다.
    - 주의: 연결 조건을 빠뜨리면 cross join이 된다.


## 통합 분석 쿼리

- 아래에 만족하는 SQL 작성하기.
- "Engineering 또는 Data Science 부서에 속한 직원 중,
자신의 **부서 평균 급여**보다 높은 급여를 받는 직원의 이름, 급여, 부서명 조회하기."
- **핵심**
    - 각 직원의 부서 평균을 구하려면 상관 서브쿼리가 필요하다.
    - 안쪽 서브쿼리에서 바깥 쿼리의 `DEP_ID`를 참조한다.


---

## 핵심 정리

| 항목 | 설명 |
|------|------|
| 집계 함수 | SUM, AVG, MIN, MAX, COUNT — 여러 행을 하나의 값으로 |
| 스칼라 함수 | ROUND, LENGTH, UCASE/UPPER — 각 행에 개별 적용 |
| 날짜 함수 | YEAR/MONTH/DAY (MySQL) vs strftime (SQLite) |
| 서브쿼리 WHERE | 집계 기준값 계산 → `SALARY < (SELECT AVG(...))` |
| 서브쿼리 SELECT | 추가 계산 컬럼 → `(SELECT AVG(...)) AS avg` |
| 서브쿼리 FROM | 임시 테이블(파생 테이블) → 반드시 별칭 필요 |
| 암시적 조인 | FROM에 여러 테이블 + WHERE 연결 조건 |