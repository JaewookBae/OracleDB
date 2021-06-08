-- Oracle: 사용자계정 = DataBase

-- 사용자 계정 상황보기
select * from dba_users;

-- 계정 Lock 해제하고 사용하기
alter user SH account unlock;
alter user SH IDENTIFIED BY sh;

alter user PM account unlock;
alter user PM IDENTIFIED BY pm;

-- 계정 만들기
create User java identified by java;
Grant connect,Resource to java;
--계정삭제
drop user java cascade;