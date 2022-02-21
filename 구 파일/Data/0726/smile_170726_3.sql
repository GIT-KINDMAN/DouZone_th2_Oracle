-------------- 테이블 복사 & 레코드 복사 ---------------------------------
select * from emp;
-- 형식>
create table 복사tableName
  as  select 필드명,....... from 테이블이름
  
create table c_emp
  as select * from emp
  
create table c_emp_20
  as select ename, job, deptno from emp where deptno=20
  
select * from c_emp;
select * from c_emp_20;

create table c_emp30
  as select empno 번호, ename 이름 , job 직업,  sal 급여 
  from emp
  where deptno=30;

select * from c_emp30
drop table c_emp30;

--문제1] 교수 테이블에서 전임강사만 뽑아서 테이블 생성하기
create table professor2
  as select * from professor where position='전임강사';
  
select * from professor2;

--문제2] emp(직원) 테이블에서 mgr(매니저번호)가 7566번인 사람만 추출해서 새로운 테이블 생성하기
create table emp4
  as select * from emp where mgr='7566' ;

select * from emp4;

--형식>
create table 복사tableName
  as select 필드리스트,.....from tableName where 1=0;

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
select * from c_emp;  -- 전체복사
select * from c_emp_20;  -- 조건(부서번호가 20번인 레코드)에 맞게 테이블 생성
select * from c_emp4;  -- 구조물만 복사( 레코드 제외 )
select * from c_emp3;  --  empno, ename, job, sal 원하는 필드만 복사

select * from emp
union   -- 중복행 제거 
  select * from c_emp;
  
insert into c_emp values(7788, 'kingsmile', 'manager', 7777, '02/01/2017', 5000, 1000, 30 );  
  
select * from emp
union all  -- 중복행 포함
  select * from c_emp;


select * from c_emp3;  --  empno, ename, job, sal 원하는 필드만 복사

select * from emp   -- 필드 개수, data type 일치시켜야함
union
  select * from c_emp3;


select empno, ename, job, sal from emp   -- 필드 개수, data type 일치시켜야함
union
  select * from c_emp3;
  
select empno, ename, job, hredate from emp   -- 필드 개수, data type(sal, hredate) 일치시켜야함
union
  select * from c_emp3;

--문제3] c_emp_20, c_emp4 union 결과?
select * from c_emp_20
union
  select ename, job, deptno from c_emp4;
  
--15> 사원번호, 이름, 급여 그리고 15%인상된 급여를 정수로 표시하되 
--컬럼명을 New Salary로 지정하여 출력하라.

select * from emp;
select empno, ename, sal, Cast(sal*1.15 as int) as "new Salary" from emp;


select empno,  ename,  sal,  Cast(sal*1.15 as int) as [New Salary]
from emp;

--16> 15번 문제와 동일한 데이타에서 급여 인상분(새 급여에서 이전 
-- 급여를 뺀 값)을 추가해서 출력하라.(컬럼명은 Increase로 하라).

select empno,  ename,  sal,  Cast(sal*1.15 as int) as NewSalary , (Cast(sal*1.15 as int) - sal) as Increase
from emp;

--17> 각 사원의 이름을 표시하고 근무 달 수를 계산하여 컬럼명을 
-- Months_Works로 지정하고, 근무 달수를 기준으로 오래된 
-- 사람부터 정렬하여 출력하라.


select * from emp2;

select * from emp2 where name = '백원만';

select * from emp2 where pay > (select pay from emp2 where name = '백원만');

select avg(pay) from emp2;

--1----------
select name from emp2 where pay <(select avg(pay) from emp2);
--2----

select * from student;

select * from department;

select name from student where deptno1 = (select deptno from department where deptno = 101);

select name, deptno1 from student, department where deptno = (select deptno1 from student where name = '이윤나');
select name, deptno1 from student, department;

select * from emp2;

select name, position, pay from emp2 where pay > (select min(pay) from emp2 where position = '과장');

select name, grade, weight from student where weight < (select min(weight) from student where grade = 4);

select name, height, grade from student where height = max(height) group by grade;

select grade, name, height from student where (grade, height) in (select grade,max(height) from student group by grade) order by grade;

select * from professor;



select ename, job, sal, d.deptno, dname
  from emp e  inner join  dept d
  on  e.DEPTNO = d.DEPTNO ;

select deptno1 from student where name = '이윤나';

select name, dname from student s, department d where s.deptno1 = d.DEPTNO and name = '이윤나';

select * from professor;

select p.name, p.hiredate, d.dname from professor p , department d
  where hiredate > (select hiredate from professor where name= '송도권')
  and p.deptno = d.deptno;

select name ,grade, weight from student where weight < (select min(weight) from student where grade = 4) ;

select ename, HIREDATE, MONTH(HIREDATE) as [Months_Works]
  from emp
  order by Months_Works desc
--18> 이름이 J,A 또는 M으로 시작하는 모든 사원의 이름(첫 글자는 
-- 대문자로, 나머지 글자는 소문자로 표시) 및 이름 길이를 표시하는
-- 쿼리를 작성하고 컬럼 별칭은 적당히 넣어서 출력하라.


--19> 사원의 이름과 커미션을 출력하되, 커미션이 책정되지 않은 
-- 사원의 커미션은 'no commission'으로 출력하라.

select ename, isnull(convert(varchar(20),comm),'no commission') as comm
from emp



--20> 모든 사원의 이름,부서번호,부서이름을 표시하는 질의를 작성하라.

  
  
  
  
  
  
