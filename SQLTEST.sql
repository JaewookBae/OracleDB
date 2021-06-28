DROP table orders;
DROP table book;
DROP table customer;


CREATE TABLE Book (
  bookid      NUMBER(2) PRIMARY KEY,
  bookname    VARCHAR2(40),
  publisher   VARCHAR2(40),
  price       NUMBER(8) 
);

CREATE TABLE  Customer (
  custid      NUMBER(2) PRIMARY KEY,  
  name        VARCHAR2(40),
  address     VARCHAR2(50),
  phone       VARCHAR2(20)
);


CREATE TABLE Orders (
  orderid NUMBER(2) PRIMARY KEY,
  custid  NUMBER(2) REFERENCES Customer(custid),
  bookid  NUMBER(2) REFERENCES Book(bookid),
  saleprice NUMBER(8) ,
  orderdate DATE
);




-- Book, Customer, Orders 데이터 생성
INSERT INTO Book VALUES(1, '축구의 역사', '굿스포츠', 7000);
INSERT INTO Book VALUES(2, '축구아는 여자', '나무수', 13000);
INSERT INTO Book VALUES(3, '축구의 이해', '대한미디어', 22000);
INSERT INTO Book VALUES(4, '골프 바이블', '대한미디어', 35000);
INSERT INTO Book VALUES(5, '피겨 교본', '굿스포츠', 8000);
INSERT INTO Book VALUES(6, '역도 단계별기술', '굿스포츠', 6000);
INSERT INTO Book VALUES(7, '야구의 추억', '이상미디어', 20000);
INSERT INTO Book VALUES(8, '야구를 부탁해', '이상미디어', 13000);
INSERT INTO Book VALUES(9, '올림픽 이야기', '삼성당', 7500);
INSERT INTO Book VALUES(10, 'Olympic Champions', 'Pearson', 13000);

INSERT INTO Customer VALUES (1, '박지성', '영국 맨체스타', '000-5000-0001');
INSERT INTO Customer VALUES (2, '김연아', '대한민국 서울', '000-6000-0001');  
INSERT INTO Customer VALUES (3, '장미란', '대한민국 강원도', '000-7000-0001');
INSERT INTO Customer VALUES (4, '추신수', '미국 클리블랜드', '000-8000-0001');
INSERT INTO Customer VALUES (5, '박세리', '대한민국 대전',  NULL);

INSERT INTO Orders VALUES (1, 1, 1, 6000, TO_DATE('2014-07-01','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, TO_DATE('2014-07-03','yyyy-mm-dd'));
INSERT INTO Orders VALUES (3, 2, 5, 8000, TO_DATE('2014-07-03','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, TO_DATE('2014-07-04','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, TO_DATE('2014-07-05','yyyy-mm-dd'));
INSERT INTO Orders VALUES (6, 1, 2, 12000, TO_DATE('2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (7, 4, 8, 13000, TO_DATE( '2014-07-07','yyyy-mm-dd'));
INSERT INTO Orders VALUES (8, 3, 10, 12000, TO_DATE('2014-07-08','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (9, 2, 10, 7000, TO_DATE('2014-07-09','yyyy-mm-dd')); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, TO_DATE('2014-07-10','yyyy-mm-dd'));

select * from Customer;
select * from Book;
select * from Orders;


--일반 1. 마당서점의 고객이 요구하는 다음 질문에 대해 SQL문을 작성하시오.
--1-1 도서번호가 1인 도서의 이름
SELECT bookname FROM Book WHERE bookid=1; --최대한 이렇게 문법작성할것!!!

--1-2 가격이 20,000원 이상인 도서의 이름
select bookname from book where price >=20000;

--1-3 박지성의 총 구매액(박지성의 고객번호는 1번으로 놓고 작성)
select sum(saleprice) "총 구매액" from orders where custid=1;
                   
--1-4 박지성이 구매한 도서의 수(박지성의 고객번호는 1번으로 놓고 작성)
select count(bookid) from orders where custid=1;
                -- as cnt..등등
---------------------------------------------------------------------------------
--일반 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오.
--2-1 마당서점 도서의 총 개수
select count(bookid) from book;

--2-2 마당서점에 도서를 출고하는 출판사의 총 개수
select count(publisher) from book;

--2-3 모든 고객의 이름, 주소
select name, address from customer;

--2-4 2014.7.4~2014.7.7 사이에 주문받은 도서의 주문번호
--select orderid from orders where orderdate between '14-07-04' and '14-07-07';
select orderid 
from Orders 
where orderdate >= to_date('14-07-04', 'YY-MM-DD') 
and orderdate <= to_date('14-07-07', 'YY-MM-DD'); -- 이방식 선호

--2-5 2014.7.4~2014.7.7 사이에 주문받은 도서를 제외한 도서의 주문번호
--select orderid from orders where orderdate not between '14-07-04' and '14-07-07';
select orderid 
from Orders 
where orderdate < to_date('14-07-04', 'YY-MM-DD') 
or orderdate > to_date('14-07-07', 'YY-MM-DD');
--2-6 성이 '김'씨인 고객의 이름과 주소
select name,address from customer where name like'김%';

--2-7 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소
select name,address from customer where name like '김%' and name like '%아';
---------------------------------------------------------------------------------
--심화 1.마당서점의 고객이 요구하는 다음 질문에 대해 SQL문을 작성하시오.
-- 조인 : 내부조인(98%), 외부 조인(1.5%)
--1-5 박지성이 구매한 도서의 출판사 수
--select * from orders, customer; = 테이블 한 줄에 테이블 전체가 붙어서 5*10 50개행 선택됨
select count(distinct b.publisher) from orders o, customer c, book b where o.custid = c.custid
and o.bookid = b.bookid
and c.name like '박지성'
;

select count(publisher) from book a inner join orders b 
on a.bookid = b.bookid and custid=1;

select count(publisher) from book a, orders b 
WHERE a.bookid = b.bookid and custid=1;
--1-6 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select book.bookname, book.price - orders.saleprice 
from orders, customer, book
where orders.custid = customer.custid
and orders.bookid = book.bookid
and customer.name = '박지성'
;

select bookname, price, b.price - o.saleprice "정가와 판매가격차이"
from book b inner join orders o on b.bookid=o.bookid and custid=1;

--1-7 박지성이 구매하지 않은 도서의 이름
select bookname from book
minus
select b.bookname from orders o, book b, customer c
where o.custid = c.custid
and o.bookid = b.bookid
and c.name = '박지성'
;

SELECT bookname FROM book 
WHERE bookname NOT IN ( 
SELECT bookname FROM book b,customer c,orders o 
WHERE o.bookid=b.bookid AND o.custid= c.custid 
AND c.name='박지성'
);
---------------------------------------------------------------------------------
--심화 2. 마당서점의 운영자와 경영자가 요구하는 다음 질문에 대해 SQL문을 작성하시오.
--2-8 주문하지 않은 고객의 이름(부속질의 사용-꼭 부속질의 사용 안해도됨), 동명이인 제외
SELECT name FROM Customer
WHERE custid NOT IN(
    SELECT custid FROM Orders
    )
    ;
    
--2-9 주문 금액의 총액과 주문의 평균 금액
SELECT SUM(saleprice) "주문금액 총액", AVG(saleprice) "주문금액 평균" FROM Orders;

--2-10 고객의 이름과 고객별 구매액
SELECT cs.name,t1.sss FROM (
SELECT custid, SUM(saleprice) as sss FROM Orders
GROUP BY custid
) t1, Customer cs
WHERE t1.custid = cs.custid
;
--2. 상관 부속질의로 해결하는 법
SELECT (
    SELECT cc.name FROM Customer cc WHERE cc.custid = od.custid
) as nm, SUM(saleprice) as sss FROM Orders od
GROUP BY custid;
-- 상관 부속질의 이해
SELECT (
    SELECT cs.name FROM Customer cs WHERE cs.custid = od.custid
) FROM Orders od
;

--GROUP BY - 통계...집계...~별...
SELECT custid, SUM(saleprice), COUNT(*), AVG(saleprice) 
FROM Orders
GROUP BY custid
HAVING custid < 3
;

-- 서브 쿼리
--SELECT(___) FROM(___) WHERE(___) = (___);
SELECT t1.* FROM(
SELECT orders.orderid as a, 
book.bookname as b, 
book.price - orders.saleprice as c
FROM Orders, Book
WHERE Orders.bookid = Book.bookid
) t1
WHERE t1.c = 1000
;

--2-11 고객의 이름과 고객이 구매한 도서 목록
SELECT c. name, b.bookname FROM Orders o, Book b, Customer c
WHERE o.custid = c.custid AND o.bookid = b.bookid;

--2-12 도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문
SELECT o1.* FROM Orders o1, Book b1
WHERE o1.bookid = b1.bookid
AND b1.price - o1.saleprice = (
SELECT MAX(bb.price - oo.saleprice) FROM Orders oo, Book bb
WHERE oo.bookid = bb.bookid
)
;
-- 도서가격과 판매가격의 차이가 가장 큰 값
SELECT MAX(bb.price - oo.saleprice) FROM Orders oo, Book bb
WHERE oo.bookid = bb.bookid;

--2-13 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
SELECT o1.custid, AVG(o1.saleprice) FROM Orders o1
GROUP BY o1.custid
HAVING AVG(o1.saleprice) > (
SELECT AVG(saleprice) FROM Orders
)
;
--도서의 판매액 평균
SELECT AVG(saleprice) FROM Orders;

-- 심화+ 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
-- 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름
SELECT DISTINCT c1.name FROM Orders o1, Book b1, Customer c1
WHERE o1.custid = c1.custid AND o1.bookid = b1.bookid
AND b1.publisher IN (
SELECT b.publisher FROM Orders o, Book b, Customer c
WHERE o.custid = c.custid AND o.bookid = b.bookid
AND c.name LIKE '박지성'
)
;
-- 박지성이 구매한 도서의 출판사
SELECT b.publisher FROM Orders o, Book b, Customer c
WHERE o.custid = c.custid AND o.bookid = b.bookid
AND c.name LIKE '박지성'
;

-- 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
SELECT * FROM(
SELECT o.custid FROM Orders o, Book b
WHERE o.bookid = b.bookid
GROUP BY o.custid
HAVING COUNT(DISTINCT b.publisher) >=2
) t1, Customer cs
WHERE t1.custid = cs.custid
;
-- 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객번호
SELECT o.custid FROM Orders o, Book b
WHERE o.bookid = b.bookid
GROUP BY o.custid
HAVING COUNT(DISTINCT b.publisher) >=2
;

-- (생략) 전체 고객의 30% 이상이 구매한 도서
SELECT COUNT(*) * 0.3 as ccc FROM Customer;

SELECT b1.bookname FROM(
-- 도서 별 구매 횟수
SELECT o1.bookid, COUNT(*) as "구매횟수" FROM Orders o1
GROUP BY o1.bookid
) t1, Book b1
WHERE t1.bookid = b1.bookid 
AND t1."구매횟수" > (SELECT COUNT(*) * 0.3 as ccc FROM Customer
)
;


--3개 조인 구문...
SELECT * FROM Orders o, Book b, Customer c
WHERE o.custid = c.custid AND o.bookid = b.bookid;