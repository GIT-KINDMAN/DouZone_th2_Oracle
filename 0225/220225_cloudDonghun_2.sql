show user;
select * from emp2;

grant select on donghun.emp2 to hoon;
select * from emp2;
drop table emp2 cascade constraints; -- 삭제에 걸리는 제약조건까지 제거

flashback table emp2 to before drop;

--------------------------------------------------------------------------------------------

-- PL/SQL (Procedual Language)
/* 형식>
Declare - 선언(선택)
    Begin
        실행(필수)
    End;
*/

Begin
    DBMS_output.put_line('이동훈'); -- 출력 안나옴. 보기>DBMS출력 란에서 볼 수 있음
End;

DECLARE e_name emp.ename%type; --  := 기호가 +=인가봄 추가한다는 프로시저인듯
            e_sal emp.sal%type;
BEGIN
    select sal, ename into e_sal, e_name from emp where empno='7788';
    DBMS_OUTPUT.PUT_LINE('7788님의 이름은 ' || e_name || ' 급여는 ' || e_sal);
END;


-- SCOTT, ANALYST, 7566, 20
DECLARE data emp%ROWTYPE;
BEGIN
    SELECT * INTO data from emp where empno = '7788';
    DBMS_OUTPUT.PUT_LINE(data.ename ||', ' || data.job ||', ' ||data.mgr||', ' || data.deptno);
END;

----------------------------------------------------------------------------------------------------------
-- 제어문(if, for문은 BEGIN END 사이에 있어야함. DECLARE는 안쓰면 생략 가능하긴함)

DECLARE
    num1 number := 3;
    num2 number := 5;
BEGIN
    IF num1 >= num2 then
        DBMS_OUTPUT.PUT_LINE(num1 || '이 큽니다.');
    ELSE DBMS_OUTPUT.PUT_LINE(num2 || '이 큽니다.');
    END IF;
END;

--------------------------------------------------------------------------------------------------------------

-- 프로시저로 만듦
create PROCEDURE p_sal IS
DECLARE
    v_salary number :=0;
    v_dept_id number :=0;
BEGIN
    v_dept_id := round(DBMS_random.value(10,120), -1);
    
    select sal into v_salary from emp where deptno = v_dept_id and rownum =1;
    DBMS_OUTPUT.PUT_LINE(v_salary);
    
    if v_salary between 1 and 3000 then DBMS_OUTPUT.PUT_LINE('보수적음');
    ELSIF v_salary between 3001 and 6000 then DBMS_OUTPUT.PUT_LINE('업계 평균');
    ELSIF v_salary between 6001 and 9000 then DBMS_OUTPUT.PUT_LINE('보수좋음');
    ELSE DBMS_OUTPUT.PUT_LINE('고연봉');
    END IF;
END;

-- EXECUTE 프로시저이름:


-------------------------------------
-- 실행해도 파일로 저장되기 때문에 안보일거임. 프로시저 탭에서 확인 가능
create PROCEDURE p_test
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('예아 주말');
END;
--------------------------------------
-- 즉 정리하면
-- 프로시져 생성
create PROCEDURE p_test
IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('예아 주말');
END;
----------------------------------------
EXECute p_test; -- 프로시저 실행
EXEC p_test; -- 이하 동문
