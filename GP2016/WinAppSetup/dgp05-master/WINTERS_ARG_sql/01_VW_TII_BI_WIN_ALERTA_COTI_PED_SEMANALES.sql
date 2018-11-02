USE PRD01
GO

CREATE VIEW TII_BI_WIN_ALERTA_COT_PED_SEMANAL AS
SELECT		RTRIM( LINEA.SALSTERR)         ZONA
		,	RTRIM( LINEA.USERDEF2)          SEGMENTO
        ,   LINEA.USCATVLS_6				DIVISION
		,	A.SOPTYPE						TIPODOCUMENTO
        ,   A.SOPNUMBE						DOCUMENTO 
		,   A.CUSTNMBR						CLIENTE 
		,   rtrim(A.CUSTNAME)				NOMBRE
		,   A.DOCDATE						FECHA
		,   SUM(PRECIO)						PRECIO 
		,	SUM(COSTO)						COSTO
        ,	LINEA.SLPRSNID					PROVINCIA
FROM SOP10100 A 
    INNER JOIN ( 
                SELECT	A.SOPTYPE, 
						A.SOPNUMBE, 
						C.USCATVLS_6 ,	
                        D.SALSTERR ,	
          				D.SLPRSNID,
                        D.USERDEF2,
						CASE WHEN B.REMPRICE != 0 		
							THEN 
                                 B.REMPRICE-ROUND((B.TRDISAMT/B.QUANTITY)*B.QTYREMAI, 2) 
							ELSE	0   
							END PRECIO
	   					,CASE WHEN B.REMPRICE != 0  
							THEN ROUND((B.EXTDCOST/B.QUANTITY)*B.QTYREMAI, 2) 
							ELSE 0 	
							END COSTO
				FROM	SOP10100 A 
						INNER JOIN RM00101 D ON A.CUSTNMBR = D.CUSTNMBR
						INNER JOIN SOP10200 B ON A.SOPTYPE = B.SOPTYPE AND A.SOPNUMBE = B.SOPNUMBE
						INNER JOIN IV00101 C ON B.ITEMNMBR = C.ITEMNMBR
				WHERE A.DOCDATE >= '20121101'  
				AND C.USCATVLS_6  in('INSTR','ELECT','SICK')
				AND D.SALSTERR in('W06','W07','W08','W09','W10','WH0')
				 
 	) 
	LINEA ON A.SOPTYPE = LINEA.SOPTYPE AND A.SOPNUMBE = LINEA.SOPNUMBE 
  GROUP BY A.SOPTYPE
		,  A.SOPNUMBE
		,  A.CUSTNMBR
		, RTRIM(A.CUSTNMBR) , A.CUSTNAME 
                                     ,  USCATVLS_6         	
                                     ,  LINEA.SLPRSNID
                                      ,  LINEA.SALSTERR
                                     , LINEA.USERDEF2  
		,  A.DOCDATE
                                     ,  CONVERT(DECIMAL(10,2), A.TAXAMNT)
                                      , CONVERT(DECIMAL(10,2), A.DOCAMNT)      

GO