--TRUNCATE �׽�Ʈ
--1.REDO�α׸� �������� �ʱ� ������ ������ ������ ������ �Ұ��ϴ�
--2.DML(SELECT, INTSERT, UPDATE, DELETE)�� �ƴ϶� DDL�� �з�(ROLLBACK�� �Ұ�)

--�׽�Ʈ �ó�����
--emp���̺� ���縦 �Ͽ� EMP_COPY��� �̸����� ���̺� ����
--EMP_COPY���̺��� ������� TRUCATE TABLE EMP_COPY����
--EMP_COPY���̺��� �����Ͱ� �����ϴ��� (���������� ������ �Ǿ�����) Ȯ��

--EMP_COPY���̺� ����
--CREATE ==> DDL(ROLLBACK�� �ȵȴ�)

CREATE TABLE EMP_COPY AS
SELECT *
FROM emp;

SELECT *
FROM emp_copy;

TRUNCATE TABLE emp_copy;
--TRUNCATE TABLE ���ɾ�� DDL�̱⶧���� ROLLBACK�� �Ұ��ϴ�
--ROLLBACK�� SELECT�� �غ��� �����Ͱ� �������� ���� ���� �� �� �ִ�.
ROLLBACK;

--����ȭ ����

--DDL : Data Definition Language -������ ������
--��ü�� ����, ����, ������ ���
--ROLLBACK�Ұ�
--�ڵ� QUERRY

--���̺� ����
--CREATE TABLE [��Ű����.]���̺���(
--   �÷��� �÷�Ÿ�� [DEFAULT �⺻��],
--   �÷��� �÷�2Ÿ�� [DEFAULT �⺻��],,...
--);

--ranger��� �̸��� ���̺� ����
CREATE TABLE ranger(
    ranger_no NUMBER,
    ranger_nm VARCHAR2(50),
    reg_dt DATE DEFAULT SYSDATE
);

SELECT *
FROM ranger;

INSERT INTO ranger (ranger_no, ranger_nm) VALUES (1, 'brown');
COMMIT;

--���̺� ����
--DROP TABLE ���̺���
DROP TABLE ranger;

--DDL�� �ѹ� �Ұ�
ROLLBACK;
--���̺��� �ѹ� ���� ���� ���� Ȯ���� �� �ִ�.
SELECT *
FROM ranger;

--������Ÿ�� 
--���ڿ� (varchar2 ���, charŸ�� ��� ����)
--varchar2(10) : �������� ���ڿ�, ������ 1~4000byte
--�ԷµǴ� ���� �÷� ������� �۾Ƶ� ���� ������ �������� ä���� �ʴ´�.
--cahr(10) �������� ���ڿ� 
--�ش� �÷��� ���ڿ��� 5byte�� �����ϸ� ������ 5byte�������� ä������.
--'test' ==> 'test     '
--'test' != 'test     '

--����
--NUMBER(p, s) : p -��ü�ڸ��� (38), s-�Ҽ��� �ڸ���
--INTEGER ==> NUMBER(38,0)
--ranger_no NUMBER ==> NUMBER(38,0)

--��¥
--DATE - ���ڿ� �ð� ������ ����
--7byte
--��¥ - DATE
--      VARCHAR(8) '20200207'
--�� �ΰ��� Ÿ���� �ϳ��� �����ʹ� 1BYTE�� ����� ���̰� ����
--������ ���� �������� �Ǹ� ������ �� ���� �������, ����� Ÿ�Կ� ���� ������ �ʿ�

--LOB(Large Object)-�ִ� 4byte
--CLOB - Character Large Object
--       VARCHAR2�� ���� �� ���� �������� ���ڿ�(4000byte �ʰ� ���ڿ�)
--       ex : �������Ϳ� ������ html�ڵ�
--BLOB - Byte Large Object
--       ������ �����ͺ��̽��� ���̺����� ������ ��
--       �Ϲ������� �Խñ� ÷�������� ���̺��� ���� �������� �ʰ� ���� ÷�������� ��ũ�� Ư�� ������ �����ϰ�, �ش� [���]�� ���ڿ��� ����
--       ������ �ſ� �߿��� ��� : ����������� ���Ǽ� -> [����]�� ���̺��� ����

--���� ���� : �����Ͱ� ���Ἲ�� ��Ű���� ���� ����
--1. UNIQUE ��������
--�ش� �÷��� ���� �ٸ� ���� �����Ϳ� �ߺ����� �ʵ��� ����
--EX : ����� ���� ����� ���� ���� ����

--2. NOT NULL��������(CHECK��������)
--�ش� �÷��� ���� �ݵ�� ��������ϴ� ����
--EX  : ��� �÷��� NULL�� ����� ������ ���� ����
--      ȸ�� ���Խ� �ʼ� �Է»��� ( GITHUB -�̸���, �̸�)

--3.PRIMATY KEY���� ����
--UNIQUE + NOT NULL
--EX : ����� ���� ����� ���� ���� ���� , ����� ���� ����� ���� ���� ����
--PRIMARY KEY���� ������ ������ ��� �ش� �÷����� UNIQUE INDEX�� �����ȴ�

--4. FOREIGN KEY ��������(�������Ἲ)

--�ش��÷��� �����ϴ� �ٸ� ���̺��� ���� �����ϴ� ���� �־���Ѵ�.
--emp���̺��� deptno�ø��� dept���̺��� deptno�÷��� ����(����)
--emp���̺��� deptno �÷����� dept ���̺��� �������� �ʴ� �μ���ȣ�� �Էµ� �� �ִ�
--EX : ���� dept ���̺��� �μ���ȣ�� 10, 20, 30, 40���� ������ ���
--emp���̺��� ���ο� ���� �߰� �ϸ鼭 �μ���ȣ ���� 99������ ����� ���
--�� �߰��� ����

--5.CHECK��������(���� ġũ)
--NOT NULL���� ���ǵ� CHECK���࿡ ����
--emp���̺��� JOB�÷��� ���� �� �մ� ���� = 'SALESMAN', 'PRESIDENT', 'CLERK'

--�������� �������
--1.���̺��� �����ϸ鼭 �÷��� ���
--2.���̺��� �����ϸ鼭 �÷� ��� ���Ŀ� ������ ���������� ���
--3.���̺� ������ ������ �߰������� ���������� �߰�

--CREATE TABLE ���̺���(
--  �÷�1, �÷� Ÿ��[1.��������],
--  �÷�2, �÷� Ÿ��[1.��������],
--  [2.TABLE_CONSTRAINT]
--   );

--3.ALTER TABLE emp....;

--PRIMARY KEY������ �÷� ������ ����(1�� ���)
--dept���̺��� �����Ͽ� dept_test���̺��� PRIMARY KEY�������ǰ� �Բ� ����
--�� �̹���� ���̺��� key �÷��� �����÷��� �Ұ�, ���� �÷��� ���� ����

CREATE TABLE dept_test(
    deptno NUMBER(2) PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test(deptno) VALUES (99); --���������� ����
INSERT INTO dept_test(deptno) VALUES (99);--�ٷ� ���� ������ ���� ���� ���� �����Ͱ� �̹� �����

--�������� : �츮�� ���ݱ��� ������ ����� dept���̺��� deptno�÷�����
--UNIQUE�����̳� PRIMARY KEY���� ������ ������ ������
--�Ʒ� �ΰ��� INSERT������ ���������� ����ȴ�
INSERT INTO dept(deptno) VALUES (99); 
INSERT INTO dept(deptno) VALUES (99); 
ROLLBACK;

--�������� Ȯ�� ���
--1. TOOL�� ���� Ȯ��
--Ȯ���ϰ��� �ϴ� ���̺��� ����
--2.dictionary�� ���� Ȯ��(USER_TABLES,USER_CONSTRAINTS)
SELECT *
FROM USER_CONSTRAINTS
WHERE table_name = 'DEPT_TEST';

SELECT *
FROM USER_CONS_COLUMNS
WHERE CONSTRAINT_NAME = 'SYS_C007085';


--3.�𵨸�(ex:exerd)���� Ȯ��
--�������� ���� ������� ���� ��� ����Ŭ���� �������� �̸��� ���Ƿ� �ο� (ex :SYS_C007805)
--�������� �������� ������
--������Ģ �����ϰ� �����ϴ°� ����, � ������ ����
--PRIMARY KEY �������� : PK_���̺���
--FOREIGN KEY �������� : FK_������̺���_�������̺���

DROP TABLE dept_test;

--�÷� ������ ���������� �����ϸ鼭 �������� �̸��� �ο�
--CONSTRAINT �������Ǹ� ��������Ÿ�� (PRIMARY KEY)

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14),
    loc VARCHAR2(13)
);
INSERT INTO dept_test (deptno) VALUES(99);
INSERT INTO dept_test (deptno) VALUES(99);

--2.���̺� ������ �÷� ��� ���� ������ �������� ���
DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY (deptno)
);

--NOT NULL�������� �����ϱ�
--1.�÷��� ����ϱ� (O)
--�� �÷��� ����ϸ鼭 �������� �̸��� �ο��ϴ°� �Ұ�
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14) NOT NULL,
    loc VARCHAR2(13),
    
    CONSTRAINT PK_dept_test PRIMARY KEY (deptno)
);

--NOT NULL�������� Ȯ��
INSERT INTO dept_test(deptno, dname) VALUES (99, NULL);

--2.���̺� ������ �÷� ��� ���Ŀ� ���� ���� �߰�
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    
    CONSTRAINT NM_dept_test_danme CHECK (deptno IS NOT NULL)
);

--UNIQUE ���� : �ش� �÷��� �ߺ��Ǵ� ���� ������ ���� ����, �� NULL�� �Է��� �����ϴ�
--PRIMARY KEY = UNIQUE + NOT NULL

--1.���̺� ������ �÷� ���� UNIQUE ��������
--dname �÷��� UNIQUE��������
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) UNIQUE,
    loc VARCHAR2(13)
);

--dept_test ���̺���dname�÷��� ������ unique���������� Ȯ��
INSERT INTO dept_test VALUES (98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');


--2.���̺� ������ �÷��� �������� ���, �������� �̸� �ο�
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2) CONSTRAINT PK_dept_test PRIMARY KEY,
    dname VARCHAR2(14) CONSTRAINT UK_dept_test_danme UNIQUE,
    loc VARCHAR2(13)
);

--dept_test ���̺���dname�÷��� ������ unique���������� Ȯ��
INSERT INTO dept_test VALUES (98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

--2. ���̺� ������ �÷� ��� ���� �������� ���� -�����÷�(deptno-dname)(unique)
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR(14),
    loc VARCHAR(13),
    
    CONSTRAINT UK_dept_test_deptno_dname UNIQUE (deptno, dname)
);

--�����÷��� ���� UNIQUE����Ȯ�� (deptno, dname)
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (98, 'ddit', '����');

--FOREIGN KEY���� ����
--�����ϴ� ���̺��� �÷��� �����ϴ� ���� ��� ���̺��� �÷��� �Է��� �� �յ��� ����
--EX : emp���̺��� deptno�÷��� ���� �Է��� ��,dept���̺��� deptno�÷��� �����ϴ� �μ���ȣ�� �Է��� �� �յ��� ����
--�������� �ʴ� �μ���ȣ�� emp ���̺����� ������� ���ϰԲ� ����

--1.dept_test ���̺� ����
--2.emp_test���̺� ����
--emp_test���̺� ������ deptno�÷����� dpet.deptno�÷��� �����ϵ��� FK����

DROP TABLE dept_test;
CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);

DROP TABLE emp_test;
CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR(10),
    deptno NUMBER(2) REFERENCES dept_test (deptno),
    
    CONSTRAINT PK_EMP_TEST PRIMARY KEY(empno)
);

--������ �Է¼���
--emp_test ���̺��� �����͸� �Է��ϴ� ���� �����Ѱ�???
--���ݻ�Ȳ (dept_test, emp_test���̺��� ��� ����-�����Ͱ� �������� ������)
INSERT INTO emp_test VALUES (9999, 'brown', NULL); --fk�� ������ �÷��� null�� ���
INSERT INTO emp_test VALUES (9999, 'sally', NULL); --10���μ��� dept_test���̺��� �������� �ʾƼ� ����

--dept_test���̺��� �����͸� �غ�
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');
INSERT INTO dept_test VALUES (99, 'sally', 10); --10���μ��� dept_test�� �������� �����Ƿ� ����
INSERT INTO emp_test VALUES (9998, 'sally', 99);--99���μ��� dept_test�� �����ϹǷ� �������

--���̺� ������ �÷� ��� ����, FOREIGN KEY ���� ���� ����

DROP TABLE emp_test;
DROP TABLE dept_test;

CREATE TABLE dept_test(
    deptno NUMBER(2),
    dname VARCHAR2(14),
    loc VARCHAR2(13),
    CONSTRAINT PK_dept_test PRIMARY KEY(deptno)
);
INSERT INTO dept_test VALUES (99, 'ddit', 'daejeon');

CREATE TABLE emp_test(
    empno NUMBER(4),
    ename VARCHAR2(10),
    deptno NUMBER(2),
    CONSTRAINT FK_emp_test_dept_test FOREIGN KEY (deptno) REFERENCES dept_test (deptno)
);

INSERT INTO emp_test VALUES (9999, 'brown', 10);--dept_test���̺��� 10���μ��� dept_test�� �������� �����Ƿ� ����
INSERT INTO emp_test VALUES (9999, 'brown', 99);--dept_test���̺��� 99���μ��� dept_test�� �����ϹǷ� �������










