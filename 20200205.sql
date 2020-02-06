--sub6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (
            SELECT pid
            FROM cycle
            WHERE cid = 2);
            
--sub7
SELECT customer.cid, customer.cnm, product.pnm, a.day, a.cnt
FROM    (SELECT *
        FROM cycle
        WHERE cid = 1
        AND pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2))a JOIN customer ON (a.cid = customer.cid)
                                     JOIN product ON (a.pid = product.pid);
                    
SELECT *
FROM customer;
SELECT *
FROM product;

SELECT customer.cid, customer.cnm, product.pnm, a.day, a.cnt
FROM 
        (SELECT *
        FROM cycle
        WHERE cid = 1
        AND pid IN (
                    SELECT pid
                    FROM cycle
                    WHERE cid = 2))a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

SELECT cycle.cid, customer.cnm, cycle.pid ,product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

--매니저가 존재하는 직원을 조회(KING을 제외한 13명의 데이터가 조회)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXISTS 조건에 만족하는 행이 존재하는지 확인하는 연산자
--다른 연산자와 다르게 WHERE절에 컬럼을 기술하지 않는다
--WHERE empno = 7369
--WHERE EXISTS (SELECT 'X'
--                FROM .....)

--매니저가 존재하는 직원을 EXISTS연산자를 통해 조회
--매니저도 직원
SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
--sub9
--1번 고객이 애음하는 제품 ==> 100,400
SELECT *
FROM cycle;
SELECT *
FROM product;

SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);

--sub10
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);
              
--집합연산
--합집합 : UNION -중복제거(집합개념) /UINION ALL -중복을 제거하지 않음(속도향상)
--교집합 : INTERSECT (집합개념)
--차집합 : MINUS (집합개념)
--집합연산 공통사항
--두 집합의 컬럼의 개수, 타입이 일치해야한다.

--동일한 집합을 합집합하기 때문에 중복되는 데이터는 한번만 적용된다
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--UNION ALL연산자는 UNION연산자와 다르게 중복을 허용한다
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--INTERSECT(교집합) : 위, 아래 집합에서 값이 같은 행만 조회
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--MINUS(차집합) :위 집합에서 아래 집합의 데이터를 제거한 나머지 집합
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--집합의 기술 순서가 영향이 가는 집합연산자
--A UNION B        B UNION A ==>같음
--A UNION ALL B    B UNION ALL A ==>같음(집합)
--A INTERSECT B    B INTERSECT A ==>같음
--A MINUS B        B MINUS A ==>다름

--집합연산의 결과 컬럼 이름은 첫번째 집합의 컬럼명을 따른다.
SELECT 'X' fir, 'B' sec
FROM dual

UNION

SELECT 'Y', 'A'
FROM dual;

--정렬(ORDER BY)는 집합연산 가장 마지막 집합 다음에 기술
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(10, 20)

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(30, 40)
ORDER BY deptno;

--햄버거 도시 발전지수

SELECT *
FROM fastfood;

--시도, 시군구, 버거지수
--(버거킹 + 맥도날드 + kfc)/롯데리아
--버거지수 값이 높은 도시가 먼저 나오도록 정렬
SELECT *
FROM fastfood;

SELECT gb
FROM fastfood
GROUP BY gb;

SELECT gb, CONCAT(sido, sigungu) city
FROM fastfood;


SELECT b.sido||sigungu
FROM
(SELECT sido||sigungu, COUNT(sido||sigungu)버거킹
FROM fastfood
WHERE gb = '버거킹'
GROUP BY sido||sigungu)b,

(SELECT sido||sigungu, COUNT(sido||sigungu)KFC
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido||sigungu)k,

(SELECT sido||sigungu, COUNT(sido||sigungu)맥도날드
FROM fastfood
WHERE gb = '맥도날드'
GROUP BY sido||sigungu)m

GROUP BY sido||sigungu;


SELECT (bg.sido||bg.sigungu)city , bg.bcity 버거, lt.lcity 롯데리아,  bg.bcity/lt.lcity 버거지수
FROM
    (SELECT sido, sigungu, COUNT(*)bcity
    FROM fastfood
    WHERE gb = '버거킹' OR gb = 'KFC' OR gb = '맥도날드'
    GROUP BY sido, sigungu)bg,
    (SELECT sido,sigungu, COUNT(*)lcity
    FROM fastfood
    WHERE gb = '롯데리아'
    GROUP BY sido, sigungu)lt
WHERE bg.sido = lt.sido AND bg.sigungu = lt.sigungu;











            