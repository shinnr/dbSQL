--pro_2

CREATE OR REPLACE PROCEDURE registdept_test ( p_deptno IN dept.deptno%TYPE, p_dname IN dept.dname%TYPE, p_loc IN dept.loc%TYPE) IS
    
BEGIN
    INSERT INTO dept_test (deptno, dname, loc, empcnt) VALUES (p_deptno, p_dname, p_loc, 0);

END;
/
SET SERVEROUTPUT ON;
exec registdept_test (99, 'ddit', 'daejeon');

rollback;

SELECT *
FROM dept_test;

SELECT *
FROM dept;
/


--pro_3
CREATE OR REPLACE PROCEDURE UPDATEdept_test(
                        p_deptno IN dept.deptno%TYPE, 
                        p_dname IN dept.dname%TYPE, 
                        p_loc IN dept.loc%TYPE) IS

BEGIN
UPDATE dept_test 
SET dname = p_dname, loc=p_loc
WHERE deptno = p_deptno ;

END;
/
exec UPDATEdept_test (99, 'ddit_m', 'daejeon');

SELECT *
FROM dept_test;


--���պ��� %rowtype : Ư�� ���̺��� ���� ��� �÷��� ������ �� �մ� ����
--��뺯�� : ������ ���̺�� %ROWTYPE

SET SERVEROUTPUT ON;
DECLARE
    v_dept_row dept%ROWTYPE;
BEGIN
    SELECT * INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE(v_dept_row.deptno || ' ' || v_dept_row.dname || ' ' || v_dept_row.loc);
END;
/

--���պ��� RECORD
--�����ڰ� ���� �������� �÷��� ������ �� �ִ� Ÿ���� �����ϴ� ���
--JAVA�� �����ϸ� Ŭ������ �����ϴ� ����
--�ν��Ͻ��� ����� ������ ��������

--����
--TYPE Ÿ���̸�(�����ڰ� ����) IS RECORD (
--      ������1, ����Ÿ��,
--      ������2, ����Ÿ��
--);

--������ Ÿ���̸�

DECLARE
    TYPE dept_row IS RECORD(
        deptno NUMBER(2),
        dname VARCHAR2(14)
    );
    
    v_dept_row dept_row;
    
BEGIN
    SELECT deptno, dname INTO v_dept_row
    FROM dept
    WHERE deptno = 10;
    
    DBMS_OUTPUT.PUT_LINE( v_dept_row.deptno || ' ' || v_dept_row.dname);
    
END;
/

--table type  ���̺� Ÿ��
--�� : ��Į�󺯼�
--�� : %ROWTYPE, record type
--�� : table type
--     � ��(%ROWTYPE, RECORD TYPE)�� ������ �� �ִ���
--     �ε��� Ÿ���� ��������

--dept ���̺��� ������ ���� �� �ִ� table type�� ����
--������ ��� ��Į��Ÿ��, rowtype������ �� ���� ������ ���� �� �վ�����
--tableŸ�� ������ �̿��ϸ� ���� ���� ������ ���� �� �ִ�

--PL/SQL������ �ڹٿ� �ٸ��� �迭�� ���� �ε����� ������ �����Ǿ� ���� �ʰ� ���ڿ��� �����ϴ�
--�׷��� TABLE������ ������ ���� �ε����� ���� Ÿ�Ե� ���� ���
--BAINARY_INSDEXŸ���� PL/SQL������ ��� ������ Ÿ������
--NUMBERŸ���� �̿��Ͽ� ������ ��밡���ϰԲ��� NUMBERŸ���� ����Ÿ���̴�

DECLARE
    TYPE dept_tab IS TABLE OF dept%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dept_tab dept_tab;
BEGIN 
    SELECT * BULK COLLECT INTO v_dept_tab
    FROM dept;
    --���� ��Į�󺯼�, recordŸ���� �ǽ��ÿ��� ���ุ ��ȸ�ǵ��� WHERE���� ���� �����Ͽ���
    
    --�ڹٿ����� �迭[�ε�����ȣ]
    --pl/sql : table���� (�ε�����ȣ)�� ����
    FOR i IN 1..v_dept_tab.count LOOP
    DBMS_OUTPUT.PUT_LINE(v_dept_tab(i).deptno || ' ' || v_dept_tab(i).dname);
    END LOOP;
END;
/

--�������� IF
--����

--IF ���ǹ� THEN
--   ���๮
--ELSIF ���ǹ� THEN
--      ���๮
--ELSE
--     ���๮
--END IF

DECLARE
    p NUMBER(1) := 2; --��������� ���ÿ� ���� ����
BEGIN 
    IF p = 1 THEN
      DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
    ELSIF p = 2 THEN
      DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
    ELSE
      DBMS_OUTPUT.PUT_LINE('�˷����� �ʾҽ��ϴ�');
    END IF;
END;
/

--CASE���� 
--1.�Ϲ� ���̽� (JAVA�� SWITCH�� ����)
--2.�˻� ���̽� (if, else if, else)

--CASE expression
--    WHEN value THEN
--        ���๮
--    WHEN value THEN
--        ���๮
--    ELSE
--        ���๮
--END CASE

DECLARE
    p NUMBER(1) :=2;
BEGIN
    CASE p
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�𸣴� ���Դϴ�');
    END CASE;
END;
/

DECLARE
    p NUMBER(1) :=2;
BEGIN
    CASE 
        WHEN p = 1 THEN
            DBMS_OUTPUT.PUT_LINE('1�Դϴ�');
        WHEN p = 2 THEN
            DBMS_OUTPUT.PUT_LINE('2�Դϴ�');
        ELSE
            DBMS_OUTPUT.PUT_LINE('�𸣴� ���Դϴ�');
    END CASE;
END;
/

--FOR LOOP ����
--FOR ��������/�ε������� IN [REVERSE] ���۰�..���ᰪ LOOP
--    �ݺ��� ����
--END LOOP

--1���� 5���� FOR LOOP �ݺ����� �̿��Ͽ�\�� ���� ���

DECLARE
BEGIN
    FOR i IN 1..5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;
/

--�ǽ� 2~9�� ������ �������� ���
DECLARE

BEGIN
    FOR i IN 2..9 LOOP
        FOR j IN 1..9 loop
        DBMS_OUTPUT.PUT_LINE(i||'*' || j|| '=' ||i*j);
        END LOOP;
    END LOOP;

END;
/

--WHILE LOOP ����
--WHILE ���� LOOP
--      �ݺ������� ����
--END LOOP

DECLARE
    i NUMBER := 0;
BEGIN 
    WHILE i <= 5 LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        i := i+1;
    END LOOP;
END;
/

--LOOP�� ���� == while(true)
--LOOP
--  �ݺ������� ����
--  EXIT ����
--END LOOP

DECLARE
    i NUMBER := 0;
BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE(i);
        EXIT WHEN i > 5;
        i := i + 1;
    END LOOP;
END;
/


























