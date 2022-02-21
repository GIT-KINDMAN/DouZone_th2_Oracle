-- select 별칭주기
select * 
    from emp2
    where position='부장';

select empno, name, pay, position
    from emp2
    where position='부장';
    
select empno as "사원번호", name "성  명", pay  급여, position "직    급"
    from emp2
    where position='부장';
    
select empno as "사원번호", name "성  명", pay  급여, position "직    급"
    from emp2
    where position='과장' and name='유관순';  -- and
    
    
select empno as "사원번호", name "성  명", pay  급여, position "직    급"
    from emp2
    where position='과장' or name='김문호';  -- or
    
select * from emp2 where deptno=1000;    -- 숫자

select *
    from emp2
    where name like '김%';   -- % : 모든,   _ : 한문자 

select *
    from professor
--    where name like '%은%';      
     where name like '%은';  
    
select *
    from professor    
--     where name like '허_';
--      where name like '_은';
        where name like '__';  -- 이름이 두글자인~ 

select *
    from professor    
       where name like '%원_';  
       
-- 숫자
select *
    from professor  
--    where pay > 500;
--    where pay <= 300;
--      where pay >= 250 and pay < 500;       
      where pay <= 250 or pay < 500;
       
select * from professor where bonus is not null;       
select * from professor where bonus is null;   

--문제1] 급여가 500이상이고, 보너스가 60이상 받는 교수는? (professor table)
select * 
    from professor
    where pay >= 500 and bonus >= 60;

--문제2] 이름이 '나한라'을 '너한라'으로 변경 (emp2)
select * from emp2 where name='나한라';
update emp2 set  name='너한라' where name='나한라';

--문제3] 취미가 등산인 사람들만 찾아서 '수영'으로 변경
select * from emp2 where hobby= '등산';
update emp2 set hobby='수영' where hobby= '등산';
select * from emp2 where hobby= '수영';

--문제4] 계약직 직원 찾아서 삭제하기
select * from emp2 where EMP_TYPE = '계약직';
delete
    from EMP2
    where EMP_TYPE = '계약직';

--문제5] pay(or bonus)가 50이상인 사람만 출력 (professor )
SELECT *
    from professor
--        where bonus >=50;
        where pay >=450;

--문제6] ~세트가 아닌 상품들만 출력 ( gift table)
select * from gift;
select * from gift where gname not like '%세트';

--문제7] gno가 10인 상품의 이름을 널처리(null) 하세요.
select * from gift where gno=10;
update gift set gname=null where gno=10;

--문제8] gname 이름이 없고, g_start가 999인 값을 갖는 데이터 입력하세요.
desc gift;
insert into gift(gno, g_start) values (11, 999);
insert into gift(gname, g_start) values (' ', 999);
select * from gift;

--문제9] gname이 null이거나 ' ' 인 데이터를 제외하고 출력하시오.
select * from gift where gname is null or gname=' ';
select * from gift where gname is not null and gname != ' ';  -- != 
select * from gift where gname not in('null', ' ') order by gno desc;

-- 연산자 --------------------------------
select mod(7, 3) from dual;  -- 나머지
select 7/3 from dual;  --몫

-- null 연산은 무조건 null
select name, pay,bonus from professor;
select name, pay, nvl(bonus, 0) from professor;

update professor set bonus = bonus+100 ;
update professor set bonus = nvl(bonus, 0)  + 100 ;
ROLLBACK;

select * from gift;
select * from gift where gno=1 or gno=3 or gno=7;
select * from gift where gno in(1,3,7);  -- 권장 
select * from gift where gno not in(1,3,7);
-- between 앞에 값이 작은값 and 뒤에값 큰값
select * from gift where gno BETWEEN 6 and 9;
select * from gift where gno BETWEEN 9 and 6; -- 안됨
select * from gift where g_end BETWEEN 600000 and 800000;

--정규직 이면서 '백원만' 찾기

--정규직 이거나 '유도봉' 찾기

--수습직 이거나 김씨성을 가진 사람 찾기

--김씨가 아닌 수습직원 찾기
select * from emp2 where emp_type='수습직' or name not like '김%';

--문제1] 이름에서 '김영조' 사람들을 보여주세요.
    select * from professor where name='김영조'
--문제2] 이름에서 '김'씨 성을 가진 사람들을 보여주세요.  - 모든 : % , 한글자 : _
    select * from professor where name like '김%'
--문제3] 이름이 두 글자인 사람 보여주세요.
 select * from professor where name like '__'
 
 select * from professor where name like '_은_'
 select * from professor where name like '_은_' or name like '__은_'
 select * from professor where name like '_은'
 select * from professor where name like '%은%'
 
--문제4] id에 s or a 글자가 들어가는 사람 찾기
  select * from professor where id like '%s%' or id like '%a%'
  
  select * from professor where id like '%s%' or id like 'a%'
  select * from professor where id like 's%' or id like 'a%'
  
--문제5] 전임강사 찾아주세요
  select * from professor where position like '전임강사'
 
  select * from professor where position = '전임강사'
  select * from professor where position like '전%'
 
 -- 형식>
-- create table 테이블명 ( 필드명 자료형(크기), 필드명 자료형(크기),..... ); 
 -- kosa2  table create  - 이름name, 지역loc, 연락처phone
 create table kosa2 ( name varchar2(10), loc varchar2(20), phone varchar2(15));
 
 insert into kosa2 values('doyeon', 'seoul', '000');
 insert into kosa2 values('doyeon2', 'busan', '3456');
 insert into kosa2(name, phone) values('doyeon3','9999');
 insert into kosa2(loc, phone) values('jeju','7777');
 
--cf)
select name, position from professor;
select name || position from professor;  -- 필드와 필드 연결해서 출력

--퀴즈1 **
--Professor 테이블에서 교수들의 이름을 조회하여 성부분에 ‘ㅈ’ 이 포함된 사람의 명단을 아래와 같이 출력 하세요.
select * 
    from professor
    where name >= '자' and name < '차';   -- 상한값 포함 하한값 미포함
--    where name >= '자' and name < '처';  -- 차범절 포함 
       
select * 
    from professor
    where name between '자' and '차';   -- '자' 이상 '차' 미만
       
select * 
    from professor
    where name between '자%' and '차%'
    order by 1;    -- 정렬  (설명할것!! )    
       
--문제6] 학년이 3학년(grade)이고 키(height)가 165이상인 학과코드(deptno1)가 101인 학생 찾기
select * from student;
--문제7] 생일이 77년 이전인 학생들 찾기
--문제8] 부전공(deptno2)을 가진 학생들만 찾기
--문제9] 담당교수(profno)가 1000 ~ 2001 사이 학생들 찾기

       
       
       
    
    
    
    
    
    
    