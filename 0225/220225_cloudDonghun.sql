create or replace view v_student_join -- ???
as
    select p.profno, p.name, p.position,
            s.studno, s.name, s.grade, d.dname, p.deptno --, p.deptno;
            from professor p join student s
            on p.profno = s.profno join department d
            on s.deptno1 = d.deptno;
            
-- 레코드 복사 ---------------
-- 형식> 
--insert into 테이블이름
--    select 컬럼명, ... from 테이블이름 */

select * from c_emp; -- 전체복사
select * from c_emp_20; -- 조건(부서번호가 20번인 레코드)에 맞는 테이블 생성
select * from c_emp3;
select * from c_emp4;

insert into c_emp4(empno, job, hiredate, comm) -- data type, 필드 개수
    select empno, birthday, position from emp2;
    
-- 4, 9, date, 7
desc c_emp4;
-- 4,
desc emp2;

--rownum --------------
select ename, job, rownum, sal from emp;

select rownum, job from emp;

select rownum, job from emp where sal > 3000; -- rownum : 조건 적용
select rownum, job sal, rowid from emp; -- where sal > 3000;

-- 가상 테이블 : dual
select sysdate from dual;   

-- Sequence : 자동 증가 번호

/*
create sequence 시퀀스이름 -- 1부터 시작 1씩 증가
    [start with 시작값]
    [increment by 증가치]
    [maxvalue 최대값]
    [minvalue 최소값]
    [cycle | nocycle]
    [cache | nocache]
*/

create sequence autonum; -- 1부터 시작해서 1씩 증가한다

select AUTONUM.nextval from dual; -- 시퀀스 값 증가
select AUTONUM.currval from dual; -- 현재 시퀀스 값 가져오기

create table kosa_T (
    no number,
    name varchar2(20)
);

-- 시퀀스 값 증가를 두번 하고 밑의 튜플을 입력했더니 3456이 됐다 기억해두자
-- pk 값 증가시킬때 이렇게 하면 일일히 수정 안해도 될듯
insert into kosa_t values(AUTONUM.nextval, 'aa');
insert into kosa_t values(AUTONUM.nextval, 'bb');
insert into kosa_t values(AUTONUM.nextval, 'cc');
insert into kosa_t values(AUTONUM.nextval, 'dd'); 
select * from kosa_T;

-----

create table kosa (
    no number,
    name varchar2(20)
);

-- 문제 확인. 기존 시퀀스를 쓰면 다른 테이블인데도 nextval이 연동되어버림
-- 새로 create 하고 쓰면 된다
insert into kosa values(AUTONUM.nextval, 'aa');
insert into kosa values(AUTONUM.nextval, 'bb');
insert into kosa values(AUTONUM.nextval, 'cc');
insert into kosa values(AUTONUM.nextval, 'dd'); 
select * from kosa;

create sequence seq_kosa;
insert into kosa values(AUTONUM.nextval, 'aa');
insert into kosa values(AUTONUM.nextval, 'bb');
insert into kosa values(AUTONUM.nextval, 'cc');
insert into kosa values(AUTONUM.nextval, 'dd'); 
drop sequence seq_kosa;

create sequence seq_kosa
    increment by 100;
    
select * from kosa;


-----

create table kosa2 (
    no number,
    id varchar2(20),
    name varchar2(20)
);

insert into kosa values(seq_kosa.nextval, 'aa');
insert into kosa values(seq_kosa.nextval, 'bb');
insert into kosa values(seq_kosa.nextval, 'cc');
insert into kosa values(seq_kosa.nextval, 'dd');

insert into kosa2 values(seq_kosa.nextval, 'aa', 'n1');
insert into kosa2 values(seq_kosa.nextval, 'bb', 'n2');
insert into kosa2 values(seq_kosa.nextval, 'cc', 'n3');
insert into kosa2 values(seq_kosa.nextval, 'dd', 'n4');

select * from kosa2;


-- create가 아닌 alter
alter sequence seq_board
    increment by 100
    maxvalue 1000
    cycle
    cache 2;

create table kosa3 (
    no number,
    id varchar2(20),
    name varchar2(20)
);

insert into kosa3 values(seq_board.nextval, 'aa', 'n1');
insert into kosa3 values(seq_board.nextval, 'bb', 'n2');
insert into kosa3 values(seq_board.nextval, 'cc', 'n3');
insert into kosa3 values(seq_board.nextval, 'dd', 'n4');

select * from kosa3; -- 시퀀스 seq_board 의 maxvalue 5 때문에 5 이상의 회원은 넣을 수 없음 + exceed 시 cycle 순환 볼 수 있음

-----

create sequence seq_jumin_no
    increment by 10
    start with 10
    maxvalue 150
    minvalue 9
    cycle
    cache 2;
    
create table jumin_T(
    seq number,
    name varchar2(10),
    phone varchar2(15)
) segment creation immediate; -- 요즘 버전엔 필수 명시사항은 아님

insert into jumin_T values(seq_jumin_no.nextval, 'aa', '111');
insert into jumin_T values(seq_jumin_no.nextval, 'bb', '222');
insert into jumin_T values(seq_jumin_no.nextval, 'cc', '3333');
insert into jumin_T values(seq_jumin_no.nextval, 'dd', '444');
insert into jumin_T values(seq_jumin_no.nextval, 'ee', '555');
insert into jumin_T values(seq_jumin_no.nextval, 'ff', '666');

-- 사이클 다시 돌때는 9부터 시작하는걸 볼 수 있음
select * from jumin_T;

-- Transaction -------------- 기본 구조물이 망가지는 것보다 정규식 등을 통해 트랜잭션만 철회하는게 훨씬 안전하고 이득이다

create table c_emp100
as
    select * from emp where 1=2; -- 조건에 맞지 않는, 뼈대만 복제하는 코드
-------------------------------
begin
    for i in 1..10000 loop
        insert into c_emp100
            select * from emp;
    end loop;
end;
------------------------------
select * from c_emp100; -- 프로시저 추가한 이상 앞으로는 블럭 지정하고 ㅋ엔터
rollback; -- 얘도
commit; -- 이후로는 롤백 불가

update c_emp100 set sal=1000;
delete from c_emp100 where deptno=20;
rollback;

------------------------------
update c_emp100 set sal=888 where deptno=20;
savepoint update_sal;

update c_emp100 set sal=10 where deptno=30;
savepoint update_sal30;

update c_emp100 set sal = 1 where deptno = 30;

select * from c_emp100;
select sum(sal) from c_emp100; -- sal=1 -> 241310000 / 롤백 시 24185000

rollback to savepoint update_sal;
commit;

rollback to savepoint update_sal30;
commit;

savepoint create_tt;
create table tt (id number);
insert into tt values(1);
insert into tt values(2);

select * from tt;
rollback to savepoint create_tt; -- DML에만 적용되는거지 DCL엔 적용 안됨. create table 등은 만들어질때 이미 커밋되기 때문

-----------------------------------------------------------
show user; -- USER이(가) "DONGHUN"입니다.
SELECT * FROM EMP2;

------------------ Admin에서 작업한거 갖고온것 --------------------- + ppt 22번 항목 참고. 사용자에게 권한은 최소한만 줘라
SELECT * FROM donghun.emp2;
select * from user1.emp; -- 커밋해야 남의 테이블을 보든지 말든지 하지
---------------------------------------------------------------------------