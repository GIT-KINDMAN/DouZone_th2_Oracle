--  PL/SQL (Procedural Language) ------------
/*형식>
create [or replace] procedure 프로서저명 (
    변수이름 in 데이터타입, 변수이름 in 데이터타입,..
)
is
   변수이름 데이터타입;   -- 프로시저 내에서 사용할 변수
Begin
     실행(필수)
End;
------------------------
실행 형식>
execute 프로시저명;
exec 프로시저명(값, 값,...);
*/

declare
    vno  emp2.empno%type;
    vname varchar2(20);
begin
    select empno, name into vno, vname 
        from emp2
        where empno = &empno;   -- &empno 통해서 값을 입력 받기
        dbms_output.put_line('입력된 사번 : ' || vno || ' <---> ' || vname);
end;
-----------------------------------------
select * from emp2;

create or replace PROCEDURE p_test(      -- 프로시저 생성 
            name in VARCHAR2,
            su in number
) 
is
begin
    DBMS_OUTPUT.PUT_LINE(name || '님 점수는 : ' || su );
end;

exec p_test('김연아', 99);
----------------------------------------------------
select * from userlist;
drop table userlist;
create table userlist (
    id varchar2(10),
    name varchar2(20),
    age number,
    addr varchar2(50)
);
desc userlist;
    
create or replace PROCEDURE p_userlist(      -- 프로시저 생성 
    id in userlist.id%Type := 'kingsmile',
    name in userlist.name%TYPE default '도연이',
    age in userlist.age%type := 10,
    addr in userlist.addr%type := null
) 
is
begin
    insert into userlist values(id, name, age, addr);
    DBMS_OUTPUT.PUT_LINE('insert 정보는 : ' ||id||' ' ||name||' ' ||age||' '||addr );
end;
-------------------------------------------------------------
exec p_userlist('yuna', '김연아', 20, '군포');  -- 전체 필드 추가    
exec p_userlist;  -- default value input
exec p_userlist(id=>'박보검', age=>33);  -- 원하는 필드값만 추가 가능

select * from userlist;
------------------------------------
declare
    su number := 90;
begin
    DBMS_OUTPUT.PUT_LINE('Program started. ');
    if( su >= 90 ) then
        DBMS_OUTPUT.PUT_LINE('A');
    elsif( su >= 80 ) then
        DBMS_OUTPUT.PUT_LINE(su || ' B');
    end if;
    DBMS_OUTPUT.PUT_LINE('Program end. ');
end;
---------------------------------------------
declare
    su number := 90;
    grade varchar2(2);
begin
    if( su >= 90 ) then  grade :='A';
    elsif( su >= 80 ) then  grade :='B';
    elsif( su >= 70 ) then  grade :='C';
    elsif( su >= 60 ) then  grade :='D';
    else  grade :='F';
    end if;
    DBMS_OUTPUT.PUT_LINE('당신의 : '||su ||'점 ==> ' ||grade ||'학점입니다.');
end;    
------------------------------------------------
/*
for 변수이름 in 시작..끝 loop
    반복실행;
end loop */

begin
    for i in 1..100 loop
        if mod(i, 2) = 0 then DBMS_OUTPUT.PUT_LINE( i ||' ==> even!!');
        else DBMS_OUTPUT.PUT_LINE( i ||' ==> odd!!');
        end if;
    end loop;
end;    
--------------------------------------
begin
    for su_list in ( 
        select 1 as num from dual
        union all
        select 2 as num from dual
        union all
        select 3 as num from dual
        union all
        select 4 as num from dual
    )
    loop
        if mod(su_list.num, 2) = 0 then
            DBMS_OUTPUT.PUT_LINE( su_list.num ||' ==> even!!');
        else DBMS_OUTPUT.PUT_LINE( su_list.num ||' ==> odd!!');
        end if;
    end loop;
end;   
--------------------------------------------------------
/*
WHILE 조건식 LOOP
    실행문장;
    증감식;
END LOOP;    */

declare
    su number := 0;   -- 초기화
begin
    while su < 50 loop
        su := su + 1;  -- 증감식
        DBMS_OUTPUT.PUT_LINE('현재 값은 '|| su);
    end loop;
end;
-------------------------------------------------------------
/*
ex) 사용자 입력(단수)를 받아 구구단 출력
[힌트] DECLARE vdan NUMBER(1) :=&dan;
*/
declare
    dan number(1) := &inputDan;
begin
    for i in 1..9 loop
        DBMS_OUTPUT.PUT_LINE(dan ||'*'||i||'='|| i*dan);
    end loop;
end;
------역순으로 출력( REVERSE )----------------------------------------
declare
    dan number(1) := &inputDan;
begin
    for i in REVERSE 1..9 loop
        DBMS_OUTPUT.PUT_LINE(dan ||'*'||i||'='|| i*dan);
    end loop;
end;
------프로시저 찾기---------------------------------------------    
SELECT * FROM user_objects
    WHERE LOWER(object_type)='procedure' ;   -- 해당 계정이 갖고 있는 프로시저 리스트 보기
    
SELECT text FROM user_source
    WHERE LOWER(NAME) = 'p_test'  ;  -- p_test 프로시저의 만들어진 내용(텍스트) 보기
---------------------------------------------------------------------    
declare
    v_emprow emp%rowtype;
begin
    for i in 1..5 loop
        select * into v_emprow 
            from ( select * 
                    from (select * from emp order by sal desc )
                     where rownum <= i  ) where rownum <= 5;
         DBMS_OUTPUT.PUT_LINE(v_emprow.empno||' '||v_emprow.ename||' '||v_emprow.sal);   
    end loop;
end;
---------------------------------------   
select * from emp order by sal desc;    

 select sal, rownum
            from ( select * 
                    from (select * from emp order by sal desc )
                     where rownum <= i  )  where rownum <= 5;
--------------------------------------------------
create or replace procedure p_empMaxSal
is
    v_emprow emp%rowtype;
    begin
        for i in 1..5 loop
            select * into v_emprow 
                from ( select * from (select * from emp order by sal desc )
                         where rownum <= i  order by sal, ename ) where rownum =1 order by sal asc;
             DBMS_OUTPUT.PUT_LINE(v_emprow.empno||' '||v_emprow.ename||' '||v_emprow.sal);   
        end loop;
    end;
---------------------------------------------------------------  
exec p_empmaxsal;    
---------------------------------------------------------------   
desc emp;
insert into emp(empno, ename, sal) values(8888,'DoYeon', 5500);
 -- 학생 테이블에서 키가 제일 큰 순서로 3명 출력하는 프로시저 만들기
select * from student;
create or replace procedure p_stdMaxHeight
is
    v_stdrow student%rowtype;
    begin
        for i in 1..3 loop
            select * into v_stdrow 
            from ( select * 
                    from (select * from student order by height desc )
                     where rownum <= 3  order by height, name )where rownum = 1 order by height asc; 
             DBMS_OUTPUT.PUT_LINE(v_stdrow.studno||' '||v_stdrow.name||' '||v_stdrow.height);   
        end loop;
    end;
---------------------------------------------------------------   
exec p_stdMaxHeight;    
---------------------------------------------------------------   
select * from student order by height desc;
-----------------------------------------------------------------
create procedure t_testt
is
    v_studentrow student%rowtype;
    begin
        for i in 1..3 loop
            select * into v_studentrow
                from ( select *
                    from (select * from student order by height desc )
                    where rownum <= i order by height, name) where rownum=1;
            dbms_output.put_line(v_studentrow.name || v_studentrow.height);
        end loop;
end;

exec t_testt;
----------------------------------------------------------
create or replace procedure p_outTest (
    name out varchar2, age out varchar2
)
is
begin
    name := '이나영3';
    age := 33;
    dbms_output.put_line('out을 이용한 프로시저 완료');
end;
----------------------------------
variable v_name varchar2(20);
variable v_age varchar2(3);

exec p_outTest(:v_name, :v_age);
print v_name;
print v_age;

print (v_name, v_age); -- ???? 
------------------------------------------
create or replace procedure p_out( x in out number )
as
begin
    dbms_output.put_line( 'x = ' || x );
    x := 33;
end;

VARIABLE x VARCHAR2(25);
exec p_out(:x);
print x;

exec p_out(:x);

VARIABLE y VARCHAR2(25);
exec p_out(:y);
print y;
------------------------------------------------
create or replace procedure p_emp_job( v_job in emp.job%type )
is
    name emp.ename%type;
    empno emp.empno%type;
    sal emp.sal%type;
--  cursor c_name is select empno, ename, sal from emp where job=upper(v_job) or job=lower(v_job);   -- 1.커서선언
    cursor c_name is select empno, ename, sal from emp where job in(upper(v_job), lower(v_job));   -- 1.커서선언
begin
    open c_name;   -- 2.커서열기
    dbms_output.put_line('------------------------------');
    loop
        fetch c_name into empno, name, sal;  -- 3.커서로부터 데이터 읽기
        exit when c_name%NOTFOUND; -- 찾을 데이터가 없으면 반복문 탈출한다.
        dbms_output.put_line(name ||' '||empno||' '||sal||' ' ||v_job);
    end loop;
    dbms_output.put_line('result recode count ==> ' || c_name%rowcount);
     
    close c_name;  -- 4.커서닫기
end;
--------------------------------------------------------------
exec p_emp_job('manager');  -- 레코드 대소문자 구분함
exec p_emp_job(upper('manager'));

select * from emp where job ='manager';
---------------------------------------------------






