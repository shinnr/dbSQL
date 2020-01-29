--DATE : TO_DATE 문자열->날짜(DATE)
--      TO_CHAR 날짜->문자열(날짜 포맷 지정)
--JAVA에서는 날짜 포맷의 대소문자를 가린다(MM / mm ->월 / 분)
--주간일자(1~7) D: 일요일 1, 월요일 2......토요일 7
--주차 IW : ISO표준 -해당 주의 목요일이 기준으로 주차를 산정
--         2019/12/31 화요일 --?2020/01/02(목요일)-->그렇기 때문에 1주차로 산정
SELECT TO_CHAR (SYSDATE, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(SYSDATE, 'D'),--오늘은 2020/01/29(수)-->4
       TO_CHAR(SYSDATE, 'IW'),
       TO_CHAR(TO_DATE('2019/12/31', 'YYYY/MM/DD'),'IW')
FROM dual;

--emp테이블의 hiredate(입사일자)컬럼의 년월일 시:분:초
SELECT ename, hiredate,
       TO_CHAR(hiredate, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(hiredate + 1, 'YYYY-MM/DD HH24:MI:SS'),
       TO_CHAR(hiredate+1/24, 'YYYY-MM/DD HH24:MI:SS'),
       --hiredate에 30분을 더하여 TO_CHAR로 표현
       TO_CHAR(hiredate+(1/24/60)*30, 'YYYY-MM/DD HH24:MI:SS')
FROM emp;

--fn2
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD') dt_dash,
       TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24-MI-SS') dt_dash_with_time,
       TO_CHAR(SYSDATE, 'DD-MM-YYYY') dt_dd_mm_yyyy
FROM dual;

--MONTHS_BETWEEN(DATE, DATE)
--인자로 들어온 두 날짜 사이의 개월수를 리턴
SELECT ename, hiredate,
       MONTHS_BETWEEN(sysdate, hiredate),
       MONTHS_BETWEEN(TO_DATE('2020-01-17', 'YYYY-MM-DD'), hiredate)
FROM emp
WHERE ename='SMITH';

--ADD_MONTHS(DATE, 정수-가감할 개월수)
SELECT ADD_MONTHS(SYSDATE, 5),--2020/01/29-->2020/06/29
       ADD_MONTHS(SYSDATE, -5)--2020/01/29-->2020/08/29
FROM dual;

--NEXT_DAY(DATE, 주간일자), ex : NEXT_DAY(SYSDATE, 5)-->SYSDATE이후 처음 등장하는 주간일자 5에 해당하는 일자
--                              SYSDATE 2020/01/29(수) 이후 처음 등장하는 5(목)요일 -->2020/01/30(목)
SELECT NEXT_DAY(SYSDATE, 5)
FROM dual;

--LAST_DAY(DATE) DATE가 속한 월의 마지막 일자를 리턴
SELECT LAST_DAY(SYSDATE)--SYSDATE 2020/01/29 -->2020/01/31
FROM dual;

--LAST_DAY를 통해 인자로 들어온 date가 속한 월의 마지막 일자를 구할 수 있는데
--date의 첫번째 일자는 어떻게 구할까?
SELECT SYSDATE,
       LAST_DAY(SYSDATE),
       --CONCAT(TO_CHAR(SYSDATE, 'MM'),TO_CHAR(TO_DATE('2020/01/01', 'D'))
       ADD_MONTHS(LAST_DAY(SYSDATE)+1, -1),
       TO_DATE(TO_CHAR(SYSDATE,'YYYY-MM')||'-01','YYYY-MM-DD')
FROM dual;

--hiredate값을 이용하여 해당 월의 첫번째 일자로 표현
SELECT ename, hiredate,
       TO_DATE(TO_CHAR(hiredate,'YYYY-MM')||'-01','YYYY-MM-DD')
FROM emp;

--empno는 NUMBER타입, 인자는 문자열
--타입이 맞지 않기 때문에 묵시적 형변환이 일어남
--테이블 컬럼의 타입에 맞게 올바른 인자 값을 주는 게 중요
SELECT *
FROM emp
WHERE empno='7369';--이렇게 쓰지 마삼
-->
SELECT *
FROM emp
WHERE empno=7369;

--hiredate의 경우 DATE타입, 인자는 문자열로 주어졌기 때문에 묵시적 형변환이 발생
--날짜 문자열 보자 날짜 타입으로 명시적으로 기술하는 것이 좋음
SELECT *
FROM emp
WHERE hiredate = '1980/12/17'; --올바른 방법X
-->
SELECT *
FROM emp
WHERE hiredate = TO_DATE('1980/12/17', 'YYYY/MM/DD');

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE empno='7369';

EXPLAIN PLAN FOR
SELECT *
FROM emp
WHERE TO_CHAR(empno)='7369';

SELECT *
FROM table(dbms_xplan.display);

--숫자를 문자열로 변경하는 경우 : 포맷
--천단위 구분자
--1000이라는 숫자를
--한국 : 1,000.50
--독일 : 1.00.,50

--emp sal 컬럼(NUMBER 타입)을 포맷팅
-- 9 : 숫자
--0 : 강제 자리 맞춤(0으로 표기)
--L : 통화단위
SELECT ename, sal, TO_CHAR(sal, 'L0,999')
FROM emp;


--NULL에 대한 연산의 결과는 항상 NULL
--emp테이블에 sal컬럼에는 null데이터가 존재하지 않음(14건의 데이터에 대해)
--emp테이블에 comm컬럼에는 null데이터가 존재(14건의 데이터에 대해)
--sal + comm --> comm인 null인 행에 대해서는 결과 null로 나온다
--요구사항이 comm이 null이면 sal컬럼의 값만 조회
--요구사항이 충족 시키지 못한다-> sw에서는 [결함]

--NVL(타겟, 대체값)
--타겟의 값이 NULL이면 대체값을 반환
--타겟의 값이 NULL이 아니면 타겟값을 반환
--if(타겟 == null)
--  return 대체값;
--else
--  return 타겟;
SELECT ename, sal, comm, NVL(comm,0),
       sal+NVL(comm,0),
       NVL(sal+comm, 0)
FROM emp;

--NVL2(expr1, expr2, expr3)
--if(expr1 != null)
--  return expr2;
--else
--  return  expr3;
SELECT ename, sal, comm, NVL2(comm, 10000, 0)
FROM emp;

--NULLIF(expr1, expr2)
--if(expr1 == expr2)
--  return null;
--else
--  return expr1;

--sal 1250인 사원은 null을 리턴, 1250이 아닌사람은 sal을 리턴
SELECT ename, sal, comm, NULLIF(sal, 1250)
FROM emp;

--가변인자
--COALESCE 인자 중에 가장 처음으로 등장하는 null이 아닌 인자를 반환
--COALESCE(expr1, expr2....)
--if(expr1 != null)
--  rerutn expr1;
--else
--  return COALESCE(expr2, expr3...);

--COALESCE(comm, sal) : comm이 null이 아니면 comm
--                      comm이 null이면 sal (단, sal 컬럼의 값이 NULL이 아닐때)
SELECT ename, sal, comm, COALESCE(comm, sal)
FROM emp;

--fn4
SELECT empno, ename, mgr,
       NVL(mgr, 9999) mgr_n,
       NVL2(mgr, mgr, 9999) mgr_n1,
       COALESCE(mgr, 9999) mgr_n2
FROM emp;

--fn5
SELECT userid, usernm, reg_dt, NVL(reg_dt, SYSDATE) n_reg_dt
FROM users
WHERE userid != 'brown';

--CONDITION : 조건절
--CASE : JAVA의 if - else if -else
--CASE
--    WHEN 조건 THEN 리턴값1
--    WHEN 조건2 THEN 리턴값2
--    ELSE 기본값
--END
--emp테이블에서 job컬럼의 값이 SALESMAN SAL * 1.05리턴
--                          MANAGER이면 SAL * 1.1 리턴
--                          PRESIDENT이면 SAL * 1.2리턴
--                          그 밖의 사람들은 SAL리턴
SELECT ename, job, sal,
      CASE
          WHEN job = 'SALESMAN' THEN sal * 1.05
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
     END bonus_sal
FROM emp;

--DECODE 함수 : CASE절과 유사, 
--(다른점 CASE 절 : WHEN절의 조건비교가 자유롭다
--       DECODE 함수 : 하나의 값에 대해서 = 비교만 허용
--DECODE 함수 : 가변인자(인자의 개수가 상황에 따라서 늘어날 수가 있음)
--DECODE(collexpr, 첫번째 인자와 비교할 값1, 첫번째 인자와 두번째 인자가 같을 경우 반환 값,
--                 첫번째 인자와 비교할 값2, 첫번째 인자와 네번째 인자가 같을 경우 반환 값...
--                 option - else 최종적으로 반환할 기본값)

--emp테이블에서 job컬럼의 값이 SALESMAN이면서 sal가 1400보다 크면 SAL * 1.05리턴
--                          SALESMAN이면서 sal가 1400보다 작으면 SAL * 1.1리턴
--                          MANAGER이면 SAL * 1.1 리턴
--                          PRESIDENT이면 SAL * 1.2리턴
--                          그 밖의 사람들은 SAL리턴
SELECT ename, job, sal,
       DECODE(job, 'SALESMAN',sal * 1.05,
                   'MANAGER', sal *1.1,
                   'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;

--CASE
SELECT ename, job, sal,
      CASE
          WHEN job = 'SALESMAN' AND sal>1400 THEN sal * 1.05
          WHEN job = 'SALESMAN' AND sal<1400 THEN sal * 1.1
          WHEN job = 'MANAGER' THEN sal * 1.1
          WHEN job = 'PRESIDENT' THEN sal * 1.2
          ELSE sal
     END bonus_sal
FROM emp;

--DECODE, CASE를 혼용해서
SELECT ename, job, sal,
       DECODE(job, 'SALESMAN',sal * 1.05,
                   'MANAGER', sal *1.1,
                   'PRESIDENT', sal * 1.2, sal) bonus_sal
FROM emp;