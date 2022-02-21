-------------- View ------------------------------------------------
select * from PROFESSOR;
select * from emp;

create view  v_emp
as
  select empno, ename, deptno from emp ;
  
select * from v_emp;
 
-- emp ���̺� �����ϸ� v_emp ?
-- v_emp ���̺� �����ϸ� emp ?

--����5] 30�� �μ� ������� ����, �̸�, ������ ��� view ���̺� ����� (emp)
drop view v_emp30 ;

create view v_emp30
as
  select job "����", ename "��� �̸�" , sal "�޿�"
      from emp
      where deptno = 30;
      
select * from v_emp30;

-------------------------------------------------------
--����6] 30�� �μ� ������� ����, �̸�, ������ ��� view �� ����µ�, �÷����� ����, ����̸�, ����
-- ���� Alias�� �ְ� ������ 300���� ���� ����鸸 �����Ͻÿ�.
drop view v_emp30_2;

CREATE VIEW v_emp30_2 
AS
  SELECT job "����" , ename "����̸�", sal "����"
  		FROM emp
      WHERE sal > 2000;

SELECT * FROM v_emp30_2;


--����7] �μ��� �ִ�޿�, �ּұ޿�, ��ձ޿��� ���� view�� ����ÿ�.
select avg(sal) from emp;

CREATE VIEW v_emp3
AS
	SELECT deptno "�μ�", MAX(sal) "�ִ����", MIN(sal) "�ּҿ���", ROUND(AVG(sal), 3) "��տ���"
  	FROM emp
    GROUP BY deptno 
    ORDER BY deptno ;

 SELECT * FROM v_emp3;

--����8] �μ��� ��ձ޿��� ���� view�� �����, ��ձ޿��� 2000�̻��� �μ��� ����ϵ��� �Ͻÿ�.
SELECT * FROM emp;

CREATE VIEW v_emp4 
AS
 SELECT deptno, ROUND(AVG(sal),3) "�μ����"
 		FROM emp
 		GROUP BY deptno
 		HAVING AVG(sal) > 2000 ;

 SELECT * FROM v_emp4;
 
--����9] ������ �ѱ޿��� ���� view ���̺��� �����, ����(job)�� manager�� ������� �����ϰ� 
--         �ѱ޿��� 3000�̻���  ����Ͻÿ�.
select * from emp;

 CREATE VIEW v_emp7 
 AS
    SELECT job, SUM(sal) "�ѱ޿�"
  	  FROM emp
        WHERE job <> 'MANAGER' -- WHERE job != 'MANAGER'
        GROUP BY job
        HAVING SUM(sal) > 3000 ;


 SELECT * FROM v_emp7;

-------------------------------------
select * from c_emp4;

create table copy_emp
as
  select empno, ename, mgr from emp;

select * from copy_emp;

create table copy_emp2
as
  select empno, ename, mgr from emp where 1=0;  -- ���� �Ҹ��� ���� 

select * from copy_emp2;

select * from c_emp4;
select * from copy_emp2;

insert into copy_emp2   -- ���ڵ� ����
  select empno, ename, mgr from emp where sal > 3000;

select * from copy_emp2;

-- ����] ���� ���̺��� ���̺� ������ ����� c_professor ���ο� ���̺� 
--        ����(�̸�, ����, �Ի���, �̸���, Ȩ������)�ϰ� ���ڵ� ���� �ϱ�
select * from professor;
drop table c_professor;
--------------------------------------------------------
create table c_professor
as
  select name, position, hiredate, email, hpage from professor where 1=0 ;
 ------------------------------------------------------ 
select * from c_professor;
----------------------------------------------------
insert into c_professor 
  select name, position, hiredate, email, hpage from professor;


--����10] c_emp2 ���̺��� �������� ���� c_emp22�� ���弼��
 create table c_emp22
 as
  select * from emp where 1=0;
  
select * from c_emp22;

--����11] emp ���̺��� c_emp22�� ������ 'manager'�� ����鸸 ���ڵ� �����Ͻÿ�.
 insert into c_emp22
  select empno, ename, job, sal from emp where job='MANAGER';
  
 insert into c_emp22
  select * from emp where job='MANAGER';

select * from c_emp22;

------rownum------------------------------------
select rownum, ename, sal from emp;

select rownum, rowid, ename, sal 
  from ( select * from emp order by sal );
  
--�Խ��� ��������� ����¡ ó��......

----------------------------------------------------
select *
  from DBA_SYS_PRIVS
  Where grantee= 'sys';
  
show recyclebin;  -- ���� ���̺� ��� ����
commit;
  