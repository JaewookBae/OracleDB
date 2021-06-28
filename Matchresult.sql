CREATE TABLE Matchresult(
    ranking NUMBER(4),
    horse_number NUMBER(4),
    horse_name VARCHAR2(40),
    horse_origin VARCHAR2(10),
    horse_sex VARCHAR2(10),
    horse_age NUMBER(4),
    jockey_weight NUMBER(8),
    rating VARCHAR2(10), --??
    jockey_name VARCHAR2(20),
    assistant_name VARCHAR2(20),
    owner_name VARCHAR2(20),
    arrival_difference VARCHAR2(20),
    horse_weight NUMBER(8),
    dan_win NUMBER(20),
    yun_win NUMBER(20),
    equipment VARCHAR2(200),
    running_date DATE,
    race_number NUMBER(4)
);

SELECT * FROM Matchresult;
-- 데이터 총 개수
SELECT COUNT(*) FROM Matchresult;

-- 생산지 종류를 확인해보자
SELECT DISTINCT horse_origin FROM Matchresult;

-- 말 생산지 별 출전 횟수??
SELECT * FROM Matchresult;

SELECT horse_origin, COUNT(*) FROM Matchresult GROUP BY horse_origin;

-- 출생지 별 승률...
SELECT * FROM Matchresult;


-- 가장 많이 우승한 말(1,2등)
SELECT horse_name, COUNT(*) FROM Matchresult
WHERE ranking IN (1,2)
GROUP BY horse_name
ORDER BY COUNT(*) DESC
;

-- 가장 많이 출전한 말
SELECT horse_name, COUNT(*) FROM Matchresult
GROUP BY horse_name
ORDER BY COUNT(*) DESC
;

-- 가장 많이 출전한 선수(자키)
SELECT jockey_name, COUNT(*) FROM Matchresult
GROUP BY jockey_name
ORDER BY COUNT(*) DESC
;

-- 박태종의 년도별 출전 횟수
SELECT TO_CHAR(running_date,'YYYY'), COUNT(*) FROM Matchresult
WHERE jockey_name = '박태종'
GROUP BY TO_CHAR(running_date,'YYYY')
ORDER BY TO_CHAR(running_date,'YYYY') ASC
;

-- 박태종 선수가 전설인가?? 문세영 선수가 전설인가??
--출전횟수, 승률
SELECT t1.cnt, (
SELECT COUNT(*) as cnt FROM Matchresult
WHERE jockey_name LIKE '박태종'
AND ranking IN (1,2)
)/t1.cnt * 100 as tt FROM(
SELECT COUNT(*) as cnt FROM Matchresult
WHERE jockey_name LIKE '박태종'
) t1
;