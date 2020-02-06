SELECT *
FROM tax;

Ssystem
SELECT sido, sigungu, ROUND(sal/people) pri_sal
FROM tax
ORDER BY pri_sal DESC;

--�ܹ������� �õ�, �ܹ������� �ñ���, �ܹ��� ���� ���� �õ�, ���� �ñ���, ���κ� �ٷμҵ��

SELECT burger.*, st.*
FROM;
(SELECT ROWNUM num 
FROM
    (SELECT a.sido, a.sigungu, ROUND(a.c1/b.c2, 2) hamburger_score
        FROM    
            (SELECT sido, sigungu, COUNT(*)c1
            FROM fastfood
            WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����')
            GROUP BY sido, sigungu)a,
            (SELECT sido, sigungu, COUNT(*) c2
            FROM fastfood
            WHERE gb IN ('�Ե�����')
            GROUP BY sido, sigungu)b
        WHERE a.sido = b.sido 
        AND a.sigungu = b.sigungu
        ORDER BY hamburger_score DESC))burger,
    (SELECT ROWNUM num
    FROM
        (SELECT sido, sigungu, ROUND(sal/people) pri_sal
        FROM tax
        ORDER BY pri_sal DESC))st
WHERE burger.num = st.num
ORDER BY burger.num;

--ROWNUM ���� ����
--1.SELECT ==> ORDERBY
--���ĵ� ����� ROWNUM�� �����ϱ� ���ؼ��� INLINE-VIEW
--1������ ���������� ��ȸ�� �Ǵ� ���ǿ� ���ؼ��� WHERE������ ����� ����
--ROWNUM = 1 (O)
--ROWNUM = 2 (X)
--ROWNUM < 10 (O)
--ROWNUM > 10(X)
SELECT burger.sido, burger.sigungu, burger.burger_score, s.sido, s.sigungu, s.pri_sal
FROM
    (SELECT ROWNUM num, sido, sigungu, burger_score
    FROM 
        (SELECT sido, sigungu, ROUND((kfc+BURGERKING+mac)/lot,2)burger_score
        FROM
            (SELECT sido, sigungu,
               NVL(SUM(DECODE(gb, 'KFC', 1)),0) kfc, NVL(SUM(DECODE(gb, '����ŷ', 1)),0) BURGERKING,
               NVL(SUM(DECODE(gb, '�Ƶ�����', 1)),0)mac, NVL(SUM(DECODE(gb, '�Ե�����', 1)),1)lot
                FROM fastfood
                WHERE gb IN ('KFC', '����ŷ', '�Ƶ�����', '�Ե�����')
                GROUP BY sido, sigungu)
                ORDER BY burger_score DESC)) burger, 
    (SELECT ROWNUM num, sido, sigungu, pri_sal
     FROM
        (SELECT sido, sigungu, ROUND(sal/people) pri_sal
        FROM tax
        ORDER BY pri_sal DESC))s
WHERE burger.num = s.num;

--ROWNUM - ORDER BY
--ROUND
--GROUP BY SUM
--JOIN
--DECODE
--NVL
--IN

--empno�÷��� NOT NULL ���� ������ �ִ�. - INSERT�� �ݵ�� ���� �����ؾ� ���������� �Էµȴ�
--empno�÷��� ������ ������ �÷��� NULLABLE�̴� (NULL���� ����� �� �ִ�)
INSERT INTO emp (empno, ename, job)
VALUES(9999, 'brown', NULL);

SELECT *
FROM emp;

INSERT INTO emp (ename, job)
VALUES ('sally', 'SALESMAN');

--���ڿ� : '���ڿ�'==>"���ڿ�"
--���� : 10
--��¥ : TO_DATE('20200206', 'YYYYMMDD'), SYSDATE
--emp ���̺��� hiredate�÷��� dateŸ��
--emp���̺��� 8�� �÷��� ���� �Է�
DESC emp;
INSERT INTO emp 
VALUES (9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99);
ROLLBACK;

--�������� �����͸� �ѹ��� INSERT : 
--INSERT INTO ���̺�� (�÷���1, �÷���2, ....)
--SELECT ...
--FROM ;

INSERT INTO emp
SELECT 9998, 'sally', 'SALESMAN', NULL, SYSDATE, 1000, NULL, 99
FROM dual
UNION ALL
SELECT 9999, 'brown', 'CLERK', NULL, TO_DATE('20200205','YYYYMMDD'), 1100, NULL, 99
FROM dual;

SELECT *
FROM emp;

--UPDATE����
--UPDATE ���̺��, �÷���1 = ������ �÷���1, �÷���2 = ������ �÷���2,...
--WHERE �� ���� ����
--������Ʈ ���� �ۼ��� WHERE���� �������� ������ �ش� ���̺��� ��� ���� ������� ������Ʈ�� �Ͼ��
--UPDATE, DELETE ���� WHRER���� ������ �ǵ��� �� �´��� �ٽ��ѹ� Ȯ���Ѵ�
--WHERE���� �մٰ� �ϴ��� �ش� �������� �ش� ���̺��� SELECT�ϴ� ������ �ۼ��Ͽ� �����ϸ�
--UPDATE��� ���� ��ȸ�� �� �����Ƿ� Ȯ���ϰ� �����ϴ� �͵� ��� �߻� ������ ������ �ȴ�.

--99�� �μ���ȣ�� ���� �μ������� dept���̺� �ִ� ��Ȳ
INSERT INTO dept VALUES (99, 'ddit', 'daejeon');
COMMIT;

SELECT *
FROM dept;

--99�� �μ���ȣ�� ���� �μ��� daname�÷��� ���� '���IT', loc �÷��� ���� '���κ���'���� ������Ʈ
--UPDATE ���̺��, �÷���1 = ������ �÷���1, �÷���2 = ������ �÷���2,...
--WHERE �� ���� ����

UPDATE dept SET dname = '���IT', loc = '���κ���'
WHERE deptno = 99;

SELECT *
FROM dept;

ROLLBACK;

--�Ǽ��� WHERE���� ������� ���� ���
--UPDATE dept SET dname = '���IT', loc = '���κ���'
/*WHERE deptno = 99;*/
--ROLLBACK;

--10 ==> SUBQUERY;
--SMITH, WARD�� ���� �μ��� �Ҽӵ� ��������
SELECT *
FROM emp
WHERE deptno IN (20, 30);

SELECT *
FROM emp
WHERE deptno IN (SELECT deptno
                 FROM emp
                 WHERE ename IN ('SMITH', 'WARD'));
                 
--UPDATE�ÿ��� �������� ����� ����
INSERT INTO emp (empno, ename) VALUES(9999, 'brown');
--9999�� ��� deptno, job ������ SMITH����� ���� �μ�����, �������� ������Ʈ
UPDATE emp SET deptno = (SELECT deptno FROM emp WHERE ename = 'SMITH'),
               job = (SELECT job FROM emp WHERE ename = 'SMITH')
WHERE empno = 9999;

SELECT *
FROM emp;

ROLLBACK;

--DELETE SQL : Ư������ ����
--DELETE [FROM] ���̺��
--WHERE �� ���� ����

SELECT *
FROM dept;

--99�� �μ���ȣ�� �ش��ϴ� �μ� ���� ����
DELETE dept
WHERE deptno = 99;
COMMIT;

--SUBQUERY�� ���ؼ� Ư������ �����ϴ� ������ ���� DELETE
--�Ŵ�����  7698����� ������ �����ϴ� ������ �ۼ�
DELETE emp
WHERE empno IN (SELECT empno 
                FROM emp
                WHERE mgr = 7698);
ROLLBACK;

SELECT *
FROM emp;












