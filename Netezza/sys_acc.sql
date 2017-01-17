CREATE TABLE sys_accounts
(
	  idp_warehouse_id BIGINT 		 NOT NULL
	, idp_audit_id 	   BIGINT 		 NOT NULL
	, eff_dt  	   DATE			 NOT NULL
	, end_dt 	   DATE
	, del_eff_dt       DATE
	
	, acc_id 	   INTEGER
	, acc_number       VARCHAR(50)
	, client_name      VARCHAR(50)
	, client_addr      VARCHAR(100)
	, client_city      VARCHAR(100)
	, open_date        TIMESTAMP
	, close_date       TIMESTAMP
	, balance 	   DOUBLE
	, currency         VARCHAR(4)
);

INSERT INTO sys_accounts
(
	  idp_warehouse_id
	, idp_audit_id
	, eff_dt
	, end_dt
	, del_eff_dt
	
	, acc_id
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
	  NEXT VALUE FOR seq  AS idp_warehouse_id
	, ${audit_id}  	      AS idp_audit_id
	, CURRENT_DATE 	      AS eff_dt
	, $end_dt 	      AS end_dt
	, $del_eff_dt 	      AS del_eff_dt
	
	, TRIM (acc_id)
	, TRIM (acc_number)
	, TRIM (client_name)
	, TRIM (client_addr)
	, TRIM (client_city)
	, TRIM (open_date)
	, TRIM (close_date)
	, TRIM (balance)
	, TRIM (currency)
FROM file_accounts;
