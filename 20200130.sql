-- cond1
SELECT empno, ename,
      CASE 
         WHEN deptno = 10 THEN 'ACCOUNTING'
         WHEN deptno = 20 THEN 'RESEARCH'
         WHEN deptno = 30 THEN 'SLAES'
         WHEN deptno = 40 THEN 'OPERATIONS'
         ELSE 'DDIT'
      END dname
FROM emp;

SELECT empno, ename,
        DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESESARCH', 30, 'SALES', 40, 'OPERATIONS', 'DDIT') dname
FROM emp;

--cond2
--���س⵵�� �������, Ȧ������ Ȯ��
--DATE Ÿ�� -> ���ڿ�(�������� ����, YYYY-MM-DD HH24:MI:SS)
--¦��->2�� �������� ������0
-->Ȧ��->2�γ����� �� ������1
SELECT empno, ename, hiredate, 
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2) = 0 AND MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')),2) = 0 THEN '�ǰ����� �����'
            WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2) = 1 AND MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')),2) = 1 THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;

SELECT empno, ename, hiredate, 
       CASE 
            WHEN MOD(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')),2) = MOD(TO_NUMBER(TO_CHAR(hiredate, 'YYYY')),2) THEN '�ǰ����� �����'
            ELSE '�ǰ����� ������'
        END contact_to_doctor
FROM emp;

--GROUP BY ���� ���� ����
--�μ���ȣ ���� ROW���� ���� ��� : GROUP BY dept no
--���������� ���� ROW���� ���� ��� : GROUP BY job
--MGR�� ���� �������� ���� ROW���� ���� ��� : GROUP BY mgr, job

--�׷��Լ��� ����
--SUM : �հ�
--COUNT : ���� -NULL���� �ƴ� ROW�� ����)
--MAX : �ִ밪
--MIN : �ּҰ�
--AVG : ���

--�׷��Լ��� Ư¡
--�ش��÷��� NULL���� ���� ROW�� ������ ��� �ش� ���� �����ϰ� ����Ѵ�. (NULL������ ����� null)

--�׷��Լ� ������
--**GROUP BY���� ���� �÷� �̿��� �ٸ��÷��� SELECT���� ǥ���Ǹ� ����**

--�μ��� �޿���
SELECT deptno, ename,
        SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2), COUNT(sal)
       
FROM emp
GROUP BY deptno, ename;

--GROUP BY���� ���� ���¿��� �׷��Լ��� ����� ���            
-- -->��ü���� �ϳ��� ������ ���´�
SELECT  SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2), COUNT(sal), 
        COUNT(sal), --sal�÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),--comm�÷��� ���� null�� �ƴ� row�� ����
        COUNT(*) --����� �����Ͱ� �ִ���
FROM emp;

--GROUP BY�� ������ empno�̸� ������� ���?
--�׷�ȭ�� ���þ��� ������ ���ڿ�, �Լ�, ���ڵ��� SELECT���� ������ ���� ����
SELECT  1, SYSDATE, 'ACCOUNTING', SUM(sal) sum_sal, MAX(sal) max_sal, MIN(sal) min_sal, ROUND(AVG(sal),2), COUNT(sal), 
        COUNT(sal), --sal�÷��� ���� null�� �ƴ� row�� ����
        COUNT(comm),--comm�÷��� ���� null�� �ƴ� row�� ����
        COUNT(*) --����� �����Ͱ� �ִ���
FROM emp
GROUP BY empno;

--SINGLE ROW FUNCTION�� ��� WHERE ������ ����ϴ� ���� ����
--MULTI ROW FUNCTION(GROUP FUCTION)�� ��� WHERE������ ����ϴ� ���� �Ұ����ϰ� HAVING������ ������ ���

--�μ��� �޿� �� ��ȸ, �� �޿����� 9000�̻��� row�� ��ȸ
--dseptno, �޿���
SELECT deptno, SUM(sal) sum_sal
FROM emp
GROUP BY deptno
HAVING SUM(sal) > 9000;

--grp1
SELECT MAX(sal) max_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr, 
       COUNT(*) count_all
FROM emp;

--grp2
SELECT deptno,
       MAX(sal) max_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr, 
       COUNT(*) count_all
FROM emp
GROUP BY deptno;

--grp3
SELECT DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES')dname,
       MAX(sal) max_sal, 
       MIN(sal) min_sal, 
       ROUND(AVG(sal),2) avg_sal, 
       SUM(sal) sum_sal, 
       COUNT(sal) count_sal,
       COUNT(mgr) count_mgr, 
       COUNT(*) count_all
FROM emp
GROUP BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES')
ORDER BY DECODE(deptno, 10, 'ACCOUNTING', 20, 'RESEARCH', 30, 'SALES');


--grp4
--ORACLE 9i���������� GROUP BY���� ����� �÷����� ������ ����
--ORACLE 10G ���� ���ʹ� GROUP BY���� ����� �÷����� ������ �������� �ʴ´� (GROUP BY ����� �ӵ� up)
SELECT TO_CHAR(hiredate, 'YYYYMM')hire_yyyymm, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYYMM')
ORDER BY TO_CHAR(hiredate, 'YYYYMM');

--grp5
SELECT TO_CHAR(hiredate, 'YYYY')hire_yyyy, COUNT(*) cnt
FROM emp
GROUP BY TO_CHAR(hiredate, 'YYYY');

--grp6
SELECT COUNT(deptno) cnt
FROM dept;

--grp7
SELECT COUNT(*) cnt
   FROM (SELECT deptno
         FROM emp
        GROUP BY deptno); 




