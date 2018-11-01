USE PRD01
GO

CREATE VIEW TII_BI_WIN_ALERTA_VENTA_SEMANAL AS
select      
		RTRIM( B.SALSTERR)							ZONA
	,   RTRIM( B.USERDEF2)							SEGMENTO
	,	I.USCATVLS_6								DIVISION
	,	RTRIM(LTRIM( B.SLPRSNID ) )					PROVINCIA 
	,	RTRIM(A.CUSTNMBR) + ' - ' +B.CUSTNAME		CLIENTE
	,	B.CUSTNAME									NOMBRE
	,	SUM(CASE WHEN 
                 LEFT(CONVERT(CHAR(8), A.DOCDATE, 112), 6) = 
                 LEFT(CONVERT(CHAR(8), getdate() , 112), 6) 
                THEN 
                                         CASE WHEN A.SOPTYPE = 3 THEN C.XTNDPRCE-C.TRDISAMT 
                                                                                            ELSE -(C.XTNDPRCE-C.TRDISAMT) END 
                                       ELSE 0 END) MESACTUAL
	,	SUM(CASE WHEN A.DOCDATE BETWEEN Y1.FSTFSCDY AND Y1.LSTFSCDY 
                       THEN CASE WHEN A.SOPTYPE = 3 THEN C.XTNDPRCE-C.TRDISAMT 
                                                                                            ELSE -(C.XTNDPRCE-C.TRDISAMT) END 
                                    ELSE 0 END) ANIOACTUAL 
	,	DATEDIFF(m, Y1.FSTFSCDY, LEFT(CONVERT(CHAR(8), getdate() , 112), 6) + '01')+1 PROMACTUAL
	,   SUM(CASE WHEN
                                        LEFT(CONVERT(CHAR(8), A.DOCDATE, 112), 6) = 
                                        LEFT(CONVERT(CHAR(8), getdate() , 112), 6)
                                   THEN 
                                       CASE WHEN A.SOPTYPE = 3 THEN C.EXTDCOST
                                                                                           ELSE -(C.EXTDCOST) END 
                                    ELSE 0 END) COSTOMES
    ,  SUM(CASE WHEN 
                                     A.DOCDATE BETWEEN Y1.FSTFSCDY AND Y1.LSTFSCDY
                                THEN 
                                     CASE WHEN A.SOPTYPE = 3 THEN C.EXTDCOST
                                     ELSE -(C.EXTDCOST) END 
                               ELSE 0 END) COSTOANIO      
FROM SOP30200 A 
     INNER JOIN RM00101 B  ON A.CUSTNMBR = B.CUSTNMBR
     INNER JOIN SOP30300 C ON A.SOPTYPE = C.SOPTYPE AND A.SOPNUMBE = C.SOPNUMBE
     INNER JOIN IV00101 I  ON C.ITEMNMBR = I.ITEMNMBR
     INNER JOIN
               (SELECT CASE WHEN RMDTYPAL = 8 THEN 4 ELSE 3 END SOPTYPE
                      , DOCNUMBR SOPNUMBE 
                FROM RM20101 
                WHERE VOIDSTTS = 0 
                  AND RMDTYPAL IN(1,8)
                UNION
                SELECT CASE WHEN RMDTYPAL = 8 THEN 4 ELSE 3 END SOPTYPE
                     , DOCNUMBR SOPNUMBE 
                FROM RM30101 
                WHERE VOIDSTTS = 0 
                  AND RMDTYPAL IN(1,8) ) D
                           ON A.SOPTYPE = D.SOPTYPE AND A.SOPNUMBE = D.SOPNUMBE
    INNER JOIN RM00102 E ON A.CUSTNMBR = E.CUSTNMBR AND A.PRSTADCD = E.ADRSCODE
    INNER JOIN RM00301 E1 ON E.SLPRSNID = E1.SLPRSNID 
     INNER JOIN CANADIAN_FISCAL_YEARS Y1 ON A.DOCDATE BETWEEN Y1.FSTFSCDY AND Y1.LSTFSCDY
WHERE A.SOPTYPE IN(3,4) 
  AND A.VOIDSTTS = 0 
  AND A.DOCDATE BETWEEN Y1.FSTFSCDY AND Y1.LSTFSCDY 
AND A.DOCDATE <= CONVERT(CHAR(8),  getdate() , 112)
  AND CONVERT(CHAR(8), getdate() , 112) BETWEEN Y1.FSTFSCDY AND Y1.LSTFSCDY
  AND LEFT(A.SOPNUMBE, 2) IN('FV', 'NC', 'ND') 
 AND I.USCATVLS_6 in('INSTR','ELECT','SICK')
AND B.SALSTERR in ('W06','W07','W08','W09','W10','WH0')
AND  C.ITEMNMBR not like 'ANTICIPO%'
GROUP BY B.SALSTERR, I.USCATVLS_6
       ,     RTRIM(A.CUSTNMBR) + ' - ' +B.CUSTNAME    
       ,B.CUSTNAME
      , B.SLPRSNID
       ,B.USERDEF2
      , DATEDIFF(m, Y1.FSTFSCDY, LEFT(CONVERT(CHAR(8), getdate() , 112), 6) + '01')+1
	  GO