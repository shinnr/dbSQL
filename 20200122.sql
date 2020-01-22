-- PROD ���̺��� ��� �÷��� �ڷ� ��ȸ
SELECT prod
FROM prod;

--PROD ���̺��� PROD_ID, PROD_NAME �÷��� �ڷḸ ��ȸ
SELECT prod_id, prod_name
FROM prod;

--lprod ���̺��� ��� ������ ��ȸ
SELECT *
FROM lprod;

--buyer ���̺��� buyer_id, buyer_name ��ȸ
SELECT buyer_id, buyer_name
FROM buyer;

--cart ���̺��� ��� ���̺� ��ȸ
SELECT *
FROM cart;

--member ���̺��� mem_id, mem_pass, mem_name �÷� ��ȸ
SELECT mem_id, mem_pass, mem_name
FROM member;

--users ���̺� ��ȸ
SELECT *
FROM users;

--���̺� � �÷��� �ִ��� Ȯ���ϴ� ���
--1. SELECT *
--2.TOOL�� ��� (�����-TABLES)
--3.DESC ���̺��(DESC-DESCRIBLE)

DESC users;

--��¥ ����(reg_dt �÷��� date������ ������ �ִ� Ÿ��)
--��¥Į�� +(���ϱ⿬��)
--�������� ��Ģ������ �ƴѰ͵�
--SQL���� ���ǵ� ��¥�� ����: ��¥+����= ��¥���� ������ ���ڷ� ����Ͽ� ���� ��¥�� �ȴ�(2019/01/28 +5=2019/02/02)
--reg_dt:������� Į��
--null:���� �𸣴� ����
--null�� ���� �������� �׻� null

--users ���̺��� userid, usernm, rog_dt �÷��� ��ȸ�ϴ� sql
SELECT userid u_id, usernm, reg_dt, reg_dt+5 AS reg_dt_after_5day
FROM users;

--�ǽ�2
SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS buyer_name, buyer_name
FROM buyer;

--���ڿ� ����
--�ڹپ��� ���ڿ� ���� : +
--SQL������ : || ('HELLO' || 'world')
--SQL������ : comcat ('HELLO', 'world')

--userid, usernm �÷��� ����, ��Ī id_name
SELECT userid || usernm AS id_name
FROM users;

SELECT CONCAT(userid, usernm) AS concat_id_name
FROM users;

--����, ���
--int a=5; String msg="HelloWorld";
--//������ �̿��� ���
--system.out.println(msg);
--//����� �̿��� ���
--Ssystem.out.println("Hello, World");

--SQL������ ������ ����
--(�ø��� ����� ����, pl/sql ���������� ����)
--SQL���� ���ڿ� ����� �̱� �����̼����� ǥ��
--"Hello, World"--> 'Hello, World'

--���ڿ� ����� �÷����� ����
--user id : brown
--uesr id : cony
SELECT 'userid id : '|| userid AS "user id"
FROM users;

SELECT *
FROM USER_TABLES;

SELECT 'SELECT * FROM '||table_name||';' AS query
FROM user_tables;

SELECT CONCAT('SELECT * FROM ', CONCAT(table_name, ';')) AS query 
FROM user_tables;

--int a=5; //�Ҵ�, ���� ������
--if(a==5) (a�� ���� 5���� ��)
--sql������ ������ ������ ����(PL/SQL)
--sql=-->equal

--users���̺��� ��� �࿡ ���ؼ� ��ȸ
--users���� 5���� �����Ͱ� ����
SELECT *
FROM users;

--WHERE��: ���̺��� �����͸� ��ȸ�� �� ���ǿ� �´� �ุ ��ȸ
--ex: userid�÷��� ���� brown�� �ุ ��ȸ
SELECT *
FROM users
WHERE userid=brown;

--emp ���̺��� ename�÷����� JONES�� �ุ ��ȸ
--*SQL KEY WORD�� ��ҹ��ڸ� ������ ������ �÷��� ���̳� ���ڿ�, 
SELECT *
FROM emp
WHERE ename = 'JONES';

--emp���̺��� deptno(�μ���ȣ)�� 30���� ũ�ų� ���� ����鸸 ��ȸ
SELECT *
FROM emp
WHERE deptno>=30;

--���ڿ� : '���ڿ�'
--����:50
--��¥:???-->�Լ��� ���ڿ��� �����Ͽ� ǥ��
--���ڿ��� �̿��Ͽ� ǥ������(�������)
--�ѱ�:�⵵ 4�ڸ�-��2�ڸ�-����2�ڸ�
--�̱�:��2�ڸ�-��2�ڸ�-�⵵4�ڸ�


SELECT *
FROM emp
WHERE hiredate='80/12/17';

--TO_DATE:���ڿ��� dateŸ������ �����ϴ� �Լ�
--TO_DATE(��¥���� ���ڿ�, ù��° ������ ����)
SELECT *
FROM emp
WHERE hiredate=TO_DATE('1980/12/17', 'YYYY/MM/DD');

--��������
--sal �÷��� ���� 1000���� 2000������ ���]
--sal >=1000
--sal<=2000
SELECT *
FROM emp
WHERE sal>=1000 
AND SAL <=2000;

--���������ڸ� �ε�ȣ ��ſ� BETWEEN AND�����ڷ� ��ü
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD') AND TO_DATE('1983/01/01','YYYY/MM/DD');

 