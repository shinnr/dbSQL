SELECT level, lpad(' ',(level-1)*4, ' ') || deptnm deptnm, p_deptcd
FROM dept_h
START WITH deptcd = 'dept0_02'
CONNECT BY PRIOR deptcd = p_deptcd;

--����� ��������(leaf==> root node(����(node))
--��ü��带 �湮�ϴ� �� �ƴ϶� �ڽ��� �θ��常 �湮(����İ� �ٸ���)
--������ : ��������
--������ : �����μ�

--ù��°�� �鿩������ϰ�,LEVEL�ϳ��� ��ĭ�� ����
SELECT dept_h.*, LEVEL, LPAD(' ', (LEVEL-1) * 4) ||deptnm
FROM dept_h
START WITH deptnm = '��������'
CONNECT BY PRIOR p_deptcd = deptcd;

--h_4
create table h_sum as
select '0' s_id, null ps_id, null value from dual union all
select '01' s_id, '0' ps_id, null value from dual union all
select '012' s_id, '01' ps_id, null value from dual union all
select '0123' s_id, '012' ps_id, 10 value from dual union all
select '0124' s_id, '012' ps_id, 10 value from dual union all
select '015' s_id, '01' ps_id, null value from dual union all
select '0156' s_id, '015' ps_id, 20 value from dual union all

select '017' s_id, '01' ps_id, 50 value from dual union all
select '018' s_id, '01' ps_id, null value from dual union all
select '0189' s_id, '018' ps_id, 10 value from dual union all
select '11' s_id, '0' ps_id, 27 value from dual;

SELECT *
FROM h_sum;

SELECT LPAD(' ', (LEVEL-1) * 4) ||s_id s_id, value
FROM h_sum
START WITH s_id = '0'
CONNECT BY PRIOR s_id = ps_id;

--h_5
create table no_emp(
    org_cd varchar2(100),
    parent_org_cd varchar2(100),
    no_emp number
);
insert into no_emp values('XXȸ��', null, 1);
insert into no_emp values('�����ý��ۺ�', 'XXȸ��', 2);
insert into no_emp values('����1��', '�����ý��ۺ�', 5);
insert into no_emp values('����2��', '�����ý��ۺ�', 10);
insert into no_emp values('������ȹ��', 'XXȸ��', 3);
insert into no_emp values('��ȹ��', '������ȹ��', 7);
insert into no_emp values('��ȹ��Ʈ', '��ȹ��', 4);
insert into no_emp values('�����κ�', 'XXȸ��', 1);
insert into no_emp values('��������', '�����κ�', 7);

commit;

SELECT *
FROM no_emp;

SELECT LPAD(' ', (LEVEL-1) * 4)||org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;


--������ ������ �� ���� ���� ��� ��ġ�� ���� ��� �� (pruning btanch - ����ġ��)
--FROM => START WITH, CONNECT BY ==> WHERE
--1. WHERE : ���� ������ �ϰ��� ���� ����
--2.CONNECT BY : ���� ������ �ϴ� �������� ���� ����

--WHERE�� ��� �� : �� 9���� ���� ��ȸ�Ǵ� �� Ȯ��
--WHERE�� (org_cd != '������ȹ��') : ������ȹ�θ� ������ 8���� �� ��ȸ�Ǵ� �� Ȯ��

SELECT LPAD(' ', (LEVEL-1) * 4)||org_cd, no_emp
FROM no_emp
WHERE org_cd != '������ȹ��'
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--CONNECT BY���� ������ ���
SELECT LPAD(' ', (LEVEL-1) * 4)||org_cd, no_emp
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd AND org_cd != '������ȹ��';

--CONNECT_BY_ROOT(�÷�) : �ش� �÷��� �ֻ��� ���� ���� ��ȯ
--SYS_CONNECT_BY_PATE(�÷�, ������) : �ش� ���� �÷��� ���߿� �÷����� ��õ, �����ڷ� �̾��ش�
--CONNECT_BY_ISLEAF : �ش� ���� LEAF �������(����� �ڽ��� ������) ���� ���� (1 : LEAF, 0 : NO LEAF)
SELECT LPAD(' ', (LEVEL-1) * 4)||org_cd, no_emp,
       CONNECT_BY_ROOT(org_cd) root,
       LTRIM(SYS_CONNECT_BY_PATH(org_cd, '-'),'-') path,
       CONNECT_BY_ISLEAF
FROM no_emp
START WITH org_cd = 'XXȸ��'
CONNECT BY PRIOR org_cd = parent_org_cd;

--h6
create table board_test (
 seq number,
 parent_seq number,
 title varchar2(100) );
 
insert into board_test values (1, null, 'ù��° ���Դϴ�');
insert into board_test values (2, null, '�ι�° ���Դϴ�');
insert into board_test values (3, 2, '����° ���� �ι�° ���� ����Դϴ�');
insert into board_test values (4, null, '�׹�° ���Դϴ�');
insert into board_test values (5, 4, '�ټ���° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (6, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (7, 6, '�ϰ���° ���� ������° ���� ����Դϴ�');
insert into board_test values (8, 5, '������° ���� �ټ���° ���� ����Դϴ�');
insert into board_test values (9, 1, '��ȩ��° ���� ù��° ���� ����Դϴ�');
insert into board_test values (10, 4, '����° ���� �׹�° ���� ����Դϴ�');
insert into board_test values (11, 10, '���ѹ�° ���� ����° ���� ����Դϴ�');
commit;

SELECT *
FROM board_test;

SELECT seq, LPAD(' ', (LEVEL-1) * 4)||title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq;

--h_7
SELECT seq, LPAD(' ', (LEVEL-1) * 4)||title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER BY seq DESC;

--h_8
SELECT seq, LPAD(' ', (LEVEL-1) * 4)||title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

--h_9
SELECT seq, LPAD(' ', (LEVEL-1) * 4)||title title,
     LTRIM(SYS_CONNECT_BY_PATH(seq, '-'),'-') path  
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY seq DESC;

SELECT *
FROM board_test;

--�׷��ȣ�� ������ �÷��� �߰�
ALTER TABLE board_test ADD (gn NUMBER);
UPDATE board_test SET gn = 4
WHERE seq IN (4,5,6,7,8,10,11);

UPDATE board_test SET gn = 2
WHERE seq IN (2,3);

UPDATE board_test SET gn = 1
WHERE seq IN (1,9);

commit;

SELECT *
FROM board_test;

SELECT gn, seq, LPAD(' ', (LEVEL-1) * 4)||title title
FROM board_test
START WITH parent_seq IS NULL
CONNECT BY PRIOR seq = parent_seq
ORDER SIBLINGS BY gn DESC, seq ASC;


SELECT *
FROM emp
WHERE sal = (SELECT MAX(sal)
             FROM emp);
             
--ana0


SELECT ename, sal, deptno
FROM emp
ORDER BY deptno, sal DESC;

SELECT * 
FROM 
(SELECT LEVEL lv
FROM dual
CONNECT BY LEVEL <= 14) a,

(SELECT deptno, COUNT(*) cnt
FROM emp
GROUP BY deptno) b
WHERE b.cnt >= a.lv
ORDER BY b.deptno, a.lv;

