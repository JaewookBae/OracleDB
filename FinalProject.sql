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