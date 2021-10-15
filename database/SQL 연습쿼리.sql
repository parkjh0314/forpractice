show tables;

desc author;
desc topic;
desc profile;

select * from topic;
select * from author;
select * from profile;

/*
	** outer join **
	
	left outer join
	왼쪽 테이블에 해당하는 값만 보고싶을 때, 왼쪽테이블 전체 + 왼쪽 테이블과 연결 오른쪽 테이블의 데이터
	왼쪽의 테이블의 행의 조건과 일치하는 오른쪽 테이블의 행을 갖다 붙임
	왼쪽이 null이면 오른쪽도 다 null로 출력
 */

select * from topic t left outer join author a on t.author_id = a.aid;
-- left outer join의 결과로 null인 행이 나왔을 때 : 붙인 테이블(오른쪽)에는 left 테이블의 조건 컬럼의 값과 일치하는 값이 없다.


select * from topic t 
left outer join author a 
on t.author_id = a.aid
left outer join profile p 
on a.profile_id = p.pid;

select tid, t.title, author_id, name, p.title as job_title from topic t 
left outer join author a 
on t.author_id = a.aid
left outer join profile p 
on a.profile_id = p.pid;

select tid, t.title, author_id, name, p.title as job_title from topic t 
left outer join author a 
on t.author_id = a.aid
left outer join profile p 
on a.profile_id = p.pid
where name = 'egoing';

/*
 	** inner join **
 	
	inner join : 교집합 (그냥 join이라고 하면 inner join을 이야기 하는 것)
	join 중 성능이 더 좋다
	null == null -> false // null과 null은 같지 않음
 */ 
select * from topic t inner join author a on t.author_id = a.aid;
select * from topic t inner join author a on t.author_id = a.aid inner join profile p on a.profile_id = p.pid;
select tid, t.title, author_id, name, p.title as job_title from topic t inner join author a on t.author_id = a.aid inner join profile p on a.profile_id = p.pid where name = 'egoing';


/*
 	** full outer join **
 	
	full outer join : 합집합
	결과 : left outer join 값 + right outer join 값 - 중복되는 행
	많은 DataBase 시스템에서 지원하지 않고 있음
	그래도 사용가능 -> left outer join 값 union(중복제거) right outer join 값;
 */

-- 아래 둘의 결과값 동일
select * from topic full outer join author on topic.author_id = author.aid; -- full outer join은 MariaDB에서 지원하지 않음
-- left outer join, right outer join, union을 이용해 full outer join과 같은 결과값을 출력할 수 있음
(select * from topic left outer join author on topic.author_id = author.aid) union (select * from topic right outer join author on topic.author_id = author.aid);

/*
 	** exculsive join **
 	
	exclusive join : 둘 중 한가지 테이블에만 있는 데이터를 가져옴
	다른 JOIN들과는 다르게 별도의 EXCLUSIVE JOIN함수가 있는 것은 아니고 기존의 LEFT JOIN과 Where절의 조건을 함께 사용하여 만드는 JOIN
 */
select * from topic left join author on topic.author_id = author.aid where aid is null; -- 왼쪽 테이블에만 있는 행
select * from topic left join author on topic.author_id = author.aid where author_id is null; -- 왼쪽 테이블에만 있는 행

/*
	** cross join **

	Cartesian product (카테시안 곱)

	모든 경우의 수를 전부 표현
	결과값 = A테이블의 행 개수 * B테이블의 행 개수
	on절이 존재하지 않음
 */
select * from topic t cross join author a;

/*
	** union ** 
	- 합집합
	union : 중복제거
	union all : 중복포함 / 성능은 union보다 더 빠름 (중복제거 연산이 생략됐기 때문)
	
	** intersect **
	- 교집합
	
	** except **
	- 차집합
*/

-- 이름: madang_demo.sql
-- 설명 : IT CookBook, 오라클로 배우는 데이터베이스 개론과 실습 교재를 위한 샘플 쿼리입니다.
-- madang 스키마를 생성하고 MADANG 서점 실습테이블과 데이터를 입력한다.
-- 교재 샘플 소스에서 제공하는 것과 살짝 바뀌었습니다.
 
CREATE DATABASE IF NOT EXISTS madang;
 
USE madang;

 
DROP TABLE IF EXISTS Book,
                     Customer,
                     Orders ;
                     
 
CREATE TABLE Book (   
  bookid      int PRIMARY KEY,
  bookname    VARCHAR(40),
  publisher   VARCHAR(40),
  price       INT 
);

CREATE TABLE  Customer (
  custid      int PRIMARY KEY,  
  name        VARCHAR(40),
  address     VARCHAR(50),
  phone       VARCHAR(20)
);


CREATE TABLE Orders (
  orderid int  PRIMARY KEY, 
  custid  int ,
  bookid  int ,
  saleprice int ,
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

-- 주문(Orders) 테이블의 책값은 할인 판매를 가정함
INSERT INTO Orders VALUES (1, 1, 1, 6000, '2014-07-01'); 
INSERT INTO Orders VALUES (2, 1, 3, 21000, '2014-07-03');
INSERT INTO Orders VALUES (3, 2, 5, 8000,  '2014-07-03'); 
INSERT INTO Orders VALUES (4, 3, 6, 6000, '2014-07-04'); 
INSERT INTO Orders VALUES (5, 4, 7, 20000, '2014-07-05');
INSERT INTO Orders VALUES (6, 1, 2, 12000, '2014-07-07');
INSERT INTO Orders VALUES (7, 4, 8, 13000,  '2014-07-07');
INSERT INTO Orders VALUES (8, 3, 10, 12000, '2014-07-08'); 
INSERT INTO Orders VALUES (9, 2, 10, 7000,  '2014-07-09'); 
INSERT INTO Orders VALUES (10, 3, 8, 13000, '2014-07-10');
INSERT INTO Orders VALUES (11, 3, 8, 13000, '2014-07-10');

use madang;

select * from book;
select * from customer;
select * from orders;

select * from customer c 
left outer join orders o 
on c.custid = o.custid
left outer join book b 
on o.bookid = b.bookid;

select c.custid, name, bookname, publisher, price from customer c 
left outer join orders o 
on c.custid = o.custid
left outer join book b 
on o.bookid = b.bookid
order by c.custid;


/*
[쿼리문제]

[조건] custid를 직접 입력하지 않는다

*/
         

-- 1. 박지성의 총 구매액  

	select name as '고객명', sum(saleprice) as 구매금액
	from customer c
	left outer join orders o
	on c.custid = o.custid
	where name='박지성';

-- 12. 박지성이 구매한 도서의 수 
--  [조건]  중복된 도서 한번 만 출력

	select name as '고객명', count(distinct bookid) as '구매권수'
	from customer c
	left outer join orders o
	on c.custid = o.custid
	where name='박지성';

-- 3. 박지성이 구매한 도서의 출판사 총 수~ 
--  [조건] 출판사 중복은 제거 

	select name as '고객명', count(distinct publisher) as '구매 도서의 출판사 수'
	from customer c
	left outer join orders o
	on c.custid = o.custid
	left outer join book b
	on o.bookid = b.bookid
	where name = '박지성';


-- 4. 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이 

	select name as '고객명', bookname as '구매도서', price as '정가', saleprice as '판매가', price-saleprice as '할인된 금액'
	from customer c 
	left outer join orders o
	on c.custid = o.custid
	left outer join book b
	on o.bookid = b.bookid
	where name = '박지성'
	order by orderid;

-- 5. 박지성이 구매하지 않은 도서의 이름

	select bookname
	from book
	where bookid not in (select bookid from orders inner join customer on orders.custid = customer.custid where customer.name = '박지성') 
	order by bookid;

	select bookname 
	from book
	except 
	select bookname	from book, orders, customer
	where book.bookid = orders.bookid and orders.custid = customer.custid and name LIKE '박지성'; 

-- 6. 2014년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서의 주문번호

	select orderid
	from orders
	where orderdate between '2014-07-04' and '2014-07-07';


-- 7. 2014년 7월 4일 ~ 7월 7일 사이에 주문받은 도서를 제외한 도서의 주문번호
	
	select orderid as '주문번호', bookname as '도서명', orderdate as '주문일자'
	from book b
	left outer join orders o
	on b.bookid = o.bookid 
	left outer join customer c 
	on o.custid = c.custid
	where orderdate not between '2014-07-04' and '2014-07-07';

-- 8. 성이 '김'씨인 고객의 이름과 주소

	select name as '고객명', address as '주소'
	from customer
	where name like '김%';
  

-- 9. 성이 '김'씨이고 이름이 '아'로 끝나는 고객의 이름과 주소

	select name as '고객명', address as '주소'
	from customer
	where name like '김%아';
  

-- 10. 주문하지 않는 고객의 이름  

	select name as '고객명'
	from customer c 
	left outer join orders o
	on c.custid = o.custid
	where orderid is null

-- 11. 박지성 고객의 2014년도의 주문 총금액의 평균금액을 출력

	select name as '고객명', avg(saleprice) as '평균주문금액'  
	from customer c 
	left outer join orders o 
	on c.custid = o.custid 
	where year(orderdate) = 2014 and name = '박지성';

-- 12. 고객의 이름과 고객별 구매액 

    [조건] 구매내역이 없는사람은 0으로 출력 

            구매액이 높은순으로 정렬 

	select name as '고객명', ifnull(sum(saleprice),0) as '총구매액' 
	from customer c 
	left outer join orders o 
	on c.custid = o.custid
	group by c.custid, name
	order by 2 desc;


-- 13. 고객의 이름과 고객별 구매액 중 상위 2개의 데이터만 보입니다.

	select name as '고객명', ifnull(sum(saleprice),0) as '총구매액' 
	from customer c 
	left outer join orders o 
	on c.custid = o.custid
	group by name
	order by 2 desc limit 2;
     

-- 14. 2번 이상 구매를 한 이력이 있는 고객 명단을 구하세요. 

    [조건] 고객번호, 이름, 구매 횟수를 나열합니다. 

            구매 횟수가 많은 사람이 제일 위에 보이게 합니다. 

	select c.custid as '고객번호', name as '고객명', count(orderid) as '구매횟수' 
	from customer c 
	left outer join orders o 
	on c.custid = o.custid
	group by c.custid, name
	having count(orderid) >= 2
	order by 3 desc;
	
-- 15. 정가가 가장 비싼 책을 산 고객 이름 

	select name as '고객명', bookname as '도서명', price as '정가'
	from customer c 
	left outer join orders o 
	on c.custid = o.custid
	left outer join book b
	on o.bookid = b.bookid
	where price = (select max(price) from book);

-- 16.  도서의 가격(Book 테이블)과 판매가격(Orders 테이블)의 차이가 가장 많은 주문, 주문번호, 도서가격-판매가격을 검색

	select orderid as '주문번호', price-saleprice as '할인금액'
	from book b
	left outer join orders o 
	on b.bookid = o.bookid
	where price-saleprice = (select max(price-saleprice) from book left outer join orders on book.bookid = orders.bookid)



-- 17. 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
    
	select name as '고객명', avg(saleprice) as '구매액평균'
	from customer c
	left outer join orders o
	on c.custid = o.custid 
	group by c.custid, name
	having avg(saleprice) > (select avg(saleprice) from orders)
	order by avg(saleprice) desc;


-- 18. 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름

	select name as '고객명', publisher as '출판사'
	from customer c 
	left outer join orders o
	on c.custid = o.custid
	left outer join book b
	on o.bookid = b.bookid
	where publisher in(select publisher
						from customer c 
						left outer join orders o
						on c.custid = o.custid
						left outer join book b
						on o.bookid = b.bookid
						where name = '박지성'
						) 
					and name != '박지성';

-- 19. 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
	
	select name as '고객명'
	from customer c 
	left outer join orders o
	on c.custid = o.custid
	left outer join book b
	on o.bookid = b.bookid
	group by c.custid, name
	having 2 <= count(distinct publisher);


-- 20. 전체 고객의 30% 이상이 구매한 도서
	
	select bookname as '도서명', count(o.orderid) as '판매권수'
	from book b
	left outer join orders o
	on b.bookid = o.bookid
	left outer join customer c 
	on o.custid = c.custid
	group by b.bookid
	having count(o.orderid) >= (select count(*)*0.3 from customer)
	order by 2 desc;