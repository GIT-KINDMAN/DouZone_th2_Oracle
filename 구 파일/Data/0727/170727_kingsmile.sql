------------- PL/SQL (�������ν���) -------------------------------
drop PROCEDURE p_test;

create procedure  p_test
is
  BEGIN
    DBMS_OUTPUT.PUT('Oracle ������ �� ������4556677');
    DBMS_OUTPUT.PUT_LINE('Oracle ������ �� ������');
  END;
--------------------------------------------------------------
exec p_test;
-------------------------------------------------------------
create procedure  p_test(name in varchar2)
is
  BEGIN
     DBMS_OUTPUT.PUT_LINE(name || '�� ���� �հ��Դϴ�.');
  END;
--------------------------------------------------------------
exec p_test('�̵���');
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
  name in userlist.name%type default '������' ,
  age in userlist.age%type :=10 ,
  addr in userlist.addr%type := null
)
is
  Begin
    insert into userlist values(id, name, age, addr );
    dbms_output.put_line('insert ������ ' || id || name || age || addr );
  End;
--------------------------------------------------------------
exec p_userlist('haapy', '�ں���', 20, '����');  -- ��ü �ʵ� �߰�
exec p_userlist;   -- default data input 
exec p_userlist(id=>'�嵿��' , age=>50); --���ϴ� �ʵ尪�� �߰� ����
--------------------------------------------------------------
select * from userlist;

-- ��Į�󼭺����� vs �ζ��κ� vs �������� ���� ����Ʈ
-- http://seohc.tistory.com/87

--����1] �������ν��� emp ���̺��� �޿� ���� 5������ ����ϴ� ���ν��� �����
select sal from emp where rownum=1;

select *
  from (select * from emp order by sal )    -- �ζ��� ��  
  where rownum=1 ;     -- 

select  x.*
  from (select * from emp) x   -- �ζ��� ��  
  where rownum=1 ;  
  
select x.*
  from emp x, dept2 d   -- �ζ��� ��  
  where rownum=1 ;

--cf)
select top 1 sal from emp;  -- top �� MSSQL�� �ִ� ���

-----���� ���� ã��???-------------------------------------------------------
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
-----���1. ---------------------------------------------------
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
----���2. ----------------------------------------------------
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
        DBMS_OUTPUT.put_line('7788���� �̸��� ' || e_name || ' �޿��� ' || e_sal );
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
-- 1~10���� ���
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
-- 1~10������ ¦�� ���
Begin
  for i in 1..10 loop
     --dbms_output.put_line( mod(i, 2) );
     if( mod( i, 2 ) = 0 ) then DBMS_OUTPUT.put_line(i);
     end if;
  end loop;
End;
-------------------------------------
-- 2�� ����ϱ�
-- BASIC LOOP�� ������(2�� ����ϱ�)
DECLARE   -- ����(����)
    dan NUMBER :=2;
    i NUMBER :=1;
BEGIN  -- �ʼ� 
    loop
    dbms_output.put_line(dan || '*' ||i|| '=' || (dan*i));
    -- 2 * i = 2
    i:=i+1;
    IF i > 9 THEN exit;  
    END IF;
  END loop;
END;  -- �ʼ�
-------------------------------------------------------------------
-- FOR LOOP�� ������(2��) ����ϱ�
DECLARE
    dan NUMBER := 2;
    i NUMBER :=1;
BEGIN
    FOR i IN 1..9 loop
      dbms_output.put_line(dan||'*'||i||'='||(dan*i));
    END loop;
END;
---------------------------------------------------------------------
-- WHILE LOOP�� ������ (2��) ����ϱ�
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
-- ����� �Է�(�ܼ�)�� �޾� ������ ���
-- &�� ������Է°��� ������ ����ϴ� Ű���� . &�����̸�
DECLARE vdan NUMBER(1) :=&dan;
    BEGIN
        FOR i IN 1.. 9 loop
            DBMS_output.put_line(vdan || ' * ' || i ||'='|| (vdan * i) );
        END LOOP;
     END;
     
-----------------------------------------------------------
--������ ��ü ��� ( 2�� �ݺ��� )
    BEGIN
        FOR i IN 1 .. 9 LOOP
            FOR j IN 2 .. 9 LOOP
                dbms_output.put( j || ' * ' || i ||'='|| ( i * j ) ||'    ');
            END LOOP;
                dbms_output.put_line(' ');
        END LOOP;
    END;
     