-------------- ���̺� ���� & ���ڵ� ���� ---------------------------------
select * from emp;
-- ����>
create table ����tableName
  as  select �ʵ��,....... from ���̺��̸�
  
create table c_emp
  as select * from emp
  
create table c_emp_20
  as select ename, job, deptno from emp where deptno=20
  
select * from c_emp;
select * from c_emp_20;

create table c_emp30
  as select empno ��ȣ, ename �̸� , job ����,  sal �޿� 
  from emp
  where deptno=30;

select * from c_emp30
drop table c_emp30;

--����1] ���� ���̺��� ���Ӱ��縸 �̾Ƽ� ���̺� �����ϱ�
create table professor2
  as select * from professor where position='���Ӱ���';
  
select * from professor2;

--����2] emp(����) ���̺��� mgr(�Ŵ�����ȣ)�� 7566���� ����� �����ؼ� ���ο� ���̺� �����ϱ�
create table emp4
  as select * from emp where mgr='7566' ;

select * from emp4;

--����>
create table ����tableName
  as select �ʵ帮��Ʈ,.....from tableName where 1=0;

create table c_emp4 
  as select * from emp where 1 = 0;
 
select * from c_emp4; 

select *
  from emp
  order by ename desc, sal desc, empno asc ;
  

select *
  from emp
  order by 2 desc, 6 desc, 1 asc ;
  
create table c_emp3
   as select empno, ename, job, sal from emp;

select * from emp;
select * from c_emp;  -- ��ü����
select * from c_emp_20;  -- ����(�μ���ȣ�� 20���� ���ڵ�)�� �°� ���̺� ����
select * from c_emp4;  -- �������� ����( ���ڵ� ���� )
select * from c_emp3;  --  empno, ename, job, sal ���ϴ� �ʵ常 ����

select * from emp
union   -- �ߺ��� ���� 
  select * from c_emp;
  
insert into c_emp values(7788, 'kingsmile', 'manager', 7777, '02/01/2017', 5000, 1000, 30 );  
  
select * from emp
union all  -- �ߺ��� ����
  select * from c_emp;


select * from c_emp3;  --  empno, ename, job, sal ���ϴ� �ʵ常 ����

select * from emp   -- �ʵ� ����, data type ��ġ���Ѿ���
union
  select * from c_emp3;


select empno, ename, job, sal from emp   -- �ʵ� ����, data type ��ġ���Ѿ���
union
  select * from c_emp3;
  
select empno, ename, job, hredate from emp   -- �ʵ� ����, data type(sal, hredate) ��ġ���Ѿ���
union
  select * from c_emp3;

--����3] c_emp_20, c_emp4 union ���?
select * from c_emp_20
union
  select ename, job, deptno from c_emp4;
  
--15> �����ȣ, �̸�, �޿� �׸��� 15%�λ�� �޿��� ������ ǥ���ϵ� 
--�÷����� New Salary�� �����Ͽ� ����϶�.

select * from emp;
select empno, ename, sal, Cast(sal*1.15 as int) as "new Salary" from emp;


select empno,  ename,  sal,  Cast(sal*1.15 as int) as [New Salary]
from emp;

--16> 15�� ������ ������ ����Ÿ���� �޿� �λ��(�� �޿����� ���� 
-- �޿��� �� ��)�� �߰��ؼ� ����϶�.(�÷����� Increase�� �϶�).

select empno,  ename,  sal,  Cast(sal*1.15 as int) as NewSalary , (Cast(sal*1.15 as int) - sal) as Increase
from emp;

--17> �� ����� �̸��� ǥ���ϰ� �ٹ� �� ���� ����Ͽ� �÷����� 
-- Months_Works�� �����ϰ�, �ٹ� �޼��� �������� ������ 
-- ������� �����Ͽ� ����϶�.


select * from emp2;

select * from emp2 where name = '�����';

select * from emp2 where pay > (select pay from emp2 where name = '�����');

select avg(pay) from emp2;

--1----------
select name from emp2 where pay <(select avg(pay) from emp2);
--2----

select * from student;

select * from department;

select name from student where deptno1 = (select deptno from department where deptno = 101);

select name, deptno1 from student, department where deptno = (select deptno1 from student where name = '������');
select name, deptno1 from student, department;

select * from emp2;

select name, position, pay from emp2 where pay > (select min(pay) from emp2 where position = '����');

select name, grade, weight from student where weight < (select min(weight) from student where grade = 4);

select name, height, grade from student where height = max(height) group by grade;

select grade, name, height from student where (grade, height) in (select grade,max(height) from student group by grade) order by grade;

select * from professor;



select ename, job, sal, d.deptno, dname
  from emp e  inner join  dept d
  on  e.DEPTNO = d.DEPTNO ;

select deptno1 from student where name = '������';

select name, dname from student s, department d where s.deptno1 = d.DEPTNO and name = '������';

select * from professor;

select p.name, p.hiredate, d.dname from professor p , department d
  where hiredate > (select hiredate from professor where name= '�۵���')
  and p.deptno = d.deptno;

select name ,grade, weight from student where weight < (select min(weight) from student where grade = 4) ;

select ename, HIREDATE, MONTH(HIREDATE) as [Months_Works]
  from emp
  order by Months_Works desc
--18> �̸��� J,A �Ǵ� M���� �����ϴ� ��� ����� �̸�(ù ���ڴ� 
-- �빮�ڷ�, ������ ���ڴ� �ҹ��ڷ� ǥ��) �� �̸� ���̸� ǥ���ϴ�
-- ������ �ۼ��ϰ� �÷� ��Ī�� ������ �־ ����϶�.


--19> ����� �̸��� Ŀ�̼��� ����ϵ�, Ŀ�̼��� å������ ���� 
-- ����� Ŀ�̼��� 'no commission'���� ����϶�.

select ename, isnull(convert(varchar(20),comm),'no commission') as comm
from emp



--20> ��� ����� �̸�,�μ���ȣ,�μ��̸��� ǥ���ϴ� ���Ǹ� �ۼ��϶�.

  
  
  
  
  
  
