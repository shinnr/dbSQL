--������ SQL �����̶� :  �ؽ�Ʈ�� �Ϻ��ϰ� ������ SQL
--1. ��ҹ��� ����
--2. ���鵵 �����ؾ���
--3. ��ȸ ����� ���ٰ� ������ SQL�� �ƴ�
--4. �ּ��� ������ ��ħ
--�׷��� ������ ���� SQL������ ������ ������ �ƴ�

SELECT * FROM dept;
select * FROM dept;
select   *FROM dept;
select *
FROM dept;

--SQL ����� V$SQL �信 �����Ͱ� ��ȸ�Ǵ��� Ȯ��

SELECT /* sql_test*/ * 
from dept
WHERE deptno = 10;

SELECT /* sql_test*/ * 
from dept
WHERE deptno = 20;

--���� �ΰ��� sql�� �˻��ϰ���  �ϴ� �μ���ȣ�� �ٸ��� ������ �ؽ�Ʈ�� �����ϴ�
--������ �μ���ȣ�� �ٸ��� ������ DBMS���忡���� ���� �ٸ� SQL�� �νĵȴ�
--==>�ٸ� SQL���� ��ȹ�� �����
--==> �����ȹ�� �������� ���Ѵ�
--==>�ذ�å : ���ε� ����
--SQL���� ����Ǵ� �κ��� ������ ������ �ϰ� �����ȹ�� ������ ���Ŀ� ���ε� �ھ��� ����
--���� ����ڰ� ���ϴ� ���� ������ ġȯ �� ����
-- ==>�����ȹ�� ���� ==> �޸� �ڿ� ���� ����

SELECT /* sql_test*/ *
FROM dept
WHERE deptno = :deptno;

--SQL Ŀ�� : SQL���� �����ϱ� ���� �޸� ����
--������ ����� SQL���� ������ Ŀ���� ���
--������ �����ϱ� ���� Ŀ�� : ������ Ŀ��

--SELECT ��� �������� TABLE Ÿ���� ������ ������ �� ������
--�޸𸮴� �������̱� ������ �������� �����͸� ��⿡�� ������ ����

--SQLĿ���� ���� �����ڰ� ���� �����͸� FETCH �����ν� SELECT �����
--���� �ҷ����� �ʰ��� ������ ����

--Ŀ�� ���� ��� : 
--�����(DECLARE)���� ����
--  CURSOR Ŀ���̸� IS
--      ������ ����;

--�����(BEGIN)���� Ŀ�� ����
--   OPEN Ŀ���̸�;

--����� (BEGIN)���� Ŀ���� ���� ������ FETCH
--  FETCH Ŀ���̸� IMTO�Լ�;

--�����(BEGIN)���� Ŀ�� �ݱ�
--  CLOSE Ŀ���̸�;

--�μ� ���̺��� Ȱ���Ͽ� ��� �࿡ ���� �μ���ȣ�� �μ��̸���  CURSOR�� ����
--FETCH, FETCH�� ����� Ȯ��

SET SERVEROUTPUT ON;

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    OPEN dept_cursor;
    
    LOOP
        
        FETCH dept_cursor INTO v_deptno, v_dname;
        EXIT WHEN dept_cursor%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(v_deptno || ' : ' || v_dname);
        
    END LOOP;    
END;
/

--CURSOR�� ���� �ݴ� ������ �ټ� �����彺����
--CURSOR��  �Ϲ������� LOOP�� �Բ� ����ϴ� ��찡 ����
--==>������ Ŀ���� FOR LOOP���� ����� �� �ְԲ� �������� ����

--List<String> userNameList = new ArrauList<String>();
--userNameList.add("brown");
--userNameList.add("cony");
--userNameList.add("sally");

--�Ϲ� for
--for(int i = 0; i < userNameList.size(); i++){
--  userNameList.get(i);
--}

--���� for
--for(String userName : userNameList){
--  userName���� ���....
--}

--java�� ���� for���� ����
--FOR record_name(������ ������ ���� �����̸� / ���� �������) IN Ŀ���̸� LOOP
--    record_name.�÷���
--END LOOP

DECLARE
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;

    CURSOR dept_cursor IS
        SELECT deptno, dname
        FROM dept;
BEGIN
    FOR rec IN dept_cursor LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ' : ' || rec.dname);
    END LOOP;
END;
/

--���ڰ� �ִ� ������ Ŀ��
--���� Ŀ�� ������
--  CURSOR Ŀ���̸� IS
--      ��������...;

--���ڰ� �մ� Ŀ�� ������
--  CURSOR Ŀ���̸�(����1, ����1Ÿ��....)IS
--      ��������
--      (Ŀ�� ����ÿ� �ۼ��� ���ڸ� ������������ ����� �� �ִ�)

DECLARE 
    v_deptno dept.deptno%TYPE;
    v_dname dept.dname%TYPE;
    
    CURSOR dept_cursor(p_deptno dept.deptno%TYPE) IS
        SELECT deptno, dname
        FROM dept
        WHERE deptno <= p_deptno;
BEGIN
    FOR rec IN dept_cursor(20) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ':' || rec.dname);
    END LOOP;
END;
/         

--�������̽��� �̿��Ͽ� new ��ü�� ���� �����Ѱ�?

--FOR LOOP���� Ŀ���� �ζ��� ���·� �ۼ�
--FOR ���ڵ� �̸� IN Ŀ���̸�
--==>
--FOR ���ڵ��̸� IN (��������)


DECLARE 
BEGIN
    FOR rec IN (SELECT deptno, dname FROM dept) LOOP
        DBMS_OUTPUT.PUT_LINE(rec.deptno || ':' || rec.dname);
    END LOOP;
END;
/

 CREATE TABLE DT
(	DT DATE);

insert into dt
select trunc(sysdate + 10) from dual union all
select trunc(sysdate + 5) from dual union all
select trunc(sysdate) from dual union all
select trunc(sysdate - 5) from dual union all
select trunc(sysdate - 10) from dual union all
select trunc(sysdate - 15) from dual union all
select trunc(sysdate - 20) from dual union all
select trunc(sysdate - 25) from dual;

commit;

SELECT *
FROM dt;

--pro_dt3

CREATE OR REPLACE PROCEDURE avgdt IS 
    TYPE dt_tab IS TABLE OF dt%ROWTYPE INDEX BY BINARY_INTEGER;
    v_dt_tab dt_tab;
    
    v_diff_sum NUMBER := 0;
BEGIN
    SELECT * BULK COLLECT INTO v_dt_tab
    FROM dt;
    
    --DT���̺����� 8���� �ִµ� 1~7�� ������� LOOP�� ����
    FOR i IN 1..v_dt_tab.COUNT-1 LOOP
        v_diff_sum := v_diff_sum + v_dt_tab(i).dt - v_dt_tab(i+1).dt;
    END LOOP;
    
    DBMS_OUTPUT.PUT_LINE(v_diff_sum /(v_dt_tab.COUNT-1));
    
END;
/

EXEC avgdt;

SELECT AVG(dt)
FROM
    (SELECT (dt - dt1) dt
    FROM
        (SELECT dt, LEAD(dt) OVER(ORDER BY dt DESC) dt1
        FROM dt));
        
SELECT AVG(diff)
FROM
(SELECT dt - LEAD(dt)  OVER(ORDER BY dt DESC) diff
FROM dt);

SELECT (MAX(dt) - MIN(dt)) / (COUNT(dt) -1) diff
FROM dt;














