-- DDL 정의
-- member Table 스키마
DROP TABLE FP_Member;

CREATE TABLE FP_Member(
    member_no NUMBER,
    member_id VARCHAR2(20),
    member_pw VARCHAR2(160),
    member_nick VARCHAR2(20),
    member_gender VARCHAR2(4),
    member_birth DATE,
    member_phone VARCHAR2(20),
    member_email VARCHAR2(40),
    member_joindate DATE
);
DROP SEQUENCE FP_Member_seq;
CREATE SEQUENCE FP_Member_seq;

--test
SELECT * FROM FP_Member;
select * from FP_Board;
select * from FP_Hobby;
select * from FP_Hobby_category;
delete from FP_Member where member_no='25';

-- 회원 가입 코드
INSERT INTO FP_Member VALUES(
FP_Member_seq.nextval,
'jaewook',
'1111',
'Bae',
'M',
'940318',
'010-1234-1234',
'123@123.com',
SYSDATE);

--Board 테이블
DROP TABLE FP_Board;
CREATE TABLE FP_Board(
    board_no NUMBER,
    member_no NUMBER,
    board_title VARCHAR2(400),
    board_content VARCHAR2(4000),
    board_readcount NUMBER,
    board_writedate DATE
);

DROP SEQUENCE FP_Board_seq;
CREATE SEQUENCE FP_Board_seq;

--hobby 카테고리
DROP TABLE FP_Hobby_Category;
CREATE TABLE FP_Hobby_Category(
    hobby_category_no NUMBER,
    hobby_category_name VARCHAR2(20)
);
DROP SEQUENCE FP_Hobby_Category_seq;
CREATE SEQUENCE FP_Hobby_Category_seq;

INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'야구');
INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'축구');
INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'농구');
INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'당구');
INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'배구');

--취미 테이블
DROP TABLE FP_Hobby;
CREATE TABLE FP_Hobby(
    hobby_no NUMBER,
    member_no NUMBER,
    hobby_category_no NUMBER
);

DROP SEQUENCE FP_Hobby_seq;
CREATE SEQUENCE FP_Hobby_seq;
commit;

INSERT INTO FP_Hobby_Category VALUES(FP_Hobby_Category_seq.NEXTVAL,'테니스');
commit;

INSERT INTO FP_Hobby VALUES(FP_Hobby_seq.nextval, 2, 3);

select * from FP_Hobby_Category;
select * from FP_Hobby_Category order by hobby_no asc;
select FP_Member_seq.nextval from Dual;

--글 작성 쿼리
INSERT INTO FP_Board VALUES(
    FP_Board_seq.nextval,
    1,
    '테스트 제목입니다.',
    '테스트 내용입니다.',
    0,
    SYSDATE
);

SELECT * FROM FP_Board,FP_Member ORDER BY board_no DESC;
select * from FP_Board order by board_no desc;
delete from FP_Board where board_no = 34;

select * from FP_Board where board_no=5;
select * from FP_Member where member_no =4;

COMMIT;
rollback;

--삭제 쿼리
delete from FP_Board where board_no = 2;
delete from FP_Member where member_id = 'bbbb';
--내용 수정
update FP_Board set board_title = '바뀐 제목~' , board_content = '바뀐 내용~'
where board_no = 5;
--조회수 증가
update FP_Board set board_readcount = board_readcount + 1
where board_no = 5;

------------------트랜젝션
select * from FP_Board;


--이미지 테이블
drop table FP_BoardImage;
create table FP_BoardImage(
    image_no number,
    board_no number,
    image_url varchar2(300),
    image_ori varchar2(300)
);

drop sequence FP_BoardImage_seq;
create sequence FP_BoardImage_seq;

--test
insert into FP_BoardImage values(
    FP_BoardImage_seq.nextval,
    1,
    '2021/07/16/aaaaaa.jpg',
    'qqqq.jpg'
);    

select * from FP_BoardImage
where board_no = 1
order by image_no asc
;

select FP_Board_seq.nextval from dual;

select * from FP_BoardImage
order by image_no asc
;

<<<<<<< HEAD
--메일 인증 테이블
DROP TABLE FP_MailAuth;
CREATE TABLE FP_MailAuth(
    mailauth_no NUMBER,
    member_no NUMBER,
    mailauth_key VARCHAR2(100),
    mailauth_complete VARCHAR2(4),
    mailauth_date DATE
);

DROP SEQUENCE FP_MailAuth_seq;
CREATE SEQUENCE FP_MailAuth_seq;
select * from FP_MailAuth;

--회원 가입시
insert into FP_MailAuth values(
    FP_MailAuth_seq.nextval,
    3,
    'asdasd-asdasdf-asdfsadfas',
    'N'
    null
);

--인증시
update FP_MailAuth 
set mailauth_complete = 'Y', mailauth_date = sysdate
where mailauth_key = 'asdasd-asdasdf-asdfsadfas';

--로그인 쿼리
select * from FP_Member , FP_MailAuth
where fp_mailauth.member_no = fp_member.member_no
and member_id = 'b001'
and member_pw = '1111asdasdasfsdf'
and FP_MailAuth.mailauth_complete = 'Y'
;
=======
>>>>>>> c847b88860866debc21510e6b5a39b3d4bbbcb8d



