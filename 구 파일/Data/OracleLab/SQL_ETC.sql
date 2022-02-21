--의사컬럼 (^^):
--ROWNUM : 실제로 테이블에 존재하는 컬럼은 아님 ( 쿼리 결과에대한 행번호 부여)
--ROWID : 주소로서 행이 실제로 저장되어 있는 내부 고유주소
SELECT  ROWNUM , empno , ename FROM EMP;

--Top-n 쿼리(^^)
--테이블에서 조건에 맞는 최상위 (Top) 레코드 n개 , 최하위 n개의 레코드를 추출
--Top-n : rownum
SELECT  ROWNUM , empno , ename FROM EMP;

--게시판성 데이터 구조에서  사용
--rownum , order by , where 절 이용
--문법
/*
SELECT [column_list] , ROWNUM
FROM (SELECT [column_list]
         FROM TABLE
         ORDER BY top_N column)
WHERE ROWNUM <= N(NUMBER)
 */

SELECT *
FROM (
					 SELECT e.*
           FROM EMP e ORDER BY sal DESC
         )
WHERE ROWNUM <=5

--------------------------------------------------------------------------
--게시판 형태
--일반 형태 게시판
--board (boardnum , title , content , writer , regdate , readcount ,,,,,)
--1
--2
--3 ........ 100글까지 ...

--최신글 : select * from board order by boardnum desc
--page :  한화면에 보여줄수 있는 게시물의 건수
--pagesize : 5
--pagecount : 20개의 페이지
--[1] [2] [3] [4] [5]
--currpage = 1 => 5건 (1~5)
--currpage =2 => 5건 (6~10)

select * from board order by boardnum desc

--rownum , boardnum
      1           100
      2           99
      ..
      6
      ..
      10
SELECT * FROM
									  (SELECT ROWNUM num , a.* FROM
                    					(
                    						  SELECT * FROM board  ORDER BY boardnum desc
                      				) a WHERE ROWNUM <=10
                     ) WHERE num >= 5
--1 . SELECT * FROM board  ORDER BY boardnum desc 정렬
--2. 두번째 subquery rownum <= 10    10건  (100 ~ 91)
--3.
--rownum    boardnum
--------------------------------------------------------------------------
--답변형 게시판(계층형 게시판)
--Multiboard (boardnum , title , content , writer , regdate , readcount ,,,,,)
--ref(참조)  , step(순서)  , depth(글의 깊이:들여쓰기)

--boardnum    ,    ref    ,  step   , depth

--select * from Multiboard order by ref desc , step asc
--최신글 묶음으로 정렬 ,
--------------------------------------------------------------------------
--(~~!)
--rollup 함수   --cube
--소계 , 합계 (통계성)
--OLAP  <-> OLTP (DML)

SELECT  deptno, job,COUNT(*),SUM(sal)
FROM EMP
GROUP BY ROLLUP(deptno,job);

SELECT  deptno, job,COUNT(*),SUM(sal)
FROM EMP
GROUP BY cube(deptno,job);

--------------------------------------------------------------------------
--(~^)
--PIVOT(11g 제공)
--row 단위를 colum 단위로 변경

CREATE TABLE CAL
(
  WEEK NUMBER(1),  --첯번째 주 , 두번쨰 주
  DAY  VARCHAR2(10), --요일
  NUM_DAY NUMBER(2) --1일 , 2일  , 3일
);

INSERT INTO CAL VALUES(1,'일',1);
INSERT INTO CAL VALUES(1,'월',2);
INSERT INTO CAL VALUES(1,'화',3);
INSERT INTO CAL VALUES(1,'수',4);
INSERT INTO CAL VALUES(1,'목',5);
INSERT INTO CAL VALUES(1,'금',6);
INSERT INTO CAL VALUES(1,'토',7);
COMMIT;
INSERT INTO CAL VALUES(2,'일',8);
INSERT INTO CAL VALUES(2,'월',9);
INSERT INTO CAL VALUES(2,'화',10);
INSERT INTO CAL VALUES(2,'수',11);
INSERT INTO CAL VALUES(2,'목',12);
INSERT INTO CAL VALUES(2,'금',13);
INSERT INTO CAL VALUES(2,'토',14);
COMMIT;
INSERT INTO CAL VALUES(3,'일',15);
INSERT INTO CAL VALUES(3,'월',16);
INSERT INTO CAL VALUES(3,'화',17);
INSERT INTO CAL VALUES(3,'수',18);
INSERT INTO CAL VALUES(3,'목',19);
INSERT INTO CAL VALUES(3,'금',20);
INSERT INTO CAL VALUES(3,'토',21);
COMMIT;
INSERT INTO CAL VALUES(4,'일',22);
INSERT INTO CAL VALUES(4,'월',23);
INSERT INTO CAL VALUES(4,'화',24);
INSERT INTO CAL VALUES(4,'수',25);
INSERT INTO CAL VALUES(4,'목',26);
INSERT INTO CAL VALUES(4,'금',27);
INSERT INTO CAL VALUES(4,'토',28);
COMMIT;
INSERT INTO CAL VALUES(5,'일',29);
INSERT INTO CAL VALUES(5,'월',30);
INSERT INTO CAL VALUES(5,'화',31);
COMMIT;

SELECT * FROM cal;

주	일 	월 	화 	수 	목 	금 	토
1	  1	  2	    3   	4	  5	  6   	7
2	 8	 9	  10	  11	 12	 13  	14
3	 15 	16	17	   18	 19	 20	  21

SELECT MAX(DECODE(day,'일',num_day)) AS sun ,
					 MAX(DECODE(day,'월',num_day)) AS mon,
           MAX(DECODE(day,'화',num_day)) AS tue ,
           MAX(DECODE(day,'수',num_day)) AS wed ,
           MAX(DECODE(day,'목',num_day)) AS thu ,
           MAX(DECODE(day,'금',num_day)) AS fri ,
           MAX(DECODE(day,'토',num_day)) AS sat
FROM cal
GROUP BY week
ORDER BY week;

SELECT * FROM (SELECT week "주" , day, num_day FROM cal)
PIVOT(
				MAX(num_day)
        FOR day IN('일' AS "일",
        						   '월' AS "월",
                       '화' AS "화",
                       '수' AS "수",
                       '목' AS "목",
                       '금' AS "금",
                       '토' AS "토" )
        )
ORDER BY "주";

--사원테이블에서 부서별로 각 직종별 인원이 몇명인 계산해서 출력
--deptno , clerk ,......
detpno   clierk  man....
10           1        2
20           0      3

SELECT deptno ,
           COUNT(DECODE(job,'CLERK',0)) AS "CLERK",
           COUNT(DECODE(job,'MANAGER',0)) AS "MANAGER",
           COUNT(DECODE(job,'SALESMAN',0)) AS "SALESMAN",
           COUNT(DECODE(job,'ANALYST',0)) AS "ANALYST",
           COUNT(DECODE(job,'PRESIDENT',0)) AS "PRESIDENT"
FROM EMP
GROUP BY deptno
ORDER BY deptno;

--PIVOT사용
SELECT * FROM (SELECT deptno , job, empno FROM emp)
PIVOT(
				count(empno)
        FOR job  IN('CLERK' AS "CLERK",
        						   'MANAGER' AS "MANAGER",
                       'SALESMAN' AS "SALESMAN",
                       'ANALYST' AS "ANALYST",
                       'PRESIDENT' AS "PRESIDENT"
                        )
        )
ORDER BY deptno;

--------------------------------------------------------------------------
--데이터 만들기
create table professor
(profno number(4) primary key,
 name  varchar2(10) not null,
 id  varchar2(15) not null,
 position varchar2 (10) not null,
 pay number (3) not null,
 hiredate  date not null,
 bonus number(4) ,
 deptno  number(3),
 email  varchar2(50),
 hpage  varchar2(50)) tablespace users;

insert into professor
values(1001,'김유신','captain','정교수',550,to_date('1980-06-23','YYYY-MM-DD'),100,101,'captain@abc.net','http://www.abc.net');

insert into professor
values(1002,'이순신','sweety','조교수',380,to_date('1987-01-30','YYYY-MM-DD'),60,101,'sweety@abc.net','http://www.abc.net');

insert into professor
values (1003,'송도권','powerman','전임강사',270,to_date('1998-03-22','YYYY-MM-DD'),null,101,'pman@power.com','http://www.power.com');

insert into professor
values (2001,'양선희','lamb1','전임강사',250,to_date('2001-09-01','YYYY-MM-DD'),null,102,'lamb1@hamail.net',null);

insert into professor
values (2002,'김영조','number1','조교수',350,to_date('1985-11-30','YYYY-MM-DD'),80,102,'number1@naver.com','http://num1.naver.com');

insert into professor
values (2003,'주승재','bluedragon','정교수',490,to_date('1982-04-29','YYYY-MM-DD'),90,102,'bdragon@naver.com',null);

insert into professor
values (3001,'김도형','angel1004','정교수',530,to_date('1981-10-23','YYYY-MM-DD'),110,103,'angel1004@hanmir.com',null);

insert into professor
values (3002,'나한열','naone10','조교수',330,to_date('1997-07-01','YYYY-MM-DD'),50,103,'naone10@empal.com',null);

insert into professor
values (3003,'김현정','only-u','전임강사',290,to_date('2002-02-24','YYYY-MM-DD'),null,103,'only_u@abc.com',null);

insert into professor
values (4001,'심슨','simson','정교수',570,to_date('1981-10-23','YYYY-MM-DD'),130,201,'chebin@daum.net',null);

insert into professor
values (4002,'최슬기','gogogo','조교수',330,to_date('2009-08-30','YYYY-MM-DD'),null,201,'gogogo@def.com',null);

insert into professor
values (4003,'박원범','mypride','조교수',310,to_date('1999-12-01','YYYY-MM-DD'),50,202,'mypride@hanmail.net',null);

insert into professor
values (4004,'차범철','ironman','전임강사',260,to_date('2009-01-28','YYYY-MM-DD'),null,202,'ironman@naver.com',null);

insert into professor
values (4005,'바비','standkang','정교수',500,to_date('1985-09-18','YYYY-MM-DD'),80,203,'standkang@naver.com',null);

insert into professor
values (4006,'전민','napeople','전임강사',220,to_date('2010-06-28','YYYY-MM-DD'),null,301,'napeople@jass.com',null);

insert into professor
values (4007,'허은','silver-her','조교수',290,to_date('2001-05-23','YYYY-MM-DD'),30,301,'silver-her@daum.net',null);

commit;

SELECT * FROM professor;
--순위함수(~^)
--RANK()
--RANK(조건값) WITHIN GROUP(ORDER BY 조건값 컬럼명 [ASC | DESC]
SELECT * FROM professor ORDER BY NAME;

SELECT RANK('이순신') WITHIN GROUP(ORDER BY NAME ASC) "RANK"
FROM professor;

SELECT RANK(330) WITHIN GROUP(ORDER BY PAY DESC) "RANK"
FROM PROFESSOR;

SELECT profno , NAME, pay,
					 RANK() OVER(ORDER BY pay ASC) AS "rank1",
           RANK() OVER(ORDER BY pay DESC ) AS "rank2"
FROM professor;

--quiz
--사원 테이블 사번, 이름 , 급여 , 부서번호 , 부서내에서 [직종별] 급여 순위 출력
SELECT empno, ename , sal ,deptno ,
           RANK() OVER(PARTITION BY deptno ORDER BY sal desc) AS "rank"
FROM EMP;
--------------------------------------------------------------------------
--파티션 테이블 만들기----------------------------------------------------------
--개발자가 접근 하기는 난해하다 (DBA 가 처리하는 사항)
--개발자가 알고 있다면 PLUS 사항입니다
--대용량 데이터 에서 사용되는 방법
--파티션 테이블 (ADMIN)
--기본상식
--데이터 조회 나 수정시  물리적인 데이터 저장소에 접근하여 데이터를 복사한 후
--메모리에 올려 놓게 작업 (그 메모리 공간을 Buffer) 라 합니다
--오라클에서 사용되는 Buffer를 => DataBase Buffer Cache
--오라클은 DataBase Buffer Cache 라는 메모리 공간을 TableSpace라는 논리적
--공간으로 나누어 사용

--EX) 백화점
--물건이 전시되어 있는 공간 (TABLESPACE)
--물건창고 (데이터 파일)
--손님이 원하는 물건 : 테이블 .....
--그런데 물건창고에 물건이 적은 경우는 문제가 되지 않지만
--물건창고에 엄청나게 많은 제품이 있다면 ?????
--물건 정리 (기준) ... 물리적인 작업

--조회 작업은  SYSTEM 권한으로 접속 해서 확인
--SELECT * FROM dba_data_files;
--SELECT * FROM dba_tab_partitions WHERE table_owner ='HR';
------------------------------------------------------------------------------
SELECT * FROM user_tables;
--물리적인 데이터 저장 공간
--C:\APP\KOSTA\ORADATA\ORCL\USERS01.DBF

--판매용 테이블
--범위를 기준으로한 Range partition(범위 파티션)
--데이터를 날짜를 기준으로  [물리적인 공간]에 배치하는 작업
--작업순서
--1.  물리적인 데이터 공간 확인 작업
---- SYSTEM 계정으로 접근 조회 확인
--SELECT * FROM dba_data_files;
--SELECT * FROM dba_tab_partitions WHERE table_owner ='HR';
-- 경로 파악 : C:\APP\KOSTA\ORADATA\ORCL\USERS01.DBF

--2.  분활 기준을 가지고 저장용 테이블 스페이스 확보
--별도의 공간
--작업은  SYSTEM 권한
/*
CREATE TABLESPACE ts_q1
DATAFILE 'C:\APP\KOSTA\ORADATA\ORCL\ts_q101.DBF' SIZE 2M;

CREATE TABLESPACE ts_q2
DATAFILE 'C:\APP\KOSTA\ORADATA\ORCL\ts_q201.DBF' SIZE 2M;

CREATE TABLESPACE ts_q3
DATAFILE 'C:\APP\KOSTA\ORADATA\ORCL\ts_q301.DBF' SIZE 2M;

CREATE TABLESPACE ts_q4
DATAFILE 'C:\APP\KOSTA\ORADATA\ORCL\ts_q401.DBF' SIZE 2M;

CREATE TABLESPACE ts_q5
DATAFILE 'C:\APP\KOSTA\ORADATA\ORCL\ts_q501.DBF' SIZE 2M;
*/

CREATE TABLE panmae
(
    pdate VARCHAR2(8),
    pcode NUMBER(3),
    pqty   NUMBER(5))
  	PARTITION BY RANGE(pdate) -- 무었을 기준으로 정렬(파티션을 할 것이냐)
    ( PARTITION q1 VALUES LESS THAN ('20100401') TABLESPACE ts_q1,
      PARTITION q2 VALUES LESS THAN ('20100701') TABLESPACE ts_q2,
      PARTITION q3 VALUES LESS THAN ('20101001') TABLESPACE ts_q3,
      PARTITION q4 VALUES LESS THAN ('20110101') TABLESPACE ts_q4,
      PARTITION q5 VALUES LESS THAN (MAXVALUE) TABLESPACE ts_q5
 );


SELECT * FROM panmae;

INSERT INTO panmae
VALUES('20100404',100,50);

INSERT INTO panmae
VALUES('20100920',200,30);

INSERT INTO panmae
VALUES('20131010',800,2);

COMMIT;

SELECT * FROM panmae;

SELECT * FROM panmae PARTITION(q2);
SELECT * FROM panmae PARTITION(q3);
SELECT * FROM panmae PARTITION(q5);
--------------------------------------------------------------------------


