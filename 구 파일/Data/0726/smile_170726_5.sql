-------------- View ------------------------------------------------
select * from PROFESSOR;
select * from emp;

create view  v_emp
as
  select empno, ename, deptno from emp ;
  
select * from v_emp;
 
-- emp 테이블 제거하면 v_emp ?
-- v_emp 테이블 제거하면 emp ?

--문제5] 30번 부서 사원들의 직위, 이름, 월급을 담는 view 테이블 만들기 (emp)
drop view v_emp30 ;

create view v_emp30
as
  select job "직위", ename "사원 이름" , sal "급여"
      from emp
      where deptno = 30;
      
select * from v_emp30;

-------------------------------------------------------
--문제6] 30번 부서 사원들의 직위, 이름, 월급을 담는 view 를 만드는데, 컬럼명을 직위, 사원이름, 월급
-- 으로 Alias를 주고 월급이 300보다 많은 사원들만 추출하시오.
drop view v_emp30_2;

CREATE VIEW v_emp30_2 
AS
  SELECT job "직위" , ename "사원이름", sal "월급"
  		FROM emp
      WHERE sal > 2000;

SELECT * FROM v_emp30_2;


--문제7] 부서별 최대급여, 최소급여, 평균급여를 갖는 view를 만드시오.
select avg(sal) from emp;

CREATE VIEW v_emp3
AS
	SELECT deptno "부서", MAX(sal) "최대월급", MIN(sal) "최소월급", ROUND(AVG(sal), 3) "평균월급"
  	FROM emp
    GROUP BY deptno 
    ORDER BY deptno ;

 SELECT * FROM v_emp3;

--문제8] 부서별 평균급여를 갖는 view를 만들되, 평균급여가 2000이상인 부서만 출력하도록 하시오.
SELECT * FROM emp;

CREATE VIEW v_emp4 
AS
 SELECT deptno, ROUND(AVG(sal),3) "부서평균"
 		FROM emp
 		GROUP BY deptno
 		HAVING AVG(sal) > 2000 ;

 SELECT * FROM v_emp4;
 
--문제9] 직위별 총급여를 갖는 view 테이블을 만들되, 직위(job)가 manager인 사원들은 제외하고 
--         총급여가 3000이상인  출력하시오.
select * from emp;

 CREATE VIEW v_emp7 
 AS
    SELECT job, SUM(sal) "총급여"
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
  select empno, ename, mgr from emp where 1=0;  -- 조건 불만족 상태 

select * from copy_emp2;

select * from c_emp4;
select * from copy_emp2;

insert into copy_emp2   -- 레코드 복사
  select empno, ename, mgr from emp where sal > 3000;

select * from copy_emp2;

-- 문제] 교수 테이블에서 테이블 구조만 복사된 c_professor 새로운 테이블 
--        생성(이름, 직위, 입사일, 이메일, 홈페이지)하고 레코드 복사 하기
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


--문제10] c_emp2 테이블의 구조물만 복사 c_emp22로 만드세요
 create table c_emp22
 as
  select * from emp where 1=0;
  
select * from c_emp22;

--문제11] emp 테이블에서 c_emp22에 직위가 'manager'인 사람들만 레코드 복사하시오.
 insert into c_emp22
  select empno, ename, job, sal from emp where job='MANAGER';
  
 insert into c_emp22
  select * from emp where job='MANAGER';

select * from c_emp22;

------rownum------------------------------------
select rownum, ename, sal from emp;

select rownum, rowid, ename, sal 
  from ( select * from emp order by sal );
  
--게시판 만들었을때 페이징 처리......

----------------------------------------------------
select *
  from DBA_SYS_PRIVS
  Where grantee= 'sys';
  
show recyclebin;  -- 삭제 테이블 목록 보기
commit;
  