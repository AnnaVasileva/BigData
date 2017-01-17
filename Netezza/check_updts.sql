/* Update changed records */
	/* Set end_dt */
UPDATE sys_accounts
SET    end_dt = CURRENT_DATE - 1
WHERE  end_dt = TO_DATE('9999-12-31','YYYY-MM-DD') 
AND    acc_id IN (SELECT acc_id
                  FROM (SELECT CASE
                               WHEN     fa.acc_number  = sa.acc_number
                                    AND fa.client_name = sa.client_name
                                    AND fa.client_addr = sa.client_addr
									AND fa.client_city = sa.client_city 
									AND fa.open_date   = sa.open_date 
									AND fa.close_date  = sa.close_date 
									AND fa.balance     = sa.balance 
									AND fa.currency    = sa.currency 
                                 THEN  1
                               ELSE 0
                             END AS is_equal,
							 sa.acc_id
                        FROM file_accounts fa INNER JOIN sys_accounts sa
                        ON fa.acc_id = sa.acc_id) changed_rows_tbl
                  WHERE is_equal = 0);

	/* Insert records updated records */  
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
	  NEXT VALUE FOR seq AS idp_warehouse_id
	, ${audit_id} AS idp_audit_id
	, CURRENT_DATE AS eff_dt
	, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS end_dt
	, NULL AS del_eff_dt
	
	, acc_id
	, acc_number
	, client_name
	, client_addr
	, client_city
	, open_date
	, close_date
	, balance
	, currency
FROM (SELECT CASE
             WHEN   fa.acc_number  = sa.acc_number
                AND fa.client_name = sa.client_name
                AND fa.client_addr = sa.client_addr
				AND fa.client_city = sa.client_city 
				AND fa.open_date   = sa.open_date 
				AND fa.close_date  = sa.close_date 
				AND fa.balance     = sa.balance 
				AND fa.currency    = sa.currency 
	          THEN 1
	         ELSE 0
	         END AS is_equal,
	          sa.acc_id
			, fa.acc_number
			, fa.client_name
			, fa.client_addr
			, fa.client_city
			, fa.open_date
			, fa.close_date
			, fa.balance
			, fa.currency
	   FROM file_accounts fa INNER JOIN sys_accounts sa
       ON fa.acc_id = sa.acc_id
	   WHERE is_equal = 0) changed_rows_tbl;
	   
/* Insert new records which do not exist in sys_acc */
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
 	  NEXT VALUE FOR seq AS idp_warehouse_id
	, ${audit_id} AS idp_audit_id
	, CURRENT_DATE AS eff_dt
	, TO_DATE('9999-12-31', 'YYYY-MM-DD') AS end_dt
	, NULL AS del_eff_dt
	
	, acc_id
	, acc_number
	, client_name
	, client_addr
	, client_city
	, open_date
	, close_date
	, balance
	, currency
FROM (
	   SELECT  fa.acc_id
		     , fa.acc_number
			 , fa.client_name
			 , fa.client_addr
			 , fa.client_city
			 , fa.open_date
			 , fa.close_date
			 , fa.balance
			 , fa.currency
        FROM file_accounts fa
        WHERE NOT EXISTS (SELECT 1 FROM sys_accounts sa WHERE sa.acc_id = fa.acc_id)
      ) new_records_tbl;

/* Update records which are deleted from file_accounts */
UPDATE sys_accounts sa
   SET end_dt  = CURRENT_DATE - 1,
       del_eff_dt = CURRENT_DATE
 WHERE sa.acc_id NOT IN (SELECT fa.acc_id FROM file_accounts fa);
