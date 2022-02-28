-- PL/SQL (Procedural Language) ----------------------
/*형식>
create [or replace] procedure 프로시저명 (
    변수이름 in 데이터타입, 변수이름 in 데이터타입, ...
)
is

Begin
    실행(필수)
End;
-----------------
실행 형식>
execute 프로시저명;
exec 프로시저명(값, 값, ...);
*/

DECLARE
    vno emp2.empno%type; -- 사용할
    vname varchar2(20); -- 변수
begin
    select empno, name into vno, vname
        from emp2
        where empno = &empno; -- &empno 통해서 값을 입력 받기 (입력창 나옴. 대체 입력값)
        dbms_output.put_line('입력된 사번: ' || vno || ' <---> ' || vname")
end;
---------------------------------------
select * from emp2;
        

