 CREATE OR REPLACE PROCEDURE usp_EmpList
(
	p_sal IN number,
    p_cursor OUT SYS_REFCURSOR --APP ����ϱ� ���� Ÿ��
)
IS
	BEGIN
  			OPEN p_cursor
        FOR
        		 SELECT empno, ename, sal FROM EMP WHERE sal > p_sal;

  END; 




------ �������ν��� ã�� -------------------------------
select * from user_objects
  where lower(object_type)='procedure' ;
------- �������ν����� �ۼ��� SQL�� ���� -------------------
select text from user_source
  where lower(name) = '�������ϴ� ���ν�����' ;
  
select text from user_source
  where lower(name) = 'p_test' ;
---------------------------------------------------------------------
create or replace procedure p_outTest (
    name out varchar2,  age out number
)
is
  begin
      name := '�̳���';
      age := 20;
      dbms_output.put_line('out�� �̿��� ���ν��� �ۼ�');
  end;
------------------------------------------------------------
variable v_name varchar2(30);
variable v_age number;    -- �̺κ� ������

exec p_outTest( :v_name, :v_age );
print v_name;
print v_age;
--------------------------------------------------------------


