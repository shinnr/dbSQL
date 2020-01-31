--0131

--JOIN 두 테이블을 연결하는 작업
--JOIN 문법
--1. ANSI 문법
--2. ORACLE 문법

-- Natural Join
--두 테이블간 컬럼명이 같을 때 해당 컬럼으로 연결(조인)
--emp, dept 테이블에는 deptno라는 컬럼이 존재

SELECT *
FROM emp NATURAL JOIN dept;

--Natural joim에 사용된 조언컬럼(deptno)는 한정자(ex : 테이블명, 테이블별칭)을 사용하지 않고
--컬럼명만 기술(dept.no --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--테이블에 대한 별칭도 사용가능
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM절에 조인할 테이블 목록을, 로 구분하여 나열
--조인할 테이블의 연결 조건을 WHERE절에 기술
--emp, dept테이블에 존재하는 deptno컬럼이 [같을때 ] 조인
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

--오라클 조인의 테이블 별칭
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING
--조인하려는 두개의 테이블에 이름이 같은 컬림이 두개이지만 하나의 컬럼으로만 조인을 하고자 할 때
--조인하려는 기준 컬럼을 기술
--emp, dept테이블의 공통 컬럼 : deptno
SELECT emp.ename,dept.dname, deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH USING을 ORACLE로 표현하면?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--조인하려고 하는 테이블의 컬럼의 이름이 서로 다를 때
SELECT emp.ename, dept.dname, dept.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON-->ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : 같은 테이블간의 조인
-- 예 : emp테이블에서 관리되는 사원의 관리자 사번을 이용하여 관리자 이름을 조회
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno) ;

--ORACLE
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno;

--equal 조인 : =
--non - equal 조인 : !=, >, <, BETWEEN AND

--사원의 급여 정보와 급여 등급 테이블을 이용하여 해당 사원의 급여 등급을 구해보자
SELECT ename, sal
FROM emp;

SELECT *
FROM salgrade;
--ORACLE
SELECT ename, sal, salgrade.grade
FROM emp, salgrade
WHERE emp.sal BETWEEN salgrade.losal
                  AND salgrade.hisal;
--ANSI                  
SELECT ename, sal, salgrade.grade
FROM emp JOIN salgrade ON (emp.sal BETWEEN salgrade.losal
                                        AND salgrade.hisal);
                                        
--join0
SELECT emp.empno, emp.ename, dept.deptno, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--join01_1
SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno != 20;

SELECT e.empno, e.ename, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND d.deptno IN(10,30);
--join0_2
SELECT *
FROM emp;

SELECT *
FROM dept;

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno AND e.sal > 2500;

--join0_3
SELECT *
FROM
    (SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno)a
WHERE a.sal > 2500 AND a.empno > 7600;

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500 AND e.empno > 7600;

--join0_4
SELECT *
FROM
    (SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
    FROM emp e, dept d
    WHERE e.deptno = d.deptno)a
WHERE a.sal > 2500 AND a.empno > 7600 AND a.dname = 'RESEARCH';

SELECT e.empno, e.ename, e.sal, d.deptno, d.dname
FROM emp e, dept d
WHERE e.deptno = d.deptno
AND e.sal > 2500 AND e.empno > 7600
AND d.dname = 'RESEARCH';

SELECT *
FROM prod;

--PROD : PROD_LGU
--LPROD : LPROD_GU

SELECT *
FROM prod;

SELECT *
FROM lprod;

--join1
SELECT lp.lprod_gu, lp.lprod_nm, p.prod_id, p.prod_name
FROM prod p, lprod lp
WHERE p.prod_lgu = lp.lprod_gu;

--join2
SELECT *
FROM buyer;

SELECT b.buyer_id, b.buyer_name, p.prod_id, p.prod_name
FROM prod p, buyer b
WHERE p.prod_buyer = b.buyer_id;


