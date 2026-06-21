# 06. 고급 SQL: View, Transaction, Join

## 학습 목표

- `CREATE VIEW`로 가상 테이블을 만들고 재사용한다.
- `COMMIT`과 `ROLLBACK`으로 Transaction을 제어하는 개념을 이해한다.
- `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`으로 여러 테이블을 연결한다.
- JOIN 결과의 `NULL` 값을 해석한다.
- 3개 이상의 테이블을 JOIN하는 복합 쿼리를 작성한다.


---
## 실습 개요

- 테이블: `employees.sql`, `departments.sql`, `jobs.sql`, `borrower.sql`, `loan.sql`
- 실행 파일: `advanced-data.sql`


---
## 테이블 구조

- **EMPLOYEES:** EMP_ID, F_NAME, L_NAME, DEP_ID, SALARY, JOB_TITLE
- **DEPARTMENTS:** DEPT_ID_DEP, DEP_NAME, MANAGER_ID, LOCATION
- **JOBS:** JOB_ID, JOB_TITLE, MIN_SALARY, MAX_SALARY
- **BORROWER:** BORROWER_ID, NAME, EMAIL, CITY
- **LOAN:** LOAN_ID, BORROWER_ID, BOOK_ID, LOAN_DATE, RETURN_DATE


---
## Part 1. View

### 1. CREATE VIEW: 기본 뷰 생성

- EMPLOYEES 테이블에서 급여(SALARY)를 제외한 공개용 뷰 `emp_public` 만들기.
- 뷰 생성 후 SELECT로 조회하기.


### 2. CREATE VIEW: 조건이 있는 뷰

- JOBS 테이블에서 최소 급여(MIN_SALARY)가 50000 이상인 직종만 담은 뷰 `high_salary_jobs` 만들기.
- 뷰를 조회하고, 뷰 위에 추가 조건(`MAX_SALARY > 130000`)도 적용하기.

```sql
-- 뷰 생성
-- 뷰 조회
-- 뷰에 추가 조건 적용
```


### 3. DROP VIEW

- `emp_public` 뷰를 삭제하고, 원본 EMPLOYEES 테이블은 그대로 남아 있는지 `SELECT COUNT(*)`로 확인하기.

```sql
-- 뷰 삭제
-- 원본 테이블 확인
```


## Part 2. Transaction

### 4. COMMIT: 변경 사항 확정

- Ana Silva(E009)의 급여를 95000으로 수정하고, `COMMIT`으로 확정하기.
- 수정 전후에 SELECT로 확인하기.

```sql
-- 수정 전 확인
-- UPDATE 실행
-- COMMIT
-- 수정 후 확인
```


### 5. ROLLBACK: 변경 사항 취소

- 모든 직원 급여를 일괄 10% 인상했다가, `ROLLBACK`으로 되돌리는 흐름 작성하기.
- **핵심**
    - SQLite는 `BEGIN TRANSACTION;`
    - MySQL은 `START TRANSACTION;`

```sql
-- 트랜잭션 시작
-- 전체 급여 10% 인상 (WHERE 없이)
-- 변경된 내용 확인
-- 롤백
-- 원래대로 복구됐는지 확인
```


## Part 3. Join

### 6. INNER JOIN: 대출 기록이 있는 대출자

- BORROWER와 LOAN 테이블을 INNER JOIN으로 연결해
대출 기록이 있는 대출자의 이름, 도시, 대출 날짜 조회하기.


### 7. LEFT JOIN: 모든 대출자 포함

- BORROWER와 LOAN 테이블을 LEFT JOIN으로 연결해
대출 기록이 없는 대출자도 포함해서 조회하기.
- 대출 기록 없는 대출자는 LOAN 관련 컬럼이 NULL로 표시된다.


### 8. NULL 해석: 한 번도 대출하지 않은 사람 찾기

- 대출 기록이 전혀 없는 대출자만 조회하기.
- **핵심**
    - LEFT JOIN 후 오른쪽 테이블의 컬럼이 NULL인 행을 필터링한다.
    - `= NULL`이 아닌 `IS NULL`을 사용해야 한다.


### 9. 아직 반납하지 않은 대출 조회

- 반납이 완료되지 않은(RETURN_DATE가 NULL인) 대출 기록과 대출자 이름 조회하기.


### 10. JOIN으로 대출자별 대출 횟수

- 각 대출자의 총 대출 횟수 구하기.
- 대출 기록이 없는 대출자도 포함하며, 대출 횟수 0으로 표시한다.
- **핵심:** `COUNT(L.LOAN_ID)`와 `COUNT(*)`의 차이.


### 11. INNER JOIN 3개 테이블

- EMPLOYEES, DEPARTMENTS, JOBS 테이블을 사용해
직원 이름, 부서명, 담당 직무의 급여 범위 함께 조회하기.
- `JOB_TITLE` 컬럼이 EMPLOYEES와 JOBS 두 테이블에 모두 있다.


---
## 통합 실습 — 도서관 분석 쿼리

- 아래를 만족하는 쿼리 작성하기.
    - "대출 기록이 있는 대출자 중, 2024년 1월에 대출을 시작했고, 아직 반납하지 않은 기록을 가진 대출자의 이름, 도시, 대출 날짜 조회하기."
- INNER JOIN + 날짜 조건 + `IS NULL` 조건을 모두 조합한다.

```sql
-- MySQL / Db2 버전
-- SQLite 버전
```


---
## 핵심 정리

### View
| 구문 | 설명 |
|------|------|
| `CREATE VIEW name AS SELECT ...` | 뷰 생성 |
| `SELECT * FROM name` | 뷰 조회 (일반 테이블처럼) |
| `DROP VIEW IF EXISTS name` | 뷰 삭제 (원본 데이터 영향 없음) |

### Transaction
| 구문 | 설명 |
|------|------|
| `BEGIN TRANSACTION` | 트랜잭션 시작 (SQLite) |
| `START TRANSACTION` | 트랜잭션 시작 (MySQL) |
| `COMMIT` | 변경 사항 확정 |
| `ROLLBACK` | 변경 사항 취소 |

### Join
| JOIN 유형 | 결과 | 사용 시점 |
|-----------|------|-----------|
| `INNER JOIN` | 양쪽에 모두 있는 행 | 매칭되는 데이터만 필요 |
| `LEFT JOIN` | 왼쪽 전체 + 오른쪽 매칭 | 왼쪽 기준 전체 + 있으면 추가 정보 |
| `RIGHT JOIN` | 오른쪽 전체 + 왼쪽 매칭 | 오른쪽 기준 전체 |
| `FULL OUTER JOIN` | 양쪽 전체 | 누락 데이터 파악 |

### NULL 처리
| 표현 | 의미 |
|------|------|
| `IS NULL` | NULL인 행 (= NULL 은 안 됨) |
| `IS NOT NULL` | NULL이 아닌 행 |
| `COUNT(컬럼)` | NULL 제외 카운트 |
| `COUNT(*)` | NULL 포함 전체 카운트 |