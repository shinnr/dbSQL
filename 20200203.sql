SELECT *
FROM customer;

SELECT *
FROM product;

SELECT *
FROM cycle;

--�Ǹ��� : 200 ~250
--���� 2.5�� ��ǰ
--�Ϸ� : 500~750
--�Ѵ� : 15000~17000

SELECT *
FROM daily;

SELECT *
FROM batch;

--join4
--join�� �ϸ鼭 row�� �����ϴ� ������ ����;
SELECT c.cid, c.cnm, cycle.pid, cycle.day, cycle.cnt
FROM customer c, cycle
WHERE c.cid = cycle.cid
AND c.cnm IN ('brown', 'sally');

--join5
SELECT cu.cid, cu.cnm, p.pid, p.pnm, c.day, c.cnt
FROM customer cu, cycle c, product p
WHERE cu.cid = c.cid AND c.pid = p.pid
AND cu.cnm IN ('brown', 'sally');

--join6
SELECT cu.cid, cu.cnm, p.pid, p.pnm, SUM(c.cnt)
FROM customer cu, cycle c, product p
WHERE cu.cid = c.cid AND c.pid = p.pid
GROUP BY cu.cid, cu.cnm, p.pid, p.pnm, c.cnt;

--join7����
SELECT p.pid, p.pnm, SUM(c.cnt)
FROM cycle c, product p
WHERE c.pid = p.pid
GROUP BY p.pid, p.pnm, c.cnt;

-- �ش� ����Ŭ ������ ��ϵ� �����(����)��ȸ;
SELECT *
FROM dba_users;

--HR������ ��й�ȣ�� java�� �ʱ�ȭ
ALTER USER HR IDENTIFIED BY java;
ALTER USER HR ACCOUNT UNLOCK;










