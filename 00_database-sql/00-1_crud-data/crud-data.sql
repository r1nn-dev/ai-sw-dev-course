-- --------------------------------------------------------
-- 실습 문제
-- 1. 모든 직원의 이름과 부서를 조회한다.
-- 2. 급여가 50000 미만인 직원을 조회한다.
-- 3. 직원이 속한 국가 목록을 중복 없이 조회한다.
-- 4. 처음 10행만 조회한다.
-- 5. 특정 직원의 부서를 수정한다.
-- --------------------------------------------------------


-- 1. 모든 직원의 이름과 부서를 조회한다. 
SELECT NAME, DEPT 
FROM EMPLOYEE; 

-- 2. 급여가 50000 미만인 직원을 조회한다. 
SELECT * 
FROM EMPLOYEE 
WHERE SALARY < 50000; 

-- 3. 직원이 속한 국가 목록을 중복 없이 조회한다. 
SELECT DISTINCT COUNTRY 
FROM EMPLOYEE; 

-- 4. 처음 10행만 조회한다. 
SELECT * 
FROM EMPLOYEE 
LIMIT 10; 

-- 5. 특정 직원의 부서를 수정한다. 
-- 먼저 수정 대상 직원이 맞는지 확인한다. 
SELECT * 
FROM EMPLOYEE 
WHERE ID = 'E001'; 

-- 대상이 맞다면 부서를 수정한다. 
UPDATE EMPLOYEE 
SET DEPT = 'Data' 
WHERE ID = 'E001';