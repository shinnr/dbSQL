SELECT *
FROM cycle;
--1번 고객이 100번 재품을 월요일날 1개 애음
--2020년 2월에 대한 일실적을 생성
--1. 2020년 2월의 월요일에 대해 일실적 생성
--
--20200203
--20200210
--20200227
--20200224

SELECT TO_CHAR(TO_DATE('202002' || '01', 'YYYYMMDD') + (LEVEL -1),'YYYYMMDD') dt,
        TO_CHAR(TO_DATE('202002' || '01', 'YYYYMMDD') + (LEVEL -1),'D')d
FROM dual
CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE('202002' || '01', 'YYYYMMDD')),'DD') ;

SELECT *
FROM cycle;

--pro_4

CREATE OR REPLACE PROCEDURE create_daily_sales(p_yyyymm IN daily.dt%TYPE) IS
    TYPE cal_row IS RECORD(
        dt VARCHAR2(8),
        d NUMBER);
    TYPE cal_tab IS TABLE OF cal_row INDEX BY BINARY_INTEGER;
    v_cal_tab cal_tab;
BEGIN
    SELECT TO_CHAR(TO_DATE(p_yyyymm || '01', 'YYYYMMDD') + (LEVEL -1),'YYYYMMDD') dt,
        TO_CHAR(TO_DATE(p_yyyymm  || '01', 'YYYYMMDD') + (LEVEL -1),'D')d
        BULK COLLECT INTO v_cal_tab
    FROM dual
    CONNECT BY LEVEL <= TO_CHAR(LAST_DAY(TO_DATE(p_yyyymm || '01', 'YYYYMMDD')),'DD') ;
    
    --일실적 데이터를 생성하기 전에 기존에 생성된 데이터를 삭제
    
    DELETE daily
    WHERE dt LIKE p_yyyymm || '%';
    
    --애음주기 정보 조회(FOR_CURSOR)
    FOR daily_row IN (SELECT * FROM cycle) LOOP
        DBMS_OUTPUT.PUT_LINE (daily_row.cid || ' ' || daily_row.pid ||' '||daily_row.day || ' ' ||daily_row.cnt);
        FOR i IN 1..v_cal_tab.COUNT LOOP
        
            --outer loop(애음주기)에서 읽은 요일이랑 inner loop(달력)에서 읽은 요일이 같은 데이터를 체크
            IF daily_row.day = v_cal_tab(i).d THEN
                INSERT INTO daily VALUES (daily_row.cid, daily_row.pid, v_Cal_tab(i).dt, daily_row.cnt);
                DBMS_OUTPUT.PUT_LINE (v_cal_tab(i).dt|| ' '||v_cal_tab(i).d);
            END IF;
        END LOOP;
    END LOOP;
    
    COMMIT;
END;
/

SET SERVEROUTPUT ON;

SELECT *
FROM daily;

EXEC create_daily_sales('202002');


