--PL-SQL(Oracle 프로그래밍 언어)

CREATE OR REPLACE PROCEDURE usp_delete_emp
  (
  	vempno IN emp.empno%TYPE,
    p_outmsg OUT VARCHAR2
   )
   IS
   		BEGIN
      		DELETE FROM EMP WHERE empno=vempno;
          	COMMIT;
      	  p_outmsg := 'success';
	          EXCEPTION WHEN OTHERS THEN
	          p_outmsg := SQLERRM;	
	          ROLLBACK;
      END; 

BEGIN
		DBMS_OUTPUT.PUT_LINE('hello world');
END;

--선언부(변수)  , 실행부(변수에 값 할당 또는 제어구문)
DECLARE --선언부
	vno NUMBER(4);
  vname VARCHAR2(20);
BEGIN --실행부
		--vno  := 100;
    --vname := 'kingsmile';    -- 할당( := )
    --DBMS_OUTPUT.PUT_LINE(vno);
		--DBMS_OUTPUT.PUT_LINE( vno  ||   '---'       ||  vname);
    SELECT empno, ename
    INTO vno, vname -- into 변수명.... select 한 결과를 변수에 담는 방법
    FROM EMP
    WHERE empno=7782;
    DBMS_OUTPUT.PUT_LINE( vno  ||   '---'       ||  vname);
END;

-----------------------------------------------------------------
--값을 입력 &변수명--
DECLARE
	vno NUMBER(4);
  vname VARCHAR2(20);
BEGIN
	SELECT empno, ename
  	INTO vno, vname
  FROM EMP
  WHERE empno = &empno;   --&empno 통해서 값 입력 받기
  DBMS_OUTPUT.PUT_LINE( '입력값 : ' || vno  ||   '---'       ||  vname);
END;
-----------------------------------------------------------------
--Type 정의하기
--sqlplus scott/1004
--set serveroutput on;
--편집 : edit 편집하고 저장
-- / enter


--1.  %TYPE
DECLARE
	  vno emp.empno%TYPE;  --원하는 테이블의 타입 정보 얻기
    vname emp.ename%TYPE;
BEGIN
		SELECT empno, ename
   	 INTO vno, vname
    FROM EMP
    WHERE empno=&empno;
      DBMS_OUTPUT.PUT_LINE( 'Type : ' || vno  ||   '---'   ||  vname);
END;

----------------------------------------------------------------
--pl-sql (DML) 처리하기
CREATE TABLE pl_test
(
   NO number,
   NAME VARCHAR2(20),
   addr VARCHAR2(50)
);
SELECT * FROM pl_test;
--pl-sql 선언부에서 parameter 값 받기   '&변수명'
DECLARE
v_no NUMBER := '&NO';
v_name VARCHAR2(20) := '&NAME';
v_addr VARCHAR2(50) := '&addr';
BEGIN
		INSERT INTO pl_test(NO,NAME,addr)
    VALUES(v_no , v_name, v_addr);
END;

--update
DECLARE
v_no NUMBER := '&NO';
v_name VARCHAR2(20) := '&NAME';
v_addr VARCHAR2(50) := '&addr';
BEGIN
		UPDATE pl_test
    SET NAME = v_name , addr= v_addr
    WHERE NO = v_no;
END;
--------------------------------------------------------------
--1.변수 제어하기
--1. 타입 : v_empno number(10)
--2.타입 : v_empno emp.empno%TYPE -> 컬럼의 타입정보 얻기
--3.타입 : v_row emp%ROWTYPE ->  emp 테이블의 여러 컬럼을 한꺼번에
--                                           저장할 수 있는 변수 선언

--Quiz
--두개의 정수를 입력받아 그 합을 출력
DECLARE
	v_no1 NUMBER := &no1;
  v_no2 NUMBER := &no2;
  result NUMBER;
BEGIN
		result := v_no1 + v_no2;
     DBMS_OUTPUT.PUT_LINE(result || '=' || v_no1 || '+' || v_no2);
END;

--------------------------------------------------------------------------
DECLARE
	v_emprow emp%ROWTYPE;

BEGIN
	SELECT *
  INTO v_emprow
  FROM EMP
  WHERE empno=7788;

   DBMS_OUTPUT.PUT_LINE(v_emprow.empno || '-' || v_emprow.ename || '-' ||
                                  v_emprow.job );
END;
--------------------------------------------------------------------------
--제어문
/*
 if(조건) then
 		실행문장;
 end if;

 if(조건) then
 		실행문;
 elseif(조건) then
    실행문

*/
DECLARE
	vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vdeptno emp.deptno%TYPE;
  vname  VARCHAR2(20) := NULL;
BEGIN
	SELECT empno, ename, deptno
  	INTO vempno, vename, vdeptno
  FROM EMP
  WHERE empno = 7788;

  IF(vdeptno =10) THEN vname :='ACCOUNT';
  	ELSIF(vdeptno = 20) THEN vname := 'IT';
  	ELSIF(vdeptno = 30) THEN vname := 'SALES';
  	ELSIF(vdeptno = 40) THEN vname := 'MARKTING';
  END IF;
   DBMS_OUTPUT.PUT_LINE('당신의 직종은 : ' || vname);
END;

--------------------------------------------------------------------------
DECLARE
	vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vsal      emp.sal%TYPE;
BEGIN
	SELECT empno, ename, sal
  	INTO vempno , vename, vsal
  FROM EMP
  WHERE empno=7788;

  IF (vsal > 2000) THEN
  		  DBMS_OUTPUT.PUT_LINE('당신의 급여 : BIG'  || vsal);
  ELSE
  			 DBMS_OUTPUT.PUT_LINE('당신의 급여 : SMALL'  || vsal);
  END IF;

END;

--SET VERIFY ON/OFF :
--SQL명령어나 PL/SQL에서 &를 이용한 치환 변수등을 사용할 때
-- 치환되기 전 후의 자세한 값을 보일 건지의 여부를 결정 한다. 기본값은 ON 이다.

--------------------------------------------------------------------------
--CASE 문
DECLARE
	vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vdeptno emp.deptno%TYPE;
  v_dname VARCHAR2(10);
BEGIN
	  SELECT empno ,ename, deptno
    	INTO vempno, vename, vdeptno
    FROM EMP
    WHERE empno=7788;
    /*
    v_dname := CASE vdeptno
                    	WHEN 10 THEN 'ACCOUT'
                    	WHEN 20 THEN 'RESEARCH'
                    	WHEN 30 THEN 'SALES'
                    	WHEN 40 THEN 'OPERATIONS'
    								END;
   */
    v_dname := CASE
                    	WHEN  vdeptno = 10 THEN 'ACCOUT'
                    	WHEN  vdeptno in(20,30) THEN 'RESEARCH'
                    	WHEN  vdeptno =40 THEN 'SALES'
                    	ELSE 'NOT'
    								END;
	DBMS_OUTPUT.PUT_LINE(vempno || ' ' || vename || ' ' || vdeptno || ' ' || v_dname);
END;
--------------------------------------------------------------------------
--반복문
--basic loop
--LOOP
--	문장;
--	EXIT[조건];
--END LOOP

DECLARE
	n NUMBER := 0;
BEGIN
		LOOP
			 DBMS_OUTPUT.PUT_LINE(n);
       n := n + 1;
       EXIT WHEN n > 5;
    END LOOP;
END;

--while
--WHILE 조건 LOOP
--	문장
--END LOOP;

DECLARE
	num  NUMBER := 0;
BEGIN
	WHILE num < 6 LOOP
  		DBMS_OUTPUT.PUT_LINE(num);
      num := num + 1;
  END LOOP;

END;

--for (java for)
BEGIN
		FOR i IN 0..10 LOOP
    	DBMS_OUTPUT.PUT_LINE(i);
    END LOOP;
END;

DECLARE
	total NUMBER := 0;
BEGIN
	FOR i IN 1..10 LOOP
		total := total + i;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('합계:' || total);
END;

--continue (11g)
DECLARE
	total NUMBER := 0;
BEGIN
	FOR i IN 1..10 LOOP
    CONTINUE WHEN i > 5;
		total := total + i;
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('합계:' || total);
END;

--------------------------------------------------------------------------
--지금까지 집합 단위의 데이터 처리
--[CURSOR]
--1.행단위로 데이터를 처리하는 방법을 제공
--2. 여러건의 데이터를 처리하는 처리하는 방법을 제공 (한 건이상의  row가지고 놀기)
/*
DECLARE
             CURSOR cursor_name IS statement; -- 커서 선언
             BEGIN
                OPEN cursor_name; -- 커서 열기
                          --커서로부터 데이터를 읽어와 변수에 저장
                FECTCH cur_name INTO variable_name;
                CLOSE cursor_name; --커서 닫기
             END;
*/

DECLARE
	vempno emp.empno%TYPE;
  vename emp.ename%TYPE;
  vsal      emp.sal%TYPE;
CURSOR c1
IS SELECT empno, ename , sal FROM EMP WHERE  deptno =30;
BEGIN
		OPEN c1; --커서가 가지고 있는  select 문 실행
  LOOP
     --Memory 상에 있는 행에 접근
     -- 7788 , king , 100
     -- 7902, smith ,200
  		FETCH c1 INTO vempno, vename, vsal;
			EXIT WHEN c1%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(vempno || '  ' || vename || '  ' || vsal);
  END LOOP;
  CLOSE c1;
END;
--------------------------------------------------------------------------
--위 표현을 조금 간결하게
---- java -> for(dept d : deptlist) { d.deptno  }
DECLARE
		CURSOR emp_curr
		IS SELECT empno, ename FROM EMP;
BEGIN
		FOR  emp_record IN emp_curr --emp_record 변수가 행전체 받아 낸다
    					LOOP
              EXIT WHEN emp_curr%NOTFOUND;
    	      	DBMS_OUTPUT.PUT_LINE(emp_record.empno || ' ' || emp_record.ename );
    END LOOP;
END;


DECLARE
		vemp  emp%ROWTYPE;
		CURSOR emp_curr
		IS SELECT empno, ename FROM EMP;
BEGIN
		FOR  vemp  IN emp_curr --emp_record 변수가 행전체 받아 낸다
    					LOOP
              EXIT WHEN emp_curr%NOTFOUND;
    	      	DBMS_OUTPUT.PUT_LINE(vemp.empno || ' ' || vemp.ename );
    END LOOP;
END;
--------------------------------------------------------------------------
--지금까지 실행하면 결과 보고 끝
--지금까지 배운 것을 영속적으로 가지고 싶다
--객체로서  저장하고 필요시 	불러내서 사용
--( create view .....)
--ORACLE SUBPROGRAM

--1. 저장 프로시져 (procedure)
--MS-SQL에서는 필수 사항으로 (NET(c# , ASP.NET) 연동시 의무적으로 강제
--[자주 사용되는 쿼리문]을 [모듈화] 시켜서 [필요할 때마다 호출 : parameter 사용]
--해서 사용하는 방법
--프로시져 또는 사용자 함수안에서 프로그램적인 제어가 가능
CREATE  OR REPLACE PROCEDURE usp_emplist
IS
	 BEGIN
   		UPDATE EMP
      SET job = 'ITTT'
      WHERE deptno =30;
  END;

--실행방법
--EXEC
EXECUTE usp_emplist
ROLLBACK;

--APP 입장에서 procedure 사용했을 경우 장점
--emp.java => String sql = "update EMP  set sal=0 where empno=1000"
--emp.java 구문을 실행한다는 것은 sql 변수에 담긴 문자열을 DB보내서 DB실행
--하고 실해 결과를 resultset 으로  java에서 반환 받는 형태

--procedure
--emp.java => String sql = "usp_emplist"
--emp.java 구문을 실행한다는 것은 sql 변수에 담긴 문자열을 DB보내서 DB실행
--하고 실해 결과를 resultset 으로  java에서 반환 받는 형태

--1. 보안 (실행구문 자체 노출되지 않는다)
--2.성능 (실행 단계에서 얻는 이점)
--3.유지보수(select ... 630본 똑같은 쿼리가 30개 사용 ....)
    --컬럼이 하나 추가

CREATE  OR REPLACE PROCEDURE usp_getEmpListByempno
( vempno emp.empno%TYPE )
IS
		BEGIN
    	UPDATE EMP
      SET sal = 0
      WHERE empno=vempno;
    END;

EXEC usp_getEmpListByempno(7788);
-------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE usp_getEmplist
(vempno emp.empno%TYPE)
IS
		--내부 변수
    vename emp.ename%TYPE;
    vsal      emp.sal%TYPE;
BEGIN
		SELECT ename, sal
    	INTO vename, vsal
    FROM EMP
    WHERE empno= vempno;
		DBMS_OUTPUT.PUT_LINE('이름은 ' || vename || ' 입니다');
    DBMS_OUTPUT.PUT_LINE('급여는  ' || vsal || ' 입니다');
END;

EXECUTE usp_getEmplist(7902);
------------------------------------------------------------------------
--프로시져에서 사용되는 두가지 parameter 유형
--1. input parameter (default) 반드시 실행할때 값을 받아야 한다
--2.output parmeter 명시해서 output 써주고 입력값을 넣지 않아도 된다

CREATE OR REPLACE PROCEDURE App_Get_Emplist
(
		vempno IN emp.empno%TYPE,
    vename OUT emp.ename%TYPE,
    vsal      OUT emp.sal%TYPE
)
IS
		BEGIN
    		SELECT ename , sal
        INTO vename, vsal
        FROM EMP
        WHERE empno = vempno;
    END;
--오라클에서 실행해보기 ................................................................................................---------------
DECLARE
	  out_name emp.ename%TYPE;
    out_sal     emp.sal%TYPE;
BEGIN
	  App_Get_Emplist(7902,out_name,out_sal);
    DBMS_OUTPUT.PUT_LINE(out_name || ' ' || out_sal);
END;
--------------------------------------------------------------------------
--프로시져에서 cursor 사용하기 (한 건 이상의 데이터 처리하기)
CREATE  OR REPLACE PROCEDURE Cusor_Getlist
(p_deptno IN emp.deptno%TYPE )
IS
   vemp	emp%ROWTYPE;
	CURSOR cur_list
	IS SELECT empno, ename , job , sal
     FROM EMP
     WHERE deptno=p_deptno;
  BEGIN
  	FOR vemp IN cur_list
    	LOOP
       	EXIT WHEN cur_list%NOTFOUND;
    		DBMS_OUTPUT.PUT_LINE(vemp.empno || '-' || vemp.ename || '-' || vemp.sal);
      END LOOP;
  END;

--실행
EXECUTE Cusor_Getlist(30);
--------------------------------------------------------------------------
--사용자 정의 함수---------------------------------------------------------
--------------------------------------------------------------------------
--SELECT SUM() , MAX()....
--To_char() To_number() To_date()
--parameter 가지고
--return Type

--사용방법 : 기존의 함수

CREATE OR REPLACE FUNCTION F_max_sal
(s_deptno emp.deptno%TYPE )
RETURN NUMBER
IS
  --지역변수 선언
	max_sal  emp.sal%TYPE;
BEGIN
	SELECT MAX(sal)
  	INTO max_sal
  FROM EMP
  WHERE deptno =s_deptno;
  RETURN max_sal;
END;
--사용자 정의 함수 사용하기------------------------
SELECT MAX(sal) ,F_MAX_SAL(30) FROM EMP;
SELECT F_MAX_SAL(30) AS "SAL" FROM dual;
-------------------------------------------------

CREATE OR REPLACE FUNCTION F_CallName
(vempno emp.empno%TYPE)
RETURN VARCHAR2
IS
	v_name emp.ename%TYPE;
BEGIN
	SELECT ename || ' 님'
		INTO v_name
  FROM EMP
  WHERE empno = vempno;
  RETURN v_name;
END;
--실행-------------------------------------------------------------------
SELECT F_CallName(7788) FROM dual;
SELECT empno, ename,F_CALLNAME(7788) , sal
FROM EMP WHERE empno=7788;
-----------------------------------------------------------------------
--문제
--parameter 사번
--return 부서이름
--함수 이름 select  f_getdname(7788) from dual;
--내부에 사용되는 쿼리는 (subquery 사용)

CREATE OR REPLACE FUNCTION f_get_dname
(vempno emp.empno%TYPE)
RETURN VARCHAR2
IS
	v_dname dept.dname%TYPE;
BEGIN
			SELECT dname
      	INTO v_dname
      FROM dept
      WHERE deptno = (SELECT deptno FROM EMP WHERE empno=vempno);
  RETURN v_dname;
END;
--실행
SELECT empno , ename , f_get_dname(7902)
FROM EMP WHERE empno=7902
--활용하기
SELECT empno , ename , f_get_dname(empno)
FROM EMP  WHERE deptno=30
--------------------------------------------------------------------------
--[패키지 : PACKAGE]

--1. 패키지의 사전적인 의미는 꾸러미이다.

--2. [관련 있는 프로시저를 보다 효율적으로 관리]하기 위해서 [패키지 단위로 배포]할 때
--유용하게 사용된다.

--3. 패키지는 패키지 [선언(명세부)]과 패키지 [몸체 선언(몸체부)]

--인사관련 프로시져 (인사 패키지 묶어서 관리)

--두 가지 모두를 정의해야 한다.
/*
CREATE [ OR REPLACE ] PACKAGE package_name
IS
    PROCEDURE procedure_name1;
    PROCEDURE procedure_name2;
END;
/
CREATE [ OR REPLACE ] PACKAGE BODY package_name
IS
    PROCEDURE procedure_name1
    IS
     ....
    END;
END;



EXECUTE [패키지명].[프로시저명]
*/

--선언부
CREATE OR REPLACE PACKAGE emp_total
AS
		PROCEDURE emp_sum;
    PROCEDURE emp_avg;

END emp_total;

--구현부(몸체)
CREATE OR REPLACE PACKAGE BODY  emp_total
AS
	 PROCEDURE emp_sum
   IS
        CURSOR emp_total_sum
        IS SELECT COUNT(*) , SUM(NVL(sal,0)) FROM EMP;
        total_sum NUMBER;
        total_num NUMBER;
        BEGIN
          OPEN emp_total_sum;
          FETCH  emp_total_sum
          INTO total_num , total_sum;
          DBMS_OUTPUT.PUT_LINE('총인원 : ' || total_num || ' 급여합 : ' || total_sum);
          CLOSE emp_total_sum;
        END emp_sum;

   PROCEDURE emp_avg
   IS
   		CURSOR emp_total_avg
      IS SELECT COUNT(*) , AVG(NVL(sal,0)) FROM EMP;
      total_num NUMBER;
      total_avg NUMBER;
      BEGIN
      	OPEN emp_total_avg;
        FETCH emp_total_avg
        INTO total_num , total_avg;
        DBMS_OUTPUT.PUT_LINE('총인원 : ' || total_num || ' 급여평균 : ' || total_avg);
        CLOSE emp_total_avg;

      END emp_avg;
END emp_total;

--실행하기
EXECUTE emp_total.emp_sum
EXECUTE emp_total.emp_avg
--------------------------------------------------------------------------
--[트리거 : Trigger]
--트리거(trigger)의 사전적인 의미는 방아쇠나 (방아쇠를) 쏘다, 발사하다,
--(사건을) 유발시키다라는 의미가 있다.

--입고    재고     출고
--입고 INSERT
--재고 INSERT
--위험부담 : lock


--PL/SQL에서의 트리거 역시 방아쇠가 당겨지면 자동으로 총알이 발사되듯이 어떠한
--이벤트가 발생하면 그에 따라 다른 작업이 자동으로 처리되는 것을 의미한다.
/*
트리거란 특정 테이블의 데이터에 변경이 가해졌을 때 자동으로 수행되는
저장 프로시저라고 할 수 있다.
앞서 배운 저장 프로시저는 필요할 때마다 사용자가 직접
 EXECUTE 명령어로 호출해야 했다.
하지만 트리거는 이와 달리 테이블의
데이터가 INSERT, UPDATE, DELETE 문에 의해 변경되어질 때
[ 자동으로 수행되므로 이 기능을 이용하며 여러 가지 작업 ] 을 할 수 있다.
이런 이유로 트리거를 사용자가 직접 실행시킬 수는 없다.


--BEFORE : 테이블에서 DML 실행되기 전에 트리거가 동작
--AFTER :  테이블에서 DML 실행후에 트리거 동작

CREATE TRIGGER trigger_name
timing[BEFORE|AFTER] event[INSERT|UPDATE|DELETE]
ON table_name
	[FOR EACH ROW]
	[WHEN conditions]
BEGIN
	statement  --부분이 실행
END



*/

--실습 COPYEMP 대상으로
CREATE OR REPLACE TRIGGER tri_01
AFTER INSERT
ON copyemp
	BEGIN
  	DBMS_OUTPUT.PUT_LINE('신입사원 입사');
  END;


CREATE OR REPLACE TRIGGER tri_02
AFTER UPDATE
ON copyemp
	BEGIN
  	DBMS_OUTPUT.PUT_LINE('데이터 수정');
  END;


  CREATE OR REPLACE TRIGGER tri_03
AFTER DELETE
ON copyemp
	BEGIN
  	DBMS_OUTPUT.PUT_LINE('데이터 삭제');
  END;

INSERT INTO COPYEMP(empno, ename)
VALUES(300,'기황후');

UPDATE COPYEMP
SET ename ='아무개'
WHERE empno=300;


DELETE FROM COPYEMP WHERE empno=300;
COMMIT;

--문장 트리거 : 영향 받는 행이 전혀 없더라도 트리거가 한번은 실행
--문장 트리거는 트리거 작업이 영향을 받는 행의 데이터 또는 트리거
--이벤트 자체에서 제공하는 데이터에 종속되지 않는 경우 유용
--ex) 로그 기록 등

--행 트리거 => for each row
--테이블이 트리거 이벤트의 영향을 받을 때마다 실행되고
--트리거의 영향을 받는 행이 없을 경우는 실행되지 않습니다
--이벤트 자체에서 제공하는 데이터에 종속적일 경우  유용

--PL-SQL 엔진 제공하는 두개 데이터 구조
--:OLD => 트리거가 처리한 레코드의 원래 값을 저장  MS-SQL( deleted )
--:NEW => 새값을 포함                                   MS-SQL( inserted )

--------------------------------------------------------------------------
CREATE TABLE tri_order
(
	NO NUMBER,
  ord_code VARCHAR2(10),
  ord_date DATE
);

select * from tri_order;

CREATE OR REPLACE TRIGGER trigger_order
BEFORE INSERT
ON tri_order
BEGIN
		IF(TO_CHAR(SYSDATE,'HH24:MI') NOT  BETWEEN '14:00' AND '16:00') THEN
    		RAISE_APPLICATION_ERROR(-20000 ,'허용시간 오류');
    END IF;
END;

SELECT TO_CHAR(SYSDATE,'HH24:MI') FROM DUAL;
INSERT INTO tri_order   VALUES(1,'p100',sysdate);
INSERT INTO tri_order   VALUES(2, 'p100', '20/4/23 10:30:00');  --

COMMIT;
SELECT * FROM tri_order;
--------------------------------------------------------------------------
--행(for each row)
DROP TRIGGER trigger_order;

CREATE OR REPLACE TRIGGER trigger_order2
BEFORE INSERT
ON tri_order
FOR EACH ROW
BEGIN
		IF(:NEW.ord_code) NOT IN('p100', 'p200') THEN
    	    RAISE_APPLICATION_ERROR(-20001 ,'제품코드 오류');
    END IF;
END;

INSERT INTO tri_order  VALUES(1,'p200',sysdate);
INSERT INTO tri_order  VALUES(1,'p300',sysdate);
COMMIT;

SELECT * FROM tri_order;

--------------------------------------------------------------------------
--입고
CREATE TABLE t_01
(
   NO number,
   pname VARCHAR2(20)
);

--재고
CREATE TABLE t_02
(
   NO number,
   pname VARCHAR2(20)
);

select * from t_01;
select * from t_02;
--insert Trigger
CREATE OR REPLACE TRIGGER insert_t_01
AFTER INSERT
ON t_01
FOR EACH ROW
BEGIN
	INSERT INTO t_02(NO,pname)  VALUES(:NEW.NO  , :NEW.pname);
END;

INSERT INTO t_01 VALUES(1,'computer');
INSERT INTO t_01 VALUES(2,'notebook');

SELECT * FROM t_01;
SELECT * FROM t_02;
COMMIT;

--update Trigger
CREATE OR REPLACE TRIGGER update_t_01
AFTER UPDATE
ON t_01
FOR EACH ROW
BEGIN
       UPDATE t_02  SET pname = :NEW.pname   WHERE NO = :OLD.NO;
END;

UPDATE t_01 SET pname = 'TV' WHERE NO =1;

SELECT * FROM t_01;
SELECT * FROM t_02;
COMMIT;

--delete Trigger
CREATE OR REPLACE TRIGGER delete_t_01
AFTER DELETE
ON t_01
FOR EACH ROW
BEGIN
    DELETE FROM t_02
    WHERE NO = :OLD.NO;
END;

DELETE FROM t_01 WHERE no=1;

SELECT * FROM t_01;
SELECT * FROM t_02;
COMMIT;


