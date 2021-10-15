show databases;
use world;
show tables;
show table status;
describe city;
desc country;
desc countrylanguage;
select * from city;
select * from city where population >= 8000000;
select * from city where population < 8000000 and Population > 7000000;
desc city;
select * from city where countrycode = 'kor';
select * from city where population between 7000000 and 8000000; -- 순서 뒤집으면 안돼욤;;
-- between 작은수 and 큰수;
-- in(조건1,조건2,조건3) = 조건1 or 조건2 or 조건3

-- like 연산: 문자열의 내용 검사하기
-- % : 아무글자(길이노상관)
-- _ : 한 글자
select * from city where CountryCode like 'K_';
select * from city where CountryCode like 'K__';
select * from city where CountryCode like 'K%';
-- k__와 k%의 결과는 같다.


-- MySQL에서는 적용 안되는 애들
select * from city where name like '[a,b,c]%'; -- 첫글자가 a 또는 b 또는 c인 애들
select * from city where name like '[a-f]%'; -- 첫글자가 a부터 f까지의 사이의 글자인 애들
select * from city where name like '[!acf]%'; -- 첫글자가 a 또는 c 또는 f가 아닌 애들


-- 서브쿼리
select * from city where CountryCode = (select CountryCode from city where name = 'seoul');
-- 서브쿼리로 두시 이름이 seoul인 나라의 coiuntrycode 를 찾아서 메인쿼리의 where 조건절의 조건으로 줌
-- 메인쿼리의 where 조건절의 조건과 서브쿼리의 결과 값이 연관된 값이어야함

-- any 여러조건 : 여러개의 조건 중 1개만 만족해도 ok
-- any 와 some은 같은 용도로 사용 가능
-- all 여러조건 : 모든 조건을 만족해야 함
select * from city where Population > any (select Population from city where district = 'New York');
select Population from city where district = 'New York';
select * from city where Population > some (select Population from city where district = 'New York');
select * from city where Population > all (select Population from city where district = 'New York');

select * from city order by CountryCode, Population desc;
select * from city where CountryCode = 'kor' order by Population desc;
select * from country order by SurfaceArea desc;

-- distinct : 중복제외
select distinct countrycode from city;

-- limit : 출력개수를 제한
-- limit N : 상위의 N개만 출력
-- MySQL GUI는 기본적으로 limit to 1000 rows를 걸고있음
select * from city order by Population desc limit 10;

-- group by : 행을 조건으로 묶어서 집계함수를 이용하여 결과 출력
select CountryCode, max(population) as 'MaxPopulation' from city group by CountryCode;
-- 도시개수
select count(*) from city;

-- having : 집계함수의 조건절
select CountryCode, max(population) as 'MaxPopulation' from city group by CountryCode having max(Population) > 8000000;

-- rollup : 총합 또는 중간합계가 필요할 경우 사용
-- group by 절과 함께 with rollup문 사용
select CountryCode, name, sum(Population)
from city 
group by CountryCode, name with rollup; 
/* CountryCode로 그룹을 짓고 도시별로 populatin과 countryCode로 묶은 그룹에 속한 도시들의 population 합계를 보여주고
  마지막에는 모든 행의 population의 총계를 보여줌 */

-- join : 데이터베이스 내의 여러 테이블에서 가져온 레코드를 조합하여 하나의 테이블이나 결과 집합으로 표현
select * from city join country on city.CountryCode = country.code;

select * from city 
join country on city.CountryCode = country.code
join countrylanguage on city.CountryCode = countrylanguage.CountryCode;


/* MySQL 내장함수 */
-- length() : 문자열 길이 반환
select length('ㅁㄴㅇㄹㅂㅈㄷㄱ'); -- 24 -> 한글은 한글자에 3
select length('마나아라바자다가');
select length('12345678'); -- 8
select length('asdfqwer'); -- 8

-- concat() : 문자열을 모두 결합하여 하나의 문자열로 반환, 받은 문자열 중 하나라도 NULL이 존재하면 NULL을 반환
select concat('My','sql Op','en Source');
select concat('My',' sql Op', null);

-- locate() : 문자열 내에서 찾는 문자열이 처음으로 나타나는 인덱스를 찾아서 반환
-- 찾는 문자열이 문자열 내에 존재하지 않으면 0을 반환
-- MySQL에서는 문자열의 시작 인덱스를 1부터 계산함
select locate('abc', 'abababababABCbababababcabab'); -- 대소문자 구분x

-- left() : 문자열의 왼쪽부터 지정한 개수만큼의 문자를 반환
select left('MySQL is an open source relational database management system', 5);

-- right() : 문자열의 오른쪽부터 지정한 개수만큼의 문자를 반환
select right('MySQL is an open source relational database management system', 6);

-- lower() : 문자열의 문자를 모두 소문자로 변경
select lower('MySQL is an open source relational database management system');

-- upper() : 문자열의 문자를 모두 대문자로 변경
select upper('MySQL is an open source relational database management system');

-- replace() : 문자열에서 특정 문자열을 대체 문자열로 교체
select replace('MSSQL', 'MS', 'My');

/*
	trim() : 문자열의 앞이나 뒤 또는 양쪽 모두에 있는 특정 문자 제거, 앞뒤만 제거, 가운데 낑겨있는건 제거안함
	trim() 함수에서 사용할 수 있는 지정자
	both: 문자열 양쪽의 특정문자 제거(지정자 생략시 both가 기본설정임)
	leading : 문자열 앞의 특정문자 제거
	trailing: 문자열 뒤의 특정문자 제거
	제거할 문자를 명시하지 않을 시 기본 설정은 공백제거임
*/
select trim('                 MySQL            '), trim('#' from '###My#Sql###'),
trim(leading '#' from '###MySQL###'), trim(trailing '#' from '###MySQL###');

/* 
	format() : 숫자타입의 데이터를 세자리마다 쉼표를 사용하는 '#,###,###.##'형식으로 변환
	반환되는 데이터의 형식은 '문자열'타입
	두번째 인수는 반올림할 소수 부분의 자릿수
*/
select format(1234569789123456798.12324987354,3);

/*
	floor() : 내림
    ceil() : 올림
    round() : 반올림
*/
select floor(10.95), ceil(10.95), round(10.95), round(10.45);

/*
	sqrt() : 양의제곱근
    pow() : 거듭제곱 / 첫번째 인수: 밑수, 두번째 인수: 지수
    exp() : 인수로 지수를 전달받아 e의 거듭제곱 계산
    log() : 자연로그 값을 계산
*/
select sqrt(4), pow(2,3), exp(3), log(3);

/*
	sin() : 사인값 반환
    cos() : 코사인값 반환
    tan() : 탄젠트값 반환
    pi() : 파이값
*/
select sin(pi()/2), cos(pi()), tan(pi()/4);

/*
	abs(X) : 절대값을 반환
    rand() : 0.0보다 크거나 같고 1.0보다 작은 하나의 실수를 무작위로 생성
*/
select abs(-3), rand(), round(rand()*100,0);

/*
	now() : 현재 날짜와 시간 반환, 형식 - 'YYYY-MM-DD HH:MM:SS' or 'YYYYMMDDHHMMSS'
    curdate() : 현재 날짜 반환, 형식 - 'YYYY-MM-DD' or 'YYYYMMDD'
    curtime() : 현재 시각 반환, 형식 - 'HH:MM:SS' or 'HHMMSS'
*/
select now(), current_timestamp(), curdate(), current_date(), curtime(), current_time();

/*
	date() : 전달받은 값에 해당하는 날짜 정보 반환
    month() : 월에 해당하는 값을 반환, 값의 범위 : 1 ~ 12
    day() : 일에 해당하는 값을 반환, 값의 범위 : 0 ~ 31
    hour() : 시간에 해당하는 값을 반환, 값의 범위 : 0 ~ 23
    minute() : 분에 해당하는 값을 반환, 값의 범위 : 0 ~ 59
    second() : 초에 해당하는 값을 반환, 값의 범위 : 0 ~ 59
*/
select now(), date(now()), month(now()), day(now()), hour(now()), minute(now()), second(now());

-- monthname() : 월에 해당하는 이름 반환
-- dayname() : 요일에 해당하는 이름 반환
select now(), monthname(now()), dayname(now());

/*
	dayofweek() : 해당일자가 해당 주에서 몇번째 날인지를 반환, 값의 범위: 1 ~ 7, 1=일요일/7=토요일
	dayofmonth() : 해당일자가 해당 월에서 몇번째 날인지를 반환, 값의 범위 : 1 ~ 31
    dayofyear() : 해당일자가 해당 연도에서 몇번째 날인지를 반환, 값의 범위 : 1 ~ 366
*/
select now(), dayofweek(now()), dayofmonth(now()), dayofyear(now());

-- date_format() : 전달받은 형식에 맞춰 날짜와 시간 정보를 문자열로 반환
select date_format(now(), '%D %y %a %d %m %n %j');
select date_format(now(), '%Y년 %m월 %W %p %l시 %i분 %s초') as '날짜' ;
-- https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html#function_date-format.html 참고


