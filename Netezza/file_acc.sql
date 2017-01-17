CREATE TABLE file_accounts
(
	  acc_id 	   INTEGER
	, acc_number   VARCHAR(50)
	, client_name  VARCHAR(50)
	, client_addr  VARCHAR(100)
	, client_city  VARCHAR(100)
	, open_date    TIMESTAMP
	, close_date   TIMESTAMP
	, balance 	   DOUBLE
	, currency     VARCHAR(4)
);

INSERT INTO file_accounts
(
	  acc_id
	, acc_number
	, client_name
	, client_addr
	, client_city
	, open_date
	, close_date
	, balance
	, currency
)
SELECT
	  TRIM (acc_id)
	, TRIM (acc_number)
	, TRIM (client_name)
	, TRIM (client_addr)
	, TRIM (client_city)
	, TRIM (open_date)
	, TRIM (close_date)
	, TRIM (balance)
	, TRIM (currency)
FROM EXTERNAL 'D:\Netezza - Training\Practice\Accounts.txt'
(
	  acc_id 	   INTEGER
	, acc_number   VARCHAR(50)
	, client_name  VARCHAR(50)
	, client_addr  VARCHAR(100)
	, client_city  VARCHAR(100)
	, open_date    VARCHAR(100)
	, close_date   VARCHAR(100)
	, balance 	   DOUBLE
	, currency     VARCHAR(4)
)
USING
(
	REMOTESOURCE 'odbc'
	SKIPROWS 1
	DELIMITER ','
);