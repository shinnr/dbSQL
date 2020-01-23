--01/23
SELECT *
FROM emp;

--WHERE2
--WHERE 절에 기술하는 조건에 순서는 조회 결과에 영향을 미치지 않는다.
--SQL은 집합의 개념을 갖고 있다.
--집합의 특징 : 집합에는 순서가 없다.
--테이블에는 순서가 보장되지 않음
--SLECT 결과가 순서가 다르더라도 값이 동일하면 정답
-->정렬기능 제공(ORDER BY)

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

-- IN연산자
--특정 집합에 포함되는지 여부를 확인
--부서번호가 10번 혹은 20번에 속하는 직원 조회
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN(10,20);

--IN연산자를 사용하지 않고 OR연산자 사용
SELECT empno, ename, deptno
FROM emp
WHERE deptno=10
OR deptno=20;

--emp테이블에서 사원이름이 SMITH, JONES인 직원만 조회(empno, ename, deptno)
SELECT empno, ename, deptno
FROM emp
WHERE ename='SMITH'
OR ename='JONES';

SELECT empno, ename, deptno
FROM emp
WHERE ename IN('SMITH', 'JONES');

--where3
SELECT *
FROM users;

SELECT userid AS 아이디, usernm AS 이름, alias AS 별명
FROM users
WHERE userid IN('brown', 'cony', 'sally');

-- 문자열 매칭 연산자 : LIKE, %, _
-- 위에서 연습한 조건은 문자열 일치에 대해서 다룸
-- 이름이 BR로 시작하는 사람만 조회
-- 이름에 R문자열이 들어가는 사람만 조회

-- 사원이름이 S로 시작하는 사원 조회
-- % : 어떤 문자열(한글자, 글자 없를 수도 있고, 여러문자열이 올 수도 있다)
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE ename LIKE 'S%'; 

-- 글자수를 제한한 패턴 매칭
-- _(언더바):정확히 한문자
-- 직원 이름이 S로 시작하고 이름의 전체 길이가 5글자인 직원
-- S____
SELECT *
FROM emp
WHERE ename LIKE 'S____';

-- 사원 이름에 S글자가 들어가는 사원 조회
-- ename LIKE '%S%'
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where4
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '신%';

--where5
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%이%';

--null 비교연산 (IS)
--comm 컬럼의 값이 null인 데이터를 조회(WHERE comm = null)
SELECT *
FROM emp
WHERE comm = null;

SELECT *
FROM emp
WHERE comm = '';

SELECT *
FROM emp
WHERE comm IS null;

--where6
SELECT *
FROM emp
WHERE comm>=0;

SELECT *
FROM emp
WHERE comm IS NOT null;

-- 사원의 관리자가 7689, 7839 그리고 null이 아닌 직원만 조회
-- 아무것도 안나옴
-- NOT IN 연산자에서는 NULL 값을 포함시키면 안된다
SELECT *
From emp
WHERE mgr NOT IN(7698,7839, NULL);
-->
SELECT *
From emp
WHERE mgr NOT IN(7698,7839)
AND mgr IS NOT NULL;

-- where7
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where8
SELECT *
FROM emp
WHERE deptno >10
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where9
SELECT *
FROM emp
WHERE deptno NOT IN (10)
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where10
SELECT *
FROM emp
WHERE deptno IN (20,30)
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where11
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD');

--where12
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR empno LIKE '78%';

--where13
SELECT *
FROM emp
WHERE job IN ('SALESMAN')
OR empno BETWEEN 7800 AND 7899;

-- 연산자 우선순위
-- *,/연산자가 +,-보다 우선순위가 높다
-- 우선순위 변경 : ()
-- AND > OR

--emp테이블에서 사원이름이 SMITH이거나 사원이름이 ALLEN이면서 담당업무가 SALESMAN인 사원 조회
SELECT *
FROM emp
WHERE ename='SMITH' 
OR (ename='ALLEN' AND job='SALESMAN');

--사원이름이 SMITH이거나 ALLEN이면서 담당업무가 SLAESMAN인 사원 조회
SELECT *
FROM emp
WHERE (ename='SMITH' OR ename='ALLEN')
AND job='SALESMAN';

--where14
SELECT *
FROM emp
WHERE job='SALESMAN' 
OR ((empno LIKE ('78%'))--BETWEEN 7800 AND 7899) 
AND hiredate >= TO_DATE('1981/06/01', 'YYYY/MM/DD'));

--정렬
--SELECT *
-- FROM table
--[WHERE]
--ORDER BY {컬럼|별칭|컬럼인덱스 [ASC | DESC], ....}

--emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 오름차순 정렬한 결과를 조회
SELECT *
FROM emp
ORDER BY ename;

--emp 테이블의 모든 사원을 ename 컬럼 값을 기준으로 내림차순 정렬한 결과를 조회
SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp;
-- DESCRIBE(설명하다)
--ORDER BY ename DESC; --DESCENDING(내림)

-- emp 테이블에서 사원 정보를 ename컬럼으로 내림차순, ename값이 같을 경우 mgr컬럼으로 오름차순 정렬하는 쿼리
SELECT *
FROM emp
ORDER BY ename DESC, mgr;

--정렬시 별칭을 사용
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;

--컬럼 인덱스로 정렬
--java array[0]
--SQL COLIMN INDEX:1부터 시작
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY 3;

--orderby1
SELECT *
FROM dept
ORDER BY dname;

SELECT *
FROM dept
ORDER BY loc DESC;

--orderby2
SELECT *
FROM emp 
WHERE comm IS NOT null AND comm!=0
ORDER BY comm DESC, empno ASC;

--orderby3
SELECT *
FROM emp
WHERE mgr IS NOT NULL
ORDER BY job, empno DESC;