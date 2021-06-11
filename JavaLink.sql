--1.계정 만들기(system)
Create User javalink IDENTIFIED BY javalink;
Grant CONNECT,Resource to javalink;

--2.계정 속성 만들기
create table member(
	id varchar2(12),
	password varchar2(12),
	name  varchar2(12),
	age number,
	addr varchar2(50),
	email varchar2(30)
);

insert into member values('aaa','aaa','홍길동',22,'서울시','a@a.com');
commit;
rollback;

select * from member;