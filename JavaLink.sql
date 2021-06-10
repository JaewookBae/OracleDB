create table member(ID varchar2(15), PASSWORD varchar2(10), NAME varchar2(10), AGE number,
Local varchar2(10), EMAIL varchar2(30), primary key(id));
drop table member;
insert into member values('aaa','aaa','홍길동',22,'서울시','a@a.com');
commit;