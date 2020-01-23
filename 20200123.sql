--01/23
SELECT *
FROM emp;

--WHERE2
--WHERE ���� ����ϴ� ���ǿ� ������ ��ȸ ����� ������ ��ġ�� �ʴ´�.
--SQL�� ������ ������ ���� �ִ�.
--������ Ư¡ : ���տ��� ������ ����.
--���̺��� ������ ������� ����
--SLECT ����� ������ �ٸ����� ���� �����ϸ� ����
-->���ı�� ����(ORDER BY)

SELECT ename, hiredate
FROM emp
WHERE hiredate >= TO_DATE('1982/01/01','YYYY/MM/DD')
AND hiredate <= TO_DATE('1983/01/01','YYYY/MM/DD');

-- IN������
--Ư�� ���տ� ���ԵǴ��� ���θ� Ȯ��
--�μ���ȣ�� 10�� Ȥ�� 20���� ���ϴ� ���� ��ȸ
SELECT empno, ename, deptno
FROM emp
WHERE deptno IN(10,20);

--IN�����ڸ� ������� �ʰ� OR������ ���
SELECT empno, ename, deptno
FROM emp
WHERE deptno=10
OR deptno=20;

--emp���̺��� ����̸��� SMITH, JONES�� ������ ��ȸ(empno, ename, deptno)
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

SELECT userid AS ���̵�, usernm AS �̸�, alias AS ����
FROM users
WHERE userid IN('brown', 'cony', 'sally');

-- ���ڿ� ��Ī ������ : LIKE, %, _
-- ������ ������ ������ ���ڿ� ��ġ�� ���ؼ� �ٷ�
-- �̸��� BR�� �����ϴ� ����� ��ȸ
-- �̸��� R���ڿ��� ���� ����� ��ȸ

-- ����̸��� S�� �����ϴ� ��� ��ȸ
-- % : � ���ڿ�(�ѱ���, ���� ���� ���� �ְ�, �������ڿ��� �� ���� �ִ�)
SELECT *
FROM emp;

SELECT *
FROM emp
WHERE ename LIKE 'S%'; 

-- ���ڼ��� ������ ���� ��Ī
-- _(�����):��Ȯ�� �ѹ���
-- ���� �̸��� S�� �����ϰ� �̸��� ��ü ���̰� 5������ ����
-- S____
SELECT *
FROM emp
WHERE ename LIKE 'S____';

-- ��� �̸��� S���ڰ� ���� ��� ��ȸ
-- ename LIKE '%S%'
SELECT *
FROM emp
WHERE ename LIKE '%S%';

--where4
SELECT *
FROM member;

SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '��%';

--where5
SELECT mem_id, mem_name
FROM member
WHERE mem_name LIKE '%��%';

--null �񱳿��� (IS)
--comm �÷��� ���� null�� �����͸� ��ȸ(WHERE comm = null)
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

-- ����� �����ڰ� 7689, 7839 �׸��� null�� �ƴ� ������ ��ȸ
-- �ƹ��͵� �ȳ���
-- NOT IN �����ڿ����� NULL ���� ���Խ�Ű�� �ȵȴ�
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

-- ������ �켱����
-- *,/�����ڰ� +,-���� �켱������ ����
-- �켱���� ���� : ()
-- AND > OR

--emp���̺��� ����̸��� SMITH�̰ų� ����̸��� ALLEN�̸鼭 �������� SALESMAN�� ��� ��ȸ
SELECT *
FROM emp
WHERE ename='SMITH' 
OR (ename='ALLEN' AND job='SALESMAN');

--����̸��� SMITH�̰ų� ALLEN�̸鼭 �������� SLAESMAN�� ��� ��ȸ
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

--����
--SELECT *
-- FROM table
--[WHERE]
--ORDER BY {�÷�|��Ī|�÷��ε��� [ASC | DESC], ....}

--emp ���̺��� ��� ����� ename �÷� ���� �������� �������� ������ ����� ��ȸ
SELECT *
FROM emp
ORDER BY ename;

--emp ���̺��� ��� ����� ename �÷� ���� �������� �������� ������ ����� ��ȸ
SELECT *
FROM emp
ORDER BY ename DESC;

DESC emp;
-- DESCRIBE(�����ϴ�)
--ORDER BY ename DESC; --DESCENDING(����)

-- emp ���̺��� ��� ������ ename�÷����� ��������, ename���� ���� ��� mgr�÷����� �������� �����ϴ� ����
SELECT *
FROM emp
ORDER BY ename DESC, mgr;

--���Ľ� ��Ī�� ���
SELECT empno, ename nm, sal*12 year_sal
FROM emp
ORDER BY year_sal;

--�÷� �ε����� ����
--java array[0]
--SQL COLIMN INDEX:1���� ����
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