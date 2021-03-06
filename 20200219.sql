
--쿼리 실행 결과 11건
--페이징처리 (페이지당 10건의 게시글)
--1페이지 : 1~10
--2페이지 : 11~20
--바인드 변수 :page. :pageSize
SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY root DESC, seq ASC;


SELECT *
FROM
    (SELECT ROWNUM rn , a.*
     FROM
        (SELECT seq, LPAD(' ', (LEVEL-1)*4) || title title, DECODE(parent_seq, NULL, seq, parent_seq) root
        FROM board_test
        START WITH parent_seq IS NULL
        CONNECT BY PRIOR seq = parent_seq
        ORDER SIBLINGS BY root DESC, seq ASC)a)
    WHERE rn BETWEEN (:page-1) * :pageSize +1 AND :page * :pageSize;

SELECT b.ename, b.sal,b.deptno, a.lv
FROM
(SELECT a.*, rownum rm
FROM
(SELECT *
FROM
(   SELECT LEVEL lv
    FROM dual
    CONNECT BY LEVEL <=14) a,
(   SELECT deptno, COUNT(*) cnt
    FROM emp
    GROUP BY deptno) b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv) a) a 
JOIN
(SELECT b.*, rownum rm
FROM
(SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal desc)b) b ON(a.rm = b.rm);

--위 쿼리를 분석함수를 사용해서 표현하면

SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

--분석함수 문법
--분석함수명([인자]) OVER ([PARTITION BY 컬럼] [ORDER BY 컬럼] [WINDOWING])
--PARTITION BY 컬럼 : 해당 컬럼이 같은 ROW끼리 하나의 그룹으로 묶는다
--ORDER BY 컬럼 : PARTITION BY에 의해 묶은 그룹 내에서 ORDER BY 컬럼으로 정렬

--ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank;

--순위 관련 분석함수
--RNAK() : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복 값만큼 떨어진 값부터 시작
--         2등이 두명이면 3등은 없고 4등부터 후순위가 생긴다
--DENSE_RANK() : 같은 값을 가질때 중복 순위를 인정, 후순위는 중복순위 다음부터 시작
--                2등이 두명이라도 후순위는 3등부터 시작
--ROW_NUMBER() : ROWNUM과 유사, 중복된 값을 허용하지 않음

--부서별, 급여 순위를 3개의 랭킹관련 함수를 적용
SELECT ename, deptno, 
       RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_rank,
       DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal) sal_dense_rank,
       ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal) sal_row_number
FROM emp;

--ana1
SELECT empno, ename,sal,deptno,
       RANK() OVER (ORDER BY sal DESC, empno) sal_rank,
       DENSE_RANK() OVER (ORDER BY sal DESC, empno) sal_dense_rank,
       ROW_NUMBER() OVER (ORDER BY sal DESC, empno) sal_row_number
FROM emp;

--no_ana2
SELECT a.empno, a.ename, b.deptno, b.c
FROM
    (SELECT empno, ename, deptno
    FROM emp) a,
    (SELECT deptno, COUNT(*) c
    FROM emp
    GROUP BY deptno)b
WHERE a.deptno = b.deptno
ORDER BY deptno;

--통계관련 분석함수(group 함수에서 제공하는 함수 종류와 동일)
--SUM(컬럼)
--COUNT(*), COUNT(컬럼)
--MIN(컬럼)
--MAX(컬럼)
--AVG(컬럼)

--no_ana2를 분석함수를 사용하여 작성
--부서별 직원수

SELECT empno, ename, deptno, COUNT(*) OVER (PARTITION BY deptno) cnt
FROM emp;

--ana2
SELECT empno, ename, deptno, ROUND(AVG(sal) OVER (PARTITION BY deptno),2)
FROM emp;

--ana3
SELECT empno, ename, sal, deptno, MAX(sal) OVER (PARTITION BY deptno)
FROM emp;

--ana4
SELECT empno, ename, sal, deptno, MIN(sal) OVER (PARTITION BY deptno)
FROM emp;

--급여를 내림차순 정렬하고, 급여가 같을 때는 입사일자가 빠른 사람이 높은 우선순위가 되도로 정렬하여
--현재행의 다음행(LEAD)의 SAL컬럼을 구하는 쿼리 작성

SELECT empno, ename, hiredate, sal, LEAD(sal) OVER (ORDER BY sal DESC, hiredate) lead_sal
FROM emp;

--ana5
SELECT empno, ename, hiredate, sal, LAG(sal) OVER (ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--ana6
SELECT empno, ename, hiredate, job, sal, LAG(sal) OVER (PARTITION BY job ORDER BY sal DESC, hiredate) lag_sal
FROM emp;

--no_ana3

SELECT a.empno, a.ename, a.sal, SUM(b.sal) C_SUM
FROM 
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal)a)a,
    (SELECT a.*, rownum rn
     FROM 
        (SELECT *
         FROM emp
         ORDER BY sal, empno)a)b
WHERE a.rn >= b.rn
GROUP BY a.empno, a.ename, a.sal, a.rn
ORDER BY a.rn, a.empno;

--no_ana3를 분석함수를 이용하여 sql작성
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)cumm_sal
FROM emp;

--현재행을 기준으로 이전 한행부터 이후 한행까지 총 3개행의 sal합계구하기
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

--ana7
--ORDER BY 기술 후 WINDOWING절을 기술하지 않을 경우 다음 WINDOWING이 기본 값으로 적용된다
--RANGE UNBOUNDED PRECEDING
--RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno) c_sum
FROM emp;

--WINDOWING의 RANGE, ROWS비교
--RANGE : 논리적인 행의 단위, 같은 값을 가지는 컬럼까지 자신의 행으로 취급
--ROWS : 물리적인 행의 단위
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) range_,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal) default_
FROM emp;


