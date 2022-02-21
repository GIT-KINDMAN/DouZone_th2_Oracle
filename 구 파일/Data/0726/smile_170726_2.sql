drop table dept;
drop table emp;

-- https://apexplained.wordpress.com/2013/04/20/the-emp-and-dept-tables-in-oracle/
select * from dept; -- 4 row
select * from emp;  -- 12 row
select * from emp, dept ;


----------- join -------------------------------
select ename, job, sal, d.deptno, dname
  from emp e  inner join  dept d
  on  e.DEPTNO = d.DEPTNO ;
  
select ename, job, sal, d.deptno, dname
  --from dept d   left join  emp e  -- ����, �����ʿ� ������ ���̺��� ��Ī�� �����غ���.
  from emp e  left outer join  dept d 
 --on d.DEPTNO = e.DEPTNO;  -- left outer join : ���ʿ� �ִ� ������ ���, ������ ��ġ�ϴ�  �����͸�,....
  on  e.DEPTNO = d.DEPTNO ;

insert into dept(deptno, loc ) values(50, 'SEOUL');
select * from dept;

select ename, job, sal, d.deptno, dname
  from dept d   right join  emp e  -- ����, �����ʿ� ������ ���̺��� ��Ī�� �����غ���.
  --from emp e  right outer join  dept d 
 on d.DEPTNO = e.DEPTNO;  -- right outer join : �����ʿ� �ִ� ������ ���, ���� ��ġ�ϴ� �����͸�,....
 -- on  e.DEPTNO = d.DEPTNO ;




select * from employee;

select * from student;

select * from professor;

desc student;

desc professor;

select s.name �л��̸�, p.name �����̸�, p.position
  from student s left join professor p 
  on s.profno = p.profno;
 
select p.name, position, deptno, p.profno, s.name studno, grade , s.deptno1
  from professor p inner join student s
  on p.profno = s.profno;
  
create table c_emp_20
  as
select ename, job, deptno from emp where deptno = 20;

select * from c_emp_20;

create table gangsa
  as
select name, position from professor where position = '���Ӱ���';

select * from gangsa;

select name from student
union
select position from professor;