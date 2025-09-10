-- drop database fc_account 
use fc_account;


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
('alice@example.com','Alice Kim',1),
('bob@example.com','Bob Lee',1),
('carol@example.com','Carol Park',1),
('dave@example.com','Dave Choi',1),
('erin@example.com','Erin Jung',0),
('frank@example.com','Frank Yoo',1),
('grace@example.com','Grace Han',1),
('heidi@example.com','Heidi Lim',1);

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