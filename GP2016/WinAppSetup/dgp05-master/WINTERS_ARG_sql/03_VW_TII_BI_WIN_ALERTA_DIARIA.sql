USE PRD01
GO

CREATE  VIEW TII_BI_WIN_ALERTA_DIARIA AS
SELECT	A.SOPTYPE 
	,	A.ESTADO
	,	A.SOPNUMBE COTIZACION
	,	A.CUSTNMBR CLIENTE
	,	LEFT(A.CUSTNAME, 20) NOMBRE
	,	A.DOCDATE 
	,	SUM(A.ELECT) ELECT
    ,	SUM(A.INST) INST
    ,	SUM(A.SICK) SICK
	,	SUM(PRECIO) PRECIO
	,	SUM(COSTO) COSTO
 FROM 
(SELECT  'SIN CONTABILIZAR' ESTADO
             ,  A.SOPTYPE
             , A.SOPNUMBE
			 , A.CUSTNMBR
			     , LEFT(A.CUSTNAME, 20)  CUSTNAME
				  , A.DOCDATE 
             ,CASE C.USCATVLS_6
	WHEN 'COMAT' THEN B.XTNDPRCE-B.TRDISAMT ELSE 0 END COMAT
            ,CASE WHEN C.USCATVLS_6 LIKE 'ELECT%' 
                                              THEN B.XTNDPRCE-B.TRDISAMT 
                                              ELSE 0 END ELECT
             ,CASE WHEN C.USCATVLS_6 LIKE 'INST%'
                                              THEN B.XTNDPRCE-B.TRDISAMT 
                                               ELSE 0 END INST
             ,CASE C.USCATVLS_6
	WHEN 'OTROS' THEN B.XTNDPRCE-B.TRDISAMT ELSE 0 END OTROS
            ,CASE C.USCATVLS_6
	WHEN 'SICK' THEN B.XTNDPRCE-B.TRDISAMT ELSE 0 END SICK
            ,B.XTNDPRCE-B.TRDISAMT PRECIO
           , B.EXTDCOST COSTO
  FROM SOP10100 A INNER JOIN SOP10200 B ON A.SOPTYPE = B.SOPTYPE AND                                                                                       A.SOPNUMBE = B.SOPNUMBE
               INNER JOIN IV00101 C ON B.ITEMNMBR = C.ITEMNMBR
  WHERE  A.VOIDSTTS = 0 
      AND ( ( A.SOPTYPE = 3 AND  LEFT(A.SOPNUMBE, 2) IN('FV', 'NC', 'ND') 
                                             AND A.SOPNUMBE NOT LIKE 'RX%'  
                                            AND A.SOPNUMBE NOT LIKE 'FV %-T00%' ) OR
               ( A.SOPTYPE != 3 ) )
     AND  B.ITEMNMBR not like 'ANTICIPO%'
 UNION ALL
 SELECT 'CONTABILIZADA' ESTADO,
               A.SOPTYPE
             , A.SOPNUMBE
			  , A.CUSTNMBR 
			      , LEFT(A.CUSTNAME, 20)  CUSTNAME
				   , A.DOCDATE 
             ,CASE C.USCATVLS_6 WHEN 'COMAT' 
                                          THEN XTNDPRCE-B.TRDISAMT ELSE 0 END COMAT
             ,CASE WHEN C.USCATVLS_6 LIKE 'ELECT%' 
                                          THEN XTNDPRCE-B.TRDISAMT ELSE 0 END ELECT
             , CASE WHEN C.USCATVLS_6 LIKE 'INST%' 
                                           THEN XTNDPRCE-B.TRDISAMT ELSE 0 END INST
            ,CASE C.USCATVLS_6 WHEN 'OTROS' 
                                            THEN XTNDPRCE-B.TRDISAMT ELSE 0 END OTROS
           ,CASE C.USCATVLS_6 WHEN 'SICK' 
                                            THEN XTNDPRCE-B.TRDISAMT ELSE 0 END SICK
           , B.XTNDPRCE-B.TRDISAMT PRECIO
           , B.EXTDCOST COSTO
 FROM SOP30200 A 
          INNER JOIN SOP30300 B ON A.SOPTYPE = B.SOPTYPE 
                                                   AND A.SOPNUMBE = B.SOPNUMBE
          INNER JOIN IV00101 C ON B.ITEMNMBR = C.ITEMNMBR
 WHERE A.SOPTYPE = 3
 AND A.VOIDSTTS = 0 
 AND LEFT(A.SOPNUMBE, 2) IN('FV', 'NC', 'ND') 
 AND A.SOPNUMBE NOT LIKE 'RX%'
 AND A.SOPNUMBE NOT IN(SELECT SOPNUMBE FROM SOP10100 WHERE SOPTYPE IN(3, 4))
 AND  B.ITEMNMBR not like 'ANTICIPO%'
 ) A
GROUP BY A.SOPTYPE
                  , A.SOPNUMBE
                , A.CUSTNMBR
              -- , A.DOCAMNT
               , LEFT(A.CUSTNAME, 20)
             , A.DOCDATE
             ,A.ESTADO

GO