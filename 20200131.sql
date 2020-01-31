--0131

--JOIN �� ���̺��� �����ϴ� �۾�
--JOIN ����
--1. ANSI ����
--2. ORACLE ����

-- Natural Join
--�� ���̺� �÷����� ���� �� �ش� �÷����� ����(����)
--emp, dept ���̺��� deptno��� �÷��� ����

SELECT *
FROM emp NATURAL JOIN dept;

--Natural joim�� ���� �����÷�(deptno)�� ������(ex : ���̺��, ���̺�Ī)�� ������� �ʰ�
--�÷��� ���(dept.no --> deptno)
SELECT emp.empno, emp.ename, dept.dname, deptno
FROM emp NATURAL JOIN dept;

--���̺� ���� ��Ī�� ��밡��
SELECT e.empno, e.ename, d.dname, deptno
FROM emp e NATURAL JOIN dept d;

--ORACLE JOIN
--FROM���� ������ ���̺� �����, �� �����Ͽ� ����
--������ ���̺��� ���� ������ WHERE���� ���
--emp, dept���̺� �����ϴ� deptno�÷��� [������ ] ����
SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno = dept.deptno;

SELECT emp.ename, dept.dname
FROM emp, dept
WHERE emp.deptno != dept.deptno;

--����Ŭ ������ ���̺� ��Ī
SELECT e.empno, e.ename, d.dname, e.deptno
FROM emp e, dept d
WHERE e.deptno = d.deptno;

--ANSI : join with USING
--�����Ϸ��� �ΰ��� ���̺� �̸��� ���� �ø��� �ΰ������� �ϳ��� �÷����θ� ������ �ϰ��� �� ��
--�����Ϸ��� ���� �÷��� ���
--emp, dept���̺��� ���� �÷� : deptno
SELECT emp.ename,dept.dname, deptno
FROM emp JOIN dept USING(deptno);

--JOIN WITH USING�� ORACLE�� ǥ���ϸ�?
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--ANSI : JOIN WITH ON
--�����Ϸ��� �ϴ� ���̺��� �÷��� �̸��� ���� �ٸ� ��
SELECT emp.ename, dept.dname, dept.deptno
FROM emp JOIN dept ON (emp.deptno = dept.deptno);

--JOIN WITH ON-->ORACLE
SELECT emp.ename, dept.dname, emp.deptno
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--SELF JOIN : ���� ���̺��� ����
-- �� : emp���̺��� �����Ǵ� ����� ������ ����� �̿��Ͽ� ������ �̸��� ��ȸ
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e JOIN emp m ON (e.mgr = m.empno) ;

--ORACLE
SELECT e.empno, e.ename, m.empno, m.ename
FROM emp e, emp m 
WHERE e.mgr = m.empno;

--equal ���� : =
--non - equal ���� : !=, >, <, BETWEEN AND

--����� �޿� ������ �޿� ��� ���̺��� �̿��Ͽ� �ش� ����� �޿� ����� ���غ���
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


