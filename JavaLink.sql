

--1.���� �����(system)
Create User javalink IDENTIFIED BY javalink;
Grant CONNECT,Resource to javalink;

--2.���� �Ӽ� �����
create table member(
	id varchar2(12),
	password varchar2(12),
	name  varchar2(12),
	age number,
	addr varchar2(50),
	email varchar2(30)
);

insert into member values('aaa','aaa','ȫ�浿',22,'�����','a@a.com');
commit;
rollback;

select * from member;

------------------------------------
--study19
CREATE TABLE mms_member(
	id NUMBER PRIMARY KEY,
	name VARCHAR2(12) UNIQUE NOT NULL,
	addr VARCHAR2(50) NOT NULL,
	nation VARCHAR2(12) NOT NULL,
	email VARCHAR2(30) NOT NULL,
	age NUMBER NULL
);
CREATE SEQUENCE mms_member_id_seq;








