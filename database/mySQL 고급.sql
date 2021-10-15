
-- city 테이블 복사해서 city2 테이블 만들기
create table city2 as select * from city;

-- database 새로 만들기
create database suan;
use suan;
select * from test; -- gui이용해서 만든 테이블

create table test2 (
	id int not null primary key,
	col1 int null,
    col2 float null,
    col3 varchar(45) null
);

select * from test2;
desc test2;

alter table test2 add col4 int null; -- 컬럼추가
alter table test2 modify col4 varchar(20) null; -- 컬럼수정
alter table test2 drop col4; -- 컬럼삭제

show index from test; -- 테이블의 인덱스 확인

-- create index : 인덱스 생성
create index col1Idx on test (col1); -- test 테이블의 col1 컬럼에 대해서 col1Idx 이라는 인덱스를 생성함
create unique index col2Idx on test (col2); -- test 테이블의 col2 컬럼에 대해서 중복값을 허용하지 않는(unique) col2Idx 이라는 인덱스를 생성함

-- fulltext index : 일반적인 인덱스와 달리 매우 빠르게 테이블의 모든 텍스트 컬럼을 검색, 모든 문자열을 빠르게 탐색할 때 사용하는 용도의 인덱스
alter table test add fulltext col3Idx(col3);

-- 인덱스 삭제 : alter table or drop index
alter table test drop index col3Idx;
drop index col2Idx on test; -- drop문은 내부적으로 alter table문으로 자동변환되어 처리됨


-- view 생성
create view testView as 
select col1, col2
from test;

-- view 수정
alter view testView as
select col1, col2, col3
from test;

-- view 삭제
drop view testView;

-- view 확인
select * from testView;

-- join문을 사용해서 view만들기
use world;

create view allView as
select city.name, country.SurfaceArea, city.Population, countrylanguage.Language
from city 
join country on city.countrycode = country.code
join countrylanguage on city.CountryCode = countrylanguage.CountryCode
where city.CountryCode = 'kor';

select * from allView;

use suan;

-- insert : 컬럼명 생략 가능, 컬럼명 생략시 value 다음에 나오는 값들의 순서와 개수가 테이블에 정의된 컬럼의 순서 및 개수와 동일해야 함
insert into test value(1,123,1.1,'test');

-- MySQL workbench에서는 GUI로 입력가능, 입력 후 apply 하면 됨
select * from test;

-- test 테이블의 데이터를 죄다 test2 테이블에 붙여넣기(테이블간 컬럼명과 순서가 동일해야 가능)
insert into test2 select * from test; 
select * from test2;

-- update : 테이블의 데이터 값 수정
update test set col1 = 1, col2 = 1.0, col3='test' where id = 1;
-- where문 입력 안해주면 테이블의 데이터 전부 바뀜 주의
update test set col3 = 'TEST'; -- 기본적으로 설정에서 막혀있음. 풀기도 가능

-- delete : 테이블의 데이터 값 삭제 / 얘도 where 입력안하면 다 삭제가능
-- 데이터는 지워지지만 테이블 용량은 줄어들지 않음, rollback 가능하기 때문
delete from test where id = 1;
delete from test; -- 기본적으로 막혀있음

-- truncate : 테이블의 데이터 값 전체 삭제
-- 용량이 줄어들고 인덱스 등 모두 삭제, rollback 불가능
truncate table test;

-- drop table : 테이블 전체 삭제(공간, 객체 삭제), rollback 불가능
drop table test;

-- drop database : database 삭제(공간, 객체 삭제), rollback 불가능
drop database suan;


