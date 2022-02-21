-- http://www.gurubee.net/lecture/1028
select * from dept;

SELECT deptno, DECODE(deptno, 10 , 'ACCOUNTING' ,
                              20 , 'RESEARCH' ,
                              30 , 'SALES', 'OPERATIONS') name
  FROM dept;
  
select * from emp;
SELECT deptno, DECODE(deptno, 
                              10 , SUM(sal),
                              20 , MAX(sal),
                              30 , MIN(sal)) sal
  FROM emp
 GROUP BY deptno; 

-- �μ����� �޿� �հ踦 ����Ѵ�. 
SELECT deptno, NVL(SUM(DECODE(deptno, 10, sal)),0) deptno10, 
               NVL(SUM(DECODE(deptno, 20, sal)),0) deptno20,
               NVL(SUM(DECODE(deptno, 30, sal)),0) deptno30,
               NVL(SUM(DECODE(deptno, 40, sal)),0) deptno40
  FROM emp
 GROUP BY deptno; 
-------------------------------------------------------------------------------
-- http://cheezred.tistory.com/35
select *
  from reg_test;

select *
  from reg_test
  where REGEXP_LIKE (text, '([aeiou])\1', 'i')  -- ���ڿ�(�Ǵ� ���ڿ� ���� �ʵ��), ����, i : ��ҹ��ڱ��о��Կɼ�
order by last_name;

select *
  from reg_test
  where REGEXP_LIKE(text, '[abc]' );  -- [ �� ] ���̿� �ִ� ���ڵ� �� �ϳ�

select *
  from reg_test
  where REGEXP_LIKE(text, '[a-z][0-9]' );   -- �ҹ��� a~z ����

select *
  from reg_test
  where REGEXP_LIKE(text, '[a-z] [0-9]' );   -- �ҹ��� a~z ���� ����
  
insert into reg_test values('789ABC');
insert into reg_test values('789 ABC');
insert into reg_test values('123kbs');
insert into reg_test values('mbc567');
insert into reg_test values('sbs 567');

-- �ҹ��ڳ� �����̳� ���ڰ� ���� �� 
SELECT * FROM REG_TEST WHERE regexp_like(text, '[a-z]?[0-9]');
SELECT * FROM REG_TEST WHERE regexp_like(text, '[0-9]?[a-z]');
SELECT * FROM REG_TEST WHERE regexp_like(text, '[A-Z]*[0-9]');

-------------------------------------------------------------------------
--����  DECODE������ CASE�Լ��� ��ȯ�� ���̴�. 
select * from dept2;

SELECT dcode, 
       CASE dcode
         WHEN '1000' THEN 'ACCOUNTING'
         WHEN '1002' THEN 'RESEARCH'
         WHEN '1003' THEN 'SALES'
         ELSE 'OPERATIONS'
       END as "Dept Name"
  FROM dept2;

----------------------------------------------
--�޿����� �λ���� �ٸ��� ����Ͽ���. 
select * from emp;
SELECT ename ,
       CASE
          WHEN sal < 1000  THEN sal+(sal*0.8)
          WHEN sal BETWEEN 1000 AND 2000 THEN sal+(sal*0.5)
          WHEN sal BETWEEN 2001 AND 3000 THEN sal+(sal*0.3)
          ELSE sal+(sal*0.1)
       END sal
  FROM emp; 
  
select * from professor;

select name, pay, 
  CASE
      WHEN pay < 200 THEN pay + (pay*0.8)
      WHEN pay BETWEEN 200 and 300 THEN pay+(pay*0.5)
      WHEN pay BETWEEN 400 and 500 THEN pay+(pay*0.3)
      ELSE pay + (pay*0.5)
      END pay
    FROM professor;
