---------------------- SubQuery (��������) ----------------------------------------------
select * from emp2;
select * from emp2 where name = '�����';
select * from emp2 where pay > 60000000 ;

select * from emp2 where pay > ( select pay from emp2 where name = '�����' ) ;
--����1]  emp2 ��� �޿����� ���� ��� ����ϼ���.
select avg(pay) from emp2;
select * from emp2 where pay < 43100000 ;

select * 
  from emp2 
  where pay < ( select avg(pay) from emp2 ) ;
  
--����2] Student ���̺�� department ���̺��� ����Ͽ� ������ �л��� ����(deptno1)�� ������ �л�����
--          �̸��� 1���� �̸��� ����ϼ���.
select * from department2;
select * from student;
drop table department2;

CREATE TABLE "DEPARTMENT2" 
   (	"DEPTNO" NUMBER(3,0), 
	"DNAME" VARCHAR2(25 BYTE), 
	"PART" NUMBER(3,0), 
	"BUILD" VARCHAR2(20 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
REM INSERTING into DEPARTMENT2
SET DEFINE OFF;
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (101,'��ǻ�Ͱ��а�',100,'������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (102,'��Ƽ�̵����а�',100,'��Ƽ�̵���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (103,'����Ʈ������а�',100,'����Ʈ�����');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (201,'���ڰ��а�',200,'���������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (202,'�����а�',200,'�������');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (203,'ȭ�а��а�',200,'ȭ�нǽ���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (301,'���������а�',300,'�ι���');
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (100,'��ǻ�������к�',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (200,'��īƮ�δн��к�',10,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (300,'�ι���ȸ�к�',20,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (10,'��������',null,null);
Insert into DEPARTMENT2 (DEPTNO,DNAME,PART,BUILD) values (20,'�ι�����',null,null);
  
--����2] Student ���̺�� department ���̺��� ����Ͽ� ������ �л��� ����(deptno1)�� ������ �л�����
--          �̸��� 1���� �̸��� ����ϼ���.
select * from department2;
select * from student;

select deptno1 from student where name = '������';

select name, dname
  from STUDENT s , department2 d
  where    s.deptno1 = d.DEPTNO ;

select name, dname
  from STUDENT s , department2 d
  where  s.DEPTNO1 = ( select deptno1 from student where name = '������' )  
  and s.deptno1 = d.DEPTNO ;

--����3] Professor ���̺��� �Ի����� �۵��� �������� ���߿� �Ի��� ����� �̸��� �Ի���, �а����� ����ϼ���.
select hiredate  from professor where name='�۵���'; 

select p.name, p.hiredate, d.dname
  from professor p , DEPARTMENT2 d
  where hiredate > ( select hiredate  from professor where name='�۵���' )  -- �Ի��� ����/ ������ �ε�ȣ �����ϸ� ��
  and p.deptno = d.DEPTNO ;

--����4] Student ���̺��� 1����(DEPTNO1)�� 101�� �а��� ��� �����Ժ��� �����԰� ���� �л����� 
--          �̸��� �����Ը� ����ϼ���.
select avg(weight) from student where deptno1 = 101 ;

select name, weight
  from student 
  where weight > 60 ;

select name, weight
  from student 
  where weight > (select avg(weight) from student where deptno1 = 101) ;
-------------------------------------------------------------------------
select * from dept2;
select dcode from dept2 where area='��������' ;
select * from emp2;

select empno, name, deptno
  from emp2
  where DEPTNO in( 1000, 1001, 1002, 1010 );

select empno, name, deptno
  from emp2
  where DEPTNO in( select dcode from dept2 where area='��������' );

----������~ -----------------------------------------------------------------------------------------
-- EMP2 ���̺��� ����Ͽ� ��ü ���� �� ���� ������ �ּ� �����ں��� ������ ���� ����� �̸��� ����,
-- ������ ����ϼ���. �� ���� ��� ������ �Ʒ��� ���� õ ���� ���б�ȣ�� �� ǥ�ø� �ϼ���
SELECT NAME, POSITION, PAY FROM EMP2 WHERE 1=1 AND POSITION != '����'
    AND PAY > ANY(SELECT PAY FROM EMP2 WHERE POSITION = '����');
----------------------------------------------------    
SELECT  name "�̸�", position "����", TO_CHAR(pay, '999,999,999')||'��' "����"
  FROM   emp2
  WHERE  pay > ANY ( SELECT pay FROM emp2  WHERE     position = '����') ;   
  
-------------------------------------------------------------------
--student ���̺��� ��ȸ�Ͽ� ��ü �л� �߿��� ü���� 4�г� �л����� ü�߿��� ���� ���� ������ 
--�л����� ���� �л��� �̸��� �г�� �����Ը� ���.
SELECT name "�̸�", grade "�г�",  weight "������"
  FROM  student
  WHERE  weight < ALL (SELECT  weight FROM  student WHERE  grade = 4) ;
-----------------------------------------------------------------------------
select name || '(' || position ||')' || ',' || name ||' ' || position || ''
  from professor ;
  
select name || '(' || position ||')' as "�̸�" , name ||'   "' || position || '"'  
  from professor ;
 
--------------------------------------------------
--student ���̺��� ��ȸ�Ͽ� �� �г⺰�� �ִ� Ű�� ���� �л����� �г�� �̸��� Ű�� ���.
SELECT grade "�г�", name "�̸�", height "Ű"
  FROM  student
  WHERE (grade, height) IN( SELECT grade, MAX(height)  FROM  student GROUP BY grade ) ;

  -----------------------------------------------------------------------
-- professor ���̺��� ��ȸ�Ͽ� �� �а����� �Ի����� ���� ������ ������ ������ȣ�� �̸�, �Ի���, �а����� ���. 
-- ��, �а�������� �������� ����.
SELECT  p.profno "������ȣ", p.name "�̸�", p.hiredate "�Ի���", d.dname "�а���"
  FROM professor p, department2 d
  WHERE p.deptno = d.deptno  AND (p.deptno, p.hiredate) 
    IN ( SELECT deptno, MIN(hiredate) FROM professor  GROUP BY deptno ) 
    order by 4;  -- �Ǵ� order by dname

select * from department2;  
----------------------------------------------
--Emp2 ���̺��� ��ȸ�Ͽ� ���޺��� �ش� ���޿��� �ִ� ������ �޴� ������ �̸��� ����, ������ ����ϼ���. 
--���������� �������� �����ϼ���.
select name "�̸�", position "����", pay "����"
   from emp2
   where (position, pay) in( select position, Max(pay) from emp2 group by position )
   order by 3 ;
----------------------------------------------------------------------------------

--�������� Ȯ��(���̺� & Į��) �� ���� ���� ���� 

--�������� Ȯ��
SELECT	* 
  FROM	 ALL_CONSTRAINTS
  WHERE	TABLE_NAME = '���̺��';
  
SELECT	* 
  FROM	 ALL_CONSTRAINTS
  WHERE	TABLE_NAME = 'emp';


SELECT	A.UNIQUENESS,
	B.*
  FROM	 ALL_INDEXES A,
  ALL_IND_COLUMNS B
  WHERE	A.INDEX_NAME = B.INDEX_NAME
  AND A.TABLE_NAME='���̺��';


--�������� ����
ALTER TABLE ���̺�� DROP CONSTRAINT �������Ǹ� CASCADE;


--�ε��� ����
CREATE UNIQUE INDEX PK�� ON ���̺�� (�÷���1, �÷���2....);


--PK ����
ALTER TABLE ���̺�� ADD (CONSTRAINT PK�� PRIMARY KEY (�÷���1, �÷���2....));



