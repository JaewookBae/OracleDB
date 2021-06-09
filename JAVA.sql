--Oracle: 대소문자 구분 X
-- 환경설정: utf-8
--글자크기: 


--1. DB 접속
--테이블 삭제:
drop table goodsinfo;

--테이블 생성
create table goodsInfo(
    code char(5) not null primary key, 
    name varchar2(30) not null, 
    price number(8) not null,
    maker varchar2(20)
);

insert into goodsinfo values ('10001','디지털1 TV',35000,'LG1');
insert into goodsinfo values ('10002','디지털2 TV',36000,'LG2');
insert into goodsinfo values ('10003','디지털3 TV',37000,'LG3');
insert into goodsinfo values ('10004','디지털4 TV',38000,'LG4');
commit; --완전저장, DML조작어할 때 사용(Insert, Update, Delete)

--2. Sequence
--DB에서 연속적으로 증가하는 값을 표현 : primary key
--MySQL : increment
--memberid INT(6) primary key INCREMENT
--      INSERT into aaa values(memberid,
--Oracle : sequence
--     memberid Number(6) primary key INCREMENT
--       create sequenve memberid_seq;
--     insert into aaa values(memberid_seq.nextval

-- sequence 생성 : create sequenve memberid_seq;
-- sequence 삭제 : drop sequence memberid_seq;

create sequence dept_deptno_seq;
select dept_septno_seq.nextval from dual; -- 현재 시퀀스의 다음값을 반환
select dept_septno_seq.currval from dual; -- 현재값 반환

drop table emp01;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10),
    hiredate date);
create sequence emp_seq;

--empno는 sequence값을 사용해서 데이터 입력하기
insert into emp01 values(1,'abcd',sysdate);
select * from emp01;
insert into emp01 values(EMP_SEQ.nextval,'홍길동','21/06/09');
insert into emp01 values(EMP_SEQ.nextval,'abcd',sysdate);


--예1
--[결과]
--10 인사과 서울 20 경리과 서울 30 총무과 대전 40 기술팀 대전

create table dept_exam(deptno number(4),dname varchar2(10),loc varchar2(10));
create sequence dept_exam_seq increment by 10 start with 0 minvalue 0;

insert into dept_exam values(dept_exam_seq.nextval,'인사과','서울');
insert into dept_exam values(dept_exam_seq.nextval,'경리과','서울');
insert into dept_exam values(dept_exam_seq.nextval,'총무과','대전');
insert into dept_exam values(dept_exam_seq.nextval,'기술팀','대전');
select * from dept_exam;


-- 3. Index
-- SQL문의 처리속도를 향상시키기 위해서 컬럼에 생성하는 객체
-- Primary key, Unique와 같은 제약조건(Constraint: 명칭)을 지정하면 자동인덱스 이름으로도 사용한다.

select index_name, table_name, column_name from USER_IND_COLUMNS 
where table_name IN ('EMP','DEPT');
select * from tab;

create table member1(ID varchar2(20), PASSWORD varchar2(20), NAME varchar2(20), AGE number(4),
GENDER varchar2(10), EMAIL varchar2(20));
