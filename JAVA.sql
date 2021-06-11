--Oracle: 대소문자 구분X
-- 환경설정: utf-8
-- 글자크기 : 


--I. DB 접속
-- 테이블 삭제: 
Drop table goodsInfo;

create table goodsInfo(
  code char(5) not null primary key,
  name VARCHAR2(30) not null,
  price NUMBER(8) not null,
  maker VARCHAR2(20)
);

insert into goodsinfo values ('10001','디지털1 TV',35000,'LG1');
insert into goodsinfo values ('10002','디지털2 TV',39000,'LG2');
insert into goodsinfo values ('10003','디지털3 TV',15000,'LG3');
insert into goodsinfo values ('10004','디지털4 TV',95000,'LG4');
commit; --완전저장, DML조작어할때 사용(Insert, UPdate,Delete)

--Study17
drop table member1;
create table member1(
	id varchar2(12),
	password varchar2(12),
	name  varchar2(12),
	age number,
	addr varchar2(50),
	email varchar2(30)
);

insert into member1 values('bbb','bbb','홍길동',22,'서울시','a@a.com');
insert into member1 values('aaa','aaa','홍길동',22,'서울시','a@a.com');
select * from member1;
select * from member1;
update member1 set addr='부산시' where id='aaa';
rollback;-- 취소,철회
commit;--완전저장(취소 불가)
delete member1 where id='aaa'


--2.Sequence
-- DB에서 연속적으로 증하는 값을 표현 : primary key
--MySQL : increment
--  memberid INT(6) primary key INCREMENT
--    Insert into aaa values(memberid,
--Oracle : sequence
--  memberid Number(6) primary key 
--    create sequence memberid_seq;
--   Insert into aaa values(memberid_seq.nextval

--sequence 생성:  create sequence memberid_seq;
--sequence 삭제:  drop sequence memberid_seq;


create sequence dept_deptno_seq;
select dept_deptno_seq.nextval from dual;--현재 시퀸스의 다음값을 반환
select dept_deptno_seq.currval from dual;--현재값 반환

drop table emp01;
create table emp01(
    empno number(4) primary key,
    ename varchar2(10),
    hiredate date
);
 create sequence emp_seq;

 -- empno는 sequence값을 사용해서 데이터 입력하기
 insert into emp01 values(1,'abcd',sysdate);
 insert into emp01 values(emp_seq.nextval,'abcd',sysdate);
 select * from emp01;
 
 --예1
 --[결과]
 10 인사과 서울
 20 경리과 서울
 30 총무과 대전
 40 개술팀 대전
 
 drop table dept_exam;
 
 create table dept_exam(
  deptno number(4) primary key,
  dname varchar2(16),
  loc varchar2(15)
 );
 
 drop sequence dept_exam_seq;
 
 create sequence dept_exam_seq
 increment by 10
 start with 0
 minvalue 0
 
 insert into dept_exam values(dept_exam_seq.nextval,'인사과','서울');
 insert into dept_exam values(dept_exam_seq.nextval,'경리과','서울');
 insert into dept_exam values(dept_exam_seq.nextval,'총무과','대전');
 insert into dept_exam values(dept_exam_seq.nextval,'기술팀','대전');
 
 select * from dept_exam;
 
 
 
 --3.Index
 --SQL문의 처리속도를 향상시키기 위해서 컬럼에 생성하는 객체
 --Primary key, Unique와 같은 제약조건(Constraint: 명칭)을 지정하면 자동인덱스 이름으로도 사용한다.
 
 select index_name, table_name, column_name
 from USER_IND_COLUMNS
 where table_name IN ('EMP','DEPT');
 
 --1)인덱스 비교
 --i)emp 테이블 복사
 drop table emp01;
 create table emp01
 as
 select * from emp;
 
 select * from emp01;
 select * from emp;
 
 select index_name, table_name, column_name
 from USER_IND_COLUMNS
 where table_name IN ('EMP','EMP01');
 --=>sybQuery 복사한 테이블(emp01)은  구조와 내용만 복사될뿐
 -- Index,제약조건은 복사 불가
 
 --ii)인덱스가 아닌 컬럼으로 검색하기
 insert into emp01 select * from emp01;
 insert into emp01 select * from emp01;
 insert into emp01 select * from emp01;
 insert into emp01 select * from emp01;
 insert into emp01 select * from emp01;
 insert into emp01 select * from emp01;
 
 --실행
 insert into emp01(empno,ename) values(1111,'aaaa');
 set timing on --실행시킨 SQL 또는 PLSQL블록에 실행속도를 보기 위한것
 --실행시 : F5 (스크립트 실행)
 select distinct empno,ename from emp01 where ename='aaaa';
 
 --iii)인덱스를 사용한 검색하기
 create Index IDX_EMP01_ENAME
 ON EMP01(ENAME);
 
select index_name, table_name, column_name
 from USER_IND_COLUMNS
 where table_name IN ('EMP','EMP01'); 
 
 select distinct empno,ename from emp01 where ename='aaaa';
--=>인덱스 사용시 : 빠른 검색 가능한 경우: 자료의 변화 적은 것
 
 --인덱스 자우기
 DROP Index IDX_EMP01_ENAME;
 
 --iii)인덱스
 --unique Index : 유일한 값을 가지는 컬럼에 대해서 설정
 --non-unique Index : 중복된  값을 같은 컬럼에 대해서 인덱스 설정(Default)
 
 drop table dept01;
 create table dept01
 as 
 select * from dept where 1=0;
 
 select * from dept01;
 
 insert into dept01 values(10,'인사과','서울');
 insert into dept01 values(20,'인사과','서울');
 insert into dept01 values(30,'인사과','서울');
 
 --Unique Index
 create unique index IDX_DEPT01_DEPTNO
 ON DEPT01(DEPTNO);
 
 --Non-Unique Index
 create index IDX_DEPT01_Loc
 ON DEPT01(LOC);
 
 --결합 Index: 2개이상의 컬럼으로 인덱스구성
 create index IDX_DEPT01_Com
 ON DEPT01(deptno, dname);
 
 select index_name, table_name, column_name
 from USER_IND_COLUMNS
 where table_name IN ('DEPT01'); 
 
 --함수 기반 Index: 수식이나 함수를 적용해서 Index를 만든것
 create Index IDX_EMP01
 on EMP01(sal*12);
 
 
 SET TIMING OFF
 