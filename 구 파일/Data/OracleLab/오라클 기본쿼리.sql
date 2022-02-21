--오라클 데이터베이스 관리시스템

--구축 :
-- 데이터베이스 모델링(설계)의 개념과 이론을 숙지하고 그에 입각한 데이터베이스를 설계
-- 이를 기반으로 오라클 데이터베이스 관리 시스템에 구축하기 위하여 데이터베이스 언어로써 SQL(Structured Query Language)을 사용
-- 오라클 데이터베이스 관리 시스템 내부에서 조금 더 복잡한 데이터 처리를 위하여 PL/SQL을 사용

--관리
-- 구축한 데이터베이스를 효율적으로 관리하는것
-- 데이터베이스가 불의의 사고로 종료되지 않고 언제든지 사용할수있도록 하는것
-- 빠른 조회와 높은 처리 성능을 내기 위해 데이터베이스를 튜닝
-- 인증 받지 않은 사용자로부터 데이터 베이스를 보호하는 보안의 책임을 지고 관리

--개발
-- 자바, C/C++, 비주얼베이직, 파워빌더, CGI, ASP, JSP, PHP등 다양한 개발 및 스크립트언어를 이용하여, 데이터베이스에 데이터를 입력하고, 조회 및 삭제하는 등의작업을 최종 사용자가 처리할수있도록 하는 일련의 행위


--개발자 바라보는  DATABASE
--DB잘하는 첫번째 방법
--**Table 구조를 명확하게 이해 (컬럼의 구조)
SELECT * FROM emp; --사원 테이블
SELECT * FROM DEPT;  --부서 테이블
SELECT * FROM BONUS;
SELECT * FROM SALGRADE; --급여 등급 테이블


--1. 문법 (데이터 조회 하기)
SELECT	[DISTINCT] 	{*, column [alias], . . .}
FROM		table_name
[WHERE		condition]
[ORDER BY	{column, expression} [ASC | DESC]];

--Table 정보 조회하기
DESC emp;

--Table 전체 데이터 조회
SELECT * FROM EMP;

--특정 컬럼 데이터 조회
SELECT empno, ename , sal FROM emp;
SELECT empno, hiredate FROM emp;

--[alias] 컬럼에 가명칭 부여하기

SELECT empno 사번 , ename 이름  FROM emp;
SELECT empno AS 사번 FROM emp;  --권장방법
SELECT ename AS "사번" FROM emp;

--오라클에서 문자 처리는 '문자'
--오라클에서  연결 연산자  ||
--hint) MS-SQL => || -> +(결합연산자)
SELECT '우리회사 사번은 ' || empno  || '입니다 ' AS empdata
    FROM emp;

SELECT empno , '0' AS data1 , 'bbbb' AS data2 , 'cccc' AS data3
    FROM emp;


SELECT '급여정보 ' || sal FROM emp;
-- + (산술연산자)
-- || (연결연산자)
SELECT 100 || 100 FROM dual; --100100
SELECT 100 + 100 FROM dual; --200

-- '100' 문자형 숫자
-- '100A' 문자형 숫자(x)
SELECT 100 + '100' FROM dual;  -- '100' 산술하기 위해 자동 형변환
SELECT '100' + '100' FROM dual; -- 둘다 형변환 -> 200
SELECT 'A' + 100  FROM dual;    -- Error

SELECT '100' + sal FROM emp;  --가능한 형태의 쿼리문 (자동 형변환)

--우리회사 직종 몇개나 있나 (데이터 좀 보자)
--중복 데이터 제거 (DISTINCT)
SELECT distinct job FROM emp;

SELECT deptno , job FROM emp;
--hint -> group  distinct 순서대로  구룹
SELECT DISTINCT deptno , job FROM emp;
--부서번호 구룹 -> job 으로 distinct

--------------------------------------------------------------
--산술연산자 (각 테이블의 컬럼의 타입 먼저 판단)
-- + , - , * , /
SELECT * FROM emp;
--사원의 월 급여 인상 100달러씩 인상하면 각 사원급여가 얼만인지 ......
SELECT empno,ename, sal AS 원급여 , sal +100 AS 인상급여
FROM emp;

--비교 연산자
-- <  ,  > ,  <= , >= , != , = (같다)      단 java  = 할당 ,   ==같다

--논리 연사자
-- AND , OR , NOT

--조건절 (where)
-- 이하(=) , 이상(=) , 초과 , 미만
SELECT *
FROM emp
WHERE sal > 3000;


SELECT empno, ename, job, sal  --3
FROM emp                            -- 1
WHERE sal >= 2000;                 --2

--사번이 7788번인 사원의 모든 정보를 출력
SELECT * FROM emp WHERE empno=7788;

--사원의 이름이 king 사원의  사번 , 이름 ,급여 정보를 출력
--오라클은[문자형 데이터] 대해서 [대소문자를 엄격]하게 구분한다
--hint) Ms-sql => 문자형 데이터 대소문자를 구별하지 않는다

SELECT * FROM emp WHERE ename = 'king';

SELECT * FROM emp WHERE ename = 'KING';

--급여가 2000달러 이상이면서 직종이 manager 인 사원의 모든 정보 출력
SELECT * FROM emp WHERE sal >= 2000 AND job='MANAGER';

--급여가 2000달러 이상이 거나 (또는) 직종이 manager 인 사원의 모든 정보 출력
SELECT * FROM emp WHERE sal >= 2000 OR job='MANAGER';


Select SQL 실행순서(오라클 SQL 기준)

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY


1) FROM table(s) [alias]
- FROM 절에 사용된 테이블을 인식하여 데이터 딕셔너리에서 관련된 정보들을 파악

2) [WHERE condition(s)]
- WHERE절에서 조건에 맞는 데이터를 추출

3) [GROUP BY column(s)]
- GROUP BY절이 추가되면 GROUP BY절에 사용된 항목별로 데이터의 정렬이 일어남

4) [HAVING condition(s)]
- HAVING 절은 GROUP BY절로 정렬이 된 데이터를 대상으로 조건을 정의.

5) SELECT {*, column(s) [alias],...}
- 대부분의 RDBMS가 ROW(로우)기준 저장구조입니다. SELECT이전까지 원하지 않는 칼럼까지도 데이터베이스의 메모리에 저장.

6 [ORDER BY column(s) [alias] [DESC],.....];
- ORDER BY절이 가장 나중에 실행.
- SELECT절에서 선택되지 않은 칼럼이나 연산도 데이터베이스의 메모리에 저장되어있으므로 ORDER BY절에서 사용



정리하자면 다음과 같다.

1.FROM 절에서 테이블의 목록을 가져옴
2.WHERE 절에서 검색 조건에 불일치 하는 행 제외
3.GROUP BY 절에서 명시된 행의 값을 그룹화
4.HAVING 절이 GROUP BY 절의 결과 행 중 검색 조건에 불일치 하는 행 제외
5.SELECT 절에서 명시된 열을 정리
6.ORDER BY 절에서 열을 기준으로 출력할 대상을 정렬 후 출력

/*
DML (데이터 조작어) 2일차
*/

SELECT * FROM emp;

--sqlplus----------------------------------
select * from nls_session_parameters;
NLS_DATE_FORMAT
--RR/MM/DD
NLS_DATE_LANGUAGE
--KOREAN
SELECT * FROM emp WHERE hiredate = '80/01/01';


--sqlgate
select * from nls_session_parameters;
NLS_DATE_FORMAT
--DD-MON-RR
NLS_DATE_LANGUAGE
--AMERICAN
--sqlgate 에서  위 와 동일한 결과를 얻는 쿼리문을 작성해 보세요
select * from emp where hiredate > '01-JAN-80';
-----------------------------------------------------------
--******내가 원하는 형태로 날짜 표기 및 입력을 가져 갈 수  없을 까*******
--한국인에게 가장 익수한 표현
SELECT * FROM EMP WHERE hiredate > '1980-01-01';


--날짜
--오라클 데이터베이스 설정 날짜
select sysdate from dual;   --DB서버 시간

--java -> jsp -> 게시판 글쓰기 -> insert into board(sDate) values( sysdate)
--MS-SQL 데이터 베이스
--select getdate()

--날짜 표기 방식 바꾸기
select sysdate from dual;
alter session set nls_date_format = 'YYYY-MM-DD HH24:MI:SS';
select * from nls_database_parameters
select * from nls_session_parameters;
--http://blog.naver.com/dgroups?Redirect=Log&logNo=10006253956

--위 설정 위지시 설명 파일 변경 및 regedit 변경을 통해서 ......~~


SELECT * FROM EMP WHERE hiredate > '1980-01-01';

SELECT * FROM EMP WHERE hiredate = '1981-02-20';

--사원의 급여 2000이상 4000이하인 모든 사원의 정보를 출력하세요
select * from emp
where sal >= 2000 and sal <= 4000

--연산자 (between A and B)
select * from emp
where sal between 2000 and 4000;    -- =가지고 있다

--사원의 급여 2000초과  4000미만인 모든 사원의 정보를 출력하세요
select * from emp
where sal > 2000 and sal < 4000

--부서번호가 10번이 사원들의 모든 정보를 출력하세요
select * from emp  where deptno=10;

--부서번호가 10번 또는 20번 또는  30인 사원의 모든 정보 출력하세요
select * from emp where deptno=10 or deptno=20 or deptno=30;
--연산자 (IN)
select * from emp where  deptno in(10,20,30);   --결과 위 처럼 풀어서 처리

--부서번호가 10번이 아닌 모든 사원의 정보를 출력하세요
select * from emp where deptno != 10;
--부서번호가 10번 , 20번 , 30번이 아닌 모든 사원의 정보를 출력하세요
select * from emp where deptno != 10 and deptno != 20 and deptno != 30
-- IN  <-> NOT IN
select * from emp where deptno not in (10,20,30);

--[ 문자열 ] 패턴 검색하기
--게시판 (이름, 제목 , 내용 )
--주소검색 (개포동 ,,, 개포   %개포%
--와일드 카드 ( %:모든 것 , _:한문자)
select ename from emp where ename like '%A%';
select ename from emp where ename like 'A%';
select ename from emp where ename like '%S';

select ename from emp where ename like '%LL%'
select ename from emp where ename like '%A%A%';
--BAAB  ,  ABBA ,
select ename from emp where ename like '_A%';
--첫글자는 어떤 것이와 상관없고  두번째 글자가 A
select ename from emp where ename like '_a%';  --문자열 데이터 대소문자 구분

--가장 일반적인 LIKE 검색 패턴
--select * from zipcode where dong like '%판교%';
 select * from zipcode where dong like '판교%';

 --key point (필요악)
 -- null
 -- DB에서는 null (데이터가 없다 )
select * from emp;

--사원테이블에서 수당을 받지 않는 모든 사원의 정보를 출력하세요
--데이터가 null
--** null에 대한 비교는 is null  또는 is not null
--select * from emp where comm = null; (x)
select * from emp where comm is null;
select * from emp where comm is not null;

--** null의 연산 (null 과의 모든 연산은 => null)
--사장님이 사원들의 이번 달 급여정보 (월급여 , 수당 , 월급여 + 수당을 합친 금액)
select empno, ename , sal, comm, sal + comm as 총급여
from emp;

--> 위 와 같은 쿼리에 대한 해결방안 -> 함수 제공 (Null 제어)
-->*****************~~~~~~~~~~~~무조건 암기
--오라클 ( NVL() )
--MS-SQL (Convert() )
select ename , sal ,  comm,  nvl(comm,0) from emp;
select ename , sal ,  comm,  nvl(comm,100) from emp;
--*****************************************************************************************
select ename , sal , comm,  sal + nvl(comm,0) as 총급여  from emp;
--Ex)---------------------------------------------------
create table member(
    id varchar2(10) not null,    --null값을 허락하지 않는다 (강제 insert)
    job varchar2(20) null        --생략 , null -> null값 허락(insert 하지 않아도 된다)
);
desc member;
select * from member;
--정상
insert into member(id, job) values ('kglim' , 'Teacher');
select * from member;
--실반영
commit;  --실행하세요
insert into member(job) values('TTTT');   -- Error -> id colmun -> id not null
insert into member(id) values('king');   --정상실행 -> job column -> null로

select * from member;
commit;

select id , nvl(job,'직종이 없습니다') as 직종 from member;

--사원의 급여가 1000이상이고 수당을 받지 않는 사원의 사번, 이름, 직종, 급여 ,수당
--정보를 출력하세요
select empno, ename, job, sal, comm
from emp
where sal >= 1000 and comm is null

--데이터 정렬하기
--정렬(sort)
--order by (성능을 좌우하는 요소)
--오름차순(낮은 순으로) asc
--내림차순(높은 순으로) desc

--급여가 낮은 순으로 정렬하세요
select * from emp order by sal asc;
select * from emp order by sal;  -- default => asc

select empno ,ename , sal  from emp order by sal desc;

--입사일이 가장 늦은 사람순으로 정렬해서 사번과 이름, 급여 , 입사일을 출력하세요
select empno, ename, sal ,hiredate
from emp
order by hiredate desc;

--사원테이블에서 직종이 MANAGER 인 사원의 정보를 출력하는데
--입사일이 빠른 순으로 출력하세요
select *
from emp
where job='MANAGER'
order by hiredate asc
--질문 ) 위 쿼리문의 실행 순서를 ......^^
1.  from
2. where
3. select
4. order by

--답변형 게시판
--(계층형 게시판)
--hint -> group
select *  from emp order by job asc , deptno asc  ;

--게시판
select id, writer , title, sdate from board order by sdate desc;

--연산자
--합집합(union) : 중복값을 배제하고 합치기
--합집합(union all) : 중복값을 허용하고 합치기
CREATE TABLE UT (NAME VARCHAR2(20));
	INSERT INTO UT(name) VALUES('AAA');
	INSERT INTO UT(name) VALUES('BBB');
	INSERT INTO UT(name) VALUES('CCC');

CREATE TABLE UTA (NAME VARCHAR2(20));
	INSERT INTO UTA(name) VALUES('AAA');
	INSERT INTO UTA(name) VALUES('BBB');
	INSERT INTO UTA(name) VALUES('CCC');

COMMIT;
SELECT * FROM ut
UNION  --중복값 배제
SELECT * FROM uta;

SELECT * FROM ut
UNION  ALL --중복값 포함
SELECT * FROM uta;
--1.  결과에 대한 컬럼 (empno, ename)
--기준 : 첫번째 Table
SELECT empno ,ename FROM emp
UNION
SELECT empno ,job FROM emp;

--결과 : empno, job
SELECT empno ,job FROM emp
UNION
SELECT empno ,ename FROM emp;

--Error  숫자방   문자방
SELECT empno, ename FROM emp
UNION
SELECT ename , empno FROM emp;

SELECT empno , ename, sal FROM emp
UNION
SELECT empno, ename, null FROM emp

--**UNION
--1.  대응대는 컬럼의 Type은 동일해야 한다
--2. 대응대는 컬럼의 수는 일치하여야 한다  (해결방법  : null)

SELECT empno , ename FROM emp
UNION
SELECT deptno , dname FROM dept;

DESC emp;
DESC dept;

--여기까지가 기본 select 구문
--SELECT           3
--FROM              1
--WHERE            2
--ORDER BY        4
-----------------------------------------------------------------------
-----------------------------------------------------------------------
--함수(Function) -------------------------------------------------------
--문자열관련 함수
SELECT INITCAP('abcde') FROM dual; --첫글자만 대문자

--대소문자(lower , upper)
SELECT LOWER('ABCDE') , UPPER('abcde') FROM dual;

SELECT LOWER(ename) AS "loname" FROM emp;

--key : 문자의 개수( length()   , lengthB() 바이트 수 리턴)
SELECT LENGTH('abcde') FROM dual;

SELECT ename, LENGTH(ename) FROM emp;

SELECT LENGTHB('AB') FROM dual;    -- 영문자 , 특수문자, 공백 1BYTE -> 2
SELECT LENGTHB('김이박') FROM dual; --한글 2BYTE -> 6
SELECT LENGTHB('     A김') FROM dual;

SELECT ename , LENGTH(ename) , job , LENGTHB(job) FROM emp;

--결합 연산자 => ||
SELECT CONCAT('ABC' , 'abc') AS "concat" FROM dual;
------------------hr계정 접속------------------------------------------
SELECT * FROM EMPLOYEES;
--사원의 fullname 을 출력하세요
SELECT first_name || '----'  || last_name AS "fullname" FROM EMPLOYEES;
SELECT CONCAT(first_name , last_name) AS "fullname" FROM EMPLOYEES;
----------------------------------------------------------------------
--key: substr() 부분문자 추출하기
SELECT SUBSTR('ABCDE',2,3) FROM dual;
SELECT SUBSTR('ABCDE',2,1) FROM dual;
SELECT SUBSTR('ABCDE',-2,1) FROM dual;
SELECT SUBSTR('ABCDE',-2,3) FROM dual;

--도움말
--http://docs.oracle.com/cd/B10501_01/server.920/a96540/toc.htm

--QUIZ
--사원테이블 ename 컬럼에 데이터에 대해서 첫글자는 소문자로 나머지 문자는 대문자
--로 하나의 컬럼으로 출력하세요
SELECT ename FROM emp;
--결과
--s MITH
--a LLEN
SELECT LOWER(SUBSTR(ename,1,1)) || ' ' || UPPER(SUBSTR(ename,2,LENGTH(ename)))
FROM emp;


--LPAD , RPAD  채우기
SELECT LPAD('ABC',10,'*')  FROM dual; --*******ABC
SELECT RPAD('ABC',10,'*')  FROM dual; --ABC*******

--QUIZ
--사용자 입력 : hong1008
--화면 출력 ho 제외한  나머지 문자 ho******
SELECT  RPAD(SUBSTR('hong1008',1,2),LENGTH('hong1008') ,'*')  FROM dual;
SELECT  RPAD(SUBSTR('kkk1234567',1,2),LENGTH('kkk1234567') ,'*') AS "ID"
FROM dual;

CREATE TABLE member2(id NUMBER , jumin VARCHAR2(14));
INSERT INTO member2(id, jumin) VALUES(100,'123456-1234567');
INSERT INTO member2(id, jumin) VALUES(200,'135791-3456789');
COMMIT;

SELECT * FROM member2;
--문제) select 결과가 => 123456-*******
SELECT RPAD(substr(jumin,1,7) , LENGTH(jumin ) , '*' ) AS "jumin"
FROM member2;

--key : replace (치환함수)
SELECT REPLACE('ABCDE' , 'A' , '가') FROM dual;

SELECT REPLACE('ABCDE' , 'A' , '가나다라마바사') FROM dual;
--문제) select 결과가 => 123456-*******   replace 사용
SELECT SUBSTR(jumin,8,LENGTH(jumin)) FROM member2;

SELECT REPLACE(jumin, SUBSTR(jumin,8,LENGTH(jumin)),'*******') AS "jumin"
FROM member2;


--1.3.11  RTRIM함수
--오른쪽 문자를 지우는 함수 입니다.
--Syntax	RTRIM(column1 | expression1,column2 | expression2)
--사 용 예	RTRIM(‘MILLER’, ‘R’)  → MILLE
--SELECT RTRIM('MILLER', 'R') FROM dual;
--SELECT LTRIM('MILLER', 'M') FROM dual;

--정규 표현식 (추후 정리 ) 샘플
SELECT * FROM EMPLOYEES WHERE regexp_like(email , '^[B-Z]*') ;
CREATE TABLE reg_test(t VARCHAR2(100));
INSERT INTO reg_test values('ABC123');
INSERT INTO reg_test values('ABC 123');
INSERT INTO reg_test values('abc 123');
INSERT INTO reg_test values('a1b2c3');
INSERT INTO reg_test values('a');
INSERT INTO reg_test values('a1');
INSERT INTO reg_test values('abc123');
INSERT INTO reg_test values('?/!@#$*&');
INSERT INTO reg_test values('\~*()..');
INSERT INTO reg_test values('123123');
INSERT INTO reg_test values('123abc');


COMMIT;
--소문자 다음에 숫자가 나오는 패턴 검색
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z][0-9]');

--소문자 공백 숫자 숫으로 나오는 패턴 검색
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z] [0-9]');

--? 문자가 없거나 하나인 문자
-- [a-z]?가 없가나 하나인 문자
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z]?[0-9]');

--* 문자가 없는 경우나 하나 이상 연속되는 문자
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z]*[0-9]');

--연속적인 글자 수 지정하기
--대문자가 연속적으로 3글자 오는 행
SELECT * FROM reg_test WHERE regexp_like(t,'[A-Z]{3}');

--소문자가 연속적으로 3글자 오는 행
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z]{3}');

--숫자가 연속적으로 3글자 오는 행
SELECT * FROM reg_test WHERE regexp_like(t,'[0-9]{3}');

--영어 대문자와 숫자가 함께 오는데 대문자가 3글자 오는 행
SELECT * FROM reg_test WHERE regexp_like(t,'[A-Z]{3}[0-9]');

--시작되는 문자와 끝나는 문자 지정하기
--숫자로 시작하는 행 출력
--^문자열의 시작과 일치
SELECT * FROM reg_test WHERE regexp_like(t,'^[0-9]');


--소문자나 숫자로 시작하는 행 출력
-- | OR
SELECT * FROM reg_test WHERE regexp_like(t,'^[a-z]|^[0-9]');

--소문자로 끝나는 출력
-- $ 문자열의 끝과 일치
SELECT * FROM reg_test WHERE regexp_like(t,'[a-z]$');

--숫자로 시작하지 않는 행 출력
SELECT * FROM reg_test WHERE regexp_like(t,'^[^0-9]');

--알파벳 대문자 'A' 나 숫자 1을 포함하고 있는 행 출력

SELECT * FROM reg_test WHERE regexp_like(t,'A|1');

--특정 조건이 아닌 경우 출력하기
--영문자(대소문자)를 포함하지 않는 모든 행
SELECT * FROM reg_test WHERE NOT  regexp_like(t,'[a-z][A-Z]');


--숫자를 포함하지 않는 모든 행
SELECT * FROM reg_test WHERE NOT  regexp_like(t,'[0-9]');


--특수문자 찿
--특수문자 앞에 \를 붙여서 검색한다
SELECT * FROM reg_test WHERE  regexp_like(t,'\?');

--반대
SELECT * FROM reg_test WHERE  not regexp_like(t,'\?');




--------------------------------------------------------------------
--문자열 함수 END

---------------------------------------------------------------------
---------------------------------------------------------------------
--숫자형 함수
--ROUND	숫자를 반올림
--TRUNC	숫자를 절삭
--MOD	나머지를 구함 => java %

--oracle : +  , - , *  ,  /
--key : Round 반올림함수  ( -3 , -2, -1  <-  0(정수만)  ->  1,2,3 )
SELECT ROUND(12.345,0) AS "R" FROM dual; --12
SELECT ROUND(12.567,0) AS "R" FROM dual; --13
SELECT ROUND(12.345,2) AS "R" FROM dual; --12.35  소수이하 2번째 자리까지 남겨라
SELECT ROUND(12.345,-1) AS "R" FROM dual;
SELECT ROUND(15.345,-1) AS "R" FROM dual;

--key : trunc (절사함수  : 반올림 하지 않아요)
SELECT TRUNC(12.345,0) AS "T" FROM dual;
SELECT TRUNC(12.567,0) AS "T" FROM dual;
SELECT TRUNC(12.345,2) AS "T" FROM dual;
SELECT TRUNC(12.345,-1) AS "T" FROM dual;
SELECT TRUNC(15.345,-1) AS "T" FROM dual;


--key MOD 나머지 구하는 함수 (java -> %)
SELECT MOD(12 , 10) FROM dual; --나머지
SELECT MOD(0 , 0) FROM dual; --나머지


--CEIL (가장 큰 정수값을 리턴)
SELECT CEIL(12.345) FROM dual;
SELECT CEIL(12.567) FROM dual;
SELECT CEIL(-12.567) FROM dual;
--FLOOR(가장 작은 정수값을 리턴)
SELECT FLOOR(12.345) FROM dual;
SELECT FLOOR(12.567) FROM dual;
SELECT POWER(2, 3) FROM dual;
---------------------------------------------------------------------
--수학함수 END
---------------------------------------------------------------------
--3일차
--날짜함수
SELECT * FROM nls_session_parameters;
ALTER SESSION set nls_date_format='YYYY-MM-DD HH24:MI:SS';

SELECT SYSDATE FROM dual;

--날짜
--날짜 + 숫자 => 날짜
--날짜 - 숫자 => 날짜
--날짜 - 날짜 => 숫자
-- MONTHS_BETWEEN (두날짜의 개월수)
SELECT MONTHS_BETWEEN('2014-04-01','2014-01-01') FROM dual; --숫자

SELECT * FROM emp;
--QUIZ
--사원테이블에서 사원들의 입사일에서 현재(sysdate) 까지 근속월수를 구하세요
--(ROUND 함수 정수부분만 남기세요)
--추가로 한달이 31일 사항을 강제하는 근속월수도 구하세요
SELECT empno, ename,
ROUND(MONTHS_BETWEEN(SYSDATE ,hiredate),0) AS "근속월"
, ROUND((SYSDATE - hiredate) / 31,0) AS "근속월2"
FROM emp;

SELECT SYSDATE , ADD_MONTHS(SYSDATE,3) FROM dual;

--날짜 ROUND , TRUNC 함수
SELECT SYSDATE , ROUND(sysdate) , trunc(sysdate) FROM dual;

-----------------------------------------------------------------
--변환함수 (~~~~******* 무한)
--TO_CHAR       날짜를 -> 문자로    숫자를 -> 문자로  (80%)
--TO_DATE       문자를 ->  날짜로 (10%)
--TO_NUMBER   문자를 ->  숫자로 (10%)

--오라클의 기본 타입
CREATE TABLE [테이블 명]
(
   컬럼명  타입정보
   id       NUMBER(2)
)
--문자데이터 타입
--CHAR(20)       :고정길이 문자열 : 한글 10자 , 영문자, 특수문자, 공백20자
--VARCHAR2(20) :가변길이 문자열  :한글 10자 , 영문자, 특수문자, 공백20자
--NCHAR(20)      : 한글 20자 , 영문자,특수문자,공백 20자 => 40byte
--NVARCHAR2(20) : : 한글 20자 , 영문자,특수문자,공백 20자 => 40byte
CREATE TEST (
col1  CHAR(20),
col2 VARCHAR2(20),
col3 NCHAR(20),
col4 NVARCHAR2(20),
col5 NUMBER,
col6 NUMBER(5),
col7 NUMBER(10,3)
)
INSERT INTO TEST(col1, col2) VALUES('A' , 'A');

--숫자 데이터 타입
--NUMBER(p,s)    : p 전체 자리수 (1~38)    , s 소수점 이하 자리수(-84~127)
--number(5,2) : 전체 5자리에서 소수부 표현 2자리
--number(5) or number

--기본 형변환 TEST
SELECT 1 + 1 FROM dual;   --2
SELECT 1 + '1' FROM dual;  --2 (형변환)
SELECT '1' + '1' FROM dual;  --2 (형변환 ) 문자 -> 숫자
SELECT '1A' + 1 FROM dual; --ERROR

SELECT TO_NUMBER('100') + 100 FROM dual;

----------------------------------------------------------
--1. 날짜 -> 문자
--TO_CHAR(날짜 , '원하는 모양') => 원하는 형식(양식)

YYYY   년도 표시(4자리)
YY       년도 표시(2자리)
MM      월을 숫자로 표시
MON    월을 알파벳으로 표시
DD      일 표시
DAY    요일 표시
DY      요일을 약어로 표시

SELECT TO_CHAR(sysdate) || '입니다' FROM dual;
SELECT SYSDATE , TO_CHAR(SYSDATE , 'YYYY') || '년' AS "YYYY" FROM dual;
SELECT TO_CHAR(SYSDATE,'YEAR')  FROM dual; --TWENTY FOURTEEN
SELECT TO_CHAR(SYSDATE,'MONTH')  FROM dual; --APRIL
SELECT TO_CHAR(SYSDATE,'MM')  FROM dual;  --04

SELECT TO_CHAR(SYSDATE,'DAY')  FROM dual; --TUESDAY
SELECT TO_CHAR(SYSDATE,'DD')  FROM dual; --22
SELECT TO_CHAR(SYSDATE , 'YYYY') || '년' ||
           TO_CHAR(SYSDATE,'MM') || '월' ||
           TO_CHAR(SYSDATE,'DD') || '일' AS "년월일"
FROM dual;

SELECT TO_CHAR(SYSDATE , 'YYYY/MM/DD:HH24:MI:SS') FROM dual;

SELECT * FROM emp;
--입사일이  12월달인 사원의 사번 ,이름, 입사일 , 월  을 출력하세요
SELECT empno, ename, hiredate, TO_CHAR(hiredate,'MM') AS "month"
FROM emp
WHERE TO_CHAR(hiredate,'MM') = '12'

--1. 숫자  -> 문자
--TO_CHAR(숫자 , '원하는 모양') => 원하는 형식(양식)
SELECT  '>' || TO_CHAR(1234,'999999') || '<' FROM dual; --자리수 (채움(x)
SELECT  '>' || TO_CHAR(1234,'000000') || '<' FROM dual; --자리수 (채움(ㅇ)

SELECT TO_CHAR(1234,'009999') FROM dual;
SELECT TO_CHAR(1234,'099999') FROM dual;
SELECT TO_CHAR(1234,'0999999999') FROM dual;

SELECT TO_CHAR(1234,'$09999') FROM dual;

SELECT TO_CHAR(12345.789,'999,999.99') FROM dual;

--------------------------------------------------
--hr계정으로
SELECT * FROM EMPLOYEES;

SELECT COUNT(*) FROM EMPLOYEES;
SELECT COUNT(salary) FROM EMPLOYEES;
SELECT COUNT(commission_pct)  FROM EMPLOYEES; --단 null 값은 무시합니다

--사원 테이블에서 사원이름 (first_name, last_name)
--사원 테이블에 사원이름은 fullname 으로 표기하시고 , 입사일은 'YYYY-MM-DD' 형식
--으로 출력하고 연봉을 구하고 연봉의  (연봉 * 1,1) 10%인상 연봉을 구해서 출력 1000단위
--콤마처리 출력 단 2005년 이후 입사자들에 대해서만
SELECT employee_id ,
          first_name || last_name AS "fullname" ,
          TO_CHAR(hire_date,'YYYY-MM-DD') AS "hire_date" ,
          salary,
          salary *12 AS "연봉",
          TO_CHAR((salary *12) *1.1,'9,999,999,999') AS "인상연봉",
          hire_date
FROM EMPLOYEES
WHERE TO_CHAR(hire_date,'YYYY') >= '2005' ;
------------------------------------------------------------
SELECT TO_DATE('2014-04-22', 'YYYY-MM-DD') FROM dual; --return 날짜
--일반함수 ------------------------------------------------------
--NVL   , NVL2
--DECODE   (if문 유사)
--CASE       (switch 유사)

SELECT comm, NVL(comm,0) FROM emp;
SELECT comm, NVL(comm,100) FROM emp;

--DECODE (표현식, 조건1 , 결과1 , 조건2 , 결과2 , 조건3 , 결과3.......)
CREATE TABLE funtionTmp
(
	 id NUMBER(6),
   job VARCHAR2(20)
);
INSERT INTO funtionTmp(id, job) VALUES(100,'IT');
INSERT INTO funtionTmp(id, job) VALUES(200,'SALES');
INSERT INTO funtionTmp(id, job) VALUES(300,'MGR');
INSERT INTO funtionTmp(id) VALUES(400);
COMMIT;

DELETE FROM funtionTmp;
COMMIT;

SELECT * FROM funtionTmp;
SELECT id, job , NVL2(job,'AAA' , 'BBB') FROM funtionTmp
--job 컬럼의 데이터가 있으면 처음값을(AAA) , null이면 두번째 입력값을(BBB)
SELECT id, job , NVL2(job,job, 'BBB') FROM funtionTmp

--DECODE
SELECT id, job , DECODE(id,100,'IT...' ,200,'SALES...' , 300,'MGR..' , 'ETC...') AS "job"
FROM funtionTmp;

--Emp 테이블에서 10 인사부 , 20 관리부 , 30 회계부  그외는 기타부서 출력
SELECT empno, ename, deptno, DECODE(deptno, 10,'인사부' ,
                                  20,'관리부',
                                  30,'회계부',
                                  '기타부서') AS "부서명"
FROM emp;

CREATE TABLE functiontmp2
(
   id NUMBER(2),
   jumin char(7)
);

INSERT INTO functiontmp2(id,jumin) VALUES(1,'1234567');
INSERT INTO functiontmp2(id,jumin) VALUES(2,'2134567');
INSERT INTO functiontmp2(id,jumin) VALUES(3,'1222222');
INSERT INTO functiontmp2(id,jumin) VALUES(4,'3123456');
COMMIT;

SELECT * FROM functiontmp2;
--QUIZ)
--jumin번호 컬럼의 앞자리가 1 이면 남성 , 2 이면 여성 , 3 이면 중성
--단 decode
SELECT id , jumin, DECODE(SUBSTR(jumin,1,1), 1,'남성' ,2,'여성' ,3,'중성') AS "gender"
FROM functiontmp2;

SELECT ename, deptno,
          DECODE(deptno , 20, DECODE(ename,'SMITH','hello','world') ,'ETC')
FROM emp;

--CASE
--java switch
CASE 조건 WHEN 결과1  THEN 출력1
              [WHEN 결과2  THEN 출력2] ...
              ELSE 출력3
END "컬럼명"
CREATE TABLE temp_zip
(
   zipcode NUMBER(10),
   region VARCHAR2(20)
);
INSERT INTO temp_zip(zipcode) VALUES(02);
INSERT INTO temp_zip(zipcode) VALUES(031);
INSERT INTO temp_zip(zipcode) VALUES(033);
INSERT INTO temp_zip(zipcode) VALUES(041);
INSERT INTO temp_zip(zipcode) VALUES(064);
COMMIT;

SELECT * FROM temp_zip

SELECT  '0' || TO_CHAR(zipcode) ,
           CASE zipcode
                   WHEN 2 THEN '서울지역'
                   WHEN 31 THEN '경기지역'
                   WHEN 33 THEN '강원지역'
                   WHEN 41 THEN '충남지역'
                   ELSE '기타지역'
           END "regionname"

FROM temp_zip
ORDER BY zipcode DESC;
---------------------------------------------------------
--점심 퀴즈
--사원테이블에서 사원 급여가  1000달러 이하면  4급
--1001달러 이상 2000달러 사이면 3급
--2001달러 이상 3000달러 사이면 2급
--3001달러 이상 4000달러 사이면 1급
--4001달러 이상이면 특급을 출려하세요

SELECT EMPNO, ENAME, SAL,
CASE WHEN SAL <= 1000 THEN '4급'
        WHEN SAL BETWEEN 1001 AND 2000 THEN '3급'
		    WHEN SAL BETWEEN 2001 AND 3000 THEN '2급'
        WHEN SAL BETWEEN 3001 AND 4000 THEN '1급'
        ELSE '특급'
END "등급"
FROM emp;
---------------------------------------------------------------------------
--여기까지가 오라클 기본 과정-------------------------------------------------
--오라클 함수 (집계함수)
--COUNT()
--SUM()
--AVG()
--MAX()
--MIN().....
--group 함수
--1. key point : null 모든 집계함수는 null을 무시한다
--2.key point : select 절에 집계함수 이외에 다른 컬럼이 오면 반드시
--                 group by 절에 그 컬럼에 명시되어야 한다

SELECT COUNT(*)  AS "rowcount" FROM emp; --row 수 반환
SELECT COUNT(empno) FROM emp;

SELECT COUNT(comm)  FROM emp; -- 4건 (null 값을 무시
SELECT * FROM emp;

SELECT SUM(comm) FROM emp; --2200
SELECT AVG(comm) FROM emp;  --550    sum() / 건수(null값을 가지지 않는 건수)
SELECT 2200 / 4 FROM dual; --우리회사는 수당을 받는 사원으로 나눈다
SELECT 2200 / 14 FROM dual; --우리회사는 사원수로 나눈다
SELECT SUM(comm) / COUNT(*) FROM emp; -- 편한방법
SELECT AVG(NVL(comm,0)) FROM emp;

SELECT COUNT(NVL(comm,0))  FROM emp;
---------------------------------------------------------------------------
SELECT MAX(sal) FROM emp;
SELECT MIN(sal) FROM emp;

SELECT MAX(hiredate) FROM emp;
SELECT MIN(hiredate) FROM emp;

SELECT COUNT(sal) , AVG(sal) , SUM(sal) , MAX(sal) , MIN(sal)
FROM emp;

---------------------------------------------------------------------------
--직종별 급여의 합을 구하세요
SELECT job , SUM(sal) ,COUNT(sal) , MAX(sal)
FROM emp
GROUP BY job;


SELECT deptno , job , SUM(sal)
FROM emp
GROUP BY deptno , job

SELECT empno , SUM(sal)
FROM emp
GROUP BY empno;


SELECT * FROM emp;

SELECT COUNT(sal)
FROM emp
GROUP BY sal
--실행순서
SELECT         --4
FROM            --1
WHERE           --2
GROUP BY      --3
ORDER BY      --5

SELECT job , AVG(sal) AS "avgsal"  --가명칭이 order by 사용될 수 있다
FROM emp
WHERE sal > 1000
GROUP BY job
ORDER BY "avgsal" asc
--quiz
--emp테이블에서 직종별 평균 급여가 3000달러 이상인 사원의 직종과 평균급여 출력
SELECT job , AVG(sal)
FROM emp
--WHERE AVG(sal) >= 3000 --조건절이 group by 절 뒤로
--group by 조건절 => having
GROUP BY job
HAVING AVG(sal) >= 3000;

--from 절의 조건절은 where
--group by 조건절은 having

SELECT
FROM
WHERE
GROUP BY
HAVING
ORDER BY

--수당을 지급받는 사원중에서 급여의 합이 10000이상
--사원 테이블에서 직종별 급여의 합을 출력하되 수당은 지급 받고 급여의 합이 10000이상인
--사원의 목록을 출력하고 급여의 합이 낮은 출력되도록 하세요

SELECT job , SUM(sal) AS "sumsal"
FROM emp
WHERE comm IS NOT NULL
GROUP BY job
HAVING SUM(sal) >=5000
ORDER BY  "sumsal" asc

--함수 (pivot , rank() ....................어느 정도 시간이 지나고 쿼리가 익숙해지면 이야기 해주세요
-----------------------------------------------------------------------------
--함수 END ------------------------------------------------------------------
--중요합니다 ^^
--RDBMS 사용하면 반드시 사용되는 ..join
--JOIN(조인) 하나 이상의 테이블에서 결과값 얻기
--조인의 종류
--1. equi join(등가조인) => 70% (1 : 1 로 비교할 컬럼이 존재)

--2. non-equi join(비등가 조인) => 의미만 존재  (1 : 1 로 비교할 컬럼이 존재(x))

--3. outer join(등가조인 + null)  20%  (주인이 누구인지를 판단한다)
      --full outer join
      --left outer join
      --right outer join

--4. self join(자기자신 참조) => 의미 10% => 문법 (등가)
SELECT * FROM emp;

--5. cross join(조건이 없는 조인)(데카르트의 곱 :행의 수 * 행의 수)
SELECT * FROM emp e , dept d ORDER BY ename  WHERE e.DEPTNO = d.DEPTNO;
--join 구문 문법
--oracle join 문법
--ANSI 표준  문법


-------------------------------------------------------------
--조인 : 테이블 구조 파악 (관계 파악)
--등가조인 (교집합)
--oracle join  =>
--ANSI  join =>  inner join  or   join

--oracle join 문법
SELECT e.EMPNO , e.ename ,e.DEPTNO , d.DNAME
FROM emp e , dept d
WHERE e.deptno = d.deptno --AND sal > 1000

--ANSI join 문법
SELECT  e.EMPNO , e.ename ,e.DEPTNO , d.DNAME
FROM emp e JOIN dept d
ON e.DEPTNO = d.DEPTNO
--WHERE sal > 1000

SELECT  e.EMPNO , e.ename ,e.DEPTNO , d.DNAME
FROM emp e INNER JOIN dept d
ON e.DEPTNO = d.DEPTNO
--WHERE sal > 1000

--급여가 1000달라 이상이고 직종이 'CLERK' 인 사원의 사번, 이름, 부서번호 , 부서이름
--을 출력하세요
SELECT e.EMPNO ,e.ENAME ,d.DNAME ,e.deptno
FROM emp e , dept d
WHERE e.deptno = d.DEPTNO
          AND sal >= 1000
          AND job ='CLERK'

SELECT e.EMPNO ,e.ENAME ,d.DNAME ,e.deptno
FROM emp e JOIN dept d
ON e.DEPTNO = d.DEPTNO
WHERE  sal >= 1000 AND job='CLERK';
---------------------------------------------------------
--사원의 사번 , 급여 , 급여등급 을 출력하세요
SELECT * FROM SALGRADE;
--join (비등가) : 의미론적으로 비등가
SELECT e.empno , e.sal , s.grade
FROM emp e JOIN SALGRADE s
ON e.SAL  BETWEEN s.losal AND s.hisal

SELECT e.empno , e.sal , s.grade
FROM emp e , SALGRADE s
WHERE e.sal BETWEEN s.LOSAL AND s.HISAL
---------------------------------------------------------------------------
---------------------------------------------------------------------------
--5일차 JOIN---------------------------------------------------------------
--조인 이해를 위한 테이블 생성
CREATE TABLE M (M1 CHAR(6) , M2 CHAR(10));
CREATE TABLE S (S1 CHAR(6) ,   S2 CHAR(10));
CREATE TABLE X (X1 CHAR(6) ,   X2 CHAR(10));

INSERT INTO M VALUES('A','1');
INSERT INTO M VALUES('B','1');
INSERT INTO M VALUES('C','3');
INSERT INTO M VALUES(Null,'3');
COMMIT;
INSERT INTO S VALUES('A','X');
INSERT INTO S VALUES('B','Y');
INSERT INTO S VALUES(null,'Z');
COMMIT;
INSERT INTO X VALUES('A','DATA');
COMMIT;

SELECT * FROM M;
SELECT * FROM S;
SELECT * FROM X;

--oracle join
SELECT m.M1 , m.M2 , s.S2
FROM M , S
WHERE m.M1 =s.S1

--ansi join
SELECT m.M1 , m.M2 , s.S2
FROM M JOIN S
ON m.m1 = s.S1

--3개 여러개의 테이블 조인
-- A = B ,  B = C , A = C
SELECT m.M1 , s.s2, x.X2
FROM M , S , X
WHERE m.m1 = s.S1 AND s.S1 = x.X1;

--ansi join
SELECT m.M1 , s.s2, x.X2
FROM m JOIN s ON m.M1 = s.S1
            JOIN x ON s.S1 = x.X1;
            --JOIN y ON x.x1 = y.y1
----------------------------------------------------------------------------
--hr 곚계정으로 접속해서 TEST
SELECT * FROM EMPLOYEES;
SELECT * FROM DEPARTMENTS;
SELECT * FROM LOCATIONS;

--사번, 이름, 부서번호 , 부서이름
SELECT e.EMPLOYEE_ID , e.LAST_NAME , e.DEPARTMENT_ID ,
           d.department_name
FROM EMPLOYEES e JOIN DEPARTMENTS d
ON e.department_id = d.department_id

--사번 , 이름, 부서번호, 부서이름 , 지역코드, 도시명
SELECT e.EMPLOYEE_ID ,
           e.LAST_NAME ,
           e.DEPARTMENT_ID ,
           d.department_name,
           d.location_id,
           l.CITY
FROM EMPLOYEES e JOIN DEPARTMENTS d
         ON e.DEPARTMENT_ID = d.DEPARTMENT_ID
         JOIN LOCATIONS l
         ON l.LOCATION_ID = d.LOCATION_ID;
--------------------------------------------------------------------------
--비등가
select * from emp;
select * from salgrade;

--------------------------------------------------------------------------
--outer join
--(내부적으로 inner join 실행되고 나서 두개테이블에서  주/종 관계를 파악)
--null값여부에 따라서 데이터 가져오는 것을 결정
--ANSI 문법
--1. full outer join (주인이 둘다)
--2. left outer join (왼쪽이 주인)
--3. right outer join (오른쪽이 주인)

--oracle join
-- e.deptno (+)= d.deptno
--ms-sql join
--where e.deptno *= d.deptno

select *
from m join s
on m.m1 = s.s1

select *
from m left outer join s
on m.m1 = s.s1

select *
from m right outer join  s
on m.m1 = s.s1

select *
from m full outer join s
on m.m1 = s.s1


--*key point => outer join 을 쓰는 이유는 null
select * from emp;
--사원테이블에서 사번, 이름 ,관리자사번 , 관리자이름 을 출력하세요
--join 실제 사원의 수는 14명 -> 출력된 데이터는 13건 -> mgr -> null -> king
select e.empno, e.ename, m.empno,m.ename
from emp e join emp m
on e.mgr = m.empno ;

select e.empno, e.ename, m.empno,m.ename
from emp e left outer join emp m
on e.mgr = m.empno ;


select * from emp  ;
------------------------------------------------------------------------
--연습문제 20분
-- 1. 사원들의 이름, 부서번호, 부서이름을 출력하라.
SELECT E.ENAME, E.DEPTNO, D.DNAME
FROM EMP E  join DEPT D
on E.DEPTNO=D.DEPTNO

-- 2. DALLAS에서 근무하는 사원의 이름, 직위, 부서번호, 부서이름을
-- 출력하라.
SELECT E.ENAME, E.JOB, D.DEPTNO, D.DNAME
FROM EMP E  join DEPT D
on E.DEPTNO=D.DEPTNO
WHERE  LOC='DALLAS'

-- 3. 이름에 'A'가 들어가는 사원들의 이름과 부서이름을 출력하라.
SELECT E.ENAME, D.DNAME
FROM EMP E inner join DEPT D
on D.DEPTNO=E.DEPTNO
WHERE  E.ENAME LIKE '%A%'

-- 4. 사원이름과 그 사원이 속한 부서의 부서명, 그리고 월급을
--출력하는데 월급이 3000이상인 사원을 출력하라.
SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E inner join DEPT D
on E.DEPTNO=D.DEPTNO
where SAL>=3000

-- 5. 직위가 'SALESMAN'인 사원들의 직위와 그 사원이름, 그리고
-- 그 사원이 속한 부서 이름을 출력하라.
SELECT E.JOB, E.ENAME, D.DNAME
FROM EMP E inner join DEPT D
on E.DEPTNO=D.DEPTNO
where E.JOB='SALESMAN'

-- 6. 커미션이 책정된 사원들의 사원번호, 이름, 연봉, 연봉+커미션,
-- 급여등급을 출력하되, 각각의 컬럼명을 '사원번호', '사원이름',
-- '연봉','실급여', '급여등급'으로 하여 출력하라.
--(비등가 ) 1 : 1 매핑 대는 컬럼이 없다
SELECT E.EMPNO AS "사원번호",
           E.ENAME AS "사원이름",
	        E.SAL*12 AS "연봉",
           E.SAL*12+COMM AS "실급여", --E.SAL*12+NVL(COMM,0) AS "실급여",
	         S.GRADE AS "급여등급"
FROM EMP E inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
where COMM IS NOT NULL

-- 7. 부서번호가 10번인 사원들의 부서번호, 부서이름, 사원이름,
-- 월급, 급여등급을 출력하라.
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E   join DEPT D
on E.DEPTNO=D.DEPTNO
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE E.DEPTNO=10

SELECT * FROM SALGRADE;


-- 8. 부서번호가 10번, 20번인 사원들의 부서번호, 부서이름,
-- 사원이름, 월급, 급여등급을 출력하라. 그리고 그 출력된
-- 결과물을 부서번호가 낮은 순으로, 월급이 높은 순으로
-- 정렬하라.
SELECT E.DEPTNO, D.DNAME, E.ENAME, E.SAL, S.GRADE
FROM EMP E inner join DEPT D
on E.DEPTNO=D.DEPTNO
inner join SALGRADE S
on E.SAL BETWEEN S.LOSAL AND S.HISAL
WHERE  E.DEPTNO<=20 --WHERE E.DEPTNO IN (10,20)
ORDER BY E.DEPTNO ASC,  E.SAL DESC



-- 9. 사원번호와 사원이름, 그리고 그 사원을 관리하는 관리자의
-- 사원번호와 사원이름을 출력하되 각각의 컬럼명을 '사원번호',
-- '사원이름', '관리자번호', '관리자이름'으로 하여 출력하라.
--SELF JOIN (자기 자신테이블의 컬럼을 참조 하는 경우)

SELECT E.EMPNO, E.ENAME , M.EMPNO, M.ENAME
FROM EMP E  left outer JOIN EMP M
ON e.MGR = m.EMPNO
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--subquery(SQL 꽃 이란 불리우는 ....)
--select 안에 select 가 들어감
--query 만능 해결사

--종류
--single row subquery : subquery 결과가 1 개의 row (단일행 단일컬럼)
--multi row subquery : subquery 결과가 여러개의 경우 (여러행 단일컬럼)
--multi column subquery : ...

--1. 서브쿼리가 가장 먼저 실행(한번만)
--2. 그 결과를 가지고 메인 쿼리가 실행
--3. 조건) subquery는 독자적으로 실행 가능 하여야 한다
--4. subquery는 괄호안에 놓인다

--사원테이블에서 평균급여보다 더 많은 급여를 받는 사원의 사번 ,이름 ,급여
--를 출력하세요
select avg(sal) from emp;    --2073
select empno, ename , sal
from emp where sal > (select avg(sal) from emp);

--1. single row subquery
--사용되는 연산자 ( = , >  , <  , >= , <= )
--사원테이블에서 jones의 급여보다 더 많은 급여를 받는 사번 ,이름 ,급여 정보 출력
select empno, ename, sal from emp
where sal > (select sal from emp where ename = 'JONES')

--2. Multi row subquery
--결과가 여러행  (IN , NOT IN , ANY , ALL)
select * from emp
where sal in (select sal from emp where sal > 2000) ;

select * from emp
where sal not in (select sal  from emp where sal > 2000) ;

 --부하직원이 있는 사원의 사원번호와 이름을 출력하세요
 select empno, ename from emp
 where empno in  (select mgr from emp)

 --부하직원이 없는 사원의 사번과 이름을 출력하세요
 select empno, ename from emp
 where empno not in  (select nvl(mgr,0) from emp)  --not in (and ... and  ... and

--king 에게 보고하는 즉 직속상관이 king인 사원의 사번 , 이름 ,직종을 출력하세요
select empno ,ename, job
from emp
where mgr =  (select empno from emp where ename='KING')

--20부서의 사원중에서 가장많은 급여를 받는 사원보다 더 많은 급여를 받는
--사원번호 , 이름, 급여 정보를 출력하세요
select empno ,ename , sal
from emp where sal >  (select max(sal) from emp where deptno=20)

--직종이 salesman 인 사원과 [같은 부서]에 근무하고 [같은 월급]을 받는 사원
--사번 ,이름 , 직종 , 급여를 출력하세요
select empno ,ename ,job ,sal
from emp
where  deptno in (select deptno from emp where job='SALESMAN')
          and sal in(select sal from emp where job ='SALESMAN')

--위 와 같지 않은 조건
select empno ,ename ,job ,sal
from emp
where  deptno not in (select deptno from emp where job='SALESMAN')
          and sal not in(select sal from emp where job ='SALESMAN')

--QUIZ
--( IN LINE VIEW ,
-- Subquery 가 Table 처럼 쓰일수 있다   from (select .....) e   )
-- subquery 와 join 통해서 .....
-- 만약에  이런 테이블이 존재하면
deptno , avgsal
10           2000
20          3500


--음료수 3개 ******************************************************************************
--자기 부서의 평균 월급보다 더 많은 월급을 받는 사원의
--이름 ,급여 , 부서번호, 부서별 평균월급을 출력하세요
select *
from emp e inner join
       (select deptno,avg(sal) as asal from emp group by deptno) s
on e.deptno = s.deptno
where e.sal > s.asal ;
--***********************************************************************************************
--연습문제
--1. 'SMITH'보다 월급을 많이 받는 사원들의 이름과 월급을 출력하라.
SELECT ENAME, SAL
FROM EMP
WHERE SAL>(SELECT SAL
		             FROM EMP
		             WHERE ENAME='SMITH')

--2. 10번 부서의 사원들과 같은 월급을 받는 사원들의 이름, 월급,
-- 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE SAL IN(SELECT SAL
		               FROM EMP
		               WHERE DEPTNO=10)

--3. 'BLAKE'와 같은 부서에 있는 사원들의 이름과 고용일을 뽑는데
-- 'BLAKE'는 빼고 출력하라.
SELECT ENAME, HIREDATE
FROM EMP
WHERE DEPTNO=(SELECT DEPTNO
		                   FROM EMP
		                   WHERE ENAME='BLAKE')
AND ENAME!='BLAKE'

--4. 평균급여보다 많은 급여를 받는 사원들의 사원번호, 이름, 월급을
-- 출력하되, 월급이 높은 사람 순으로 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL>(SELECT  AVG(SAL) 	FROM EMP)
ORDER BY SAL DESC

--5. 이름에 'T'를 포함하고 있는 사원들과 같은 부서에서 근무하고
-- 있는 사원의 사원번호와 이름을 출력하라.
SELECT EMPNO, ENAME
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
		                     FROM EMP
		                     WHERE ENAME LIKE '%T%')
 --where deptno = 20 or deptno= 30
--6. 30번 부서에 있는 사원들 중에서 가장 많은 월급을 받는 사원보다
-- 많은 월급을 받는 사원들의 이름, 부서번호, 월급을 출력하라.
--(단, ALL(and) 또는 ANY(or) 연산자를 사용할 것)
SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL > (SELECT MAX(SAL)
		              FROM EMP
		              WHERE DEPTNO=30)

SELECT ENAME, DEPTNO, SAL
FROM EMP
WHERE SAL >ALL(SELECT SAL
		FROM EMP
		WHERE DEPTNO=30)

--where sal > 1600 and sal > 1250 and sal > 2850 and sal > 1500 and sal > 950


--7. 'DALLAS'에서 근무하고 있는 사원과 같은 부서에서 일하는 사원의
-- 이름, 부서번호, 직업을 출력하라.
SELECT ENAME, DEPTNO, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
			                   FROM DEPT
			                   WHERE LOC='DALLAS')

--8. SALES 부서에서 일하는 사원들의 부서번호, 이름, 직업을 출력하라.
SELECT DEPTNO, ENAME, JOB
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
			                   FROM DEPT
			                   WHERE DNAME='SALES')

--9. 'KING'에게 보고하는 모든 사원의 이름과 급여를 출력하라.
--king 이 사수인 사람 (mgr 데이터가 king 사번)
SELECT ENAME, SAL
FROM EMP
WHERE MGR=(SELECT EMPNO
		              FROM EMP
		              WHERE ENAME='KING')

--10. 자신의 급여가 평균 급여보다 많고, 이름에 'S'가 들어가는
-- 사원과 동일한 부서에서 근무하는 모든 사원의 사원번호, 이름,
-- 급여를 출력하라.
SELECT EMPNO, ENAME, SAL
FROM EMP
WHERE SAL > (SELECT AVG(SAL)
		              FROM EMP)
AND DEPTNO IN(SELECT DEPTNO
		                 FROM EMP
		                 WHERE ENAME LIKE '%S%')

--select * from emp
--where  deptno in  (
 --                          select deptno from emp where sal > (select avg(sal) from emp)
 --                         and ename like '%S%'
                        )

--11. 커미션을 받는 사원과 부서번호, 월급이 같은 사원의
-- 이름, 월급, 부서번호를 출력하라.
SELECT ENAME, SAL, DEPTNO
FROM EMP
WHERE DEPTNO IN(SELECT DEPTNO
		                    FROM EMP
		                    WHERE COMM IS NOT NULL)
AND SAL IN( SELECT SAL
		             FROM EMP
		             WHERE COMM IS NOT NULL)

--12. 30번 부서 사원들과 월급과 커미션이 같지 않은
-- 사원들의 이름, 월급, 커미션을 출력하라.
SELECT ENAME, SAL, COMM
FROM EMP
WHERE SAL NOT IN(SELECT SAL
		                      FROM EMP
		                      WHERE DEPTNO=30)
AND COMM NOT IN(SELECT NVL(COMM, 0)
		                       FROM EMP
		                       WHERE DEPTNO=30 and comm is not null);
--1 , 200         1, 200
--2, 300          2.300

--13. 사원번호, 이름, 월급, 그리고 월급누적을 출력하라.
SELECT E.EMPNO, E.ENAME, E.SAL, SUM(D.SAL)
FROM EMP E, (SELECT EMPNO, SAL
		               FROM EMP) D
WHERE E.EMPNO>=D.EMPNO
GROUP BY E.EMPNO, E.ENAME, E.SAL
ORDER BY SUM(d.sal)

----------------------------------------------------------
SELECT *
FROM EMP E, (SELECT EMPNO, SAL
		               FROM EMP) D
WHERE E.EMPNO>=D.EMPNO
order by e.empno

---------------------------------------------------------------------------
---------------------------------------------------------------------------
--오라클 6일차--------------------------------------------------------------
--DDL(데이터 정의어) --CREATE , ALTER , DROP , TRUNCATE
--DML(데이터 조작어) --INSERT , UPDATE , DELETE
--DCL(데이터 제어어 ) - 권한 (GRANT , REVOKE)
--DQL(데이터 질의어어) --SELECT    기본적인 쿼리 작업(JOIN, SUBQUERY...)
--TCL() - COMMIT , ROLLBACK

--^^
SELECT * FROM TAB;
SELECT * FROM TABS;
SELECT * FROM COL;
SELECT * FROM COL WHERE TNAME ='DEPT';
SELECT * FROM user_tables;
--------------------------------------------------------------------------
--DML
--트랜잭션(TRANSACTION)
--정의 : 하나의 논리적인 작업 단위
--성공 아니면 실패

BEGIN TRANSACTION
	INSERT
	UPDATE
	DELETE
COMMIT  OR ROLLBACK
--한번에 실행되는 쿼리
--연속처리
--잘모르겠다
--업무적으로 의미 최소 처리 단위
--쪼갤수 없는 처리 단위
--상호 작용의 단위
--친구가 보여준 에러
--작업의 기본 단위
--------------------------------------------------------------------------
--오라클
--INSERT , UPDATE , DELETE
--DEFAULT
--BEGIN TRAN
--INSERT
--처리 :COMMIT(반영) , ROLLBACK(취소)

--MSSQL
--INSERT , UPDATE , DELETE
--DEFAULT
--BEGIN TRAN
--INSERT
--DEFAULT COMMIT
--BEGIN TRAN 명시 쓰지않으면

--APP( C , JAVA, NET, DELPI, .....)
--DB향해서 작업 할수 있는 것을
-- CRUD
--C(create)  insert
--R(read)     select
--U            update
--D            delete

--------------------------------------------------------------------------
CREATE TABLE temp3
(
   id NUMBER PRIMARY KEY , --id 컬럼에 null 또는 중복데이터를 넣을 수 없다
   NAME VARCHAR2(20)
);
INSERT INTO temp3(id , name) VALUES(100,'홍길동');
SELECT * FROM temp3;
COMMIT;
INSERT INTO temp3 VALUES(200,'김유신');
SELECT * FROM temp3;
ROLLBACK;

--BEGIN TRANSACTION --명시적 트랜잭션
--	 INSERT INTO temp3(id , name) VALUES(200,'김유신');
--   INSERT INTO temp3(id , name) VALUES(100,'아무개');
--자동 rollback 처리되도록
SELECT * FROM temp3;

CREATE TABLE temp4(
	id VARCHAR2(20)
)

--java (for (int .....
--pl-sql
BEGIN
				FOR i IN 1..100 LOOP
        		INSERT INTO temp4(id) VALUES('A' || TO_CHAR(i));
				END LOOP;
END;
COMMIT;
SELECT * FROM temp4;
--------------------------------------------------------------------------
CREATE TABLE newTable(
  memberid number(3),  --default null
  NAME VARCHAR2(20),  --default null
  addr  VARCHAR2(30),  --default null
  reg_date DATE DEFAULT SYSDATE ,
  jumin CHAR(6) --default null
);

SELECT * FROM newTable;
--컬럼 리스트 생략 (테이블 컬럼 순서에 맞게 모든 데이터 insert)
INSERT INTO newTable VALUES(100,'홍길동','서울시 강서구','2014-04-23','123456');
COMMIT;
--특정 컬럼에 데이터 넣기
INSERT INTO newTable(memberid ,name)
VALUES(200,'아무개');
SELECT * FROM newTable;
COMMIT;
--------------------------------------------------------------------------
CREATE TABLE temp5(id number);
CREATE TABLE temp6(num  number);

INSERT INTO temp5 VALUES(1);
INSERT INTO temp5 VALUES(2);
INSERT INTO temp5 VALUES(3);
INSERT INTO temp5 VALUES(4);
INSERT INTO temp5 VALUES(5);
COMMIT;

--추가 insert
--대량 데이터 insert  하기---------------------------------------------------
INSERT INTO temp6
SELECT id FROM temp5; --원래는 values 있어야 하는 구문

SELECT * FROM temp6;
COMMIT;

--대량 데이터 insert => Table 생성, Insert 병행
CREATE TABLE temp7
AS
	  SELECT * FROM temp6;

CREATE TABLE temp8  --데이터 구조는 그대로 복사 데이터는 복사 하고 싶지 않다
AS
	 SELECT * FROM newTable  WHERE 1=2
SELECT * FROM temp8;
--------------------------------------------------------------------------
--update
--update 테이블명
--set 컬럼명 = 값 , 컬럼명 = 값 , ........
--where 조건절

UPDATE newTable
SET addr = '판교'

SELECT * FROM newTable;
COMMIT;

UPDATE newTable
SET NAME = '김수한무'
WHERE memberid = 100;

SELECT * FROM newTable;
COMMIT;

UPDATE newTable
SET NAME='바보' , addr='런던' , reg_date=SYSDATE ,jumin='135791'
WHERE memberid = 100;

SELECT * FROM newTable;
COMMIT;

----------------------
--emp 똑같은 구조를 같는 copyemp 를 만드세요
CREATE TABLE copyemp
AS
	SELECT * FROM emp WHERE 1=2;

--emp 테이블에 있는 모든 데이터를  copyemp 에 넣으세요
INSERT INTO copyemp
SELECT * FROM emp;

COMMIT;

SELECT * FROM copyemp;
--copyemp 테이블에 있는 급여 정보를 평균급여 정보로 수정하세요
UPDATE copyemp
SET sal = (SELECT AVG(sal) FROM emp)

UPDATE copyemp
SET ename = ' '


SELECT * FROM copyemp;
COMMIT;


--update end
--------------------------------------------------------------------------
--DELETE
DELETE FROM copyemp
WHERE comm IS NULL;
SELECT * FROM copyemp;

DELETE FROM copyemp;
COMMIT;

--copyemp Table 크기 (100MB)
--delete from copyemp
--delete 구문은 데이터를 삭제하지 것이지
--저장공간까지는 삭제하지 않는다
--------------------------------------------------------------------------
--DELETE * FROM copyemp (MS-ACCESS)
--------------------------------------------------------------------------
--DDL--------------------------------------------------------------------
--CREATE , ALTER , DROP
CREATE TABLE board
(
   boardid number,
   title      NVARCHAR2(20),
   content VARCHAR2(100),
   regdate DATE
);
SELECT * FROM user_tables WHERE table_name ='BOARD';
DESC board;
--가상컬럼
--조합컬럼
CREATE TABLE vTable
(
   no1  NUMBER,
   no2 number,
   no3 NUMBER GENERATED ALWAYS AS (no1 + no2) VIRTUAL
)
INSERT INTO vTable(no1, no2) VALUES(100,200);

--INSERT INTO vTable(no1, no2,no3) VALUES(100,300,500);
SELECT * FROM vTable;
COMMIT;

--기본 컬럼 정보확인하기
SELECT
column_name,
data_type,
data_default
FROM user_tab_columns WHERE table_name ='VTABLE'
ORDER BY column_id;

CREATE TABLE vtable2
(
   NO NUMBER,
   pcode char(4),
   pdate CHAR(8),
   pqty NUMBER,
   pbun NUMBER(1)  GENERATED ALWAYS AS
   		      (
              CASE
                     WHEN SUBSTR(pdate,5,2) IN ('01' , '02' , '03') THEN 1
                     WHEN SUBSTR(pdate,5,2) IN ('04' , '05' , '06') THEN 2
                     WHEN SUBSTR(pdate,5,2) IN ('07' , '08' , '09') THEN 3
                     ELSE 4
              END
            )  VIRTUAL
);
INSERT INTO vtable2(pdate) VALUES('20140101');
INSERT INTO vtable2(pdate) VALUES('20140712');
SELECT * FROM vtable2;
COMMIT;
--가상컬럼 필수 사항은 아니고 참고로 알아 두세요
--------------------------------------------------------------------------
--Create구문 (필수)
--1. 테이블 생성하기
create table temp9(id number);

--2. 기존테이블 컬럼 추가하기
ALTER TABLE temp9
ADD NAME VARCHAR2(20);

--3. 기존테이블 기존 컬럼명 수정
-- name -> ename
ALTER TABLE temp9
RENAME COLUMN NAME TO ename;

--4. 기존 테이블에 기존 컬럼에 대한 TYPE 수정
ALTER TABLE temp9
MODIFY(ename  VARCHAR2(40));

--5. 기존 테이블에 기존 컬럼을 삭제하기
ALTER TABLE temp9
DROP COLUMN ename;

DESC temp9;
SELECT * FROM temp9;

--------------------------------------------------------------------------
--삭제
--1. delete 데이터 지우는 저장공간의 크기 유지

--2. truncate 데이터 지우고 저장공간의 크기 삭제
--단점) 조건을 사용할 수 없다
TRUNCATE TABLE copyemp --(x)WHERE  sal > 1000;
--3. drop  데이터 도 테이블도 삭제
--------------------------------------------------------------------------
--제약조건-----------------------------------------------------------------
--CONSTRAINT
--[TABLE 생성시 데이터 입력 , 수정 시  데이터 무결성을 확보하기 위한 방법 ]
--오라클 제약--
--NOT NULL (null값을 입력하지 못하게 하는 제약)
--unique (중보된 값이 입력되지 못하게 하는 제약)
--primary key ( unique + not null => null값을 허락하지 않고 중복데이터를 허락하지 않는다
--foreign key (참조제약) 다른 테이블에 있는 컬럼을 참조해서 무결성을 확보하는 제약
--check 설정된 값만 입력을 받게 하는 제약

--위 모든 제약의 생성시점은 테이블이 생성될때 또는
--테이블이 만들어 졌다면 추가 할 수 있다

CREATE TABLE emp3
(
   id NUMBER CONSTRAINT pk_emp3_id PRIMARY KEY ,
   NAME VARCHAR2(20) NOT NULL ,                -- default null
   addr VARCHAR2(20)
   --id number primary key
)
DROP TABLE emp3;
SELECT * FROM user_constraints WHERE table_name='EMP3';
--정상
INSERT INTO emp3(id, NAME, addr)
VALUES(100,'홍길동','조선');

SELECT * FROM emp3;
COMMIT;

--INSERT INTO emp3(id, NAME, addr) VALUES(100,'누군가','신라');
--(x) pk 제약
--INSERT INTO emp3(id, addr) VALUES(200,'신라');
--(x) not null 제약
INSERT INTO emp3(id, NAME) VALUES(200,'누군가');
--정상처리(0)
SELECT * FROM emp3;
COMMIT;

CREATE TABLE emp4
(
   id NUMBER CONSTRAINT pk_emp4_id PRIMARY KEY ,
   NAME VARCHAR2(20) NOT NULL ,                -- default null
   jumin CHAR(6)  CONSTRAINT uk_emp4_jumin  UNIQUE ,
   addr VARCHAR2(20)
   --id number primary key
);
SELECT * FROM user_constraints WHERE table_name='EMP4';
INSERT INTO emp4(id,NAME,jumin) VALUES (100,'김유신','123456');
SELECT * FROM emp4;
COMMIT;
-- unique 제약 (중복 데이터)
--INSERT INTO emp4(id,NAME,jumin) VALUES (200,'김유신','123456');
--unique 제약 null 중복 허용
INSERT INTO emp4(id,NAME) VALUES (200,'김유신');
SELECT * FROM emp4
INSERT INTO emp4(id,NAME) VALUES (300,'박군');
COMMIT;
SELECT * FROM emp4;


CREATE TABLE emp5
(
   id NUMBER CONSTRAINT pk_emp5_id PRIMARY KEY ,
   NAME VARCHAR2(20) NOT NULL ,                -- default null
   jumin CHAR(6) NOT NULL  CONSTRAINT uk_emp5_jumin  UNIQUE ,
   addr VARCHAR2(20)
   --id number primary key
);
INSERT INTO emp5(id,NAME,jumin) VALUES (300,'박군','123456');

CREATE TABLE emp6 (id number);
--테이블을 만들고 보니 제약을 .......
--제약을 테이블에 축가하기
ALTER TABLE emp6
ADD CONSTRAINT pk_emp6_id PRIMARY KEY(id);

--emp6테이블에 name varchar2(10) 컬럼을 추가하시고
ALTER TABLE emp6
ADD  NAME VARCHAR2(10);
--앗 차 실수 추가된 name 컬럼에 not null 추가로 걸어보세요
--not null ADD 제약 추가(x)
ALTER TABLE emp6
MODIFY (NAME CONSTRAINT nn_emp6_name NOT null);


CREATE TABLE emp7
(
   id NUMBER CONSTRAINT pk_emp7_id PRIMARY KEY ,
   NAME VARCHAR2(20) NOT NULL ,                -- default null
   jumin CHAR(6)  CONSTRAINT uk_emp7_jumin  UNIQUE ,
   addr VARCHAR2(20),
   age NUMBER CONSTRAINT ck_emp7_age check(age >= 19) --where age >=19
);
INSERT INTO emp7(id,NAME,jumin,age) VALUES(100,'아무개','123456',19);
SELECT * FROM emp7
COMMIT;

--emp 테이블에서 c_emp테이블을 생성하세요(구조만 복사 : 제약정보 복사 안됨)
CREATE TABLE c_emp
AS
	  SELECT * FROM emp WHERE 1=2;
--제약정보 확인
SELECT * FROM user_constraints WHERE TABLE_name =UPPER('c_emp');

--dept 테이블에서 c_dept테이블을 생성하세요 (구조만 복사)
CREATE TABLE c_dept
AS
	  SELECT * FROM dept WHERE 1=2;
--제약정보 확인
SELECT * FROM user_constraints WHERE TABLE_name =UPPER('c_emp');
SELECT * FROM user_constraints WHERE TABLE_name =UPPER('c_dept');

--참조 제약(foreign key) 제약 실습
--emp 테이블에 있는 deptno 컬럼은 dept 테이블에 있는 deptno 컬럼을 참조
--deptno 컬럼의 데이타는  dept 테이블에 있는 deptno데이터 중 하나
--전에 (신뢰성 데이터) 보장 (unique , primary key)
--c_dept(deptno)  primary key 추가
ALTER TABLE c_dept
ADD CONSTRAINT pk_c_dept_deptno PRIMARY KEY(deptno);


ALTER TABLE c_emp
ADD CONSTRAINT fk_c_emp_deptno FOREIGN KEY(deptno)
       REFERENCES c_dept(deptno);

--c_dept 테이블에 dept 데이터를 insert 하세요
INSERT INTO c_dept
SELECT * FROM dept;

SELECT * FROM c_emp;
SELECT * FROM c_dept;

INSERT INTO c_emp(deptno)
VALUES(null); --null 허용(x) not null

COMMIT;

INSERT INTO c_emp(deptno)
VALUES(56);

--활성화 / 비활성화
ALTER TABLE c_emp
DISABLE NOVALIDATE CONSTRAINT FK_C_EMP_DEPTNO

ALTER TABLE c_emp
ENABLE NOVALIDATE CONSTRAINT FK_C_EMP_DEPTNO;

SELECT * FROM user_constraints WHERE TABLE_name =UPPER('c_emp');
SELECT * FROM user_constraints WHERE TABLE_name =UPPER('c_dept');

-----------------------------------------------------------------------
--학생 성적 테이블
--학번의 데이터는 중복되거나 NULL 값을 허용하면 안된다
--이름 NULL 값을 허용하지 않는다
--국어
--영어
--수학 점수 컬럼은 숫자 타입이고 NULL 값을 허용하지 않는다
--는 값을 입력하지 않으면  default로 0값을 갖는다
--총점 ,평균 컬럼은 가상컬럼으로(조합컬럼) 생성한다
--학과코드는 학과 테이블에 학과코드를 참조한다
--학번 , 이름 , 국어 , 영어 , 수학 , 총점 , 평균 , 학과코드

--학과 테이블
--학과코드 데이터는 중복되거나 NULL 값을 허용하면 안된다,
--학과명 은 null값을 허락하지 않는다

--학과코드 , 학과명

--그리고 select 결과는
--학번 , 이름  총점, 평균 , 학과코드 , 학과명 을 출력하세요
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--VIEW-------------------------------------------------------------------
--view(뷰) : 가상 테이블 (subquery : Line View => from 절에서
--View 테이블 처럼 쓰지만  물리적인 테이블은 아니고 메모리 상에서 .....
--혹자는 view sql문장 덩어리 .......
--그런데 사용자 본인이 쓰는 것이  table 인지 view인지 구분하지 못한다
--view 보안상 목적으로도 사용된다
--목적: 편하게 쓸려고

--scott 계정에 대해서 view 만들수 있는 권한 부여
--SYSTEM 계정 으로 접속
--GRANT CREATE VIEW TO SCOTT;

CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW view_name
[(alias, alias, alias, ...)]
AS subquery
[WITH CHECK OPTION]
[WITH READ ONLY];

SELECT * FROM user_views

--FORCE 옵션 : 기본 테이블이 없더라도 뷰를 생성할수 있는 옵션
--NOFORCE 옵션 : default 값  (테이블이 없으면 생성 불가)

--1. 뷰는 가상테이블(sql)
--2. 뷰를 만드는 목적은 편리성
--3. from (select ....) aaa  -- in line view
--4. view 를 통한 DML가능 (단 단일뷰(테이블 하나로 만든 뷰)
--5. 단순 view (테이블 하나)   , 복합 view(테이블 하나 이상)
--6. view 삭제 (drop view v_emp)

CREATE OR REPLACE VIEW v_emp
AS
	  SELECT e.empno , e.ename , e.deptno , d.dname
    FROM EMP e join dept d
    ON e.deptno = d.deptno

CREATE OR REPLACE VIEW v2_emp
AS
	SELECT * FROM EMP WHERE sal > 2000;

--신입사원
SELECT * FROM v2_emp;  --뷰를 통한 DML(insert , update, delete)

-- key point : 뷰를 통한 DML 작업은  view 볼수 있는 데이터 만 가능
--update ...
UPDATE v2_emp
SET sal = sal+100

ROLLBACK;

--view -> 테이블 (컬럼명이 있어야)
CREATE OR REPLACE VIEW  static_emp
AS
		SELECT AVG(sal) AS avgsal , SUM(sal) AS sumsal , max(sal) AS maxsal , min(sal) AS minsal ,
     COUNT(sal) AS countsal
    FROM EMP;

SELECT * FROM static_emp;

--key point (하나이상 (join , union) 테이블로 생성된 view 에서 DML 작업 불가)

CREATE OR REPLACE FORCE VIEW EMPDATA
( EMPNO, ENAME, JOB )
AS
SELECT empno ,ename, job FROM EMP


1. 30번 부서 사원들의 직위, 이름, 월급을 담는 VIEW를 만들어라.

CREATE OR REPLACE  VIEW VIEW100
AS
		SELECT JOB, ENAME, SAL
		FROM EMP
		WHERE DEPTNO=30

SELECT * FROM VIEW100



--2. 30번 부서 사원들의  직위, 이름, 월급을 담는 VIEW를 만드는데,
-- 각각의 컬럼명을 직위, 사원이름, 월급으로 ALIAS를 주고 월급이
-- 300보다 많은 사원들만 추출하도록 하라.

CREATE OR REPLACE VIEW  VIEW101
( 직위, 사원이름 ,월급 )
AS
	SELECT JOB , ENAME , SAL
	FROM EMP
	WHERE DEPTNO=30 AND SAL > 300;


SELECT * FROM VIEW101



--3. 부서별 최대월급, 최소월급, 평균월급을 담는 VIEW를 만들어라.

CREATE OR REPLACE VIEW VIEW102
AS
	SELECT DEPTNO, MAX(SAL) AS "최대월급",
		MIN(SAL) AS "최소월급",
		AVG(SAL) AS "평균월급"
	FROM EMP
	GROUP BY DEPTNO


SELECT * FROM VIEW102



--4. 부서별 평균월급을 담는 VIEW를 만들되, 평균월급이 2000 이상인
-- 부서만 출력하도록 하라.
--from 조건 => where
--group by 조건 => having

CREATE OR REPLACE VIEW VIEW103
AS
	SELECT DEPTNO, AVG(SAL) AS "평균월급"
	FROM EMP
	GROUP BY DEPTNO
	HAVING AVG(SAL) >=2000

----------------------------------------
SELECT v.deptno,v.평균월급 , d.dname
FROM view103 v JOIN dept d
ON v.deptno = d.deptno
-----------------------------------------

--5. 직위별 총월급을 담는 VIEW를 만들되, 직위가 MANAGER인
-- 사원들은 제외하고 총월급이 3000이상인 직위만 출력하도록 하라.

CREATE OR REPLACE VIEW VIEW104
AS
	SELECT JOB, SUM(SAL) AS "총월급"
	FROM EMP
	WHERE JOB!='MANAGER'
	GROUP BY JOB
	HAVING SUM(SAL)>=3000

SELECT * FROM VIEW104
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--개발자 ------------------------------------------------------------------
--기본적인 select(함수 , join  ,subquery)  , DML(inser ,update ,delete)
--그 외적 ...view , index , 시스템구조 ..
--튜닝 (문장 : index ) , 시스템튜닝
--------------------------------------------------------------------------
--SEQUENCE (순번을 만드는 객체)
--ms-sql (create table board (id int identity(100,1) title varchar(20))
--insert into board(title) values('안녕') -> 1
--mysql ( create table board ( auto-increment)

--1 SEQUENCE 특징
--1)	 자동적으로 유일 번호를 생성합니다.
--2)	공유 가능한 객체
--3)	주로 기본 키 값을 생성하기 위해 사용됩니다.
--4)	어플리케이션 코드를 대체합니다.
--5)	메모리에 CACHE되면 SEQUENCE 값을 액세스 하는 효율성을 향상시킵니다.

CREATE  SEQUENCE  sequence_name
	[INCREMENT  BY  n]
	[START  WITH  n]
	[{MAXVALUE n | NOMAXVALUE}]
	[{MINVALUE n | NOMINVALUE}]
	[{CYCLE | NOCYCLE}]
	[{CACHE | NOCACHE}];

sequence_name		SEQUENCE의 이름입니다.
INCREMENT  BY    n
정수 값인 n으로 SEQUENCE번호 사이의 간격을 지정.
이 절이 생략되면 SEQUENCE는 1씩 증가.

START  WITH  n
생성하기 위해 첫번째 SEQUENCE를 지정.
이 절이 생략되면 SEQUENCE는 1로 시작.

MAXVALUE n
SEQUENCE를 생성할 수 있는 최대 값을 지정.

NOMAXVALUE
오름차순용 10^27 최대값과 내림차순용-1의 최소값을 지정.

MINVALUE n
최소 SEQUENCE값을 지정.

NOMINVALUE
오름차순용 1과 내림차순용-(10^26)의 최소값을 지정.

CYCLE | NOCYCLE
최대 또는 최소값에 도달한 후에 계속 값을 생성할 지의 여부를 지정. NOCYCLE이 디폴트.

CACHE | NOCACHE
얼마나 많은 값이 메모리에 오라클 서버가 미리 할당하고 유지
하는가를 지정. 디폴트로 오라클 서버는 20을 CACHE.


1 NEXTVAL과 CURRVAL 의사열
1)	 NEXTVAL는 다음 사용 가능한 SEQUENCE 값을 반환 한다.
2)	SEQUENCE가 참조될 때 마다, 다른 사용자에게 조차도 유일한 값을 반환한다.
3)	CURRVAL은 현재 SEQUENCE값을 얻는다.
4)	CURRVAL이 참조되기 전에 NEXTVAL이 사용되어야 한다.


--------------------------------------------------------------------------
--게시판
--create table board ( boardid number )
--insert 처음 글이 써지면  1 , 2 , 3 , 4

--INSERT INTO board (boardid , title , content)
--VALUES(1 ,
--------------------------------------------------------------------------
SELECT COUNT(*) FROM board 나온 값에  +1
-- 0 -> 1
-- 1  -> 2
-- 2 -> 3
--> 중복값 발생
1
2
3 (삭제)
4
--------------------------------------------------------------------------
SELECT MAX(boardid) +1 FROM board;

--1
--1(max)  -> 2(생성한 글번호)
--2 -> 3 (삭제)
--3 -> 4
--4 -> 5
--------------------------------------------------------------------------
CREATE SEQUENCE sequence_num;

SELECT * FROM user_sequences;
SELECT SEQUENCE_NUM.NEXTVAL FROM dual;
SELECT SEQUENCE_NUM.CURRVAL FROM dual;

INSERT INTO board(id, title)
VALUES (SEQUENCE_NUM.NEXTVAL , '안녕 배고파');

CREATE SEQUENCE SEQUENCE_num2
START WITH 10
INCREMENT BY 2


SELECT * FROM user_sequences;
SELECT SEQUENCE_num2.NEXTVAL FROM dual;
SELECT SEQUENCE_num2.CURRVAL FROM dual;
SELECT * FROM user_sequences;

-------------------------------------------------------------------------
CREATE TABLE multiboard
(
  boardid NUMBER(3),
  title   VARCHAR2(20)
);
CREATE TABLE multiboard2
(
  boardid NUMBER(3),
  title   VARCHAR2(20)
);


CREATE SEQUENCE multiSeq
START WITH 1
INCREMENT BY 1;

CREATE SEQUENCE multiSeq2
START WITH 1
INCREMENT BY 1;
SELECT MULTISEQ2.NEXTVAL FROM dual;


SELECT * FROM user_sequences;

INSERT INTO multiboard (boardid, title)
VALUES (MULTISEQ.NEXTVAL , '처음 글입니다');
COMMIT;

DELETE FROM multiboard

SELECT * FROM multiboard;
SELECT * FROM multiboard2;

INSERT INTO multiboard2 (boardid, title)
VALUES (MULTISEQ.NEXTVAL , '처음 글입니다');



--------------------------------------------------------------------------
--11g release2 발생  문제 >  SEQUENCE 실테이블 사용시 초기값이 하나 증가된 값으로
/*
 힙 테이블은 우리가 보통 그냥 만드는 테이블이라고 생각하시면 됩니다 -
 11g R2 버전부터 테이블이 생성될 때 세그먼트가 바로 할당되지 않고 데이터가
 최초로 삽입(INSERT)될 때 세그먼트가 할당됩니다.
 이것을 Deferred Segment Creation 이라고 합니다.
*/

CREATE SEQUENCE newseq;

CREATE TABLE KN_AUTHORITY (
  seq         VARCHAR2(20) NOT NULL,
  autho_name  VARCHAR2(20) NOT NULL
) SEGMENT CREATION IMMEDIATE;

INSERT INTO KN_AUTHORITY(seq, autho_name)
VALUES(NEWSEQ.NEXTVAL , 'aaa');
SELECT *FROM KN_AUTHORITY

--sequence END----------------------------------------------------------
--------------------------------------------------------------------------
--------------------------------------------------------------------------
--INDEX
--1.목적 : 검색 속도의 향상 (select ~)
--2.단점 : DML(insert , delete , update) 손실
--DBA : 인덱스 재구성하는 하는 작업을 주기적으로 ....
--index 업무 DBA업무 중에 하나 ,,,
--생성시점 : 테이블 생성시 인덱스를 생성하는 경우는 많지 않다

/*
1.4.2  인덱스 생성을 위한 지침
가) 많은 것이 항상 더 좋은 것은 아니다.
테이블의 많은 인덱스가 질의의 스피드 향상을 꼭 의미하는 것은 아닙니다.
인덱스를 가지고 있는 테이블에 대한 각DML작업은 인덱스도 갱신되어야 함을 의미합니다.
많은 인덱스가 테이블과 관련되어 있으면, ORACLE SERVER은 DML후에 모든 인덱스를
갱신하기 위해 더 많은 노력이 필요하게 됩니다.

나) 언제 인덱스를 생성하는가?
1)	열은 WHERE절 또는 조인 조건에서 자주 사용됩니다.
2)	열은 광범위한 값을 포함합니다.
3)	열은 많은 수의 null값을 포함합니다.
4)	둘 또는 이상의 열은 WHERE절 또는 조인 조건에서 자주 함께 사용됩니다.
5)	테이블은 대형이고 대부분의 질의들은 행의 2~4%보다 적게 읽어 들일 것으로 예상됩니다.

다) 언제 인덱스를 생성해서는 안되는가
1)	테이블이 작다.
2)	열이 질의의 조건으로 자주 사용되지않는다.
3)	대부분의 질의들은 행의 2~4%이상을 읽어 들일 것으로 예상된다.
4)	테이블은 자주 갱신됩니다. 테이블에 하나 이상 인덱스를 가지고 있다면
테이블을 엑세스하는 DML문장은 인덱스의 유지 때문에 상대적으로 더 많은 시간이 걸리게 됩니다.

*/


--지금까지 .....배운 코드 .....
--
SELECT * FROM user_indexes WHERE table_name='EMP';


CREATE TABLE index_T
(
	 id NUMBER ,
   NAME VARCHAR2(20)
);

INSERT INTO index_T VALUES(10,'AA');
INSERT INTO index_T VALUES(1,'BB');
INSERT INTO index_T VALUES(5,'CC');
INSERT INTO index_T VALUES(4,'DD');
COMMIT;

CREATE TABLE index_T2
(
	 id NUMBER CONSTRAINT pk_index_T2_id PRIMARY KEY  ,
   NAME VARCHAR2(20)
);
INSERT INTO index_T2 VALUES(10,'AA');
INSERT INTO index_T2 VALUES(1,'BB');
INSERT INTO index_T2 VALUES(5,'CC');
INSERT INTO index_T2 VALUES(4,'DD');
COMMIT;

--1
SELECT * FROM index_T;
SELECT * FROM index_T2;

--2
SELECT id FROM index_T;
SELECT id FROM index_T2; --PK -> 정렬(unique index)

SELECT * FROM index_T2 WHERE id = 10;

SELECT * FROM user_indexes WHERE table_name='INDEX_T';
SELECT * FROM user_indexes WHERE table_name='INDEX_T2';

----------------------------------------------------------------
--인덱스가 없는 index_T 인덱스 생성하기
DROP INDEX idx_index_T_unique
CREATE UNIQUE  INDEX idx_index_T_unique -- 중복 데이터 허용하지 않는 index
ON
			index_t(id DESC);

CREATE INDEX idx_index_T_unique  --중복 데이터 허용 index
ON
			index_t(id DESC);


SELECT * FROM user_indexes WHERE table_name='INDEX_T';

SELECT * FROM INDEX_T;
SELECT id FROM INDEX_T;

INSERT INTO INDEX_T VALUES(50,'DD');
COMMIT;

---------------------------------------------------------------------------

SELECT * FROM user_indexes WHERE table_name='COPYEMP';

SELECT * FROM COPYemp;

--empno unique
--ename unique

CREATE UNIQUE INDEX idx_copy
ON
		copyemp(empno);

DROP INDEX idx_copy_ename
CREATE  INDEX idx_copy_ename
ON
		copyemp(ename);

SELECT * FROM user_indexes WHERE table_name='COPYEMP';

INSERT INTO copyemp(empno, ename)
VALUES(100,'AA');
INSERT INTO copyemp(empno, ename)
VALUES(20,'CC');

INSERT INTO copyemp(empno, ename)
VALUES(40,'Bb');

COMMIT;

SELECT * FROM copyemp;
SELECT * FROM COPYEMP WHERE empno=100;
SELECT * FROM COPYEMP WHERE ename='AA';
--------------------------------------------------------------------------






















































