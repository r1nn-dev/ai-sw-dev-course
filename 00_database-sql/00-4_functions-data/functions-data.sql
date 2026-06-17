-- ============================================================
-- 실습 문제
-- 1. 함수로 값을 변환한다. SQL 함수로 숫자와 문자열을 변환한다.
-- 2. 평균보다 낮은 값을 찾는 서브쿼리를 작성한다.
-- 3. `FROM` 절 derived table을 사용한다. 
--    - `FROM` 절에 서브쿼리를 넣어 임시 결과를 만든다.
-- 4. 두 테이블을 연결해 필요한 컬럼만 조회한다.
-- ============================================================


-- 1. 비용을 소수점 둘째 자리까지 반올림한다.
SELECT ROUND(COST, 2) AS rounded_cost
FROM PETRESCUE;

-- 2. 평균 급여보다 낮은 급여를 받는 직원을 조회한다.
SELECT F_NAME, L_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY < (
    SELECT AVG(SALARY)
    FROM EMPLOYEES
);

-- 3. 부서별 평균 급여를 derived table로 만든 뒤 조회한다.
SELECT *
FROM (
    SELECT DEP_ID, AVG(SALARY) AS avg_salary
    FROM EMPLOYEES
    GROUP BY DEP_ID
) AS dept_avg;

-- 4. 직원 테이블과 부서 테이블을 연결해 직원 이름과 부서명을 조회한다.
SELECT E.F_NAME, D.DEP_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEP_ID = D.DEPT_ID_DEP;