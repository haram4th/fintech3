-- 데이터베이스 생성 및 선택
CREATE DATABASE IF NOT EXISTS fx_min;
USE fx_min;

-- 실습 반복 대비 드롭
DROP TABLE IF EXISTS fx_holdings, currencies, users;

-- 사용자
CREATE TABLE users (
  user_id     BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  email       VARCHAR(255) NOT NULL UNIQUE,
  full_name   VARCHAR(100) NOT NULL,
  status      ENUM('active','inactive') NOT NULL DEFAULT 'active',
  created_at  DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 통화 마스터
CREATE TABLE currencies (
  currency_code CHAR(3) PRIMARY KEY,
  currency_name VARCHAR(50) NOT NULL,
  minor_unit    TINYINT UNSIGNED NOT NULL
);

-- 사용자별 보유 외환
CREATE TABLE fx_holdings (
  holding_id     BIGINT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
  user_id        BIGINT UNSIGNED NOT NULL,
  currency_code  CHAR(3) NOT NULL,
  balance        DECIMAL(24,8) NOT NULL DEFAULT 0,
  updated_at     DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
                    ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT uq_user_currency UNIQUE (user_id, currency_code),
  CONSTRAINT fk_h_user FOREIGN KEY (user_id)
      REFERENCES users(user_id) ON DELETE CASCADE,
  CONSTRAINT fk_h_ccy  FOREIGN KEY (currency_code)
      REFERENCES currencies(currency_code)
);

-- 데이터 입력
-- 통화 6종
INSERT INTO currencies(currency_code, currency_name, minor_unit) VALUES
('KRW','Korean Won',0),
('USD','US Dollar',2),
('JPY','Japanese Yen',0),
('EUR','Euro',2),
('GBP','Pound Sterling',2),
('AUD','Australian Dollar',2);

-- 사용자 8명
INSERT INTO users(email, full_name, status) VALUES
('alice@example.com','Alice Kim','active'),
('bob@example.com','Bob Lee','active'),
('carol@example.com','Carol Park','active'),
('dave@example.com','Dave Choi','active'),
('erin@example.com','Erin Jung','inactive'),
('frank@example.com','Frank Yoo','active'),
('grace@example.com','Grace Han','active'),
('heidi@example.com','Heidi Lim','active');

-- fx_holdings 20행
-- 1) Alice(1): KRW, USD, EUR
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(1,'KRW', 1200000.00000000),
(1,'USD',     950.25000000),
(1,'EUR',     210.00000000);

-- 2) Bob(2): KRW, JPY
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(2,'KRW',  560000.00000000),
(2,'JPY',   75000.00000000);

-- 3) Carol(3): USD, GBP
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(3,'USD',    1250.75000000),
(3,'GBP',      80.00000000);

-- 4) Dave(4): KRW, USD, JPY
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(4,'KRW',  330000.00000000),
(4,'USD',     420.00000000),
(4,'JPY',   12000.00000000);

-- 5) Erin(5): EUR, AUD
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(5,'EUR',     500.00000000),
(5,'AUD',     600.00000000);

-- 6) Frank(6): KRW, USD, EUR
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(6,'KRW',  980000.00000000),
(6,'USD',     110.00000000),
(6,'EUR',      45.50000000);

-- 7) Grace(7): JPY, GBP
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(7,'JPY',  150000.00000000),
(7,'GBP',      30.00000000);

-- 8) Heidi(8): KRW, AUD
INSERT INTO fx_holdings(user_id, currency_code, balance) VALUES
(8,'KRW',  250000.00000000),
(8,'AUD',     120.00000000);
-- == 총 20행 ==


-- 문제 해답
-- 1. fx_holdings 테이블과 users 테이블에서 전체 사용자 보유 외환을 조회하세요.
SELECT u.user_id, u.full_name, h.currency_code, h.balance
FROM fx_holdings h
JOIN users u ON u.user_id = h.user_id
ORDER BY u.user_id, h.currency_code;


-- 2. users, fx_holdings 테이블에서 이메일이 alice@example.com인 사용자의 보유 외환을 조회하세요.
SELECT h.currency_code, h.balance
FROM users u
JOIN fx_holdings h ON h.user_id = u.user_id
WHERE u.email = 'alice@example.com'
ORDER BY h.currency_code;


-- 3. fx_holdings 테이블에서 통화별 총 보유 잔액을 조회하세요.
SELECT h.currency_code, SUM(h.balance) AS total_balance
FROM fx_holdings h
GROUP BY h.currency_code
ORDER BY h.currency_code;

-- 4. users, fx_holdings 테이블에서 사용자별 보유 요약(보유 통화 개수와 잔액 합계)을 조회하세요.
SELECT u.user_id, u.full_name,
       COUNT(h.currency_code) AS currency_cnt,
       SUM(h.balance)         AS sum_raw
FROM users u
LEFT JOIN fx_holdings h ON h.user_id = u.user_id
GROUP BY u.user_id, u.full_name
ORDER BY u.user_id;

-- 5. fx_holdings, users 테이블에서 원화(KRW) 보유 상위 5명의 이름과 잔액을 조회하세요.
SELECT u.full_name, h.balance
FROM fx_holdings h
JOIN users u ON u.user_id = h.user_id
WHERE h.currency_code = 'KRW'
ORDER BY h.balance DESC
LIMIT 5;

-- 6. fx_holdings, users 테이블에서 달러(USD)를 보유한 사용자와 해당 잔액을 조회하세요.
SELECT u.full_name, h.balance
FROM fx_holdings h
JOIN users u ON u.user_id = h.user_id
WHERE h.currency_code = 'USD'
ORDER BY h.balance DESC;


-- 7. users, fx_holdings 테이블에서 보유 통화가 2개 이상인 사용자의 ID, 이름, 보유 통화 개수를 조회하세요.
SELECT u.user_id, u.full_name, COUNT(*) AS currency_cnt
FROM fx_holdings h
JOIN users u ON u.user_id = h.user_id
GROUP BY u.user_id, u.full_name
HAVING COUNT(*) >= 2
ORDER BY currency_cnt DESC, u.full_name ASC;

-- 8. users, fx_holdings 테이블에서 상태가 inactive인 사용자의 보유 내역을 조회하세요.
SELECT u.full_name, h.currency_code, h.balance
FROM users u
JOIN fx_holdings h ON h.user_id = u.user_id
WHERE u.status = 'inactive'
ORDER BY u.full_name;

-- 9. fx_holdings, users, currencies 테이블에서 이메일이 alice@example.com인 사용자의 보유 외환과 통화 영문명을 함께 조회하세요.
SELECT h.currency_code, c.currency_name, h.balance
FROM users u
JOIN fx_holdings h   ON h.user_id = u.user_id
JOIN currencies  c   ON c.currency_code = h.currency_code
WHERE u.email = 'alice@example.com'
ORDER BY h.currency_code;


-- 10. fx_holdings 테이블에서 통화별로 보유 사용자 수와 총 잔액을 함께 조회하세요.
SELECT h.currency_code,
       COUNT(DISTINCT h.user_id) AS holder_count,
       SUM(h.balance)            AS total_balance
FROM fx_holdings h
GROUP BY h.currency_code
ORDER BY h.currency_code;









