-- 성이 S로 시작하는 저자를 국가별로 묶고, 
-- 국가별 저자 수를 계산한 뒤, 
-- 저자 수 기준 내림차순으로 정렬한다.

SELECT COUNTRY, COUNT(*) AS cnt
FROM AUTHOR
WHERE LASTNAME LIKE 'S%'
GROUP BY COUNTRY
HAVING COUNT(*) >= 1
ORDER BY cnt DESC;
