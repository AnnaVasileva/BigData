SELECT m.item_id, 
	   SUM(m.PIECES_QTY) ORD_QTY,
	   SUM(s.AVAILABLE_PIECES) as AV_PICK, 
	   SUM(s.BOOKED_PIECES) as BKD_PIC,
	   SUM(s.STOCKED_PIECES) as STK_PIC
  FROM VS_WH_CUSORD_MVT m
 INNER JOIN VS_WH_CUSORD o 
    ON m.ord_fk = o.pk
  LEFT JOIN VSV_WH_STOCK_DETAIL s 
    ON m.item_id = s.item_id
   AND s.deposit_id = 'MSOTA'
   AND s.IS_ACTIVE = '1'
 INNER JOIN VS_WH_AREA a 
    ON s.AREA_FK = a.PK
   AND a.LOCATION_TYPE ='PIC'
 WHERE o.ORD_TYPE = 'WOU'
   AND o.ORD_STATUS = 'REG'
   AND m.mvt_type = 'O'	  
 GROUP BY m.item_id
 ORDER BY m.item_id;