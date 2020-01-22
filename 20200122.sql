-- PROD 테이블의 모든 컬럼의 자료 조회
SELECT prod
FROM prod;

--PROD 테이블에서 PROD_ID, PROD_NAME 컬럼의 자료만 조회
SELECT prod_id, prod_name
FROM prod;

--lprod 테이블에서 모든 데이터 조회
SELECT *
FROM lprod;

--buyer 테이블에서 buyer_id, buyer_name 조회
SELECT buyer_id, buyer_name
FROM buyer;

--cart 테이블에서 모든 테이블 조회
SELECT *
FROM cart;

--member 테이블에서 mem_id, mem_pass, mem_name 컬럼 조회
SELECT mem_id, mem_pass, mem_name
FROM member;

--users 테이블 조회
SELECT *
FROM users;

--테이블에 어떤 컬럼이 있는지 확인하는 방법
--1. SELECT *
--2.TOOL의 기능 (사용자-TABLES)
--3.DESC 테이블명(DESC-DESCRIBLE)

DESC users;

--날짜 연산(reg_dt 컬럼은 date정보를 담을수 있는 타입)
--날짜칼럼 +(더하기연산)
--수학적인 사칙연산이 아닌것들
--SQL에서 정의된 알짜ㅣ 연산: 날짜+정수= 날짜에서 정수를 일자로 취습하여 더한 날짜가 된다(2019/01/28 +5=2019/02/02)
--reg_dt:등록일자 칼럼
--null:값을 모르는 상태
--null에 대한 연산결과는 항상 null

--users 테이블에서 userid, usernm, rog_dt 컬럼만 조회하는 sql
SELECT userid u_id, usernm, reg_dt, reg_dt+5 AS reg_dt_after_5day
FROM users;

--실습2
SELECT prod_id AS id, prod_name AS name
FROM prod;

SELECT lprod_gu AS gu, lprod_nm AS nm
FROM lprod;

SELECT buyer_id AS buyer_name, buyer_name
FROM buyer;

--문자열 결합
--자바언어에서 문자열 결합 : +
--SQL에서는 : || ('HELLO' || 'world')
--SQL에서는 : comcat ('HELLO', 'world')

--userid, usernm 컬럼을 결합, 별칭 id_name
SELECT userid || usernm AS id_name
FROM users;

SELECT CONCAT(userid, usernm) AS concat_id_name
FROM users;

--변수, 상수
--int a=5; String msg="HelloWorld";
--//변수를 이용한 출력
--system.out.println(msg);
--//상수를 이용한 출력
--Ssystem.out.println("Hello, World");

--SQL에서의 변수는 없음
--(컬림이 비슷한 역할, pl/sql 변수개념이 존재)
--SQL에서 문자열 상수는 싱글 쿼테이션으로 표현
--"Hello, World"--> 'Hello, World'

--문자열 상수와 컬럼간의 결합
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

--int a=5; //할당, 대입 연산자
--if(a==5) (a의 값이 5인지 비교)
--sql에서는 대입의 개념이 없다(PL/SQL)
--sql=-->equal

--users테이블의 모든 행에 대해서 조회
--users에는 5건의 데이터가 존재
SELECT *
FROM users;

--WHERE잘: 테이블에서 데이터를 조회할 때 조건에 맞는 행만 조회
--ex: userid컬럼의 값이 brown인 행만 조회
SELECT *
FROM users
WHERE userid=brown;

--emp 테이블에서 ename컬럼값이 JONES인 행만 조회
--*SQL KEY WORD는 대소문자를 가리지 않지만 컬럼의 값이나 문자열, 
SELECT *
FROM emp
WHERE ename = 'JONES';

--emp테이블에서 deptno(부서번호)가 30보다 크거나 같은 사원들만 조회
SELECT *
FROM emp
WHERE deptno>=30;

--문자열 : '문자열'
--숫자:50
--날짜:???-->함수와 문자열을 결합하여 표현
--문자열만 이용하여 표현가능(권장안함)
--한국:년도 4자리-월2자리-일자2자리
--미국:월2자리-일2자리-년도4자리


SELECT *
FROM emp
WHERE hiredate='80/12/17';

--TO_DATE:문자열을 date타입으로 변경하는 함수
--TO_DATE(날짜형식 문자열, 첫번째 인자의 형식)
SELECT *
FROM emp
WHERE hiredate=TO_DATE('1980/12/17', 'YYYY/MM/DD');

--범위연산
--sal 컬럼의 값이 1000에서 2000사이인 사람]
--sal >=1000
--sal<=2000
SELECT *
FROM emp
WHERE sal>=1000 
AND SAL <=2000;

--범위연산자를 부등호 대신에 BETWEEN AND연산자로 대체
SELECT *
FROM emp
WHERE sal BETWEEN 1000 AND 2000;

SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN TO_DATE('1982/01/01','YYYY/MM/DD') AND TO_DATE('1983/01/01','YYYY/MM/DD');

 