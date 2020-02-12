--1.table full
--2.idx1 : empno
--3.idx2 : job

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename  LIKE 'C%'; 

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE INDEX idx_n_emp_03 ON emp (job, ename);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *
FROM TABLE(dbms_xplan.display);

--1.table full
--2.idx1 : empno
--2.idx2 :job
--4.idx3 :job + ename
--5.idx4 : ename + job

CREATE INDEX idx_n_emp_04 ON emp (ename, job);


SELECT ename, job, rowid
FROM emp
ORDER BY ename, job;

--3번 인덱스를 지우자
--3,4번째 인덱스가 컬럼 구성이 동일하고 순서만 다르다

DROP INDEX idx_n_emp_03;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE job = 'MANAGER'
AND ename LIKE 'C%';

SELECT *


FROM TABLE(dbms_xplan.display);

--emp - table full, pk_emp(empno)
--dept - table full, pk_dept(deptno)

--(emp-table full, dept-table full)
--(dept-table full,emp-table full)

--(emp-table full, dept-pk_dept)
--(dept-pk_dept, emp-table full)

--(emp-pk_emp, dept-table full)
--(dept-table full, emp-pk_emp)

--(emp-pk_emp, dept-pk_emp)
--(dept-pk_emp, emp-pk_emp)

--1.순서

--2개 테이블 조인
--각각의 테이블에 인덱스 5개씩 있다면
--한 테이블에 접근 전략 :  6
--36 * 2 = 72

--ORACLE - 실시간 응답 : OLPT (ON LINE TRANSACTION PROCESSING)
--         전체 처리시간 : OLAP (ON LINE ANALYSIS PROCESSING) -복잡한 쿼리의 실행계획을 세우는데 30M~1H


--emp부터 읽을까 dept부터 읽을까???

EXPLAIN PLAN FOR
SELECT ename, dname, loc
FROM emp, dept
WHERE emp.deptno = dept.deptno
AND emp.empno = 7788;


SELECT *
FROM TABLE(dbms_xplan.display);

--idx1

--CTAS
--제약조건 복사가 NOT NULL만 된다
--백업이나, 테스트용으로

CREATE TABLE dept_test2 AS 
SELECT * 
FROM dept
WHERE 1 = 1;

CREATE UNIQUE INDEX idx_u_dept_01 ON dept_test2 (deptno);
CREATE INDEX idx_n_dept_test_02 ON dept_test2 (dname);
CREATE INDEX idx_n_dept_test_03 ON dept_test2 (deptno, dname);

--idx2
DROP INDEX idx_u_dept_01;
DROP INDEX idx_n_dept_test_02;
DROP INDEX idx_n_dept_test_03;

--idx3
CREATE TABLE emp2 AS 
SELECT * 
FROM emp
WHERE 1 = 1;

CREATE TABLE dept2 AS 
SELECT * 
FROM dept
WHERE 1 = 1;

ALTER TABLE emp2 ADD CONSTRAINT pk_emp2 PRIMARY KEY (empno);
ALTER TABLE dept2 ADD CONSTRAINT pk_dept2 PRIMARY KEY (deptno);

CREATE INDEX idx_n_emp2_01 ON emp2 (ename);
CREATE INDEX idx_n_emp2_02 ON emp2 (deptno);

--access pattern
--
--ename(=)
--deptno(=), empno(LIKE 직원번호%) ==> empno, deptno
--deptno(=), sal (BETWEEN)
--deptno(=) /mgr 동반하면 유리
--
--deptno, hiredate가 인덱스 존재하면 유리

--dept, sal, mgr, hiredate

EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE empno = :empno;

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM EMP
WHERE ename = :ename;

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp2, dept2
WHERE emp2.deptno = dept2.deptno
AND emp2.deptno = :deptno
AND emp2.empno LIKE :empno || '%';

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT *
FROM emp2
WHERE sal BETWEEN :st_sal AND  :ed_sal
AND deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);

EXPLAIN PLAN FOR
SELECT b.*
FROM emp2 a, emp2 b
WHERE a.mgr = b.empno
AND a.deptno = :deptno;

SELECT *
FROM TABLE(dbms_xplan.display);


EXPLAIN PLAN FOR
SELECT deptno, TO_CHAR(hiredate, 'yyyymm'), COUNT(*) cnt
FROM emp2
GROUP BY deptno, TO_CHAR(hiredate, 'yyyymm');

SELECT *
FROM TABLE(dbms_xplan.display);

CREATE INDEX idx_n_emp2_03 ON emp2 (deptno, TO_CHAR(hiredate,'yyyymm'));
DROP INDEX idx_n_emp2_03;

--empno
--ename
--deptno, empno ==> empno, deptno
--deptsal
--


