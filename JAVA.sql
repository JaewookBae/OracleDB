--Oracle: 대소문자 구분 X
-- 환경설정: utf-8
--글자크기: 

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