select * from emp2;
select sysdate from dual;

select * from de_test;

create table test2
(
  no number not null, --primary key, -- number, -- 4bye ( -9999 ~ 9999 )
  name varchar2(10) not null,
  birdate date, -- ���� ���� : '��-��-��' or '��/��/��' '88-12-30' , '88/12/30'
  age number,
  constraint no_pk primary key(no)
);
-- ���÷��߰�
--alter table ���̺��̸� add
--    (�÷����ڷ���[��������] , �÷����ڷ���[��������] , ....)

select * from userlist;
alter table userlist add phone varchar2(15);
alter table userlist add ( no number(2), gender char(2) ); 

update userlist set no=1 ; -- ��ü ����
update userlist set phone= '111-222' where id='smile'; -- ���ǿ� �´°͸� ����
update userlist set gender='F', phone ='999-888' where id='kingsmile';

--���÷�����
--alter table ���̺��̸� drop column �÷��̸�
alter table userlist drop COLUMN no;
alter table userlist drop (name, gender); 

--��datatype����
--alter table ���̺��̸� modify �÷��̸� �����ڷ���
select * from userlist;
desc userlist;
-- �⺻ �����Ͱ� �־��� ��� ���� �߻� ���� ����
alter table userlist modify gender numbr; 
alter table userlist modify no varchar2(20);  -- �÷��� ������ ������ ��� Ÿ�� ���� ������

update userlist set phone ='';  -- phone = null;
alter table userlist modify phone number;
rollback;  -- ��� (DML��ɾ�� �����) 

--���÷��̸�����
--alter table ���̺��̸� rename column �����÷��� to �����÷���
alter table userlist rename column phone to tel;
alter table userlist rename column no to num;
select * from userlist;

--�����̺����
--drop table ���̺��̸�
drop table userlist;

select * from userlist2;
delete from userlist2;  -- ���ڵ� ����
desc userlist2;
drop table userlist2;

-- ���� ���̺� ��� ����
show recyclebin;
desc recyclebin;
-- ����(������ ���̺�)
FLASHBACK table userlist to before drop;
-- ������ ���� 
purge recyclebin;
select * from userlist;

drop table userlist PURGE; -- �����뿡 �ȳ���� ���� ����

-- ���ڵ� ����/ ����/ ���� -------------------
--insert into ���̺��̸�(�÷���, �÷���,...) values(��, ��, ...)
--insert into ���̺��̸� values(��, ��, ...)
--   =>����÷��� ��ΰ��� ������ ���

--update ���̺��̸� set �÷���=���氪, �÷���=���氪, �÷���=���氪, .....[ where ���ǽ�]

--Delete table�̸� [ where ���ǽ� ]
--truncate table ���̺��̸�; => ��緹�ڵ����
select * from emp2;
delete emp2;   --delete from emp2; -- ���ǿ� �´°͸� ����
rollback;
delete emp2 where emp_type='������';

TRUNCATE table emp2; -- where emp_type='������';  where�� ��� ����, rollback �ȵ�.

--select distinct | * | �÷��� as ��Ī, �÷���Ī,....
--    from ���̺��̸�
--    [where ���ǽ�]
--    [order by �÷��� desc | asc , .. ]

select distinct deptno --emp_type  -- distinct :�ߺ� �����ϰ� ������
--select name, emp_type, hobby, deptno
    from emp2;
    --where name='������';
    --where hobby = '���'
    --order by name desc; -- ����: asc / desc 

create table userlist (
    id varchar2(20),
    name varchar2(20)
); 

insert into userlist values('kingsmile', 'doyeon');
insert into userlist values('park', '�迬��');
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
���¿�����
*/




