--CROSS JOIN==>Cartesian Product(īƼ�� ���δ�Ʈ)
--�����ϴ� �� ���̺��� ���� ������ �����Ǵ� ���
--������ ��� ���տ� ���� ����(����)�� �õ�
--dept(4��), emp(14)�� CROSS JOIN�� ����� 4*14=56
--dept ���̺�� emp���̺��� ������ �ϱ� ���� FROM���� �ΰ��� ���̺��� ���
--WHERE���� �� ���̺��� ���������� ����

SELECT dept.dname, emp.empno, emp.ename
FROM dept, emp
WHERE dept.deptno = 10
AND dept.deptno = emp.deptno;

--crossjoin1
SELECT customer.cid, customer.cnm, product.pid, product.pnm
FROM customer, product;

--SUBQUERY : ���� �ȿ� �ٸ� ������ ���� ��
--SUBQUERY�� ���� ��ġ�� ���� 3������ �з�
--SELECT �� : SCALA SUBQUERY : �ϳ��� ��, �ϳ��� �÷��� �����ؾ� ������ �߻����� ����
--FROM �� : INLINE - VIEW (VIEW)
--WHERE �� : SUBQUERY QUERY

--���ϰ��� �ϴ� ��:
--SMITH�� ���� �μ��� ���ϴ� �������� ������ ��ȸ
--1.SMITH�� ���ϴ� �μ� ��ȣ�� ���Ѵ�
--2.1������ ���� �μ� ��ȣ�� ���ϴ� ������ ������ ��ȸ�Ѵ�

--1.
SELECT deptno
FROM emp
WHERE ename = 'SMITH';

--2. 1������ ���� �μ���ȣ�� �̿��Ͽ� �ش� �μ��� ���ϴ� ���� ������ ��ȸ
SELECT *
FROM emp
WHERE deptno = 20;

--SUBQUERY�� �̿��ϸ� �ΰ��� ������ ���ÿ� �ϳ��� SQL�� ������ ����
SELECT *
FROM emp
WHERE deptno = (SELECT deptno
                FROM emp
                WHERE ename = 'SMITH');
                
--sub1
SELECT *
FROM emp;

SELECT COUNT(*)
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
             
--sub2
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);

--������ ������
--IN : ���������� ������ �� ��ġ�ϴ� ���� ������ ��
--ANY(Ȱ�뵵�� �ټ� ������) : ���������� ������ �� �� ���̶� ������ ������ ��
--ALL(Ȱ�뵵�� �ټ� ������) : ���������� ������ �� ��� ������ ������ ��

--sub3
--SMITH�� ���ϴ� �μ��� ��� ������ ��ȸ
--SMITH�� WARD������ ���ϴ� �μ��� ��� ������ ��ȸ

--���������� ����� �������� ���� = �����ڸ� ������� ���Ѵ�
SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));
                
--SMITH, WARD����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿��� �ƹ��ų�)
SELECT *
FROM emp
WHERE sal < ANY (SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));
--SMITH, WARD����� �޿����� �޿��� ���� ������ ��ȸ(SMITH, WARD�� �޿� 2���� ��ο� ���� ���� ��)            
SELECT *
FROM emp
WHERE sal > ALL (SELECT sal
                FROM emp
                WHERE ename IN ('SMITH', 'WARD'));  
                
--IN, NOT IN�� NULL�� ���õ� ���ǻ���

--������ ������ ����� 7902�̰ų�(OR) NULL
--IN�����ڴ� OR�����ڷ� ġȯ ����
SELECT *
FROM emp
WHERE mgr IN (7902, NULL);

--NULL�񱳴� = �����ڰ� �ƴ϶� IS NULL�� ���ؾ������� IN�����ڴ� =�� ����Ѵ�
SELECT *
FROM emp
WHERE mgr =7902 
OR mgr = NULL;

--NOT IN(7902, NULL)==>AND
--�����ȣ�� 7902�� �ƴϸ鼭(AND) NULL�� �ƴ� ������
SELECT *
FROM emp
WHERE empno NOT IN (7902, NULL);

SELECT *
FROM emp
WHERE empno != 7902 
AND empno != NULL;

SELECT *
FROM emp
WHERE empno != 7902 
AND empno IS NOT NULL;

--pairwise(������)
--�������� ����� ���ÿ� ���� ��ų ��
SELECT *
FROM emp
WHERE (mgr, deptno) IN (SELECT mgr, deptno
                        FROM emp
                        WHERE empno IN (7499, 7782));
--non-pairwise�� �������� ���ÿ� ������Ű�� �ʴ� ���·� �ۼ�
--mgr ���� 7698�̰ų� 7839�̸鼭
--deptno�� 10�̰ų� 30���� ����
--mgr, deptno
(7698, 10), (7698, 30)
(7839, 10), (7839, 30)
SELECT *
FROM emp
WHERE mgr IN (SELECT mgr
              FROM emp
              WHERE empno IN (7499, 7782))
AND deptno IN (SELECT deptno
              FROM emp
              WHERE empno IN (7499, 7782));
              
--��Į�� �������� : SELECT ���� ���, 1���� ROW, 1���� COL�� ��ȸ�ϴ� ����
--��Į�� ���������� MAIN������ �÷��� ����ϴ� �� �����ϴ�

SELECT SYSDATE
FROM dual;

SELECT (SELECT SYSDATE FROM dual), dept.*
FROM dept;

SELECT empno, ename, deptno,
       (SELECT dname 
        FROM dept 
        WHERE deptno = emp.deptno) dname
FROM emp; 
dept
WHERE emp.deptno = dept.deptno;

--INLINE VIEW : FROM���� ����Ǵ� ��������

--MAIN������ �÷��� SUBQUERY���� ����ϴ��� ������ ���� �з�
--����� ��� : correlated subquery(��ȣ��������), ���������� �ܵ����� �����ϴ� �� �Ұ���
              --������Ż� ������ �ִ�(main==>sub)
--������� ���� ��� : non-correlated subquery(���ȣ ������������), ���������� �ܵ����� �����ϴ� �� ����
               --��������� ������ ���� �ʴ�(main==>sub, sub==>main)
--��� ������ �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp
WHERE sal > (SELECT AVG(sal)
             FROM emp);
--������ ���� �μ��� �޿� ��պ��� �޿��� ���� ����� ��ȸ
SELECT *
FROM emp a
WHERE  sal > (SELECT AVG(sal)
             FROM emp b 
             WHERE deptno = a.deptno);
             
--���� ������ ������ �̿��ؼ� Ǯ���
--1.�������̺� ����
--emp, �μ��� �޿� ���(inline view)
SELECT emp.* --ename, sal, emp.deptno ,dept_sal.*
FROM emp, (SELECT deptno, ROUND(AVG(sal)) avg_sal
           FROM emp
           GROUP BY deptno) dept_sal
WHERE emp.deptno = dept_sal.deptno
AND emp.sal > dept_sal.avg_sal;

--sub4
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;
--COMMIT   Ʈ����� ���
--ROLLBACK Ʈ����� Ȯ��
SELECT *
FROM dept;

SELECT deptno, dname, loc
FROM dept
WHERE deptno NOT IN (SELECT deptno
                     FROM emp
                     group by deptno);
                     
SELECT *
FROM emp;

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN (SELECT deptno
                     FROM dept
                     WHERE deptno = 99);




