--�������� Ȯ�ι��
--1. tool
--2. dictionary view

--�������� : USER_CONSTRAINTS
--�������� - �÷� : USER_CONS_COLUMNS
--���������� ��� �÷��� ���õǾ� �ִ��� �� �� ���� ������ ���̺��� ������ �и��Ͽ� ����
--1 ������ : 

SELECT *
FROM USER_CONSTRAINTS
WHERE table_name IN ('EMP', 'DEPT', 'EMP_TEST', 'DEPT_TEST');
--EMP, DEPT PK, FK ������ �������� ����
--2.EMP : PK (empno)
--3.     FK (deptno) - dept.deptno (fk������ �����ϱ� ���ؼ��� �����ϴ� ���̺� �÷��� �ε����� �����ؾ� �Ѵ�)
--1.dept : pk (deptno)

ALTER TABLE dept ADD CONSTRAINT pk_dept PRIMARY KEY (deptno);
ALTER TABLE emp ADD CONSTRAINT PK_emp PRIMARY KEY (empno);
ALTER TABLE emp ADD CONSTRAINT FK_emp_dept FOREIGN KEY (deptno) REFERENCES dept (deptno);

--���̺�, �÷� �ּ� : DICTIONARY Ȯ�� ���
--���̺� �ּ� : USER_TAB_COMMENTS
--�÷� �ּ� : USER_COL_COMMENTS

--�ּ� ����
--���̺� �ּ� : COMMENT ON TABLE ���̺�� IS '�ּ�'
--�÷��ּ� : COMMENT ON COLUMN ���̺�.�÷� IS '�ּ�'

--emp : ����
--dept : �μ�

COMMENT ON TABLE emp IS '����';
COMMENT ON TABLE dept IS '�μ�';

SELECT *
FROM USER_TAB_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

SELECT *
FROM USER_COL_COMMENTS
WHERE TABLE_NAME IN ('EMP', 'DEPT');

--DEPT	DEPTNO : �μ���ȣ
--DEPT	DNAME : �μ���
--DEPT	LOC : �μ���ġ
--EMP	EMPNO : ���� ��ȣ
--EMP	ENAME : ���� �̸�
--EMP	JOB : ������
--EMP	MGR :�Ŵ��� ���� ��ȣ
--EMP	HIREDATE : �Ի�����
--EMP	SAL : �޿�
--EMP	COMM : ������
--EMP	DEPTNO : �ҼӺμ���ȣ

COMMENT ON COLUMN dept.deptno IS '�μ���ȣ';
COMMENT ON COLUMN dept.dname IS '�μ���';
COMMENT ON COLUMN dept.loc IS '�μ���ġ';
COMMENT ON COLUMN emp.empno IS '������ȣ';
COMMENT ON COLUMN emp.ename IS '�����̸�';
COMMENT ON COLUMN emp.job IS '������';
COMMENT ON COLUMN emp.mgr IS '�Ŵ��� ���� ��ȣ';
COMMENT ON COLUMN emp.hiredate IS '�Ի�����';
COMMENT ON COLUMN emp.sal IS '�޿�';
COMMENT ON COLUMN emp.comm IS '������';
COMMENT ON COLUMN emp.deptno IS '�ҼӺμ���ȣ';

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
--TABLEó�� DBMS�� �̸� �ۼ��� ��ü
--==>�ۼ����� �ʰ� QUERY���� �ٷ� �ۼ��� VIEW : IN-LINEVIEW ==>�̸��� ���� ������ ��Ȱ���� �Ұ�
--VIEW�� ���̺��̴�(X)

--������
--1.���� ����(Ư�� �÷��� �����ϰ� ������ ����� �����ڿ� ����)
--2.INLINE-VIEW�� VIEW�� �����Ͽ� ��Ȱ��
--   ���� ���� ����

--�������
--CREATE [OR REPLACE] VIEW ���Ī [(column1,column2...)]AS
--SUBQUERY

--emp���̺��� 8���� �÷��� sal, comm�÷��� ������ 6�� �÷��� �����ϴ� v_emp VIEW����

CREATE OR REPLACE VIEW v_emp AS
SELECT empno, ename, job, mgr, hiredate, deptno
FROM emp;

--�ý��� �������� nara �������� view�������� �߰�(�ý��� ���� �ϰ� �ý��۰������� ���� �ٲٱ�)
GRANT CREATE VIEW TO NARA;
--GRANT�ϰ� SYSTEM ��������

--���� �ζ��� ��� �ۼ���
SELECT *
FROM (SELECT empno, ename, job, mgr, hiredate, deptno
      FROM emp);

--VIEW��ü Ȱ��
SELECT *
FROM v_emp;

--emp���̺��� �μ����� ���� ==> dept���̺�� ������ ����ϰ� ����
--���ε� ����� view�� ���� �س����� �ڵ带 �����ϰ� �ۼ��ϴ� �� ����

--VIEW : v_emp_dept
--dname(�μ���), empno(������ȣ), ename(�����̸�), job(������), hiredate(�Ի�����)

CREATE OR REPLACE VIEW v_emp_dept AS
SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
FROM emp, dept
WHERE emp.deptno = dept.deptno;

--�ζ��κ�� �ۼ���
SELECT *
FROM (SELECT dept.dname, emp.empno, emp.ename, emp.job, emp.hiredate
     FROM emp, dept
     WHERE emp.deptno = dept.deptno);

--VIEW Ȱ���
SELECT *
FROM v_emp_dept;

--SMITH ���� ���� �� v_emp_dept view �Ǽ� ��ȭ Ȯ��
DELETE emp
WHERE ename = 'SMITH';

ROLLBACK;
--VIEW�� �������� �����͸� ���� �ʰ�, ������ �������� ���� ����(SQL)�̱� ������
--VIEW���� �����ϴ� ���̺��� �����Ͱ� ������ �Ǹ� VIEW�� ��ȸ ����� ������ �޴´�

--SEQUENCE :������ - �ߺ����� �ʴ� �������� �������ִ� ����Ŭ ��ü
--CREATE SEQUENCE ������_�̸�;
--[OPTION...]
--����Ģ : SEQ_���̺��

--emp���̺��� ����� ������ ����
CREATE SEQUENCE seq_emp;

--������ ���� �Լ�
--NEXTVAL : ���������� ���� ���� ������ �� ���
--CURRVAL : NEXTVAL�� ����ϰ��� ���� �о� ���� ���� ��Ȯ��

SELECT seq_emp.NEXTVAL
FROM DUAL;

SELECT seq_emp.CURRVAL
FROM DUAL;

SELECT *
FROM emp_test;

DESC emp_test;
INSERT INTO emp_test VALUES (seq_emp.NEXTVAL, 'JAMES',99, '017');

--������ ������
--ROLLBACK�� �ϴ��� NEXTVAL�� ���� ���� ���� �������� �ʴ´�
--NEXTVAL�� ���� ���� �޾ƿ��� �� ���� �ٽ� ����� �� ����

--INDEX

SELECT ROWID, emp.*
FROM emp;

SELECT *
FROM emp
WHERE ROWID = 'AAAE5dAAFAAAACLAAA';

--�ε����� ���� �� empno ������ ��ȸ �ϴ� ���
--emp���̺��� pk_emp���� ������ �����Ͽ� empno�÷����� �ε����� �������� �ʴ� ȯ���� ����

ALTER TABLE emp DROP CONSTRAINT pk_emp;

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp���̺��� empno�÷����� PK������ �����ϰ� ������ SQL�� ����
--PK : UNIQUE + NOT NULL
--     (UNIQUE �ε����� ����������)
--==>empno �÷����� unique�ε����� ������

--�ε����� sql�� �����ϰ� �Ǹ� �ε����� ���� ���� ��� �ٸ��� �������� Ȯ��

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

--SELECT ��ȸ �÷��� ���̺� ���ٿ� ��ġ�� ����
--SELECT * FROM emp WHERE empno = 7782
--==> SELECT empno FROM emp WHERE empno = 7782

EXPLAIN PLAN FOR
SELECT empno
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--UNIQUE VS NON-UNIQUE �ε����� ���� Ȯ��
--1. PK_EMP ����
--2. EMPNO�÷����� NON-UNIQUE �ε��� ����
--3. �����ȹ Ȯ��

ALTER TABLE emp DROP CONSTRAINT pk_emp;

CREATE INDEX idx_n_emp_01 ON emp (empno);

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno = 7782;

SELECT *
FROM TABLE(dbms_xplan.display);

--emp���̺� job�÷��� �������� �ϴ� ���ο� non-unique�ε����� ����
CREATE INDEX idx_n_emp_02 ON emp (job);

SELECT job, rowid
FROM emp
ORDER BY job;

--���ð����� ����
--1.EMP���̺��� ��ü �б�
--2.idx_n_01(empno) �ε��� Ȱ��
--3.idx_n_02(job) �ε��� Ȱ��

explain plan for
SELECT *
FROM emp
WHERE job = 'MANAGER';

SELECT *
FROM TABLE(dbms_xplan.display);
