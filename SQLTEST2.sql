--===========난이도 조절용(기본 문제)===========

--질의 3-1 모든 도서의 이름과 가격을 검색하시오
select bookname, price from book;
--질의 3-2 모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
select * from book;
--질의 3-3 도서 테이블에 있는 모든 출판사를 검색하시오.
select publisher from book;
--질의 3-4 가격이 20,000원 미만인 도서를 검색하시오.
select *from book where price < 20000;
--질의 3-5 가격이 10,000원 이상 20,000 이하인 도서를 검색하시오.
select * from book where price >= 10000 and price <=20000;
--질의 3-6 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
select * from book where publisher = '굿스포츠' or publisher='대한미디어';
--※ 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’가 아닌 도서를 검색하시오.
select * from book where not publisher = '굿스포츠' or publisher='대한미디어';
--질의 3-7 ‘축구의 역사’를 출간한 출판사를 검색하시오.
select publisher from book where bookname='축구의 역사';
--질의 3-8 도서이름에 ‘축구’가 포함된 출판사를 검색하시오.
select publisher from book where bookname like '%축구%';
--질의 3-9 도서이름의 왼쪽 두 번째 위치에 ‘구’라는 문자열을 갖는 도서를 검색하시오.
select * from book where bookname like '_구%';
--질의 3-10 축구에 관한 도서 중 가격이 20,000원 이상인 도서를 검색하시오.
select * from book where bookname like '%축구%' and price >= 20000;
--질의 3-11 출판사가 ‘굿스포츠’ 혹은 ‘대한미디어’인 도서를 검색하시오.
select * from book where publisher = '굿스포츠' or publisher='대한미디어';
--질의 3-12 도서를 이름순으로 검색하시오.
select * from book order by bookname asc;
--질의 3-13 도서를 가격순으로 검색하고, 가격이 같으면 이름순으로 검색하시오.
select * from book order by price asc, bookname asc;
--질의 3-15 고객이 주문한 도서의 총 판매액을 구하시오.
select sum(saleprice) from orders;
--질의 3-16 2번 김연아 고객이 주문한 도서의 총 판매액을 구하시오.

--질의 3-17 고객이 주문한 도서의 총 판매액, 평균값, 최저가, 최고가를 구하시오.

--질의 3-18 마당서점의 도서 판매 건수를 구하시오.

--질의 3-19 고객별로 주문한 도서의 총 수량과 총 판매액을 구하시오.

--질의 3-20 가격이 8,000원 이상인 도서를 구매한 고객에 대하여 고객별 주문 도서의 총 수량을 구하시오. 단, 두 권 이상 구매한 고객만 구한다.
