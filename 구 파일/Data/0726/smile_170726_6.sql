------------------- Sequence ----------------------------------------------
create sequence autonum;   -- 1부터 시작해서 1씩 증가된다.
select autonum.nextval from dual;
select autonum.currval from dual;


create table kosta_T (
    no number, 
    name varchar2(10)
) SEGMENT creation IMMEDIATE ;

select * from kosta_t;
insert into KOSTA_T values(autonum.nextval, 'aa');
insert into KOSTA_T values(autonum.nextval, 'bb');
insert into KOSTA_T values(autonum.nextval, 'cc');

drop table kosta_T;
drop sequence autonum;

alter sequence autonum
  increment by 100

alter sequence autonum
  increment by 1

-- 문제] 자동증가 시퀀스명을 seq_test 라고 지정하고 100 시작해서 100 증가하는 것 만들고,
--   테이블 seq_test 테이블(num , name, phone)  만들기.  레코드 3개 추가해서 확인하기
----------------------------------------------
create sequence seq_jumin_no
  increment by 10
  start with 100
  maxvalue 150
  minvalue  90
  cycle
  cache 2
 --------------------------------------------- 
create table jumin_T (
    seq  number,
    name  varchar2(10),
    phone  varchar2(15)
  ) segment creation immediate ;
    
insert into jumin_T values(seq_jumin_no.nextVal, 'aa', '111' );
insert into jumin_T values(seq_jumin_no.nextVal, 'bb', '222' );
insert into jumin_T values(seq_jumin_no.nextVal, 'cc', '333' );
insert into jumin_T values(seq_jumin_no.nextVal, 'dd', '444' );
insert into jumin_T values(seq_jumin_no.nextVal, 'ee', '555' );

select * from JUMIN_T;

---------------- Transaction ------------------------------------------------
select * from tab;
create table c_emp100
as
  select * from emp where 1 = 2;   -- 조건에 맞지 않은 상태 
  
select * from c_emp100;
----------------------------------------------
begin
  for i in 1..10000 loop
    insert into c_emp100
        select * from emp;
  end loop;
end;
---------------------------------------------
select * from c_emp100;
rollback;
commit;

update c_emp100 set sal=1000;

--문제] 20번 부서 모두 삭제
  delete from c_emp100 where deptno=20;
--문제] 20번 부서 복구하기
  rollback;

----------------------------------------------------------------
update c_emp100 set sal = 100 where deptno=20;
savepoint update_sal;

update c_emp100 set sal = 10 where deptno=30;
savepoint update_sal30;

select sum(sal) from c_emp100;   --249250000

rollback to savepoint update_sal; 
COMMIT;

rollback to savepoint update_sal30; 

create table tt (
  id number
);

insert into tt values(1);
insert into tt values(2);
select * from tt;
commit;

rollback;   

commit / rollback  -- DML 명령에 적용됨

------ 다른 계정에 있는 테이블에 접근하기....-----------------




