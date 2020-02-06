--sub6
SELECT *
FROM cycle
WHERE cid = 1
AND pid IN (
            SELECT pid
            FROM cycle
            WHERE cid = 2);
            
--sub7
SELECT customer.cid, customer.cnm, product.pnm, a.day, a.cnt
FROM    (SELECT *
        FROM cycle
        WHERE cid = 1
        AND pid IN (SELECT pid
                    FROM cycle
                    WHERE cid = 2))a JOIN customer ON (a.cid = customer.cid)
                                     JOIN product ON (a.pid = product.pid);
                    
SELECT *
FROM customer;
SELECT *
FROM product;

SELECT customer.cid, customer.cnm, product.pnm, a.day, a.cnt
FROM 
        (SELECT *
        FROM cycle
        WHERE cid = 1
        AND pid IN (
                    SELECT pid
                    FROM cycle
                    WHERE cid = 2))a, customer, product
WHERE a.cid = customer.cid
AND a.pid = product.pid;

SELECT cycle.cid, customer.cnm, cycle.pid ,product.pnm, cycle.day, cycle.cnt
FROM cycle, customer, product
WHERE cycle.cid = 1
AND cycle.pid IN (SELECT pid
            FROM cycle
            WHERE cid = 2)
AND cycle.cid = customer.cid
AND cycle.pid = product.pid;

--�Ŵ����� �����ϴ� ������ ��ȸ(KING�� ������ 13���� �����Ͱ� ��ȸ)
SELECT *
FROM emp
WHERE mgr IS NOT NULL;

--EXISTS ���ǿ� �����ϴ� ���� �����ϴ��� Ȯ���ϴ� ������
--�ٸ� �����ڿ� �ٸ��� WHERE���� �÷��� ������� �ʴ´�
--WHERE empno = 7369
--WHERE EXISTS (SELECT 'X'
--                FROM .....)

--�Ŵ����� �����ϴ� ������ EXISTS�����ڸ� ���� ��ȸ
--�Ŵ����� ����
SELECT *
FROM emp e
WHERE EXISTS (SELECT 'X'
              FROM emp m
              WHERE e.mgr = m.empno);
              
--sub9
--1�� ���� �����ϴ� ��ǰ ==> 100,400
SELECT *
FROM cycle;
SELECT *
FROM product;

SELECT pid, pnm
FROM product
WHERE EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);

--sub10
SELECT pid, pnm
FROM product
WHERE NOT EXISTS (SELECT 'X'
              FROM cycle
              WHERE cid = 1
              AND cycle.pid = product.pid);
              
--���տ���
--������ : UNION -�ߺ�����(���հ���) /UINION ALL -�ߺ��� �������� ����(�ӵ����)
--������ : INTERSECT (���հ���)
--������ : MINUS (���հ���)
--���տ��� �������
--�� ������ �÷��� ����, Ÿ���� ��ġ�ؾ��Ѵ�.

--������ ������ �������ϱ� ������ �ߺ��Ǵ� �����ʹ� �ѹ��� ����ȴ�
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--UNION ALL�����ڴ� UNION�����ڿ� �ٸ��� �ߺ��� ����Ѵ�
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698)

UNION ALL

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--INTERSECT(������) : ��, �Ʒ� ���տ��� ���� ���� �ุ ��ȸ
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

INTERSECT

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--MINUS(������) :�� ���տ��� �Ʒ� ������ �����͸� ������ ������ ����
SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698, 7369)

MINUS

SELECT empno, ename
FROM emp
WHERE empno IN (7566, 7698);

--������ ��� ������ ������ ���� ���տ�����
--A UNION B        B UNION A ==>����
--A UNION ALL B    B UNION ALL A ==>����(����)
--A INTERSECT B    B INTERSECT A ==>����
--A MINUS B        B MINUS A ==>�ٸ�

--���տ����� ��� �÷� �̸��� ù��° ������ �÷����� ������.
SELECT 'X' fir, 'B' sec
FROM dual

UNION

SELECT 'Y', 'A'
FROM dual;

--����(ORDER BY)�� ���տ��� ���� ������ ���� ������ ���
SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(10, 20)

UNION

SELECT deptno, dname, loc
FROM dept
WHERE deptno IN(30, 40)
ORDER BY deptno;

--�ܹ��� ���� ��������

SELECT *
FROM fastfood;

--�õ�, �ñ���, ��������
--(����ŷ + �Ƶ����� + kfc)/�Ե�����
--�������� ���� ���� ���ð� ���� �������� ����
SELECT *
FROM fastfood;

SELECT gb
FROM fastfood
GROUP BY gb;

SELECT gb, CONCAT(sido, sigungu) city
FROM fastfood;


SELECT b.sido||sigungu
FROM
(SELECT sido||sigungu, COUNT(sido||sigungu)����ŷ
FROM fastfood
WHERE gb = '����ŷ'
GROUP BY sido||sigungu)b,

(SELECT sido||sigungu, COUNT(sido||sigungu)KFC
FROM fastfood
WHERE gb = 'KFC'
GROUP BY sido||sigungu)k,

(SELECT sido||sigungu, COUNT(sido||sigungu)�Ƶ�����
FROM fastfood
WHERE gb = '�Ƶ�����'
GROUP BY sido||sigungu)m

GROUP BY sido||sigungu;


SELECT (bg.sido||bg.sigungu)city , bg.bcity ����, lt.lcity �Ե�����,  bg.bcity/lt.lcity ��������
FROM
    (SELECT sido, sigungu, COUNT(*)bcity
    FROM fastfood
    WHERE gb = '����ŷ' OR gb = 'KFC' OR gb = '�Ƶ�����'
    GROUP BY sido, sigungu)bg,
    (SELECT sido,sigungu, COUNT(*)lcity
    FROM fastfood
    WHERE gb = '�Ե�����'
    GROUP BY sido, sigungu)lt
WHERE bg.sido = lt.sido AND bg.sigungu = lt.sigungu;











            