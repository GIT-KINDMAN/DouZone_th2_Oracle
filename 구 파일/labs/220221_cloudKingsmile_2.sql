-- select ��Ī�ֱ�
select * 
    from emp2
    where position='����';

select empno, name, pay, position
    from emp2
    where position='����';
    
select empno as "�����ȣ", name "��  ��", pay  �޿�, position "��    ��"
    from emp2
    where position='����';
    
select empno as "�����ȣ", name "��  ��", pay  �޿�, position "��    ��"
    from emp2
    where position='����' and name='������';  -- and
    
    
select empno as "�����ȣ", name "��  ��", pay  �޿�, position "��    ��"
    from emp2
    where position='����' or name='�蹮ȣ';  -- or
    
select * from emp2 where deptno=1000;    -- ����

select *
    from emp2
    where name like '��%';   -- % : ���,   _ : �ѹ��� 

select *
    from professor
--    where name like '%��%';      
     where name like '%��';  
    
select *
    from professor    
--     where name like '��_';
--      where name like '_��';
        where name like '__';  -- �̸��� �α�����~ 

select *
    from professor    
       where name like '%��_';  
       
-- ����
select *
    from professor  
--    where pay > 500;
--    where pay <= 300;
--      where pay >= 250 and pay < 500;       
      where pay <= 250 or pay < 500;
       
select * from professor where bonus is not null;       
select * from professor where bonus is null;   

--����1] �޿��� 500�̻��̰�, ���ʽ��� 60�̻� �޴� ������? (professor table)
select * 
    from professor
    where pay >= 500 and bonus >= 60;

--����2] �̸��� '���Ѷ�'�� '���Ѷ�'���� ���� (emp2)
select * from emp2 where name='���Ѷ�';
update emp2 set  name='���Ѷ�' where name='���Ѷ�';

--����3] ��̰� ����� ����鸸 ã�Ƽ� '����'���� ����
select * from emp2 where hobby= '���';
update emp2 set hobby='����' where hobby= '���';
select * from emp2 where hobby= '����';

--����4] ����� ���� ã�Ƽ� �����ϱ�
select * from emp2 where EMP_TYPE = '�����';
delete
    from EMP2
    where EMP_TYPE = '�����';

--����5] pay(or bonus)�� 50�̻��� ����� ��� (professor )
SELECT *
    from professor
--        where bonus >=50;
        where pay >=450;

--����6] ~��Ʈ�� �ƴ� ��ǰ�鸸 ��� ( gift table)
select * from gift;
select * from gift where gname not like '%��Ʈ';

--����7] gno�� 10�� ��ǰ�� �̸��� ��ó��(null) �ϼ���.
select * from gift where gno=10;
update gift set gname=null where gno=10;

--����8] gname �̸��� ����, g_start�� 999�� ���� ���� ������ �Է��ϼ���.
desc gift;
insert into gift(gno, g_start) values (11, 999);
insert into gift(gname, g_start) values (' ', 999);
select * from gift;

--����9] gname�� null�̰ų� ' ' �� �����͸� �����ϰ� ����Ͻÿ�.
select * from gift where gname is null or gname=' ';
select * from gift where gname is not null and gname != ' ';  -- != 
select * from gift where gname not in('null', ' ') order by gno desc;

-- ������ --------------------------------
select mod(7, 3) from dual;  -- ������
select 7/3 from dual;  --��

-- null ������ ������ null
select name, pay,bonus from professor;
select name, pay, nvl(bonus, 0) from professor;

update professor set bonus = bonus+100 ;
update professor set bonus = nvl(bonus, 0)  + 100 ;
ROLLBACK;

select * from gift;
select * from gift where gno=1 or gno=3 or gno=7;
select * from gift where gno in(1,3,7);  -- ���� 
select * from gift where gno not in(1,3,7);
-- between �տ� ���� ������ and �ڿ��� ū��
select * from gift where gno BETWEEN 6 and 9;
select * from gift where gno BETWEEN 9 and 6; -- �ȵ�
select * from gift where g_end BETWEEN 600000 and 800000;

--������ �̸鼭 '�����' ã��

--������ �̰ų� '������' ã��

--������ �̰ų� �达���� ���� ��� ã��

--�达�� �ƴ� �������� ã��
select * from emp2 where emp_type='������' or name not like '��%';

--����1] �̸����� '�迵��' ������� �����ּ���.
    select * from professor where name='�迵��'
--����2] �̸����� '��'�� ���� ���� ������� �����ּ���.  - ��� : % , �ѱ��� : _
    select * from professor where name like '��%'
--����3] �̸��� �� ������ ��� �����ּ���.
 select * from professor where name like '__'
 
 select * from professor where name like '_��_'
 select * from professor where name like '_��_' or name like '__��_'
 select * from professor where name like '_��'
 select * from professor where name like '%��%'
 
--����4] id�� s or a ���ڰ� ���� ��� ã��
  select * from professor where id like '%s%' or id like '%a%'
  
  select * from professor where id like '%s%' or id like 'a%'
  select * from professor where id like 's%' or id like 'a%'
  
--����5] ���Ӱ��� ã���ּ���
  select * from professor where position like '���Ӱ���'
 
  select * from professor where position = '���Ӱ���'
  select * from professor where position like '��%'
 
 -- ����>
-- create table ���̺�� ( �ʵ�� �ڷ���(ũ��), �ʵ�� �ڷ���(ũ��),..... ); 
 -- kosa2  table create  - �̸�name, ����loc, ����óphone
 create table kosa2 ( name varchar2(10), loc varchar2(20), phone varchar2(15));
 
 insert into kosa2 values('doyeon', 'seoul', '000');
 insert into kosa2 values('doyeon2', 'busan', '3456');
 insert into kosa2(name, phone) values('doyeon3','9999');
 insert into kosa2(loc, phone) values('jeju','7777');
 
--cf)
select name, position from professor;
select name || position from professor;  -- �ʵ�� �ʵ� �����ؼ� ���

--����1 **
--Professor ���̺��� �������� �̸��� ��ȸ�Ͽ� ���κп� ������ �� ���Ե� ����� ����� �Ʒ��� ���� ��� �ϼ���.
select * 
    from professor
    where name >= '��' and name < '��';   -- ���Ѱ� ���� ���Ѱ� ������
--    where name >= '��' and name < 'ó';  -- ������ ���� 
       
select * 
    from professor
    where name between '��' and '��';   -- '��' �̻� '��' �̸�
       
select * 
    from professor
    where name between '��%' and '��%'
    order by 1;    -- ����  (�����Ұ�!! )    
       
--����6] �г��� 3�г�(grade)�̰� Ű(height)�� 165�̻��� �а��ڵ�(deptno1)�� 101�� �л� ã��
select * from student;
--����7] ������ 77�� ������ �л��� ã��
--����8] ������(deptno2)�� ���� �л��鸸 ã��
--����9] ��米��(profno)�� 1000 ~ 2001 ���� �л��� ã��

       
       
       
    
    
    
    
    
    
    