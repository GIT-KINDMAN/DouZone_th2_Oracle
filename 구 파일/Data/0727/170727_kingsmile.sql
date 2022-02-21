------------- PL/SQL (저장프로시저) -------------------------------
drop PROCEDURE p_test;

create procedure  p_test
is
  BEGIN
    DBMS_OUTPUT.PUT('Oracle 시험을 잘 보세요4556677');
    DBMS_OUTPUT.PUT_LINE('Oracle 시험을 잘 보세요');
  END;
--------------------------------------------------------------
exec p_test;
-------------------------------------------------------------
create procedure  p_test(name in varchar2)
is
  BEGIN
     DBMS_OUTPUT.PUT_LINE(name || '님 시험 합격입니다.');
  END;
--------------------------------------------------------------
exec p_test('이도연');
-------------------------------------------------------------
select * from userlist;
drop table userlist;

create table userlist (
  id varchar2(10),
  name varchar2(20),
  age number,
  addr varchar2(50)
);
desc userlist;

create or replace procedure p_userlist (
  id in userlist.id%TYPE := 'doyeon' ,
  name in userlist.name%type default '도연이' ,
  age in userlist.age%type :=10 ,
  addr in userlist.addr%type := null
)
is
  Begin
    insert into userlist values(id, name, age, addr );
    dbms_output.put_line('insert 정보는 ' || id || name || age || addr );
  End;
--------------------------------------------------------------
exec p_userlist('haapy', '박보검', 20, '서울');  -- 전체 필드 추가
exec p_userlist;   -- default data input 
exec p_userlist(id=>'장동건' , age=>50); --원하는 필드값만 추가 가능
--------------------------------------------------------------
select * from userlist;

-- 스칼라서브쿼리 vs 인라인뷰 vs 서브쿼리 참고 사이트
-- http://seohc.tistory.com/87

--문제1] 저장프로시저 emp 테이블에서 급여 상위 5위까지 출력하는 프로시저 만들기
select sal from emp where rownum=1;

select *
  from (select * from emp order by sal )    -- 인라인 뷰  
  where rownum=1 ;     -- 

select  x.*
  from (select * from emp) x   -- 인라인 뷰  
  where rownum=1 ;  
  
select x.*
  from emp x, dept2 d   -- 인라인 뷰  
  where rownum=1 ;

--cf)
select top 1 sal from emp;  -- top 값 MSSQL에 있는 명령

-----문제 원인 찾기???-------------------------------------------------------
create or replace procedure p_empMaxSal
(
    out p_empno  emp.empno%type ,
    out p_ename  emp.ename%type ,
    out p_sal      emp.sal%type
)
is
  begin
      select p_empno, p_ename, p_sal
          from ( select * from emp order by sal desc )
          where rownum <= 5 ;
  end;
------------------------------------------------------------
create or replace procedure p_empMaxSal
(
     p_empno  emp.empno%type ,
     p_ename  emp.ename%type ,
     p_sal      emp.sal%type,
     P_LASTSTATEMENTBALANCE OUT FLOAT
)
is
  begin
      select  empno, ename, sal, P_LASTSTATEMENTBALANCE
          from ( select empno, ename, sal from emp order by sal desc )
          where rownum <= 5 ;
  end;
------------------------------------------------------------
exec p_empMaxSal ;
-----방법1. ---------------------------------------------------
create or replace procedure p_empMaxSal 
is
  v_emprow emp%ROWTYPE;
  Begin
    for i in 1..5 loop
      select * into v_emprow from 
        ( SELECT *
            FROM ( select * from emp order by sal desc ) 
              WHERE ROWNUM <= i ) where rownum <= 5 ;
        dbms_output.put_line(v_emprow.empno || ' ' || v_emprow.ename || ' ' || v_emprow.sal);
    end loop;
  end;
------------------------------------------------------------------------------------------
exec p_empMaxSal ;
----방법2. ----------------------------------------------------
create or replace procedure emp_top5
is
  v_emprow emp%ROWTYPE;
begin
  for i in 1..5 loop
    select * into v_emprow from 
        (select * from (select * from emp order by sal desc)
         where rownum<=i order by sal, ename) where rownum=1 order by sal asc;
    dbms_output.put_line(v_emprow.empno || ' ' || v_emprow.ename || ' ' || v_emprow.sal);
  end loop;
end;
------------------------------------------------
exec emp_top5;
-------------------------------------------
select rownum, ename, sal from emp  where rownum <= 5
  order by sal desc;
------------------------------------------------------------
select * from emp;
----------------------------------------------------------------------------------------
--create or replace procedure p_emp
--is
  declare
     e_name emp.ename%type ;
     e_sal emp.sal%type;
    Begin
        select sal, ename into e_sal, e_name from emp where empno='7839';
        DBMS_OUTPUT.put_line('7788님의 이름은 ' || e_name || ' 급여는 ' || e_sal );
    End;
-------------------------------------------------------------------------------------------
exec p_emp;
---------------------------------------------------------------------------------------------
--create or replace procedure p_emp2
--is
 declare
   data emp%rowtype;
  begin
    select * into data from emp where empno='7839';
     DBMS_OUTPUT.put_line(data.ename ||', ' || data.job ||', ' || data.mgr ||',' || data.deptno );
  end;
-------------------------------------------------------------------------------------------
exec p_emp2;
---------------------------------------------------------------------------------------------
-- 1~10까지 출력
declare
Begin
  for i in 1..10 loop
   dbms_output.put_line(i);
    --dbms_output.put( i );
  end loop;
End;
---------------------------------------------
 DECLARE i INT :=1;
  BEGIN
     loop
       DBMS_OUTPUT.put_line(i);
       i:= i+1;
     EXIT WHEN (i>10);
     END LOOP;
  END;
-----------------------------------------
--while loop
  DECLARE i INT :=1;

  BEGIN
     WHILE (i<=10) loop
         DBMS_OUTPUT.put_line(i);
         i:= i+1;
     END LOOP;
  END;
------------------------------
-- 1~10사이의 짝수 출력
Begin
  for i in 1..10 loop
     --dbms_output.put_line( mod(i, 2) );
     if( mod( i, 2 ) = 0 ) then DBMS_OUTPUT.put_line(i);
     end if;
  end loop;
End;
-------------------------------------
-- 2단 출력하기
-- BASIC LOOP로 구구단(2단 출력하기)
DECLARE   -- 선언(선택)
    dan NUMBER :=2;
    i NUMBER :=1;
BEGIN  -- 필수 
    loop
    dbms_output.put_line(dan || '*' ||i|| '=' || (dan*i));
    -- 2 * i = 2
    i:=i+1;
    IF i > 9 THEN exit;  
    END IF;
  END loop;
END;  -- 필수
-------------------------------------------------------------------
-- FOR LOOP로 구구단(2단) 출력하기
DECLARE
    dan NUMBER := 2;
    i NUMBER :=1;
BEGIN
    FOR i IN 1..9 loop
      dbms_output.put_line(dan||'*'||i||'='||(dan*i));
    END loop;
END;
---------------------------------------------------------------------
-- WHILE LOOP로 구구단 (2단) 출력하기
DECLARE 
    dan NUMBER := 2;
    i NUMBER :=1;
BEGIN
    While i <= 9 loop
       dbms_output.put_line(dan||'*'||i||'='||(dan*i));
       i:=i+1;
    END loop;
END;
--------------------------------------------------------
-- 사용자 입력(단수)를 받아 구구단 출력
-- &는 사용자입력값을 받을때 상요하는 키워드 . &공간이름
DECLARE vdan NUMBER(1) :=&dan;
    BEGIN
        FOR i IN 1.. 9 loop
            DBMS_output.put_line(vdan || ' * ' || i ||'='|| (vdan * i) );
        END LOOP;
     END;
     
-----------------------------------------------------------
--구구단 전체 출력 ( 2중 반복문 )
    BEGIN
        FOR i IN 1 .. 9 LOOP
            FOR j IN 2 .. 9 LOOP
                dbms_output.put( j || ' * ' || i ||'='|| ( i * j ) ||'    ');
            END LOOP;
                dbms_output.put_line(' ');
        END LOOP;
    END;
     