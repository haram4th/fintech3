-- MySQL DML 기초 100문제 (함수 없이, 초급용)
-- 스키마: korea_stock | 테이블: stock_prices_2025, stock_prices_2024, korea_stock_company
-- 사용 범위: SELECT, DISTINCT, WHERE, AND/OR, BETWEEN, IN, LIKE, ORDER BY, LIMIT,
--            INNER/LEFT JOIN(동등조인), INSERT, UPDATE, DELETE (기초)
-- 날짜 필터는 '2025-01-01' 같은 리터럴 범위 비교만 사용합니다.
-- 사본 테이블로 DML 연습할 때는 prices_2025_copy 가 준비되어 있다고 가정합니다.
-- (교사가 미리: CREATE TABLE prices_2025_copy AS SELECT * FROM stock_prices_2025;)
USE korea_stock;

-- 01. 2025년 테이블에서 임의 10행을 조회하세요.

SELECT * FROM stock_prices_2025 LIMIT 10;

-- 02. 컬럼 Date, 회사명, 종목코드, Close 만 20행 조회하세요.
SELECT `Date`,`회사명`,`종목코드`,`Close` FROM stock_prices_2025 LIMIT 20;

-- 03. 중복 없이 회사명 목록을 조회하세요.
SELECT DISTINCT `회사명` FROM stock_prices_2025;

-- 04. 종가(Close)가 50,000 이상인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` >= 50000;

-- 05. 종가가 50,000 미만인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` < 50000;

-- 06. 시가(Open)가 10,000 이상 20,000 이하인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Open` BETWEEN 10000 AND 20000;

-- 07. 회사명에 '전자'가 포함된 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` LIKE '%전자%';

-- 08. 회사명이 '삼성전자' 또는 'LG전자'인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` IN ('삼성전자','LG전자');

-- 09. 종목코드가 '005930'인 데이터만 날짜 오름차순으로 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `종목코드`='005930' ORDER BY `Date` ASC;

-- 10. 종가 내림차순으로 50행을 조회하세요.
SELECT * FROM stock_prices_2025 ORDER BY `Close` DESC LIMIT 50;

-- 11. 거래량 Volume 오름차순으로 30행을 조회하세요.
SELECT * FROM stock_prices_2025 ORDER BY Volume ASC LIMIT 30;

-- 12. 고가(High)가 저가(Low)보다 큰 행만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `High` > `Low`;

-- 13. 회사명이 NULL 이거나 종목코드가 NULL 인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` IS NULL OR `종목코드` IS NULL;

-- 14. 회사명이 NULL 이 아닌 행만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` IS NOT NULL;

-- 15. 2025-01-02 하루의 데이터를 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Date` >= '2025-01-02' AND `Date` < '2025-01-03';

-- 16. 2025-02-01부터 2025-02-28까지 데이터를 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Date` >= '2025-02-01' AND `Date` < '2025-03-01';

-- 17. 2025년 1분기(1~3월) 데이터를 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Date` >= '2025-01-01' AND `Date` < '2025-04-01';

-- 18. 회사명이 'SK'로 시작하는 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` LIKE 'SK%';

-- 19. 회사명이 '테스트'로 끝나는 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` LIKE '%테스트';

-- 20. 시작가가 0보다 큰 행만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Open` > 0;

-- 21. 시작가보다 종가가 큰(상승) 행만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` > `Open`;

-- 22. 시작가와 종가가 같은(보합) 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` = `Open`;

-- 23. 시작가보다 종가가 작은(하락) 행만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` < `Open`;

-- 24. 고가가 100,000 이상이거나 거래량이 1,000,000 이상인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `High` >= 100000 OR Volume >= 1000000;

-- 25. 저가가 5,000 미만이고 거래량이 10,000 초과인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Low` < 5000 AND Volume > 10000;

-- 26. 회사명이 '네이버'가 아닌 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` <> '네이버';

-- 27. 종목코드가 '002001'부터 '002025' 사이(문자열 비교)인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `종목코드` BETWEEN '002001' AND '002025';

-- 28. 회사명, 종목코드, Date, Close 컬럼을 회사명을 기준으로 가나다순 오름차순으로 100행 조회하세요.
SELECT `회사명`,`종목코드`,`Date`,`Close` FROM stock_prices_2025 ORDER BY `회사명` ASC LIMIT 100;

-- 29. 회사명을 기준으로 가나다순 내림차순으로 100행 조회하세요.
SELECT * FROM stock_prices_2025 ORDER BY `회사명` DESC LIMIT 100;

-- 30. 고가-저가 스프레드가 1000 이상인 행을 조회하세요. (연산 사용)
SELECT * FROM stock_prices_2025 WHERE (`High` - `Low`) >= 1000;

-- 31. 시작가가 30,000 초과이고 종가가 25,000 미만인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Open` > 30000 AND `Close` < 25000;

-- 32. 거래량이 100,000 이상 500,000 이하인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE Volume BETWEEN 100000 AND 500000;

-- 33. 종목코드가 ('005930','000660','035420') 중 하나인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `종목코드` IN ('005930','000660','035420');

-- 34. '전자' 또는 '화학'을 이름에 포함하는 회사의 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` LIKE '%전자%' OR `회사명` LIKE '%화학%';

-- 35. 회사명에 공백이 포함된 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `회사명` LIKE '% %';

-- 36. 2025-03-01 이후의 데이터만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Date` >= '2025-03-01';

-- 37. 2025-03-01 이전의 데이터만 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Date` < '2025-03-01';

-- 38. 종가 기준 내림차순, 같으면 거래량 내림차순으로 50행 조회하세요.
SELECT * FROM stock_prices_2025 ORDER BY `Close` DESC, Volume DESC LIMIT 50;

-- 39. 시작가 기준 오름차순, 같으면 회사명 오름차순으로 50행 조회하세요.
SELECT * FROM stock_prices_2025 ORDER BY `Open` ASC, `회사명` ASC LIMIT 50;

-- 40. 회사명과 종목코드만 조회하되 종목코드 오름차순으로 200행 조회하세요.
SELECT `회사명`,`종목코드` FROM stock_prices_2025 ORDER BY `종목코드` ASC LIMIT 200;

-- 41. 종가가 0인(또는 음수 포함) 비정상 데이터를 조회하세요.
SELECT * FROM stock_prices_2025 WHERE `Close` <= 0;

-- 42. 거래량이 10,000 미만이거나 NULL 인 행을 조회하세요.
SELECT * FROM stock_prices_2025 WHERE Volume < 10000 OR Volume IS NULL;

-- 43. (INNER) 2025 가격과 korea_stock_company를 종목코드로 내부조인하여 20행 조회하세요.
SELECT p.*, c.Market, c.Marcap
FROM stock_prices_2025 p
INNER JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
LIMIT 20;

-- 44. (LEFT) korea_stock_company의 모든 컬럼과 2025년 가격을 30행 조회하세요.
SELECT p.*, c.Market, c.Marcap
FROM stock_prices_2025 p
LEFT JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
LIMIT 30;

-- 45. (RIGHT) korea_stock_company를 기준으로 2025 가격을 조인하고 30행 조회하세요.
SELECT p.*, c.Market, c.Marcap
FROM stock_prices_2025 p
RIGHT JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
LIMIT 30;

-- 46. (INNER) 업종에 '반도체'가 포함된 기업의 2025 데이터를 조회하세요.
SELECT p.*, c.`업종`
FROM stock_prices_2025 p
INNER JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
WHERE c.`업종` LIKE '%반도체%';

-- 47. (LEFT) korea_stock_company 테이블과 2025년 주가 테이블을 조인하고 지역명에 "서울"이 들어간 데이터를 조회하세요. 
SELECT p.*, c.`지역`
FROM stock_prices_2025 p
RIGHT JOIN korea_stock_company c   -- 회사 기준으로 남기려면 RIGHT 또는 아래의 FROM 순서를 바꾼 LEFT 사용
  ON p.`종목코드` = c.`종목코드`
 AND c.`지역` LIKE '%서울%';

-- 48. (RIGHT) 대표자명에 '김'이 포함된 회사(가격 유무 무관)를 조회하세요.
SELECT p.`Date`, p.`종목코드`, p.`Close`, c.`회사명`, c.`대표자명`
FROM stock_prices_2025 p
RIGHT JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
 AND c.`대표자명` LIKE '%김%';

-- 49. (LEFT) korea_stock_company와 2025 데이터를 조인하고 상장일이 '2010-01-01' 이후인 회사를 찾으세요.
--    
SELECT p.`Date`, p.`종목코드`, p.`Close`, c.`회사명`, c.`상장일`
FROM stock_prices_2025 p
RIGHT JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
 AND c.`상장일` >= '2010-01-01';

-- 50. (INNER) 홈페이지가 공백이 아닌 기업의 2025 데이터를 조회하세요. (함수 없이)
SELECT *
FROM stock_prices_2025 p
INNER JOIN korea_stock_company c
  ON p.`종목코드` = c.`종목코드`
WHERE c.`홈페이지` IS NOT NULL AND c.`홈페이지` <> '';