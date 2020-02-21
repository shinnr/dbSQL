
--���� ���� ��� 11��
--����¡ó�� (�������� 10���� �Խñ�)
--1������ : 1~10
--2������ : 11~20
--���ε� ���� :page. :pageSize
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

--�� ������ �м��Լ��� ����ؼ� ǥ���ϸ�

SELECT ename, sal, deptno, ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank
FROM emp;

--�м��Լ� ����
--�м��Լ���([����]) OVER ([PARTITION BY �÷�] [ORDER BY �÷�] [WINDOWING])
--PARTITION BY �÷� : �ش� �÷��� ���� ROW���� �ϳ��� �׷����� ���´�
--ORDER BY �÷� : PARTITION BY�� ���� ���� �׷� ������ ORDER BY �÷����� ����

--ROW_NUMBER() OVER (PARTITION BY deptno ORDER BY sal DESC) rank;

--���� ���� �м��Լ�
--RNAK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ� ����ŭ ������ ������ ����
--         2���� �θ��̸� 3���� ���� 4����� �ļ����� �����
--DENSE_RANK() : ���� ���� ������ �ߺ� ������ ����, �ļ����� �ߺ����� �������� ����
--                2���� �θ��̶� �ļ����� 3����� ����
--ROW_NUMBER() : ROWNUM�� ����, �ߺ��� ���� ������� ����

--�μ���, �޿� ������ 3���� ��ŷ���� �Լ��� ����
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

--������ �м��Լ�(group �Լ����� �����ϴ� �Լ� ������ ����)
--SUM(�÷�)
--COUNT(*), COUNT(�÷�)
--MIN(�÷�)
--MAX(�÷�)
--AVG(�÷�)

--no_ana2�� �м��Լ��� ����Ͽ� �ۼ�
--�μ��� ������

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

--�޿��� �������� �����ϰ�, �޿��� ���� ���� �Ի����ڰ� ���� ����� ���� �켱������ �ǵ��� �����Ͽ�
--�������� ������(LEAD)�� SAL�÷��� ���ϴ� ���� �ۼ�

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

--no_ana3�� �м��Լ��� �̿��Ͽ� sql�ۼ�
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW)cumm_sal
FROM emp;

--�������� �������� ���� ������� ���� ������� �� 3������ sal�հ豸�ϱ�
SELECT empno, ename, sal, SUM(sal) OVER (ORDER BY sal, empno ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) c_sum
FROM emp;

--ana7
--ORDER BY ��� �� WINDOWING���� ������� ���� ��� ���� WINDOWING�� �⺻ ������ ����ȴ�
--RANGE UNBOUNDED PRECEDING
--RANGE BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal, empno) c_sum
FROM emp;

--WINDOWING�� RANGE, ROWS��
--RANGE : ������ ���� ����, ���� ���� ������ �÷����� �ڽ��� ������ ���
--ROWS : �������� ���� ����
SELECT empno, ename, deptno, sal, 
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal ROWS UNBOUNDED PRECEDING) row_,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal RANGE UNBOUNDED PRECEDING) range_,
       SUM(sal) OVER (PARTITION BY deptno ORDER BY sal) default_
FROM emp;


