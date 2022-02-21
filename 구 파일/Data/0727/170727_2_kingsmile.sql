 CREATE OR REPLACE PROCEDURE usp_EmpList
(
	p_sal IN number,
    p_cursor OUT SYS_REFCURSOR --APP 사용하기 위한 타입
)
IS
	BEGIN
  			OPEN p_cursor
        FOR
        		 SELECT empno, ename, sal FROM EMP WHERE sal > p_sal;

  END; 




------ 저장프로시저 찾기 -------------------------------
select * from user_objects
  where lower(object_type)='procedure' ;
------- 저장프로시저가 작성된 SQL문 보기 -------------------
select text from user_source
  where lower(name) = '보고자하는 프로시저명' ;
  
select text from user_source
  where lower(name) = 'p_test' ;
---------------------------------------------------------------------
create or replace procedure p_outTest (
    name out varchar2,  age out number
)
is
  begin
      name := '이나영';
      age := 20;
      dbms_output.put_line('out을 이용한 프로시저 작성');
  end;
------------------------------------------------------------
variable v_name varchar2(30);
variable v_age number;    -- 이부분 수정함

exec p_outTest( :v_name, :v_age );
print v_name;
print v_age;
--------------------------------------------------------------


