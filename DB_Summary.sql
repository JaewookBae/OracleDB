-- Data Integrity Constraint Rule( 데이터 무결성)
-- 248
-- 무결성 제약조건 : 테이블에 부적절한 자료가 입력되는 것을 방지하기 위해서 테이블 생성할 때
--                  각 컬럼에 대해서 정의하는 여러 규칙 / 다른 말로 정확성
-- 1. 무결성 제약조건 6가지
-- not null : 반드시 값을 가져야 한다.
-- unique : 중복 불가, null불가
-- primary key : 중복 불가, null불가
-- Foreign key : 중복가능, null허용, 범위(domain)내에 있어야함
--               다른 테이블(부모)의 기본키를 현재 테이블의 컬럼으로 사용
-- check : 범위, 조건값
-- default : 기본값

-- 1. not null
select * from dept;
desc dept; --describe의 축약
insert into dept values(50, 'test', 'seoul');
insert into dept values(null, null, 'seoul');

drop table emp01;

create table emp01(
    empno number(4),
    ename varchar2(10),
    job varchar2(9),
    deptno number(2));
insert into emp01 values(null, null, 'sales', 30);

create table emp02(
    empno number(4) not null,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2));
    
insert into emp02 values(null, null, 'sales', 30);
--=> NULL을 ("SCOTT"."EMP02"."EMPNO") 안에 삽입할 수 없습니다.
insert into emp02 values(20, 'hong', 'sales', 30);


-- 2.unique : 중복불가, Null 허용
create table emp03(
    empno number(4) unique,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2));
insert into emp03 values(null, 'hong', 'sales', 30); -- null 허용
insert into emp03 values(10, 'hong', 'sales', 30); -- O
insert into emp03 values(10, 'hong', 'sales', 30); -- 중복값
--=> ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011060)에 위배됩니다


-- 3. Primary Key : Unique + not null
create table emp05(
    empno number(4)CONSTRAINT emp05_empno_pk primary key,
    ename varchar2(10)CONSTRAINT emp05_ename_nn not null,
    job varchar2(9),
    deptno number(2));
insert into emp05 values(null, 'hong', 'sales', 30); -- null 불가
insert into emp05 values(10, 'hong', 'sales', 30); -- O
insert into emp05 values(10, 'hong', 'sales', 30); -- 중복값
--=> ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011060)에 위배됩니다
select * from emp05;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('EMP05');

create table emp055(
    empno number(4) primary key,
    ename varchar2(10) not null,
    job varchar2(9),
    deptno number(2));
    
select constraint_name, constraint_type, table_name
from user_constraints
where table_name in ('EMP055');


-- 4. 참조(Reference) 무결성을 위한 Foreign Key 제약 조건
-- 다른 테이블(부모)의 기본키 컬럼을 현재 테이블(자식)의 컬럼으로 사용하는 것 
-- 부모테이블: DEPT - 기본키 컬럼, Unique컬럼만 가능
-- 자식테이블: EMP - 부모컬럼: 중복사용, NULL 가능 
select constraint_name, constraint_type, table_name
from user_constraints
where table_name IN ('DEPT','EMP');

-- Foreign key 제약조건 (Constraint) 설정하기
drop table emp06;

create table emp06(
    empno   NUMBER(4)  Constraint emp06_empno_pk PRIMARY KEY,
    ename   VARCHAR2(10) Constraint emp06_ename_pk NOT NULL,
    job     VARCHAR2(9),
    deptno NUMBER(2) Constraint emp06_deptno_fk REFERENCES dept (deptno) 
    );

insert into emp06 values ( 7499, 'Miller','saleman',30);
insert into emp06 values ( 7498, 'Miller','saleman',30);
insert into emp06 values ( 7497, 'Miller','saleman',50); -- 입력안됨, domain(범위:10~40) 
insert into emp06 values ( 7496, 'Miller3','saleman3',30); 
insert into emp06 values ( 7495, 'Miller3','saleman3',null); --null허용

-- ORA-00001: 무결성 제약 조건(SCOTT.EMP06_EMPNO_PK)에 위배됩니다 -> 부모키에 50이 없다

SELECT
    *
FROM emp06;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name IN ('EMP06');

-- 제약조건 사용방법2 : 테이블 레벨 방법
create table emp066(
    empno   NUMBER(4), 
    ename   VARCHAR2(10) Constraint emp06_ename_pk NOT NULL,
    job     VARCHAR2(9),
    deptno NUMBER(2) , 
    CONSTRAINT emp066_empno_pk primary key(empno),
    Constraint emp066_deptno_fk FOREIGN key (deptno) REFERENCES dept (deptno)
    );

create table emp0666(
    empno   NUMBER(4), 
    ename   VARCHAR2(10) Constraint emp06_ename_pk NOT NULL,
    job     VARCHAR2(9),
    deptno NUMBER(2) , 
 primary key(empno),
FOREIGN key (deptno) REFERENCES dept (deptno)
    );

-- 복합키(complete key)를 기본키로 지정하는 방법
-- 복합키 : 테이블내의 여러 컬럼을 모아서 기본키로 설정
--           : 하나의 테이블에서는 하나 이상의 기본키가 있을 수 없음
create table member01(
name varchar2(10),
address varchar2(30),
phone varchar2(16),
CONSTRAINT member01_compo_pk primary key(name, phone) -- 기본키 : 1
);

select constraint_name, constraint_type, table_name
from user_constraints
where table_name = ('MEMBER01');

-- 제약조건 변경하기
-- i)기존 테이블에 제약조건 추가하기 : alter~add
drop table emp01;
create table emp01(
empno number(4),
ename varchar2(10),
job varchar2(9),
deptno number(4)
);
select constraint_name, constraint_type, table_name
from user_constraints
where table_name = ('EMP01');

--기본키 추가하기
alter table emp01 
add constraint emp01_empno_pk primary key(empno);


alter table emp01 
add constraint emp01_deptno_fk foreign key(deptno) references dept (deptno);

alter table emp01 
modify ename constraint emp01_ename_nn not null;

-- 제약조건 삭제하기
alter table emp05
drop primary key;

alter table emp05
drop constraint emp05_ename_nn;

-- 제약조건 활성화/비활성화
drop table dept01;
create table dept01(
deptno number(2) constraint dept01_deptno_pk primary key,
dname varchar2(14),
loc varchar2(13)
);

insert into dept01 values(10,'accounting','new york');
insert into dept01 values(20,'accounting2','new york2');

drop table deptsub;

create table deptsub(
empno number(6),
ename varchar2(20) constraint deptsub_ename_nn not null,
job varchar2(15), 
deptno number(6),
constraint deptsub_emptno_pk primary key (empno),
constraint deptsub_job_uk unique(job), 
constraint deptsub_deptno_fk foreign key(deptno) references dept01 (deptno)
);
insert into deptsub values(2210,'account','new',10);
insert into deptsub values(2220,'account2','york2',20);

select * from dept01;
select * from deptsub;
commit;

select constraint_name, constraint_type, table_name
from user_constraints
where table_name = ('DEPTSUB');

--부모 테이블 지우려고 할 때 문제 발생
delete from dept01
where deptno = 10;
--=>ORA-02292: 무결성 제약조건(SCOTT.DEPTSUB_DEPTNO_FK)이 위배되었습니다- 자식 레코드가 발견되었습니다

delete from deptsub
where deptno = 10;
--=>삭제 가능 : 부모테이블과 자식테이블에서 자식을 먼저 지우면, 부모도 삭제 가능

delete from dept01
where deptno = 10;
--=>자식을 먼저 삭제했기 때문에 부모 삭제 가능

rollback;

--Disable : 비활성화
alter table deptsub
disable constraint deptsub_deptno_fk;

drop table dept01; --부모테이블
drop table deptsub; --자식테이블

rollback;
--Enable : 활성화 시키기
--부모 테이블 만들기
alter table deptsub
enable constraint deptsub_deptno_fk;
