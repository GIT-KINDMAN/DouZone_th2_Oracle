---------------------- SubQuery (서브쿼리) ----------------------------------------------
select * from emp2;
select * from emp2 where name = '백원만';
select * from emp2 where pay > 60000000 ;

select * from emp2 where pay > ( select pay from emp2 where name = '백원만' ) ;
--문제1]  emp2 평균 급여보다 작은 사람 출력하세요.
select avg(pay) from emp2;
select * from emp2 where pay < 43100000 ;

select * 
  from emp2 
  where pay < ( select avg(pay) from emp2 ) ;
  
--문제2] Student 테이블과 department 테이블을 사용하여 이윤나 학생과 전공(deptno1)이 동일한 학생들의
--          이름과 1전공 이름을 출력하세요.
select * from department2;
select * from student;
drop table department2;

CREATE TABLE "DEPARTMENT2" 
   (	"DEPTNO" NUMBER(3,0), 
	"DNAME" VARCHAR2(25 BYTE), 
	"PART" NUMBER(3,0), 
	"BUILD" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into DEPARTMENT2
SET DEFINE OFF;
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (101,'컴퓨터공학과',100,'정보관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (102,'멀티미디어공학과',100,'멀티미디어관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (103,'소프트웨어공학과',100,'소프트웨어관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (201,'전자공학과',200,'전자제어관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (202,'기계공학과',200,'기계실험관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (203,'화학공학과',200,'화학실습관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (301,'문헌정보학과',300,'인문관');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (100,'컴퓨터정보학부',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (200,'메카트로닉스학부',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (300,'인문사회학부',20,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (10,'공과대학',null,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (20,'인문대학',null,null);
  
--문제2] Student 테이블과 department 테이블을 사용하여 이윤나 학생과 전공(deptno1)이 동일한 학생들의
--          이름과 1전공 이름을 출력하세요.
select * from department2;
select * from student;

select deptno1 from student where name = '이윤나';

select name, dname
  from STUDENT s , department2 d
  where    s.deptno1 = d.DEPTNO ;

select name, dname
  from STUDENT s , department2 d
  where  s.DEPTNO1 = ( select deptno1 from student where name = '이윤나' )  
  and s.deptno1 = d.DEPTNO ;

--문제3] Professor 테이블에서 입사일이 송도권 교수보다 나중에 입사한 사람의 이름과 입사일, 학과명을 출력하세요.
select hiredate  from professor where name='송도권'; 

select p.name, p.hiredate, d.dname
  from professor p , DEPARTMENT2 d
  where hiredate > ( select hiredate  from professor where name='송도권' )  -- 입사일 이후/ 이전은 부등호 변경하면 됨
  and p.deptno = d.DEPTNO ;

--문제4] Student 테이블에서 1전공(DEPTNO1)이 101인 학과의 평균 몸무게보다 몸무게가 많은 학생들의 
--          이름과 몸무게를 출력하세요.
select avg(weight) from student where deptno1 = 101 ;

select name, weight
  from student 
  where weight > 60 ;

select name, weight
  from student 
  where weight > (select avg(weight) from student where deptno1 = 101) ;
-------------------------------------------------------------------------
select * from dept2;
select dcode from dept2 where area='서울지사' ;
select * from emp2;

select empno, name, deptno
  from emp2
  where DEPTNO in( 1000, 1001, 1002, 1010 );

select empno, name, deptno
  from emp2
  where DEPTNO in( select dcode from dept2 where area='서울지사' );

----문제들~ -----------------------------------------------------------------------------------------
-- EMP2 테이블을 사용하여 전체 직원 중 과장 직급의 최소 연봉자보다 연봉이 높은 사람의 이름과 직급,
-- 연봉을 출력하세요. 단 연봉 출력 형식은 아래와 같이 천 단위 구분기호와 원 표시를 하세요
SELECT NAME, POSITION, PAY FROM EMP2 WHERE 1=1 AND POSITION != '과장'
    AND PAY > ANY(SELECT PAY FROM EMP2 WHERE POSITION = '과장');
----------------------------------------------------    
SELECT  name "이름", position "직급", TO_CHAR(pay, '999,999,999')||'원' "연봉"
  FROM   emp2
  WHERE  pay > ANY ( SELECT pay FROM emp2  WHERE     position = '과장') ;   
  
-------------------------------------------------------------------
--student 테이블을 조회하여 전체 학생 중에서 체중이 4학년 학생들의 체중에서 가장 적게 나가는 
--학생보다 적은 학생의 이름과 학년과 몸무게를 출력.
SELECT name "이름", grade "학년",  weight "몸무게"
  FROM  student
  WHERE  weight < ALL (SELECT  weight FROM  student WHERE  grade = 4) ;
-----------------------------------------------------------------------------
select name || '(' || position ||')' || ',' || name ||' ' || position || ''
  from professor ;
  
select name || '(' || position ||')' as "이름" , name ||'   "' || position || '"'  
  from professor ;
 
--------------------------------------------------
--student 테이블을 조회하여 각 학년별로 최대 키를 가진 학생들의 학년과 이름과 키를 출력.
SELECT grade "학년", name "이름", height "키"
  FROM  student
  WHERE (grade, height) IN( SELECT grade, MAX(height)  FROM  student GROUP BY grade ) ;

  -----------------------------------------------------------------------
-- professor 테이블을 조회하여 각 학과별로 입사일이 가장 오래된 교수의 교수번호와 이름, 입사일, 학과명을 출력. 
-- 단, 학과명순으로 오름차순 정렬.
SELECT  p.profno "교수번호", p.name "이름", p.hiredate "입사일", d.dname "학과명"
  FROM professor p, department2 d
  WHERE p.deptno = d.deptno  AND (p.deptno, p.hiredate) 
    IN ( SELECT deptno, MIN(hiredate) FROM professor  GROUP BY deptno ) 
    order by 4;  -- 또는 order by dname

select * from department2;  
----------------------------------------------
--Emp2 테이블을 조회하여 직급별로 해당 직급에서 최대 연봉을 받는 직원의 이름과 직급, 연봉을 출력하세요. 
--연봉순으로 오름차순 정렬하세요.
select name "이름", position "직급", pay "연봉"
   from emp2
   where (position, pay) in( select position, Max(pay) from emp2 group by position )
   order by 3 ;
----------------------------------------------------------------------------------

--제약조건 확인(테이블 & 칼럼) 및 제약 조건 제거 

--제약조건 확인
SELECT	* 
  FROM	 ALL_CONSTRAINTS
  WHERE	TABLE_NAME = '테이블명';
  
SELECT	* 
  FROM	 ALL_CONSTRAINTS
  WHERE	TABLE_NAME = 'emp';


SELECT	A.UNIQUENESS,
	B.*
  FROM	 ALL_INDEXES A,
  ALL_IND_COLUMNS B
  WHERE	A.INDEX_NAME = B.INDEX_NAME
  AND A.TABLE_NAME='테이블명';


--제약조건 삭제
ALTER TABLE 테이블명 DROP CONSTRAINT 제약조건명 CASCADE;


--인덱스 생성
CREATE UNIQUE INDEX PK명 ON 테이블명 (컬럼명1, 컬럼명2....);


--PK 생성
ALTER TABLE 테이블명 ADD (CONSTRAINT PK명 PRIMARY KEY (컬럼명1, 컬럼명2....));



