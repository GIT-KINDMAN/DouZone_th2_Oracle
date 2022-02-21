select * from tab;

create table SampleTable (
    num number,
    name VARCHAR2(20),
    phone varchar2(15),
    address varchar2(50)
);

select * from sampletable;  -- 전체보기
select name, address from sampletable;  -- 특정 필드만 보기

-- insert --
insert into sampletable values(10, 'doyeon', '010-9872-0202', '서울');
insert into sampletable values(20, '강감찬', '010-5555-8888', '부산');
insert into sampletable(name, address, phone, num)values('aa', 'jeju', '2222', 30);
insert into sampletable(name, address)values('bb', '3333');






