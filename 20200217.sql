--dt==>202002
SELECT DECODE(d, 1, iw+1, iw)i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) thu,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:dt,'yyyymm') + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL-1),'D')d,
        TO_CHAR(TO_DATE(:dt,'yyyymm') + (LEVEL-1),'iw') iw
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))
GROUP BY DECODE(d, 1, iw+1, iw) 
ORDER BY DECODE(d, 1, iw+1, iw) ;

--1.해당 월의 1일자가 속한 주의 일요일 구하기
--2.해당 월의 마지막 일자가 속한 주의 토요일 구하기
--3. 2-1을 하여 총 일수 구하기

--기존 : 시작일자 1일, 마지막 날짜 : 해달월의 마지막 일자

--변경 : 시작일자 : 해당월의 1일자가 속한 주의 일요일
--      마지막날짜 : 해당월의 마지막 일자가 속한 주의 토요일    
SELECT TO_DATE('20200126', 'YYYYMMDD') + (LEVEL-1)
FROM dual
CONNECT BY LEVEL <= 35;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;      


SELECT DECODE(d, 1, iw+1, iw)i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) thu,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (LEVEL-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)) + (LEVEL-1),'D')d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)) + (LEVEL-1),'iw') iw
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')),'DD'))
GROUP BY DECODE(d, 1, iw+1, iw) 
ORDER BY DECODE(d, 1, iw+1, iw) ;

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;  

SELECT 
        TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) st,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D')) ed,
        LAST_DAY(TO_DATE(:dt, 'yyyymm')) + (7- TO_CHAR(LAST_DAY(TO_DATE(:dt, 'yyyymm')), 'D'))
                      - ( TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D'))) daycnt
FROM dual;  

SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);    

SELECT DECODE(d, 1, iw+1, iw) i,
       MIN(DECODE(d, 1, dt)) sun,
       MIN(DECODE(d, 2, dt)) mon,
       MIN(DECODE(d, 3, dt)) tue,
       MIN(DECODE(d, 4, dt)) wed,
       MIN(DECODE(d, 5, dt)) tur,
       MIN(DECODE(d, 6, dt)) fri,
       MIN(DECODE(d, 7, dt)) sat
FROM 
(SELECT TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1) + (level-1) dt,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'D') d,
        TO_CHAR(TO_DATE(:dt, 'yyyymm') - ( TO_CHAR(TO_DATE(:dt, 'yyyymm'), 'D') -1)  + (LEVEL-1), 'iw') iw
 FROM dual
 CONNECT BY LEVEL <=  last_day(to_date(:dt,'yyyymm'))+(7-to_char(last_day(to_date(:dt,'yyyymm')),'D'))
                    -to_date(:dt,'yyyymm')-(to_char(to_date(:dt,'yyyymm'),'D')-1)  )
 GROUP BY DECODE(d, 1, iw+1, iw)
 ORDER BY DECODE(d, 1, iw+1, iw);
 
 create table sales as 
select to_date('2019-01-03', 'yyyy-MM-dd') dt, 500 sales from dual union all
select to_date('2019-01-15', 'yyyy-MM-dd') dt, 700 sales from dual union all
select to_date('2019-02-17', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-02-28', 'yyyy-MM-dd') dt, 1000 sales from dual union all
select to_date('2019-04-05', 'yyyy-MM-dd') dt, 300 sales from dual union all
select to_date('2019-04-20', 'yyyy-MM-dd') dt, 900 sales from dual union all
select to_date('2019-05-11', 'yyyy-MM-dd') dt, 150 sales from dual union all
select to_date('2019-05-30', 'yyyy-MM-dd') dt, 100 sales from dual union all
select to_date('2019-06-22', 'yyyy-MM-dd') dt, 1400 sales from dual union all
select to_date('2019-06-27', 'yyyy-MM-dd') dt, 1300 sales from dual;



SELECT *
FROM sales;

SELECT TO_CHAR(TO_DATE(dt, 'yyyy/mm/dd'),'mm') m
FROM sales;

--1. dt(일자) ==>월, 월단위별 SUM(SALSE) ==>월의 수만큼 행이 그룹핑된다
SELECT SUM(jan) jan, SUM(feb) feb, NVL(SUM(mar),0) mar,SUM(apr) apr,SUM(may) may,SUM(jun) jun
FROM
(SELECT DECODE(TO_CHAR(dt, 'MM'),'01', SUM(sales)) JAN,
       DECODE(TO_CHAR(dt, 'MM'),'02', SUM(sales)) FEB,
       DECODE(TO_CHAR(dt, 'MM'),'03', SUM(sales)) MAR,
       DECODE(TO_CHAR(dt, 'MM'),'04', SUM(sales)) APR,
       DECODE(TO_CHAR(dt, 'MM'),'05', SUM(sales)) MAY,
       DECODE(TO_CHAR(dt, 'MM'),'06', SUM(sales)) JUN
FROM sales
GROUP BY TO_CHAR(dt, 'MM'));

create table dept_h (
    deptcd varchar2(20) primary key ,
    deptnm varchar2(40) not null,
    p_deptcd varchar2(20),
    
    CONSTRAINT fk_dept_h_to_dept_h FOREIGN KEY
    (p_deptcd) REFERENCES  dept_h (deptcd) 
);

insert into dept_h values ('dept0', 'XX회사', '');
insert into dept_h values ('dept0_00', '디자인부', 'dept0');
insert into dept_h values ('dept0_01', '정보기획부', 'dept0');
insert into dept_h values ('dept0_02', '정보시스템부', 'dept0');
insert into dept_h values ('dept0_00_0', '디자인팀', 'dept0_00');
insert into dept_h values ('dept0_01_0', '기획팀', 'dept0_01');
insert into dept_h values ('dept0_02_0', '개발1팀', 'dept0_02');
insert into dept_h values ('dept0_02_1', '개발2팀', 'dept0_02');
insert into dept_h values ('dept0_00_0_0', '기획파트', 'dept0_01_0');
commit;

SELECT *
FROM dept_h;

--오라클 계층형 쿼리 문법
--SELECT ...
--FROM ...
--WHERE
--START WITH 조건 : 어떤 행을 시작점으로 삼을지
--CONNECT BY 행과 행을 연결하는 기준
--           PRIOR : 이미 읽은 행
--          "     ":앞으로 읽을 행

--하향식 : 상위에서 자식 노드로 연결(위==>아래)

--XX회사(최상위 조직)에서 시작하여 하위 부서로 내려가는 계층쿼리
SELECT *
FROM dept_h
START WITH deptcd = 'dept0'
--START WITH deptnm = 'XX회사'
--START WITH p_deptcd IS NULL
CONNECT BY PRIOR deptcd = p_deptcd;
--: 행과 행의 연결 조건(PRIOR XX회사-3가지 부(디자인부ㅡ 정보기획부, 정보시스템부))
--PRIOR XX회사.deptcd = 디자인부.p_deptcd
--PRIOR 디자인부.deptcd = 디자인팀p_deptcd

--PRIOR XX회사.deptcd = 정보기획부.p_deptcd
--PRIOR 정보기획부.deptcd = 기획팀.p_deptcd
--PRIOR 기획팀.deptcd = 기획파트.p_dept_cd

--PRIOR XX회사.deptcd = 정보시스템부.p_deptcd(개발1팀, 개발2팀)
--PRIOR 정보시스템부.p_deptcd = 개발1팀.p_deptcd
--PRIOR 정보시스템부.p_deptcd = 개발2팀.p_deptcd


SELECT LPAD(' ', 4, '*')
FROM dual;

SELECT dept_h.*, LEVEL, lpad(' ', (LEVEL-1)*4, ' ') ||deptnm
FROM dept_h
START WITH deptcd = 'dept0'
CONNECT BY PRIOR deptcd = p_deptcd;





