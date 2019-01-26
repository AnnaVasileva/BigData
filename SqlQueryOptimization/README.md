# SQL Query Optimization

A developer has written an sql query, which is functionally sound i.e. returns the expected result. However, there is a non-functional issue with it – it is slow. The query goes to review by the DB Admin and he responds as follows:<br />

- There are observable misapplications of best practices in the query<br />
- The query has to be re-written for optimized performance.<br />
- The schema will not be available, but you can use the following for reference:<br />
    1. Query to optimize <br />
    2. Execution plan <br />
    3. Query results <br />
    
 ## Query to optimize

```sql
select m.item_id, SUM(m.PIECES_QTY) ORD_QTY,
	(select SUM(S.AVAILABLE_PIECES)
	from VSV_WH_STOCK_DETAIL S, VS_WH_AREA A
	where
		s.item_id=m.item_id
		and s.deposit_id='MSOTA'
		and s.AREA_FK=A.PK
		and A.LOCATION_TYPE ='PIC'
		and S.IS_ACTIVE='1'
		group by s.item_id) AV_PICK,
	(select SUM(S.BOOKED_PIECES)
	from VSV_WH_STOCK_DETAIL S, VS_WH_AREA A
	where
		s.item_id=m.item_id
		and s.deposit_id='MSOTA'
		and s.AREA_FK=A.PK
		and A.LOCATION_TYPE ='PIC'
		and S.IS_ACTIVE='1'
		group by s.item_id) BKD_PIC,
	(select SUM(S.STOCKED_PIECES)
	from VSV_WH_STOCK_DETAIL S, VS_WH_AREA A
	where
		s.item_id=m.item_id
		and s.deposit_id='MSOTA'
		and s.AREA_FK=A.PK
		and A.LOCATION_TYPE ='PIC'
		and S.IS_ACTIVE='1'
		group by s.item_id) STK_PIC
from VS_WH_CUSORD_MVT M, VS_WH_CUSORD o
where
O.ORD_TYPE='WOU'
and O.ORD_STATUS = 'REG'
and m.mvt_type='O'
and o.pk=m.ord_fk
and o.deposit_id='MSOTA'
group by m.item_id
order by m.item_id;
```

## Execution plan

Plan hash value: 511076833


| Id    | Operation                        | Name                     | Rows  | Bytes | Cost (%CPU)| Time     |
|------:|----------------------------------|--------------------------|-------|-------|------------|----------|
|     0 | SELECT STATEMENT                 |                          |    82 |  3608 |   251K  (1)| 00:00:10 |
|     1 |  SORT GROUP BY NOSORT            |                          |     1 |    78 |  2041   (1)| 00:00:01 |
|     2 |   NESTED LOOPS                   |                          |     1 |    78 |  2041   (1)| 00:00:01 |
|     3 |    NESTED LOOPS                  |                          |     1 |    78 |  2041   (1)| 00:00:01 |
|     4 |     NESTED LOOPS                 |                          |     1 |    68 |  2040   (1)| 00:00:01 |
|     5 |      NESTED LOOPS                |                          |     1 |    62 |  2040   (1)| 00:00:01 |
|    *6 |       TABLE ACCESS BY INDEX ROWID| VS_WH_ITEM_STOCK         |     1 |    56 |  2040   (1)| 00:00:01 |
|    *7 |        INDEX SKIP SCAN           | ITEM_STOCK_DEPOSIT_IDX   | 20512 |       |   662   (0)| 00:00:01 |
|    *8 |       INDEX UNIQUE SCAN          | SYS_C00156009            |     1 |     6 |     0   (0)| 00:00:01 |
|    *9 |      INDEX UNIQUE SCAN           | SYS_C00155567            |     1 |     6 |     0   (0)| 00:00:01 |
|   *10 |     INDEX UNIQUE SCAN            | SYS_C00156137            |     1 |       |     0   (0)| 00:00:01 |
|   *11 |    TABLE ACCESS BY INDEX ROWID   | VS_WH_AREA               |     1 |    10 |     1   (0)| 00:00:01 |
|    12 |  SORT GROUP BY NOSORT            |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    13 |   NESTED LOOPS                   |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    14 |    NESTED LOOPS                  |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    15 |     NESTED LOOPS                 |                          |     1 |    65 |  2040   (1)| 00:00:01 |
|    16 |      NESTED LOOPS                |                          |     1 |    59 |  2040   (1)| 00:00:01 |
|   *17 |       TABLE ACCESS BY INDEX ROWID| VS_WH_ITEM_STOCK         |     1 |    53 |  2040   (1)| 00:00:01 |
|   *18 |        INDEX SKIP SCAN           | ITEM_STOCK_DEPOSIT_IDX   | 20512 |       |   662   (0)| 00:00:01 |
|   *19 |       INDEX UNIQUE SCAN          | SYS_C00156009            |     1 |     6 |     0   (0)| 00:00:01 |
|   *20 |      INDEX UNIQUE SCAN           | SYS_C00155567            |     1 |     6 |     0   (0)| 00:00:01 |
|   *21 |     INDEX UNIQUE SCAN            | SYS_C00156137            |     1 |       |     0   (0)| 00:00:01 |
|   *22 |    TABLE ACCESS BY INDEX ROWID   | VS_WH_AREA               |     1 |    10 |     1   (0)| 00:00:01 |
|    23 |  SORT GROUP BY NOSORT            |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    24 |   NESTED LOOPS                   |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    25 |    NESTED LOOPS                  |                          |     1 |    75 |  2041   (1)| 00:00:01 |
|    26 |     NESTED LOOPS                 |                          |     1 |    65 |  2040   (1)| 00:00:01 |
|    27 |      NESTED LOOPS                |                          |     1 |    59 |  2040   (1)| 00:00:01 |
|   *28 |       TABLE ACCESS BY INDEX ROWID| VS_WH_ITEM_STOCK         |     1 |    53 |  2040   (1)| 00:00:01 |
|   *29 |        INDEX SKIP SCAN           | ITEM_STOCK_DEPOSIT_IDX   | 20512 |       |   662   (0)| 00:00:01 |
|   *30 |       INDEX UNIQUE SCAN          | SYS_C00156009            |     1 |     6 |     0   (0)| 00:00:01 |
|   *31 |      INDEX UNIQUE SCAN           | SYS_C00155567            |     1 |     6 |     0   (0)| 00:00:01 |
|   *32 |     INDEX UNIQUE SCAN            | SYS_C00156137            |     1 |       |     0   (0)| 00:00:01 |
|   *33 |    TABLE ACCESS BY INDEX ROWID   | VS_WH_AREA               |     1 |    10 |     1   (0)| 00:00:01 |
|    34 |  SORT ORDER BY                   |                          |    82 |  3608 |   251K  (1)| 00:00:10 |
|    35 |   HASH GROUP BY                  |                          |    82 |  3608 |   251K  (1)| 00:00:10 |
|    36 |    NESTED LOOPS                  |                          |    82 |  3608 |  1927   (1)| 00:00:01 |
|    37 |     NESTED LOOPS                 |                          |    82 |  3608 |  1927   (1)| 00:00:01 |
|   *38 |      TABLE ACCESS FULL           | VS_WH_CUSORD             |    13 |   273 |  1875   (1)| 00:00:01 |
|   *39 |      INDEX RANGE SCAN            | VS_WH_ORD_MVT_ORD_FK_IDX |     6 |       |     2   (0)| 00:00:01 |
|    40 |     TABLE ACCESS BY INDEX ROWID  | VS_WH_CUSORD_MVT         |     6 |   138 |     4   (0)| 00:00:01 |

### Predicate Information (identified by operation id):

6 - filter("S"."ITEM_ID"=:B1 AND "S"."DEPOSIT_ID"='MSOTA')<br />
7 - access("S"."IS_ACTIVE"='1')<br />
    filter("S"."IS_ACTIVE"='1')<br />
8 - access("D"."PK"="S"."DEPOSIT_FK")<br />
9 - access("C"."PK"="S"."CUSTOMER_FK")<br />
10 - access("A"."PK"="S"."AREA_FK")<br />
11 - filter("LOCATION_TYPE"='PIC')<br />
17 - filter("S"."ITEM_ID"=:B1 AND "S"."DEPOSIT_ID"='MSOTA')<br />
18 - access("S"."IS_ACTIVE"='1')<br />
     filter("S"."IS_ACTIVE"='1')<br />
19 - access("D"."PK"="S"."DEPOSIT_FK")<br />
20 - access("C"."PK"="S"."CUSTOMER_FK")<br />
21 - access("A"."PK"="S"."AREA_FK")<br />
22 - filter("LOCATION_TYPE"='PIC')<br />
28 - filter("S"."ITEM_ID"=:B1 AND "S"."DEPOSIT_ID"='MSOTA')<br />
29 - access("S"."IS_ACTIVE"='1')<br />
     filter("S"."IS_ACTIVE"='1')<br />
30 - access("D"."PK"="S"."DEPOSIT_FK")<br />
31 - access("C"."PK"="S"."CUSTOMER_FK")<br />
32 - access("A"."PK"="S"."AREA_FK")<br />
33 - filter("LOCATION_TYPE"='PIC')<br />
38 - filter("O"."ORD_STATUS"='REG' AND "O"."ORD_TYPE"='WOU' AND "O"."DEPOSIT_ID"='MSOTA')<br />
39 - access("O"."PK"="M"."ORD_FK" AND "M"."MVT_TYPE"='O')<br />


### Note

   - dynamic statistics used: dynamic sampling (level=2)
   - this is an adaptive plan
   
## Results

| ITEM_ID  | ORD_QTY | AV_PICK | BKD_PIC  | STK_PIC|
|---------:|--------:|--------:|---------:|-------:|
|09070     |97       |null     |null      |null    |
|10565     |1        |1        |0         |1       |
