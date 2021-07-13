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














