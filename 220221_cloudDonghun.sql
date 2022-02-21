select * from emp2;
delete emp2 where name like  '%��';

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


-- �÷��߰�
--alter table ���̺��̸� add
-- (�÷����ڷ���[��������], �÷����ڷ���[��������], ....)

select * from userlist;
alter table userlist add name varchar2(15);
alter table userlist add phone varchar2(15);
alter table userlist add (no number(2), gender char(2));

update userlist set no=1; -- ��ü ����
update userlist set gender='M', phone='111-222' where id='donghun';
update userlist set gender='F', phone='999-888' where id='aa';

--2. �÷� ����
--alter table ���̺��̸� drop cloumn �÷��̸�
alter table userlist drop column no;
-- !!! ���ŵ� no �÷��� �޸� ���� �� �������μ� �ڸ��� �����ϰ� �ִ�. GC������ ������ �״�� �޸� ����Ǵ� ���� �ܰ迡�� ������ ��!!!

alter table userlist drop (name,gender);

--3. datatype ����
--alter table ���̺��̸� modify �÷��̸� �����ڷ���
select * from userlist;
desc userlist;

alter table userlist modify gender number;
alter table userlist modify no varchar2(20); -- �÷��� ������ ������ ��� Ÿ�� ���� ������. ������ ������ �̰ŷδ� �Ұ���

update userlist set phone =''; -- phone�� ��� null�� ó���ϰ�
alter table userlist modify phone number; -- Ÿ�� ����

ROLLBACK; -- ��� ���������, �̰� DML ��ɾ ���ظ� �����. e.g. create ��

--4. �÷��̸�����
--alter table ���̺��̸� rename column �����÷��� to �����÷���
alter table userlist rename column phone to tel;
alter table userlist rename column no to num;
select * from userlist;

--5. ���̺����
-- drop table ���̺��̸� (������ �Ұ�)
drop table userlist;

select * from userlist2;
delete from userlist2; -- ���ڵ�'��' ����
desc userlist2;
drop table userlist2;

-- ���� ���̺� ��� ���� (������ ���� Ȯ���ؾ� �ϴ� ��� ���� ��)
show recyclebin;
desc recyclebin;

-- ����(������ ���̺���)
FLASHBACK table userlist to before drop; -- �ش� ���̺��� ���� ���� ���·� �����޶�
select * from userlist; -- ����

purge recyclebin; -- ������ ����(���� ����)
show recyclebin;
-- ������ ������ ���� Ȯ���� �� ����


drop table userlist PURGE; -- �������� ��ġ�� �ʰ� ��õ ����

-- ���ڵ���� / ���� / ���� --------------
-- insert into ���̺��̸�(�÷���,�÷���,...) values (��, ��, ...)
-- insert into ���̺��̸� values (��, ��, ...) --> ��! ���̺��� �Ӽ��� ���� ���Ѿ���!


-- update ���̺��̸� set �÷���=���氪, �÷���,���氪, ... where ���ǹ�

-- Delete table�̸� [where ���ǻ�]
-- truncate table ���̺��̸�; => ��� ���ڵ� ����
select * from emp2;
delete emp2; -- delete from emp2�� �����
rollback;
delete emp2 where emp_type='������';

TRUNCATE table emp2; -- where emp_type='������' , DML ��ɾ �ƴϱ� ������ rollback�� �ȵ�

--select distinct | * | �÷��� as ��Ī, �÷���Ī,...
--  from ���̺��̸�
--  [where ���ǽ�]
--  [order by �÷��� desc | asc , ... ]

select *
    from emp2
    where name='������';
    
select distinct deptno --emp_type -- �ߺ� �����ϰ� ������ --> distinct
-- select name, emp_type, hobby
    from emp2;
    --where name='������';
    --where hobby = '���'
    --order by name desc; -- ����: asc/desc

create table userlist (
    id varchar(20),
    name varchar(20)
);

insert into userlist values ('1', 'LEE');
insert into userlist values ('2', 'PARK');
insert into userlist (id) values ('3'); -- �̰Ŷ�
insert into userlist (name) values ('KIM'); -- �̰Ŵ� �� �ٿ� �¹����� ����! (3, (null)) , ((null), KIM)��
insert into userlist (id) values ('kang2');

select * 
    from userlist
    --where name=null; -- name=null�� �ȵ�
    --where name is null;
    where name is not null; -- null�� is�� ������ �����Ͱ� ������ is �ȵǰ� like = �� �ǳ���
    
update userlist set name=' ' where id like 'kang2'; -- null�̶� ������ �ʴ� ����

select *
    from userlist
    where name is null or name=' '; -- null�̰ų� �����ڰ� �Ϻη� ����ó����, �� �������� null�� ��� ������ Ž��

-- select ��Ī �ֱ�
select *
    from emp2
    where position='����';

select empno "�����ȣ", name "��    ��", pay "��       ��", position "��     ��"
    from emp2
    where position='����';

select empno "�����ȣ", name "��    ��", pay "��       ��", position "��     ��"
    from emp2
    --where position='����' and name like '������';
    --where position='����' and name like '�蹮ȣ'; -- ��� �ȳ���
    where position='����' or name like '�蹮ȣ'; -- �븮 �蹮ȣ �� ����� ���
    
select * from emp2 where deptno=1000; -- ����

select *
    from emp2
    where name like '��__'; -- ���ϵ�ī��: like + ( % : ���), ( _ : �ѹ��� --> __ �� ���ڼ� ���� ����)
    
select *
    from professor
    --where name like '%��%';
    where name like '%��';
    
select *
    from professor
    --where name like '��_';
    --where name like '_��';
    where name like '__'; --��� �α��� ���ڵ� ���
    
select *
    from professor
    where name like '%��_';
    
select *
    from professor
    --where pay>500;
    --where pay<=300;
    --where pay>=250 and pay<500;
    where pay<=250 or pay<500;
    
select * from professor where bonus is not null;
select * from professor where bonus is null;

--����1] �޿��� 500�̻�, ���ʽ��� 60 �̻��� ���� ã��
select * from professor where pay>500 and bonus>60;

--����2] �̸��� '���ѳ�'��� ����� '���Ѷ�'�� �����غ��� ) emp ���̺�
update emp2 set name='���Ѷ�' where name = '���ѳ�';

--����3] ��̰� ����� ����鸸 ã�Ƽ� �������� ����
update emp2 set hobby='����' where hobby='���';

--����4] ����� ���� ã�Ƽ� �����ϱ�
delete emp2 where emp_type = '�����';

--����5] pay�� 450, bonus�� 50 �̻��� ����鸸 ��� (professor)
select * from professor where pay>=450 or bonus>50;

--����6] ~��Ʈ�� �ƴ� ��ǰ�鸸 ��� (gift ���̺�)
select * from gift where GNAME not like '%��Ʈ';

--����7] gno�� 10�� ��ǰ�� �̸��� ��ó��(null) �϶�
update gift set gno=null where gno=10;

--����8] gname �̸��� ����, g_start�� 999�� ���� ���� ������ �Է��϶�
insert into gift (gno, g_start) values (11,999);

--����9] gname�� null�̰ų� ' '�� �����͸� �����ϰ� ����϶�
select * from gift where gname is not null and gname not like ' ';
select * from gift where gname not in('null', ' ' );
select * from gift where gname not in('null', ' ' ) order by gno desc; -- gno ���� �������� ����

-- ������ -------------------
select mod(7,3) from dual; -- ������
select 7/3 from dual; -- ��

-- null ������ ������ null?
select name, pay,bonus from professor;
select name, pay, nvl(bonus, 0) from professor;

update professor set bonus = bonus + 100; -- null + 100�� null
update professor set bonus = nvl(bonus, 0) + 100; -- nvl(bonus, 0) ��: bonus�Ӽ��� null�� �ϰ������� 0���� �ʱ�ȭ�϶�
rollback;

select * from gift;
select * from gift where gno=1 or gno=3 or gno=7;
select * from gift where gno in(1,3,7); -- ����. ����: ������ �ξ� ����
select * from gift where gno not in(1,3,7); -- ������

select * from gift where gno BETWEEN 6 and 9;
select * from gift where gno BETWEEN 9 and 6; -- ������ ������ ���� �۵�X. ����: ���� ���� ������ �;���. ������ ���� �츦 �����ϸ� ���ҵ�
select * from gift where g_end BETWEEN 600000 and 900000;


select * from emp2;
--�������̸鼭 '�����' ã��
select * from emp2 where emp_type like '������' and name like '�����';
--�������̰ų� '������' ã��
select * from emp2 where emp_type = '������' or name like '������';
--�������̰ų� �达���� ���� ��� ã��
select * from emp2 where emp_type = '������' or name like '��%';
--�达�� �ƴ� �������� ã��
select * from emp2 where emp_type = '������' and name not like '��%';

select * from emp2;
select * from gift;
    
--����1] �̸����� '�迵��' ������� �����ּ���. -- emp
select * from emp where name like '�迵��';

--����2] �̸����� '��'�� ���� ���� ������� �����ּ���.  - ��� : % , �ѱ��� : _ -- emp
select * from emp where name like '��%';

--����3] �̸��� �� ������ ��� �����ּ���. -- emp
select * from emp where name like '__';
 
--����4] id�� s or a ���ڰ� ���� ��� ã�� -- �������̺�
select * from professor where id like '%s%' or id like '%a%';
   
--����5] ���Ӱ��� ã���ּ��� -- �������̺�
select * from professor where position='���Ӱ���';

--����1 **
-- Professor ���̺��� �������� �̸��� ��ȸ�Ͽ� ���κп� '��'�� ���Ե� ����� ����� �Ʒ��� ���� ����ϼ���.
select *
    from professor
    where name like '��%';

select *
    from professor
    where name >= '��' and name < '��';
    
select *
    from professor
    where name between '��' and '��'; --'��'�̻� '��'�̸�
    
select *
    from professor
    where name between '��%' and '��%'
    order by 7; -- ����

select * from student;    

--����6] �г��� 3�г�(grade)�̰� Ű(height)�� 165�̻��� �а��ڵ�(deptno1)�� 101�� �л� ã��
select * from student where grade=3 and height>165 and deptno1 = 101;

--����7] ������ 77�� ������ �л��� ã��
select * from student where birthday <= TO_DATE('771231', 'YYMMDD');

--����8] ������(deptno2)�� ���� �л��鸸 ã��
select * from student where deptno2 is not null;

--����9] ��米��(profno)�� 1000 ~ 2001 ���� �л��� ã��
select * from student where profno between 1000 and 2001;
    
/*
[A_�����غ�] [���� 11:18] �� ��  ���ٶ��� ���� �ٸ�Ǯ���µ���?
[A_������] [���� 11:18] �� ���ٶ������ ������ ���߽��ϴ�
[A_�����غ�] [���� 11:18] �װ� ��ũ�ѷ� ȭ�� Ȯ���ϸ�
[A_�����غ�] [���� 11:18] �ذ�Ǳ��ؿ�
[A_�ڽŰ����Ƿ¿���] [���� 11:18] �����ڵ��� ���� 1�ÿ� ���ôº�? �׽�Ʈ ��ũ ���� ������������??
[A_�����غ�] [���� 11:18] ������ ��  �Ȱ��ҳ����׿�?
[A_������] [���� 11:19] �׷��� ��ճ׿�
[A_������] [���� 11:19] �װ͵� �𸣰ھ��.. ���� ��� ��°� ������ �ؼ�..
[A_�����غ�] [���� 11:19] ��� ��ձ� �߾��
[A_�����غ�] [���� 11:19] �� ���ڼ� ���ߴ°� ���ϴ°���?
*/