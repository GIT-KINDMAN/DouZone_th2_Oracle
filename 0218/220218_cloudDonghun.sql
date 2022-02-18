select * from tab;

create table SampleTable (
    num number,
    name varchar2(20) not null,
    phone varchar2(15),
    address varchar2(50)
);

select * from sampletable; -- 전체보기
select name, address from sampletable; -- 특정 필드만 보기

-- insert --
insert into sampletable values(10, 'Lee', '010-1234-5678', '서울');
insert into sampletable values(20, '김', '019-8765-4321', '경기');

insert into sampletable(name, address, phone, num) values ('나', '제주', '015', 30);
insert into sampletable(name, address) values ('박', '인천');

insert into sampletable(phone, address) values ('011', '인천');

commit;
-- update --

update sampletable set name='이동훈'; -- 전체 수정
ROLLBACK; -- 취소

update sampletable set name='이동훈' where name='동훈'; -- 조건문: where, 조건에 맞는 것만 수정
update sampletable set name='이동훈', address='서울시 강동구' where name='Lee';

desc sampletable; -- 테이블의 구조(속성값? 스키마? 아무튼 자료형 타입) 확인 가능
select * from sampletable;
-- delete from sampletable; -- from 생략 가능

delete sampletable; -- 레코드(데이터) 전체 삭제 + 속성구조체는 여전히 남아있음
delete sampletable where num = 30; -- num이 30인 조건에 맞는 레코드(튜플)을 삭제

drop table sampletable; -- 휴지통에서 살릴 순 있는데(이름은 안보임. 날짜로 된 다른 이름으로 바뀜) 롤백으론 복구 불가
ROLLBACK; -- 안먹힘

-- 한 줄 주석
/* 여러 줄 주석 */

select * from emp2;
desc emp2; -- EMPNO, NAME, DEPTNO: 3개가 NOT NULL

select empno, name, emp_type, deptno from emp2;

select *
    from emp2
    where emp_type = '계약직'
--    order by name; -- 오름차순 정렬이 기본값
    order by name desc; 
    
show user; --

select sysdate from emp2;
select sysdate from sampletable; -- 수정 날짜?
select sysdate from dual; -- 제공되는 가상 테이블, 최종 수정일 1개만 보여줌


CREATE TABLE userlist(
id VARCHAR2(10) CONSTRAINT id_pk PRIMARY key,
name varchar2(10) not null
)

-- drop table userlist;

-- not null 제약조건
select * from userlist;
insert into userlist values('donghun', '이');
insert into userlist values('donghun', 'Lee');
insert into userlist (name) values('donghun'); -- error

/*
CREATE TABLE fk_member(
code number(2) NOT NULL ,
id VARCHAR2(20) NOT NULL
CONSTRAINT id_fk REFERENCES MEMBER(id) ,
etc VARCHAR2(10)
)
*/

select * from professor;
select * from student;
select * from department;


-- 제약 조건 unique 조건 (not null 조합은 제외했음)
CREATE TABLE userlist2(
id VARCHAR2(10) CONSTRAINT userlist2_id_pk PRIMARY key,
jumin char(13) CONSTRAINT jumin_un unique
);

select * from userlist2;
insert into userlist values('aa', '111');
insert into userlist values('bb', '222');

insert into userlist values('park', '11122');
insert into userlist(id) values('kang');


-- 제약조건 check 조건
CREATE TABLE ck_Test(
NAME VARCHAR2(10) NOT NULL,
age NUMBER(2) NOT NULL
CHECK (age BETWEEN 20 AND 30 ) --age컬럼의 값은 20~30사이만 허용
);

select * from ck_Test;
insert into ck_test values('aa',21);
insert into ck_test values('bb',31);
insert into ck_test values('cc',30);
insert into ck_test values('pp',29);
insert into ck_test values('pp',43);

insert into ck_test values('kk',22);
insert into ck_test values('pp',33);
insert into ck_test values('dd',27);

-- default
CREATE TABLE de_Test(
NAME VARCHAR2(10) NOT NULL,
addr VARCHAR2(10) DEFAULT '서울'
);

select * from de_test;
desc de_test;

insert into de_test values ('hh', 'seoul');
insert into de_test values ('gg', 'busan');
insert into de_test (name) values ('jj'); -- create 시 속성에 defalut를 적은건 null -> default 값 자동 적용
insert into de_test values ('ff', default);
insert into de_test (name) values ('ss');
insert into de_test values ('ss'); -- 오류
insert into de_test values ('ss', null); -- 명시적으로 null을 적으면 null이 적힘
