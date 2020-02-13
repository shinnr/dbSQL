--syninum : ���Ǿ�
--1.��ü ��Ī�� �ο�
--  ==> �̸��� �����ϰ� ǥ��
--nara����ڰ� �ڽ��� ���̺� emp���̺��� ����ؼ� ���� v_emp view
--hr ����ڰ� ����� �� �ְԲ� ������ �ο�

--v_emp : �ΰ��� ���� sal, comm�� ������ view

--hr����� v_emp�� ����ϱ� ���� ������ ���� �ۼ�
--SELECT *
--FROM nara.v_emp;

--hr��������
--SYNONYM nara.v_emp ==> v_emp
--v_emp == nara.v_emp

SELECT *
FROM v_emp;

--1.nara�������� v_emp�� hr�������� ��ȸ�� �� �ֵ��� ��ȸ���� �ο�
GRANT SELECT ON v_emp TO hr;

--2.hr���� v_emp ��ȸ�ϴ� �� ����(���� 1������ �޾ұ⶧����)
--���� �ش� ��ü�� �����ڸ� ��� : nara.v_emp
--�����ϰ� nara.v_emp ==> v_emp ����ϰ� ���� ��Ȳ
--synonym ����

--CCREATE SYNONYM �ó���̸� FOR �� ��ü��(HR�������� ����)

--SYNONYM ����
--DROP SYSNONYM �ó���̸�


--GRANT CONNECT TO NARA;
--GRANT SELECT ON ��ü�� TO HR;

--��������
--1.�ý��� ���� : TABLE����, VIEW���� ����...
--2.��ü ���� : Ư�� ��ü�� ���� SELECT, UPDATE, INSERT, DELETE...

--ROLE : ������ ��Ƴ��� ����
--����ں��� ���� ������ �����ϰ� �Ǹ� ������ �δ�
--Ư�� ROLE�� ������ �ο��ϰ� �ش� ROLE ����ڿ��� �ο�
--�ش� ROLE�� �����ϰ� �Ǹ� ROLE�� ���� �մ� ��� ����ڿ��� ����

--���Ѻο�/ȸ��
--�ý��� ���� : GRANT �����̸� TO ����� | ROLE;
--            REVOKE �����̸� FROM ����� | ROLE;
--��ü���� : GRANT �����̸� ON ��ü�� TO ����� | ROLE;
--          REVOKE �����̸� ON ��ü�� FROM ����� | ROLE;

--data dictionary : ����ڰ� �������� �ʰ� DBMS�� ��ü������ �����ϴ� �ý��� ������ ���� VIEW
--DATA DICTIONARY ���ξ�
--1. USER : �ش� ����ڰ� ������ ��ü
--2. ALL : �ش� ����ڰ� ������ ��ü + �ٸ� ����ڷκ��� ������ �ο����� ��ü
--3. DBA : ��� ������� ��ü

--*VS Ư�� VIEW
SELECT *
FROM USER_TABLES;

SELECT *
FROM ALL_TABLES;

--�Ϲݻ���� �����̶� �� �� ����
SELECT *
FROM DBA_TABLES;

--DICTIONAR ���� Ȯ�� : SYS.DICTIONARY

SELECT *
FROM DICTIONARY;
--��ǥ���� DICTIONARY
--OBJECTS : ��ü������ȸ(���̺�, �ε��� , VIEW, SYNONYM...)
--TABLES : ���̺� ������ ��ȸ
--TAB_COLUMNS : ���̺��� �÷����� ��ȸ
--INDEXS : �ε��� ���� ��ȸ
--IND_COLUMNS : �ε��� ���� �÷� ��ȸ
--CONSTRAINTS : �������� ��ȸ
--CONS_COLUMNS : �������� ���� �÷� ��ȸ
--TAB_COMMENTS : ���̺� �ּ�
--COL_COMMENTS : ���̺��� �÷� �ּ�

SELECT *
FROM USER_OBJECTS;

--emp, dept ���̺��� �ε����� �ε��� �÷� ���� ��ȸ
--USER_INDEXES, USER_IND_COLUMNS JOIN
--���̺��, �ε�����, �÷��� �÷�����
--emp   ind_n_emp_04 ename
--emp   ind_n_emp_04 job

SELECT *
FROM USER_INDEXES;

SELECT *
FROM USER_IND_COLUMNS;

SELECT a.TABLE_NAME, a.INDEX_NAME, b.COLUMN_NAME, b.column_position
FROM USER_INDEXES a, USER_IND_COLUMNS b
WHERE a.INDEX_NAME = b.INDEX_NAME;

SELECT table_name, index_name, column_name, column_position
FROM USER_IND_COLUMNS;




--multiple insert : �ϳ��� insert �������� ���� ���̺� �����͸� �Է��ϴ� DML

SELECT *
FROM dept_test;

SELECT *
FROM dept_test2;

--������ ���� ���� ���̺� ���� �Է��ϴ� multiple insert
INSERT ALL 
       INTO dept_test
       INTO dept_test2
SELECT 98, '���', '�߾ӷ�' FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

--���̺� �Է��� �÷��� �����Ͽ� multiple insert
ROLLBACK;
INSERT ALL 
       INTO dept_test (deptno, loc) VALUES ( deptno, loc)
       INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

--���̺� �Է��� �����͸� ���ǿ� ���� multiple insert;
--CASE
--    WHEN ���� ��� THEN
--END

ROLLBACK;
INSERT ALL 
       WHEN deptno = 98 THEN 
            INTO dept_test (deptno, loc) VALUES ( deptno, loc)
       ELSE
            INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test;

--������ �����ϴ� ù��° insert�� �����ϴ� multiple insert

ROLLBACK;
INSERT FIRST
       WHEN deptno >= 98 THEN 
            INTO dept_test (deptno, loc) VALUES ( deptno, loc)
       WHEN deptno >= 98 THEN 
            INTO dept_test2
       ELSE
            INTO dept_test2
SELECT 98 deptno, '���' dname, '�߾ӷ�' loc FROM dual UNION ALL
SELECT 97, 'IT', '����' FROM dual;

SELECT *
FROM dept_test;

SELECT *
FROM dept_test;

--����Ŭ ��ü : ���̺� �������� ������ ��Ƽ������ ����
--���̺� �̸� �����ϳ� ���� ������ ���� ����Ŭ ���������� ������ �и��� ������ �����͸� ����

--dept_test ==> dept_test_20200202

--MERGE : ����
--���̺� �����͸� �Է�/�����Ϸ��� ��
--1.���� �Է��Ϸ��� �ϴ� �����Ͱ� �����ϸ� 
-- ===> ������Ʈ
--2.1.���� �Է��Ϸ��� �ϴ� �����Ͱ� �������� ������
--==>INSERT

--1.SELEC ����
--2-2.SELECT �������� 0 ROW�̸� INSERT
--2-2.SELECT �������� 1 ROW�̸� UPDATE

--MERGE ������ ����ϰ� �Ǹ� SELECT�� ���� �ʾƵ� �ڵ����� ������ ������ ���� INSERT Ȥ�� UPDATE �����Ѵ�
--2���� ������ �ѹ����� �ش�

--MERGE INTO ���̺�� (alias)
--USING (TABLE | VIEW | IN-LINE-VIEW)
--ON (��������)
--WHEN MATCHED THEN
--     UPDATE SET coll = �÷���, col2 = �÷���...
--WHEN NOT MATCHED TEHN
--     INSERT (�÷�1, �÷�2...) VALUES (�÷���1, �÷���2...)

SELECT *
FROM emp_test;

DELETE emp_test;

--�α׸� �ȳ����==������ �ȵȴ� ==>�׽�Ʈ������...
TRUNCATE TABLE emp_test;

--emp���̺��� emp_test���̺�� �����͸� ����(7369-SMITH)
INSERT INTO emp_test
SELECT empno, ename, deptno, '010'
FROM emp
WHERE empno = 7369;

--�����Ͱ� �� �ԷµǾ����� Ȯ��
SELECT *
FROM emp_test;

UPDATE emp_test SET ename = 'brown'
WHERE empno = 7369;

COMMIT;

--emp���̺��� ��� ������ emp_test���̺�� ����
--emp���̺��� ���������� emp_test���� �������� ������ insert
----emp���̺��� �����ϰ� emp_test���� �����ϸ� ename, deptno�� update

--emp���̺� �����ϴ� 14���� �������� emp_test���� �����ϴ� 7369�� ������ 13���� �����Ͱ�
--emp_tets ���̺� �űԷ� �Է��� �ǰ�
--emp_test�� �����ϴ� 7369���� �����ʹ� ename(brown)�� emp���̺� �����ϴ� �̸��� SMITH�� ����
MERGE INTO emp_test a 
USING emp b
ON (a.empno = b.empno)
WHEN MATCHED THEN
      UPDATE SET a.ename = b.ename, 
                 a.deptno = b.deptno
WHEN NOT MATCHED THEN
    INSERT (empno, ename, deptno) VALUES (b.empno, b.ename, b.deptno);
    
SELECT *
FROM emp_test;

--�ش����̺� �����Ͱ� ������ insert ������ update
--emp_test���̺� ����� 9999���� ����� ������ ���Ӱ� insert
--������ update
--(9999, 'brown', 10, '010')

--INSERT INTO dept_test VALUES(9999, 'brown', 10, '010')
--UPDATE dept_test SET ename = 'brown'
--                     deptno =10
--                     hp='010                    
--WHERE empno = 9999;

MERGE INTO emp_test
USING dual
ON (empno = 9999)
WHEN MATCHED THEN
     UPDATE SET ename = 'brown' || '_u',
                deptno = 10,
                hp = '010'
WHEN NOT MATCHED THEN
     INSERT VALUES (9999,'brwon', 10, '010');
     
SELECT *
FROM emp_test;

--merge, window function(�м��Լ�)

--group_ad1
SELECT deptno, SUM(sal)
FROM emp
GROUP BY deptno

UNION ALL

SELECT null, SUM(sal)
FROM emp;

--I/O
--CPU CACHE > RAM > SSD > HDD > NETWORK

--REPORT GROUP FUNCTION 
--ROLLUP
--CUBE
--GRIUPING

--ROLLUP
--��� ��� : GROUP BY ROLLUP (�÷�1, �÷�2...)
--SUBGROUP�� �ڵ������� ����
--SUBGROUP�� �����ϴ� ��Ģ : ROLLUP�� ����� �÷��� �����ʿ������� �ϳ��� �����ϸ鼭 SUB GROUP�� ����
--EX : GROUP BY ROLLUP (deptno)
--==>
--ù��° sub group : GROUP BY deptno
--�ι�° sub group : GROUP BY NULL => ��ü ���� ���

--group_ad1�� GROUP BY ROLLUP ���� ����Ͽ� �ۼ�
SELECT deptno, SUM(sal)
FROM emp
GROUP BY ROLLUP (deptno);

SELECT job, deptno, SUM(sal + NVL(comm, 0))sal
FROM emp
GROUP BY ROLLUP (job, deptno);

--GROUP BY job, deptno; : ������, �μ��� �޿���
--GROUP BY job; : �������� �޿���
--GROUP BY : ��ü�޿���
SELECT job, deptno, 
       GROUPING(job), GROUPING(deptno),
       SUM(sal + NVL(comm, 0))sal
FROM emp
GROUP BY ROLLUP (job, deptno);


--group_ad2
SELECT CASE WHEN GROUPING(job) = 1 AND GROUPING(deptno) = 1 THEN '�Ѱ�'
            ELSE job
            END AS job,
            deptno, SUM(sal + NVL(comm, 0))sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job), 1, '�Ѱ�', job),
       DECODE(GROUPING(deptno), 1, '�Ѱ�', deptno)
            deptno, SUM(sal + NVL(comm, 0))sal
FROM emp
GROUP BY ROLLUP (job, deptno);

SELECT DECODE(GROUPING(job) , 1 , DECODE(GROUPING(deptno), 1, '�Ѱ�' , job), job), deptno,
        GROUPING(job) , GROUPING(deptno),
        SUM(sal + NVL(comm,0)) sal
FROM emp
GROUP BY ROLLUP (job, deptno);


