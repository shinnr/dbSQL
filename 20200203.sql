SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

--판매점 : 200 ~250
--고객당 2.5개 제품
--하루 : 500~750
--한달 : 15000~17000

SELECT *
FROM daily;

SELECT *
FROM batch;

--join4
--join을 하면서 row를 제한하는 조건을 결합;
SELECT c.cid, c.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer c, cycle
WHERE c.cid = cycle.cid
AND c.cnm IN ('brown', 'sally');

--join5
SELECT cu.cid, cu.cnm, p.pid, p.pnm, c.day, c.cnt
FROM customer cu, cycle c, product p
WHERE cu.cid = c.cid AND c.pid = p.pid
AND cu.cnm IN ('brown', 'sally');

--join6
SELECT cu.cid, cu.cnm, p.pid, p.pnm, SUM(c.cnt)
FROM customer cu, cycle c, product p
WHERE cu.cid = c.cid AND c.pid = p.pid
GROUP BY cu.cid, cu.cnm, p.pid, p.pnm, c.cnt;

--join7과제
SELECT p.pid, p.pnm, SUM(c.cnt)
FROM cycle c, product p
WHERE c.pid = p.pid
GROUP BY p.pid, p.pnm, c.cnt;

-- 해당 오라클 서버에 등록된 사용자(계정)조회;
SELECT *
FROM dba_users;

--HR계정의 비밀번호를 java로 초기화
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;










