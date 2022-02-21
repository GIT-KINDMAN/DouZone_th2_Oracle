select * from emp2;
select sysdate from dual;

select * from de_test;

create table test2
(
  no number not null, --primary key, -- number, -- 4bye ( -9999 ~ 9999 )
  name varchar2(10) not null,
  birdate date, -- 생년 월일 : '년-월-일' or '년/월/일' '88-12-30' , '88/12/30'
  age number,
  constraint no_pk primary key(no)
);
-- ①컬럼추가
--alter table 테이블이름 add
--    (컬럼명자료형[제약조건] , 컬럼명자료형[제약조건] , ....)

select * from userlist;
alter table userlist add phone varchar2(15);
alter table userlist add ( no number(2), gender char(2) ); 

update userlist set no=1 ; -- 전체 수정
update userlist set phone= '111-222' where id='smile'; -- 조건에 맞는것만 수정
update userlist set gender='F', phone ='999-888' where id='kingsmile';

--②컬럼삭제
--alter table 테이블이름 drop column 컬럼이름
alter table userlist drop COLUMN no;
alter table userlist drop (name, gender); 

--③datatype변경
--alter table 테이블이름 modify 컬럼이름 변경자료형
select * from userlist;
desc userlist;
-- 기본 데이터가 있었을 경우 문제 발생 소지 있음
alter table userlist modify gender numbr; 
alter table userlist modify no varchar2(20);  -- 컬럼에 데이터 없었을 경우 타입 변경 가능함

update userlist set phone ='';  -- phone = null;
alter table userlist modify phone number;
rollback;  -- 취소 (DML명령어에만 적용됨) 

--④컬럼이름변경
--alter table 테이블이름 rename column 기존컬럼명 to 변경컬럼명
alter table userlist rename column phone to tel;
alter table userlist rename column no to num;
select * from userlist;

--⑤테이블삭제
--drop table 테이블이름
drop table userlist;

select * from userlist2;
delete from userlist2;  -- 레코드 제거
desc userlist2;
drop table userlist2;

-- 삭제 테이블 목록 보기
show recyclebin;
desc recyclebin;
-- 복구(삭제된 테이블)
FLASHBACK table userlist to before drop;
-- 휴지통 비우기 
purge recyclebin;
select * from userlist;

drop table userlist PURGE; -- 휴지통에 안남기고 완전 제거

-- 레코드 삽입/ 수정/ 삭제 -------------------
--insert into 테이블이름(컬럼명, 컬럼명,...) values(값, 값, ...)
--insert into 테이블이름 values(값, 값, ...)
--   =>모든컬럼에 모두값을 넣을때 사용

--update 테이블이름 set 컬럼명=변경값, 컬럼명=변경값, 컬럼명=변경값, .....[ where 조건식]

--Delete table이름 [ where 조건식 ]
--truncate table 테이블이름; => 모든레코드삭제
select * from emp2;
delete emp2;   --delete from emp2; -- 조건에 맞는것만 제거
rollback;
delete emp2 where emp_type='정규직';

TRUNCATE table emp2; -- where emp_type='정규직';  where절 사용 못함, rollback 안됨.

--select distinct | * | 컬럼명 as 별칭, 컬럼명별칭,....
--    from 테이블이름
--    [where 조건식]
--    [order by 컬럼명 desc | asc , .. ]

select distinct deptno --emp_type  -- distinct :중복 제거하고 보여줌
--select name, emp_type, hobby, deptno
    from emp2;
    --where name='이윤나';
    --where hobby = '등산'
    --order by name desc; -- 정렬: asc / desc 

create table userlist (
    id varchar2(20),
    name varchar2(20)
); 

insert into userlist values('kingsmile', 'doyeon');
insert into userlist values('park', '김연아');
insert into userlist(id) values('kang2');
insert into userlist(name) values('kim');

select * 
    from userlist
    --where name=null;  (X)
    --where name is null;  -- is null  or is not null 
    where name is not null;

update userlist set name=' ' where id='kang2';
select * 
    from userlist
    where name is null or name=' ';  -- 









/*
010-9462-9454
김태연선임
*/




