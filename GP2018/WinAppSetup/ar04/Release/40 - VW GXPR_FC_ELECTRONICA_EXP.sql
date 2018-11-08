GO
/****** Object:  View [dbo].[GXPR_FC_ELECTRONICA_EXP]    Script Date: 16/08/2018 11:56:28 ******/
SET ANSI_NULLS ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[GXPR_FC_ELECTRONICA_EXP]') and OBJECTPROPERTY(id, N'IsView') = 1) 
drop view [dbo].[GXPR_FC_ELECTRONICA_EXP]

GO



SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[GXPR_FC_ELECTRONICA_EXP]
AS
SELECT        /*Datos Compañia Emite*/ rtrim(CMP.CMPNYNAM) CMPNYNAM/*OK*/ , rtrim(concat(rtrim(CMP.ADDRESS1), rtrim(CMP.ADDRESS2), rtrim(CMP.ADDRESS3))) 
                         CMPADRESS/*OK*/,RTRIM(CONCAT(rtrim(CMP.CITY), ' - ', rtrim(CMP.STATE),' - ',RTRIM(CMPCNTRY)))  CMPADRESS_1 , 'file:' + ARC.fileName FileName/*OK*/ , Substring(TAXREGTN, 1, 2) + '-' + Substring(TAXREGTN, 3, 8) + '-' + Substring(TAXREGTN, 11, 1) CUIT/*OK Falta separar*/ , Substring(INFO.INETINFO, 
                         charindex('IIBB=', INFO.INETINFO, 1) + 5, 11) IIBB/* OK*/ , Substring(INFO.INETINFO, charindex('FECHA_INICIO=', INFO.INETINFO, 1) + 13, 10) FECHA_INICIO/*OK*/ , Substring(INFO.INETINFO, 
                         charindex('COND_IVA=', INFO.INETINFO, 1) + 9, 50) COND_IVA/*NOK*/ , rtrim(FEI_COD) FEI_COD/*OK*/ , rtrim(FEI_LETRA1) FEI_LETRA1/*OK*/ , rtrim(FEI_PDV) FEI_PDV/*OK*/ , FEI_NRO/*NOK*/ , FEI_CAE/*NOK*/ , 
                         FORMAT(FEI_CAE_DUE, 'dd-MM-yyyy') FEI_CAE_DUE/*OK*/ , rtrim(FORMAT(ISNULL(FEI.FEI_PeriodoDesde, '01-01-1900'), 'dd-MM-yyyy')) PERIODO_DESDE, rtrim(FORMAT(ISNULL(FEI.FEI_PeriodoHasta, 
                         '01-01-1900'), 'dd-MM-yyyy')) PERIODO_HASTA, rtrim(FORMAT(ISNULL(FEI.FEI_VtoPago, '01-01-1900'), 'dd-MM-yyyy')) VTO_PAGO/* ,'01-01-1900'  VTO_PAGO*/ , rtrim(SUBSTRING(TAXREGTN, 1, 11)) 
                         + rtrim(FEI_COD) + rtrim(FEI_PDV) + rtrim(FEI_CAE) + rtrim(FORMAT(FEI_CAE_DUE, 'yyyyMMdd')) CODIGO_BARRA/* Datos FACnte Factura Cabecera*/ , rtrim(FAC.SOPNUMBE) NRO_FACTURA/*OK*/ , 
                         rtrim(FAC.SOPTYPE) TIPO_FACTURA/*OK*/ , substring(FAC.DOCID, 1, 2) DOCID, rtrim(FORMAT(FAC.DOCDATE, 'dd-MM-yyyy')) FECHA/*OK*/ , FAC.[PYMTRMID] COND_PAGO/*OK*/ , 
                         FAC.[CUSTNMBR] ID_FACNTE/*OK*/ , FAC.[CUSTNAME] NOMBRE_CLIENTE/*OK*/ , FAC.[CSTPONBR] NRO_ORDEN/*OK*/ , rtrim(concat(rtrim(DIR.ADDRESS1), rtrim(DIR.ADDRESS2), rtrim(DIR.ADDRESS3), ' - ', 
                         rtrim(DIR.CITY), ' - ', rtrim(DIR.STATE))) CLNT_ADRESS/* DAtos FACnte Factura*/ , rtrim(FAC.CURNCYID) CURNCYID, rtrim(mb.Moneda) as curncd, FAC.XCHGRATE, FAC.ORTDISAM TRDISAMT/*OK*/ , FAC.ORSUBTOT SUBTOTAL/*OK*/ , 
                         FAC.ORTAXAMT IMPUESTO_DISCR/*OK*/ , FAC.OBTAXAMT IMPUESTO_INCL/*NOK BCKTXAMT*/ , FAC.ORDOCAMT IMPORTE_TOTAL/*OK DOCAMNT*/ , FAC.DOCAMNT IMPORTE_FUNCIONAL/*OK*/ , 
                        RTRIM(RM.CUIT_PAIS)+' ('+rtrim(pa.pais)+')' CLNT_CUIT/*OK*/ , RTRIM(SUBSTRING(FAC.TXRGNNUM,1,20)) CLNT_IVA/*OK*/ , rtrim(FORMAT(FAC.DUEDATE, 'dd-MM-yyyy')) 
                         DUEDATE, dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-27%') IMP_IVA_27, dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-21%') IMP_IVA_21/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-10%') IMP_IVA_10/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-05%') IMP_IVA_05/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-02%') IMP_IVA_02/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-00%') IMP_IVA_00/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'P-IV%') PERC_IVA/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'P-IB%') PERC_IIBB/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, 
                         FAC.SOPNUMBE, 'V-RETGAN%') RET_GANAN/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IMPINT%') IMP_INTERNO/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 
                         'V-IMPMUN%') IMP_MUNICIPAL/* Detalles Factura*/ , rtrim([ITEMNMBR]) ITEMNMBR, rtrim(ITEMDESC) ITEMDESC/*OK*/ , rtrim([UMSCHDSC]) UOFM/*OK*/ , ORUNTPRC UNITPRCE/*OK*/ , OXTNDPRC XTNDPRCE/*OK*/ , 
                         DET.ORTAXAMT TAXAMNT/*,convert(decimal(10,2),PORC_IVA) --'21' PORC_IVA*/ , dbo.GXPRFuncGetTaxItm(DET.SOPTYPE, DET.SOPNUMBE, DET.LNITMSEQ) PORC_IVA, det.ORMRKDAM MRKDNAMT,fac.ORTDISAM as ORTDISAM /*OK */ , 
                         QUANTITY QUANTITY,rtrim(pa.pais) pais
/*OK*/ FROM DYNAMICS.dbo.SY01500 AS CMP INNER JOIN
                         DYNAMICS.dbo.SY01501 AS ARC ON ARC.CMPANYID = CMP.CMPANYID LEFT OUTER JOIN
                         SY01200 AS INFO ON CMP.INTERID = INFO.MASTER_ID, SOP10100 AS FAC INNER JOIN
                         SOP10200 AS DET ON FAC.SOPTYPE = DET.SOPTYPE AND FAC.SOPNUMBE = DET.SOPNUMBE INNER JOIN
                         RM00102 AS DIR ON FAC.CUSTNMBR = DIR.CUSTNMBR AND FAC.PRBTADCD = DIR.ADRSCODE LEFT OUTER JOIN
                         FEI_SOP30200 AS FEI ON FAC.SOPTYPE = FEI.SOPTYPE AND FAC.SOPNUMBE = FEI.SOPNUMBE LEFT OUTER JOIN
                         AWLI_RM00101 AS RM ON FAC.CUSTNMBR = RM.CUSTNMBR LEFT OUTER JOIN
                         DYNAMICS.dbo.AWLI40330 AS IVA ON RM.RESP_TYPE = IVA.RESP_TYPE LEFT OUTER JOIN
                         IV40201 AS UN ON UN.BASEUOFM=DET.UOFM left outer join
                         dynamics.dbo.AWLI_MC40200 ma on fac.CURNCYID=ma.CURNCYID left outer join 
 DYNAMICS.dbo.AWLI40340 mb on  ma.CURR_CODE=mb.CURR_CODE left outer join
dynamics.dbo.AWLI40320 pa on pa.Cuit_pais = rm.cuit_pais
/*- SOP10105 IMP ON DET.SOPTYPE = IMP.SOPTYPE AND DET.SOPNUMBE = IMP.SOPNUMBE AND DET.LNITMSEQ = IMP.LNITMSEQ AND IMP.TAXDTLID LIKE '%' + rtrim('V-IV-') + '%'*/ WHERE CMP.INTERID = DB_NAME() 
                         AND INFO.ADRSCODE = 'FC_ELECTRONICA' AND INFO.MASTER_TYPE = 'CMP'
UNION ALL
SELECT        /*Datos Compañia Emite*/ rtrim(CMP.CMPNYNAM) CMPNYNAM/*OK*/ , rtrim(concat(rtrim(CMP.ADDRESS1), rtrim(CMP.ADDRESS2), rtrim(CMP.ADDRESS3))) 
                         CMPADRESS/*OK*/,RTRIM(CONCAT(rtrim(CMP.CITY), ' - ', rtrim(CMP.STATE),' - ',RTRIM(CMPCNTRY))) , 'file:' + ARC.fileName FileName/*OK*/ , Substring(TAXREGTN, 1, 2) + '-' + Substring(TAXREGTN, 3, 8) + '-' + Substring(TAXREGTN, 11, 1) CUIT/*OK Falta separar*/ , Substring(INFO.INETINFO, 
                         charindex('IIBB=', INFO.INETINFO, 1) + 5, 11) IIBB/* OK*/ , Substring(INFO.INETINFO, charindex('FECHA_INICIO=', INFO.INETINFO, 1) + 13, 10) FECHA_INICIO/*OK*/ , Substring(INFO.INETINFO, 
                         charindex('COND_IVA=', INFO.INETINFO, 1) + 9, 50) COND_IVA/*NOK*/ , rtrim(FEI_COD) FEI_COD/*OK*/ , rtrim(FEI_LETRA1) FEI_LETRA1/*OK*/ , rtrim(FEI_PDV) FEI_PDV/*OK*/ , FEI_NRO/*NOK*/ , FEI_CAE/*NOK*/ , 
                         FORMAT(FEI_CAE_DUE, 'dd-MM-yyyy') FEI_CAE_DUE/*OK	*/ , rtrim(FORMAT(ISNULL(FEI.FEI_PeriodoDesde, '01-01-1900'), 'dd-MM-yyyy')) PERIODO_DESDE, rtrim(FORMAT(ISNULL(FEI.FEI_PeriodoHasta, 
                         '01-01-1900'), 'dd-MM-yyyy')) PERIODO_HASTA, rtrim(FORMAT(ISNULL(FEI.FEI_VtoPago, '01-01-1900'), 'dd-MM-yyyy')) VTO_PAGO/*  ,'01-01-1900'  VTO_PAGO	*/ , rtrim(SUBSTRING(TAXREGTN, 1, 11)) 
                         + rtrim(FEI_COD) + rtrim(FEI_PDV) + rtrim(FEI_CAE) + rtrim(FORMAT(FEI_CAE_DUE, 'yyyyMMdd')) CODIGO_BARRA/* Datos FACnte Factura Cabecera*/ , rtrim(FAC.SOPNUMBE) NRO_FACTURA/*OK*/ , 
                         rtrim(FAC.SOPTYPE) TIPO_FACTURA/*OK*/ , substring(FAC.DOCID, 1, 2) DOCID, rtrim(FORMAT(FAC.DOCDATE, 'dd-MM-yyyy')) FECHA/*OK*/ , FAC.[PYMTRMID] COND_PAGO/*OK*/ , 
                         FAC.[CUSTNMBR] ID_FACNTE/*OK*/ , FAC.[CUSTNAME] NOMBRE_CLIENTE/*OK*/ , FAC.[CSTPONBR] NRO_ORDEN/*OK*/ , rtrim(concat(rtrim(DIR.ADDRESS1), rtrim(DIR.ADDRESS2), rtrim(DIR.ADDRESS3), ' - ', 
                         rtrim(DIR.CITY), ' - ', rtrim(DIR.STATE))) CLNT_ADRESS/* DAtos FACnte Factura*/ , rtrim(FAC.CURNCYID) CURNCYID,rtrim(mb.Moneda), FAC.XCHGRATE, FAC.ORTDISAM TRDISAMT/*OK*/ , FAC.ORSUBTOT SUBTOTAL/*OK*/ , 
                         FAC.ORTAXAMT IMPUESTO_DISCR/*OK*/ , FAC.OBTAXAMT IMPUESTO_INCL/*NOK BCKTXAMT*/ , FAC.ORDOCAMT IMPORTE_TOTAL/*OK DOCAMNT*/ , FAC.DOCAMNT IMPORTE_FUNCIONAL/*OK*/ , 
                          RTRIM(RM.CUIT_PAIS)+' ('+rtrim(pa.pais)+')' CLNT_CUIT/*OK*/ , RTRIM(SUBSTRING(FAC.TXRGNNUM,1,20))  CLNT_IVA/*OK*/ , rtrim(FORMAT(FAC.DUEDATE, 'dd-MM-yyyy')) 
                         DUEDATE, dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-27%') IMP_IVA_27, dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-21%') IMP_IVA_21/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-10%') IMP_IVA_10/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-05%') IMP_IVA_05/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-02%') IMP_IVA_02/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IV%-00%') IMP_IVA_00/*NOK*/ , 
                         dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'P-IV%') PERC_IVA/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'P-IB%') PERC_IIBB/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, 
                         FAC.SOPNUMBE, 'V-RETGAN%') RET_GANAN/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 'V-IMPINT%') IMP_INTERNO/*NOK*/ , dbo.GXPRFuncGetTax(FAC.SOPTYPE, FAC.SOPNUMBE, 
                         'V-IMPMUN%') IMP_MUNICIPAL/* Detalles Factura*/ , rtrim([ITEMNMBR]) ITEMNMBR, rtrim(ITEMDESC) ITEMDESC/*OK*/ , rtrim(UMSCHDSC) UOFM/*OK*/ , ORUNTPRC UNITPRCE/*OK*/ , OXTNDPRC XTNDPRCE/*OK*/ , 
                         DET.ORTAXAMT TAXAMNT/*,dbo.GXPRFuncGetTaxItm(DET.SOPTYPE,DET.SOPNUMBE,DET.LNITMSEQ) PORC_IVA*/ , dbo.GXPRFuncGetTaxItm(DET.SOPTYPE, DET.SOPNUMBE, DET.LNITMSEQ) PORC_IVA, 
                         det.ORMRKDAM MRKDNAMT,fac.ORTDISAM as ORTDISAM/*OK */ , QUANTITY QUANTITY,rtrim(pa.pais) pais
/*OK*/ FROM DYNAMICS.dbo.SY01500 AS CMP INNER JOIN
                         DYNAMICS.dbo.SY01501 AS ARC ON ARC.CMPANYID = CMP.CMPANYID LEFT OUTER JOIN
                         SY01200 AS INFO ON CMP.INTERID = INFO.MASTER_ID, SOP30200 AS FAC INNER JOIN
                         SOP30300 AS DET ON FAC.SOPTYPE = DET.SOPTYPE AND FAC.SOPNUMBE = DET.SOPNUMBE INNER JOIN
                         RM00102 AS DIR ON FAC.CUSTNMBR = DIR.CUSTNMBR AND FAC.PRBTADCD = DIR.ADRSCODE LEFT OUTER JOIN
                         FEI_SOP30200 AS FEI ON FAC.SOPTYPE = FEI.SOPTYPE AND FAC.SOPNUMBE = FEI.SOPNUMBE LEFT OUTER JOIN
                         AWLI_RM00101 AS RM ON FAC.CUSTNMBR = RM.CUSTNMBR LEFT OUTER JOIN
                         DYNAMICS.dbo.AWLI40330 AS IVA ON RM.RESP_TYPE = IVA.RESP_TYPE LEFT OUTER JOIN
                         IV40201 AS UN ON UN.BASEUOFM=DET.UOFM  left outer join
                         dynamics.dbo.AWLI_MC40200 ma on fac.CURNCYID=ma.CURNCYID left outer join 
 DYNAMICS.dbo.AWLI40340 mb on  ma.CURR_CODE=mb.CURR_CODE left outer join
dynamics.dbo.AWLI40320 pa on pa.Cuit_pais = rm.cuit_pais
WHERE        CMP.INTERID = DB_NAME() AND INFO.ADRSCODE = 'FC_ELECTRONICA' AND INFO.MASTER_TYPE = 'CMP'
GO
