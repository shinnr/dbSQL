--제약조건 확인방법
--1. tool
--2. dictionary view

--제액조건 : USER_CONSTRAINTS
--제약조건 - 컬럼 : USER_CONS_COLUMNS
--제약조건이 몇개의 컬럼에 관련되어 있는지 알 수 없기 때문에 테이블을 별도로 분리하여 설계
--1 정규형 : 

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');
--EMP, DEPT PK, FK 제약이 존재하지 않음
--2.EMP : PK (empno)
--3.     FK (deptno) - dept.deptno (fk제약을 생성하기 위해서는 참조하는 테이블 컬럼에 인덱스가 존재해야 한다)
--1.dept : pk (deptno)

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

--테이블, 컬럼 주석 : DICTIONARY 확인 기능
--테이블 주석 : USER_TAB_COMMENTS
--컬럼 주석 : USER_COL_COMMENTS

--주석 생성
--테이블 주석 : COMMENT ON TABLE 테이블명 IS '주석'
--컬럼주석 : COMMENT ON COLUMN 테이블.컬럼 IS '주석'

--emp : 직원
--dept : 부서

COMMENT ON TABLE emp IS '직원';
COMMENT ON TABLE dept IS '부서';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

--DEPT	DEPTNO : 부서번호
--DEPT	DNAME : 부서명
--DEPT	LOC : 부서위치
--EMP	EMPNO : 직원 번호
--EMP	ENAME : 직원 이름
--EMP	JOB : 담당업무
--EMP	MGR :매니저 직원 번호
--EMP	HIREDATE : 입사일자
--EMP	SAL : 급여
--EMP	COMM : 성과급
--EMP	DEPTNO : 소속부서번호

COMMENT ON COLUMN dept.deptno IS '부서번호';
COMMENT ON COLUMN dept.dname IS '부서명';
COMMENT ON COLUMN dept.loc IS '부서위치';
COMMENT ON COLUMN emp.empno IS '직원번호';
COMMENT ON COLUMN emp.ename IS '직원이름';
COMMENT ON COLUMN emp.job IS '담당업무';
COMMENT ON COLUMN emp.mgr IS '매니저 직원 번호';
COMMENT ON COLUMN emp.hiredate IS '입사일자';
COMMENT ON COLUMN emp.sal IS '급여';
COMMENT ON COLUMN emp.comm IS '성과급';
COMMENT ON COLUMN emp.deptno IS '소속부서번호';

SELECT * 
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name = c.table_name;

SELECT *
FROM user_tab_comments t, user_col_comments c
WHERE t.table_name IN ('customer', 'product', 'cycle', 'daily')
AND c.table_name IN ('customer', 'product', 'cycle', 'daily')
AND t.table_name = c.table_name;

select *
from user_tab_comments;
select *
from user_col_comments ;


--VIEW = QUERY
--TABLE처럼 DBMS에 미리 작성한 객체
--==>작성하지 않고 QUERY에서 바로 작성한 VIEW : IN-LINEVIEW ==>이름이 없기 때문에 재활용이 불가
--VIEW는 테이블이다(X)

--사용목적
--1.보안 목적(특정 컬럼을 제외하고 나머지 결과만 개발자에 제공)
--2.INLINE-VIEW를 VIEW로 생성하여 재활용
--   쿼리 길이 단축

--생성방법
--CREATE [OR REPLACE] VIEW 뷰명칭 [(column1,column2...)]AS
--SUBQUERY

--emp테이블에서 8개의 컬럼중 sal, comm컬럼을 제외한 6개 컬럼을 제공하는 v_emp VIEW생성

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--시스템 계정에서 nara 계정으로 view생성권한 추가(시스템 접속 하고 시스템계정으로 접속 바꾸기)
GRANT CREATE VIEW TO NARA;
--GRANT하고 SYSTEM 접속해제

--기존 인라인 뷰로 작성시
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp);

--VIEW객체 활용
SELECT *
FROM v_emp;

--emp테이블에는 부서명이 없음 ==> dept테이블과 조인을 빈번하게 진행
--조인된 결과를 view로 생성 해놓으면 코드를 간결하게 작성하는 게 가능

--VIEW : v_emp_dept
--dname(부서명), empno(직원번호), ename(직원이름), job(담당업무), hiredate(입사일자)

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--인라인뷰로 작성시
SELECT *
FROM (SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
     FROM emp, dept
     WHERE emp.deptno = dept.deptno);

--VIEW 활용시
SELECT *
FROM v_emp_dept;

--SMITH 직원 삭제 후 v_emp_dept view 건수 변화 확인
DELETE emp
WHERE ename = 'SMITH';

ROLLBACK;
--VIEW는 물리적인 데이터를 갖지 않고, 논리적인 데이터의 정의 집합(SQL)이기 때문에
--VIEW에서 참조하는 테이블의 데이터가 변경이 되면 VIEW의 조회 결과도 영향을 받는다

--SEQUENCE :시퀀스 - 중복되지 않는 정수값을 리턴해주는 오라클 객체
--CREATE SEQUENCE 시퀀스_이름;
--[OPTION...]
--명명규칙 : SEQ_테이블명

--emp테이블에서 사용할 시퀀스 생성
CREATE SEQUENCE seq_emp;

--시퀀스 제공 함수
--NEXTVAL : 시퀀스에서 다음 값을 가져올 때 사용
--CURRVAL : NEXTVAL를 사용하고나서 현재 읽어 들인 값을 재확인

SELECT seq_emp.NEXTVAL
FROM DUAL;

SELECT seq_emp.CURRVAL
FROM DUAL;

SELECT *
FROM emp_test;

DESC emp_test;
INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'JAMES',99, '017');

--시퀀스 주의점
--ROLLBACK을 하더라도 NEXTVAL를 통해 얻은 값이 원복되진 않는다
--NEXTVAL를 통해 값을 받아오면 그 값을 다시 사용할 수 없다

--INDEX

SELECT ROWID, emp.*
FROM emp;

SELECT *
FROM emp
WHERE ROWID = 'AAAE5dAAFAAAACLAAA';

--인덱스가 없을 때 empno 값으로 조회 하는 경우
--emp테이블에서 pk_emp제약 조건을 삭제하여 empno컬럼으로 인덱스가 존재하지 않는 환경을 조성

ALTER TABLE emp DROP CONSTRAINT pk_emp;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp테이블의 empno컬럼으로 PK제약을 생성하고 동일한 SQL을 실행
--PK : UNIQUE + NOT NULL
--     (UNIQUE 인덱스를 생성해준자)
--==>empno 컬럼으로 unique인덱스가 생성됨

--인덱스로 sql을 실행하게 되면 인덱스가 없을 때와 어떻게 다른지 차이점을 확인

ALTER TABLE emp ADD CONSTRAINT pk_emp PRIMARY KEY (empno);

SELECT ROWID, emp.*
FROM emp;

SELECT empno, rowid
FROM emp
ORDER BY empno;

explain plan for
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

SELECT *
FROM emp
WHERE ename = 'SMITH';

--SELECT 조회 컬럼이 테이블 접근에 미치는 영향
--SELECT * FROM emp WHERE empno = 7782
--==> SELECT empno FROM emp WHERE empno = 7782

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--UNIQUE VS NON-UNIQUE 인덱스의 차이 확인
--1. PK_EMP 삭제
--2. EMPNO컬럼으로 NON-UNIQUE 인덱스 생성
--3. 실행계획 확인

ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp테이블에 job컬럼을 기준으로 하는 새로운 non-unique인덱스를 생성
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--선택가능한 사항
--1.EMP테이블을 전체 읽기
--2.idx_n_01(empno) 인덱스 활용
--3.idx_n_02(job) 인덱스 활용

explain plan for
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);
