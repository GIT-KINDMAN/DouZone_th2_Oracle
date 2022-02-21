select * from emp2;
delete emp2 where name like  '%김';

select sysdate from dual;

select * from de_test;

create table test2
(
 no number not null, -- primary key
  name varchar(10) not null,
  birdate date,
  age number,
  constraint no_pk primary key(no)
);


-- 컬럼추가
--alter table 테이블이름 add
-- (컬럼명자료형[제약조건], 컬럼명자료형[제약조건], ....)

select * from userlist;
alter table userlist add name varchar2(15);
alter table userlist add phone varchar2(15);
alter table userlist add (no number(2), gender char(2));

update userlist set no=1; -- 전체 수정
update userlist set gender='M', phone='111-222' where id='donghun';
update userlist set gender='F', phone='999-888' where id='aa';

--2. 컬럼 삭제
--alter table 테이블이름 drop cloumn 컬럼이름
alter table userlist drop column no;
-- !!! 제거된 no 컬럼은 메모리 내에 빈 공간으로서 자리를 차지하고 있다. GC같은거 없으면 그대로 메모리 낭비되니 설계 단계에서 주의할 것!!!

alter table userlist drop (name,gender);

--3. datatype 변경
--alter table 테이블이름 modify 컬럼이름 변경자료형
select * from userlist;
desc userlist;

alter table userlist modify gender number;
alter table userlist modify no varchar2(20); -- 컬럼에 데이터 없었을 경우 타입 변경 가능함. 데이터 있을시 이거로는 불가능

update userlist set phone =''; -- phone을 모두 null로 처리하고
alter table userlist modify phone number; -- 타입 변경

ROLLBACK; -- 취소 명령이지만, 이건 DML 명령어에 대해만 적용됨. e.g. create 등

--4. 컬럼이름변경
--alter table 테이블이름 rename column 기존컬럼명 to 변경컬럼명
alter table userlist rename column phone to tel;
alter table userlist rename column no to num;
select * from userlist;

--5. 테이블삭제
-- drop table 테이블이름 (조건절 불가)
drop table userlist;

select * from userlist2;
delete from userlist2; -- 레코드'만' 제거
desc userlist2;
drop table userlist2;

-- 삭제 테이블 목록 보기 (복구를 위해 확인해야 하는 경우 있을 것)
show recyclebin;
desc recyclebin;

-- 복구(삭제된 테이블을)
FLASHBACK table userlist to before drop; -- 해당 테이블을 삭제 이전 상태로 돌려달라
select * from userlist; -- 성공

purge recyclebin; -- 휴지통 비우기(완전 삭제)
show recyclebin;
-- 완전히 삭제된 것을 확인할 수 있음


drop table userlist PURGE; -- 휴지통을 거치지 않고 원천 삭제

-- 레코드삽입 / 수정 / 삭제 --------------
-- insert into 테이블이름(컬럼명,컬럼명,...) values (값, 값, ...)
-- insert into 테이블이름 values (값, 값, ...) --> 단! 테이블의 속성값 순서 지켜야함!


-- update 테이블이름 set 컬럼명=변경값, 컬럼명,변경값, ... where 조건문

-- Delete table이름 [where 조건삭]
-- truncate table 테이블이름; => 모든 레코드 삭제
select * from emp2;
delete emp2; -- delete from emp2의 축약형
rollback;
delete emp2 where emp_type='정규직';

TRUNCATE table emp2; -- where emp_type='정규직' , DML 명령어가 아니기 때문에 rollback이 안됨

--select distinct | * | 컬럼명 as 별칭, 컬럼명별칭,...
--  from 테이블이름
--  [where 조건식]
--  [order by 컬럼명 desc | asc , ... ]

select *
    from emp2
    where name='이윤나';
    
select distinct deptno --emp_type -- 중복 제거하고 보여줌 --> distinct
-- select name, emp_type, hobby
    from emp2;
    --where name='이윤나';
    --where hobby = '등산'
    --order by name desc; -- 정렬: asc/desc

create table userlist (
    id varchar(20),
    name varchar(20)
);

insert into userlist values ('1', 'LEE');
insert into userlist values ('2', 'PARK');
insert into userlist (id) values ('3'); -- 이거랑
insert into userlist (name) values ('KIM'); -- 이거는 한 줄에 맞물리지 않음! (3, (null)) , ((null), KIM)임
insert into userlist (id) values ('kang2');

select * 
    from userlist
    --where name=null; -- name=null은 안됨
    --where name is null;
    where name is not null; -- null은 is로 되지만 데이터값 있을땐 is 안되고 like = 만 되나봄
    
update userlist set name=' ' where id like 'kang2'; -- null이라도 뜨지는 않는 공백

select *
    from userlist
    where name is null or name=' '; -- null이거나 관리자가 일부러 공백처리한, 즉 논리적으로 null인 모든 유저를 탐색

-- select 별칭 주기
select *
    from emp2
    where position='부장';

select empno "사원번호", name "이    름", pay "연       봉", position "직     급"
    from emp2
    where position='부장';

select empno "사원번호", name "이    름", pay "연       봉", position "직     급"
    from emp2
    --where position='과장' and name like '유관순';
    --where position='과장' and name like '김문호'; -- 없어서 안나옴
    where position='과장' or name like '김문호'; -- 대리 김문호 및 과장들 출력
    
select * from emp2 where deptno=1000; -- 숫자

select *
    from emp2
    where name like '김__'; -- 와일드카드: like + ( % : 모든), ( _ : 한문자 --> __ 등 글자수 지정 가능)
    
select *
    from professor
    --where name like '%은%';
    where name like '%은';
    
select *
    from professor
    --where name like '허_';
    --where name like '_은';
    where name like '__'; --모든 두글자 레코드 출력
    
select *
    from professor
    where name like '%원_';
    
select *
    from professor
    --where pay>500;
    --where pay<=300;
    --where pay>=250 and pay<500;
    where pay<=250 or pay<500;
    
select * from professor where bonus is not null;
select * from professor where bonus is null;

--문제1] 급여가 500이상, 보너스가 60 이상인 교수 찾기
select * from professor where pay>500 and bonus>60;

--문제2] 이름이 '나한나'라는 사람을 '너한라'로 변경해보라 ) emp 테이블
update emp2 set name='너한라' where name = '나한나';

--문제3] 취미가 등산인 사람들만 찾아서 수영으로 변경
update emp2 set hobby='수영' where hobby='등산';

--문제4] 계약직 직원 찾아서 삭제하기
delete emp2 where emp_type = '계약직';

--문제5] pay가 450, bonus가 50 이상인 사람들만 출력 (professor)
select * from professor where pay>=450 or bonus>50;

--문제6] ~세트가 아닌 상품들만 출력 (gift 테이블)
select * from gift where GNAME not like '%세트';

--문제7] gno가 10인 상품의 이름을 널처리(null) 하라
update gift set gno=null where gno=10;

--문제8] gname 이름이 없고, g_start가 999인 값을 갖는 데이터 입력하라
insert into gift (gno, g_start) values (11,999);

--문제9] gname이 null이거나 ' '인 데이터를 제외하고 출력하라
select * from gift where gname is not null and gname not like ' ';
select * from gift where gname not in('null', ' ' );
select * from gift where gname not in('null', ' ' ) order by gno desc; -- gno 순서 내림차순 정렬

-- 연산자 -------------------
select mod(7,3) from dual; -- 나머지
select 7/3 from dual; -- 몫

-- null 연산은 무조건 null?
select name, pay,bonus from professor;
select name, pay, nvl(bonus, 0) from professor;

update professor set bonus = bonus + 100; -- null + 100은 null
update professor set bonus = nvl(bonus, 0) + 100; -- nvl(bonus, 0) 뜻: bonus속성의 null을 일괄적으로 0으로 초기화하라
rollback;

select * from gift;
select * from gift where gno=1 or gno=3 or gno=7;
select * from gift where gno in(1,3,7); -- 권장. 이유: 성능이 훨씬 빠름
select * from gift where gno not in(1,3,7); -- 차집합

select * from gift where gno BETWEEN 6 and 9;
select * from gift where gno BETWEEN 9 and 6; -- 에러는 없으나 정상 작동X. 이유: 작은 값이 앞으로 와야함. 밖으로 도는 띠를 생각하면 편할듯
select * from gift where g_end BETWEEN 600000 and 900000;


select * from emp2;
--정규직이면서 '백원만' 찾기
select * from emp2 where emp_type like '정규직' and name like '백원만';
--정규직이거나 '유도봉' 찾기
select * from emp2 where emp_type = '정규직' or name like '유도봉';
--수습직이거나 김씨성을 가진 사람 찾기
select * from emp2 where emp_type = '수습직' or name like '김%';
--김씨가 아닌 수습직원 찾기
select * from emp2 where emp_type = '수습직' and name not like '김%';

select * from emp2;
select * from gift;
    
--문제1] 이름에서 '김영조' 사람들을 보여주세요. -- emp
select * from emp where name like '김영조';

--문제2] 이름에서 '김'씨 성을 가진 사람들을 보여주세요.  - 모든 : % , 한글자 : _ -- emp
select * from emp where name like '김%';

--문제3] 이름이 두 글자인 사람 보여주세요. -- emp
select * from emp where name like '__';
 
--문제4] id에 s or a 글자가 들어가는 사람 찾기 -- 교수테이블
select * from professor where id like '%s%' or id like '%a%';
   
--문제5] 전임강사 찾아주세요 -- 교수테이블
select * from professor where position='전임강사';

--퀴즈1 **
-- Professor 테이블에서 교수들의 이름을 조회하여 성부분에 'ㅈ'이 포함된 사람의 명단을 아래와 같이 출력하세요.
select *
    from professor
    where name like 'ㅈ%';

select *
    from professor
    where name >= '자' and name < '차';
    
select *
    from professor
    where name between '자' and '차'; --'자'이상 '차'미만
    
select *
    from professor
    where name between '자%' and '차%'
    order by 7; -- 정렬

select * from student;    

--문제6] 학년이 3학년(grade)이고 키(height)가 165이상인 학과코드(deptno1)가 101인 학생 찾기
select * from student where grade=3 and height>165 and deptno1 = 101;

--문제7] 생일이 77년 이전인 학생들 찾기
select * from student where birthday <= TO_DATE('771231', 'YYMMDD');

--문제8] 부전공(deptno2)을 가진 학생들만 찾기
select * from student where deptno2 is not null;

--문제9] 담당교수(profno)가 1000 ~ 2001 사이 학생들 찾기
select * from student where profno between 1000 and 2001;
    
/*
[A_신입준비] [오전 11:18] 저 그  날다람쥐 문제 다못풀었는데요?
[A_나르니] [오전 11:18] 전 날다람쥐까지 가지도 못했습니다
[A_신입준비] [오전 11:18] 그거 스크롤로 화면 확대하면
[A_신입준비] [오전 11:18] 해결되긴해요
[A_자신감은실력에서] [오전 11:18] 현대자동차 코테 1시에 보시는분? 테스트 링크 메일 받으셨으나요??
[A_신입준비] [오전 11:18] 문제는 다  똑같았나보네요?
[A_나르니] [오전 11:19] 그래도 재밌네요
[A_나르니] [오전 11:19] 그것도 모르겠어요.. 저는 사과 담는거 까지만 해서..
[A_신입준비] [오전 11:19] 사과 재밌긴 했어요
[A_신입준비] [오전 11:19] 그 상자수 맞추는거 말하는거죠?
*/
