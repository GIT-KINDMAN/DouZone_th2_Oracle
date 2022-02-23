-----------Join------------ pk / fk 관계
select * from emp; -- 14
select * from dept; -- 4
select * from emp, dept; -- Cartesian Product

desc emp;
desc dept;


--inner join--
select ename, job, sal, emp.deptno, dname
    from emp, dept
    where emp.deptno = dept.deptno; -- inner join (=) mssql은 where가 아니라 on
    
select ename, job, sal, d.deptno, dname -- 테이블명.필드명
    from emp e join dept d -- inner join
    on e.deptno = d.deptno; -- on은 mssql식이지만 돌아감
    
select ename, job, sal, d.deptno, dname
    --from emp e left outer join dept d -- left outer join: 왼쪽에 있는 데이터 모두, 오른쪽은 일치하는 데이터만
    from dept d left outer join emp e
    --on e.deptno = d.deptno;
    on d.deptno = e.deptno;
    
select ename, job, sal, d.deptno, dname
    from emp e right outer join dept d -- right outer join: 오른쪽에 있는 데이터 모두, 왼쪽은 일치하는 데이터만
    --from dept d right outer join emp e
    on e.deptno = d.deptno;
    --on d.deptno = e.deptno;
    
-- =, *=, =*

desc dept;
-- deptno not null pk?
insert into dept(deptno, loc) values(50, 'SEOUL');
select * from dept;

--문제]-------------------- professor / student table 이용
--inner join: profno
--outer join (l/r)

select * from professor;
select * from student;
-- inner join

--교수이름, 직위, 학과코드, 교수코드, 학생이름, 학번, 학년, 주전공학과
select p.name 교수이름, position 직위, p.deptno 학과코드, p.profno 교수코드, s.name 학생이름, studno 학번, grade 학년, s.deptno1 주전공학과 from professor p, student s where p.profno = s.profno; -- inner join은 where 작동함

--교수이름, 직위, 학과코드, 교수코드, 학생이름, 학번, 학년, 주전공학과
select p.name 교수이름, position 직위, p.deptno 학과코드, p.profno 교수코드, s.name 학생이름, studno 학번, grade 학년, s.deptno1 주전공학과 from professor p left outer join student s on p.profno = s.profno; -- where 쓰면 작동 안함

--교수이름, 직위, 학과코드, 교수코드, 학생이름, 학번, 학년, 주전공학과
select p.name 교수이름, position 직위, p.deptno 학과코드, p.profno 교수코드, s.name 학생이름, studno 학번, grade 학년, s.deptno1 주전공학과 from professor p right outer join student s on p.profno = s.profno; -- where 쓰면 작동 안함

/* 스탠더드
select p.name, p.position, p.deptno, p.profno,
        s.name "학생이름", s.studno "학번", s.grade "학년", s.deptno1 "주전공학과"
        from 테이블명1 별칭1 left outer join
                테이블명2 별칭2 right outer join 테이블명3 별칭3
        on 별칭1.컬럼명 = 별칭2.컬럼명,
        on 별칭2.컬럼명 = 별칭3.컬럼명;
*/

select * from department;
select * from professor;
select * from student;

select p.profno, p.name, p.position,
        s.studno, s.name, s.grade, d.dname
    from professor p join student s
    on p.profno = s.profno join department d
    on s.deptno1 = d.deptno;
        

--------------------------------------------------------------------------------------------------------------------------------------------

select p.profno, p.name, p.position, s.studno, s.name, s.grade, d.dname
    from professor p left join student s on p.profno = s.profno right join department d on s.deptno1 = d.deptno;
    
select p.profno, p.name, p.position, s.studno, s.name, s.grade, d.dname
    from professor p join student s on p.profno = s.profno join department d on s.deptno1 = d.deptno;
    
-- 사원이름, 부서이름, 직책, 매니저번호 출력 emp/dept 테이블 이용
select * from emp; -- empno, ename, job, mgr, hiredate, sal, comm, deptno
select * from dept; -- deptno, dname, loc
select e.ename 사원이름, d.dname 부서이름, e.job 직책, e.mgr 매니저번호 from emp e join dept d on e.deptno = d.deptno;

-- 테이블복사/레코드복사 --------------------
/* 형식>
*/

select * from emp;

create table c_emp
    as
    select * from emp;
    
select * from c_emp; -- 똑같이 만들어졌다. 하지만!! 제약조건이 없다!!!

desc emp;
desc c_emp; -- emp와 달리 not null empno가 안돼있다!!!

create table c_emp_20
    as
    select ename, job, deptno from emp where deptno=20;
    
create table c_emp_30
    as select empno 번호, ename 이름, job 직업, sal 급여
        from emp
        where deptno=30;

select * from c_emp; -- 전체 복사. But 제약조건(Constrain) 복사 안됨
select * from c_emp_20; -- 조건에 맞게 복사
select * from c_emp_30; -- 조건에 맞게 복사 + alias

--문제1] 교수 테이블에서 전임강사만 뽑아서 테이블 생성하기
create table instructor_professor
    as select * from professor where position like '전임강사';

--문제2] emp(직원) 테이블에서 mgr(매니저번호)가 7566번인 사람만 추출해서 새로운 테이블 생성하기
create table mgr_emp
    as select * from emp where mgr=7566;

select * from instructor_professor;
select * from mgr_emp;

select * from all_constraints where table_name = 'EMP';

-- 형식> 구조물만 복사하길 원할 때
/*
CREATE TABLE 테이블이름
    AS SELECT 필드명, ..... FROM 테이블명 WHERE 1=0; -- 1=0이 뭐지: 그냥 논리적으로 항상 false인걸 만들기 위해 쓴 구문
*/

create table c_emp4
    as select * from emp where 1=0; -- 내용물은 아무것도 없고 뼈대(구조물)만 생성

create table c_emp3
    as select empno, ename, job, sal from emp;

-- 결과물 정리
select * from c_emp; -- 전체 복사했던 것
select * from c_emp_20; -- 조건에 맞게 복사했던 것
select * from c_emp_30; -- 조건에 맞게 복사했던 것 + alias 적용
select * from c_emp3; -- 원하는 필드에 해당하는 레코드 복사
select * from c_emp4; -- 구조물만 복사, 레코드 없음

select * from emp
union -- 중복 행 제거하고 출력
    select * from c_emp;

select * from emp
union ALL -- 중복 행 함께 출력
    select * from c_emp;

insert into c_emp values(7788, 'donghun', 'manager', 7777, '02/01/17', 5000, 1000, 30);
select * from c_emp;

desc emp;

--select * from emp -- 에러 발생: ORA-01789: 질의 블록은 부정확한 수의 결과 열을 가지고 있습니다.
select empno, ename, job, sal from emp -- 필드 갯수와 데이터 타입이 맞아야함
union -- 데이터타입 일치시키지 않으면 하나 안하나 중복 전부 다나옴
    select * from c_emp3;

-- 매니저 검색 !!!
select * from c_emp;
select ename from c_emp where job in('MANAGER', 'manager');

-- 중요! 쿼리는 대소문자 구별을 하지 않지만 레코드는 대소문자 구분을 함
--> 시사점: 검색을 할 때는 대소문자를 잘 생각하고 해야할 것. upper이든 init이든 뭘써서든

select empno 사원번호, ename 이름, sal 급여
    from emp
    where ename = 'FORD' -- where 조건절에서 제대로 된 속성이름, ename을 맞춰주면 order by에서 쓸 수 있나봄
    order by 급여 desc; -- 별칭으로 정렬. 일단 그냥은 안됨

-- 문제1] c_emp_20, c_emp4 union 결과?
select * from c_emp_20; -- ename job deptno
select * from c_emp4; -- empno ename job mgr hiredate sal comm deptno
select ename, job, deptno from c_emp_20 union select ename, job, deptno from c_emp4;

-- 문제2] 사원번호, 이름, 급여 그리고 15% 인상된 급여를 정수로 표시하되 컬럼명을 New Salary로 지정하여 출력하라
select * from emp;
select empno 사원번호, ename 이름, sal 급여, floor(sal*1.15) "New Salary" from emp;

-- 문제3] 2번 문제와 동일한 데이터에서 급여 인상분(새 급여에서 이전 급여를 뺀 값)을 추가해서 출력하라. (컬럼명은 Increase로 하라)
select * from emp;
select empno 사원번호, ename 이름, sal 급여, floor(sal*1.15) "New Salary", floor((sal*1.15)-sal) increase from emp;

-- 문제4] 각 사원의 이름을 표시하고 근무 달 수를 계산하여 컬럼명을 Months_Works로 지정하고, 근무 달 수를 기준으로 오래된 사람부터 정렬하여 출력하라.
select * from emp;
select ename 이름,  floor(months_between(sysdate , hiredate)) Months_Works from emp order by hiredate;

-- 문제5] 사원의 이름과 커미션을 출력하되, 커미션이 책정되지 않은 사원의 커미션은 'no commission'으로 출력하라.
select * from emp;
select ename 이름, decode(comm, null, 'no commission', comm) 커미션 from emp;


select * from emp;

-- 

-- 이번엔 레이블 복사 (내일 한다고 함
/*
형식>
INSERT INTO 테이블이름
    SELECT 컬럼명, ... FROM 테이블 이름;
*/

--출처: https://all-record.tistory.com/151 [세상의 모든 기록]