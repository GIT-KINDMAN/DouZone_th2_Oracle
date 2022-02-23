select * from student;
select * from student where deptno = 103;
select name, rtrim(regexp_replace(name, '(.)' , '\-1' ), '-') "변경후"
    from student
    where deptno1 = 103;
    
select name, rtrim(regexp_replace(birthday, '(/)' , '\\' ), '-' ) "변경후"
    from student
    where deptno1 = 103;
    
select * from reg_test;

-- 4) 날짜함수
select sysdate from dual; -- 한국식
select to_char(sysdate, 'YYYY-MM-DD HH:MI:SS') from dual; -- Month와 Minute은 겹칠 수 있어서 분을 Mi로 표기
select to_char(sysdate, 'YY-MM-DD HH:MI') from dual;
select to_char(sysdate, 'YY-MM-DD') from dual; -- 하지만 게시판은 밀리초 단위도 재야할 수 있다 descending 때문에
select to_char(sysdate, 'YYYY-MM-DD HH24:MI:SS') from dual; -- 24시간 표기법

-- ppt 3장 퀴즈 1)
-- 문자 함수 퀴즈 1)
-- Student 테이블을 참조해서 아래 화면과 같이 1 전공이 (deptno1 칼럼) 101번인 학생의 이름과 전화번호와 지역번호를 출력하시오.
-- 단, 지역 번호는 숫자만 나와야 한다.

--instr(tel, ')' );
select name, tel, instr(tel, ')' ) 지역번호 from student; -- )의 인덱스 출력 --> 서울만 3

-- substr(tel, 시작위치, 뽑을갯수);
-- substr(tel, 시작위치);
select name, tel, substr(tel, 1, instr(tel, ')') -1 ) 지역번호 from student;

select dname, substr(dname, 3) from dept2;
select dname, substr(dname, 2, 3) from dept2;


/* 잠시 어제꺼 연장

select concat(name, position) || '님' from professor;

select name || position || '님'
    from professor where deptno=101;
    
-- order by !!
select * from emp2
    order by name, deptno desc, pay desc;
    
select * from emp2
    order by 2, 4 desc, 8 desc; -- 속성 순서. 2=Name, 4=Deptno, 8=pay
    
*/ -- 끝

select name, tel, substr(tel, 1, instr(tel, ')') -1 ) 지역번호
    from student
    where deptno1=101;
    
-- 문자 함수 퀴즈 3)
-- Dept2 테이블을 사용하여 dname을 오른쪽의 결과가 나오도록 쿼리를 작성하세요.
select * from dept2;
-- rpad(필드명, 전체자리수, 표현되길 원하는 기호;
select rpad(dname, 10, substr('1234567890', length(dname)-2)) "RPAD연습"
    from dept2
    where dname is not null;

select rpad(dname, 10, substr('1234567890', length(dname)+1)) "RPAD연습" from dept2;

-- 두 개의 date 사이의 month 기간 도출 + floor로 버림처리
select floor(Months_between(to_date('02-23-2022', 'MM-DD-YYYY'),
                                 to_date('01-01-2000','MM-DD-YYYY'))) "MONTHS"
                                 from dual;
                                 
select ceil(Months_between(sysdate, birthday)) "MONTHS" from emp2; -- ceil=올림

-- 개월 수 추가
select hiredate, to_char (ADD_MONTHS (hiredate, 1), 'DD-MM-YYYY') from professor; -- 고용된 달로부터 MM+1
select hiredate, to_char (ADD_MONTHS (hiredate, 1), 'DD-MON-YYYY') from professor; -- o월 (한글)
select hiredate, to_char (ADD_MONTHS (hiredate, 1), 'DD-MM-YYYY')
    from professor
    where name='나사장';
    --where name='심슨'; -- 고용된 달로부터 MM+1

-- 오늘 이후의 날짜 중 가장 가까운 지정한 요일 해당 날짜
select next_day('2023/02/23', 2) "Next Day" from dual; -- 1: 일요일, 2: 월요일, ...
select next_day('2021/02/23', 6) "Next Day" from dual; -- 6: 금요일

select sysdate, last_day(sysdate) "Last day",
                    last_day(sysdate) - sysdate "Days Left" from dual; -- last day까지 sysdate로부터 남은 날짜
    
select birthday, last_day(birthday) "Last day" from emp2; -- 생일이 있는 월의 가장 마지막 날짜

select to_char(2000, '999,999'), -- 형식 지정: 000,000
         to_char(2000, 'L999,999'), -- 형식 지정: 숫자 앞에 L + 000,0000
         to_char(2000, '$999,999') from dual; -- 형식 지정: 숫자 앞에 $ + 000,000
         
         
-- 부서번호가 10이면 ACCOUNTING, 20이면 RESEARCH, 30이면 SALES
-- 나머지는 OPERATIONS를 출력하는 예제
SELECT deptno, DECODE(deptno, 10 , 'ACCOUNTING' ,
                              20 , 'RESEARCH' ,
                              30 , 'SALES', 'OPERATIONS') name
  FROM dept;
-- 위와 아래가 결과는 일단 같긴함
select deptno, dname from dept;


select * from emp;

-- 10부서는 급여합계를, 20부서는 최대값을, 30부서는 최소값을 출력하는 예제
-- 의의: 프로시저나 이런거에서 사용될 때 이름? 지정이 가능하다던가? 그런가봄? 여기서 decode 덕분에 각 DEPTNO 별 SAL로 표기 가능하다는 것 같은데
SELECT deptno, DECODE(deptno, 10 , SUM(sal),
                              20 , MAX(sal),
                              30 , MIN(sal)) sal
  FROM emp
 GROUP BY deptno;
 

-- 부서별로 급여 합계를 출력한다. 
SELECT deptno, NVL(SUM(DECODE(deptno, 10, sal)),0) deptno10, 
               NVL(SUM(DECODE(deptno, 20, sal)),0) deptno20,
               NVL(SUM(DECODE(deptno, 30, sal)),0) deptno30,
               NVL(SUM(DECODE(deptno, 40, sal)),0) deptno40
  FROM emp
 GROUP BY deptno; 
 
 --위의  DECODE예제를 CASE함수로 변환한 예이다. 
SELECT deptno, 
       CASE deptno
         WHEN 10 THEN 'ACCOUNTING'
         WHEN 20 THEN 'RESEARCH'
         WHEN 30 THEN 'SALES'
         ELSE 'OPERATIONS'
       END as "Dept Name"
  FROM dept;
  
  --급여별로 인상율을 다르게 계산하였다. 
SELECT ename, sal,
      CASE
         WHEN sal < 1000  THEN sal+(sal*0.8)
         WHEN sal BETWEEN 1000 AND 2000 THEN sal+(sal*0.5)
         WHEN sal BETWEEN 2001 AND 3000 THEN sal+(sal*0.3)
         ELSE sal+(sal*0.1)
      END sal인상후
FROM emp;
  
-- decode(Area, %지사, '지사' ? '지사아님'

select * from dept2;
-- pdept에 따라서 지사명을 출력하세요 (dcode, case 이용)
SELECT pdept,
     CASE
        WHEN AREA like '%지사' THEN substr(AREA, 0,2)
        ELSE '본사'
     END 지사
FROM dept2;
    
    
