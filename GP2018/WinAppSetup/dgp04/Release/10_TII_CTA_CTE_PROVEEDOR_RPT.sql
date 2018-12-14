GO

/****** Object:  View [dbo].[TII_CTA_CTE_PROVEEDOR_RPT]    Script Date: 14/08/2018 10:57:33 ******/
SET ANSI_NULLS ON
GO

if exists (select * from dbo.sysobjects where id = object_id(N'[dbo].[TII_CTA_CTE_PROVEEDOR_RPT]') and OBJECTPROPERTY(id, N'IsView') = 1) 
drop view [dbo].[TII_CTA_CTE_PROVEEDOR_RPT]
go

SET QUOTED_IDENTIFIER ON
GO

CREATE VIEW [dbo].[TII_CTA_CTE_PROVEEDOR_RPT] AS
SELECT 	1 								COPIA
	,PT.vendorid 						VENDORID
	,PP.VENDNAME						VENDNAME
	,ISNULL(PA.APTVCHNM,PT.VCHRNMBR)	VOUCHER
	,PT.VCHRNMBR						VCHR_ORI
	,PA.VCHRNMBR						VCHR_JOINT
	,PT.DOCNUMBR						NUMERO_DOC
	,PT.DOCDATE							FECHA_DOC
	,PT.DOCTYPE							TIPO_DOC
	,DT.DOCTYNAM						TIPO_DESC
	,PT.DOCAMNT			
	,PA.ActualApplyToAmount
--	,Total_Apl
	,CASE  PT.DOCTYPE 	
		WHEN 1 THEN  PT.DOCAMNT			
		WHEN 2 THEN  PT.DOCAMNT			
		WHEN 3 THEN  PT.DOCAMNT	
        ELSE 0
		END								MONTO
	,PA.VCHRNMBR						VCHR_PAGO
	,PA.DOCDATE							FECHA_PAGO
	,PA.doctype							TIPODOC_PAGO
	,CASE  PT.DOCTYPE 	
		WHEN 1 THEN 0
		WHEN 2 THEN  0
		WHEN 3 THEN  0
	    else CASE PA.ActualApplyToAmount WHEN 0    THEN PT.DOCAMNT	 - isnull(Total_Apl,0)
		                                 WHEN NULL THEN PT.DOCAMNT	 - isnull(Total_Apl,0)
									     ELSE PA.ActualApplyToAmount	
									     END		
		end MONTO_APLICADO
	,APTVCHNM							APTVCHNM
	,APTODCTY							APTODCTY
	,isnull(Total_Apl,0)  Total_Apl
FROM dbo. PM30200 PT
	join dbo.PM00200 PP on  PP.VENDORID = PT.VENDORID
	join dbo.PM40102 DT on DT.DOCTYPE = PT.DOCTYPE
	left outer join dbo.PM30300 PA on  PT.VCHRNMBR = PA.VCHRNMBR and PT.DOCTYPE = PA.DOCTYPE
	left outer join (select VCHRNMBR,DOCTYPE,sum(isnull(ActualApplyToAmount,0)) Total_Apl
	                 from PM30300 
					 group by VCHRNMBR,DOCTYPE)  PTot on  PT.VCHRNMBR = PTot.VCHRNMBR and PT.DOCTYPE = PTot.DOCTYPE
					 -- where pt.vendorid='000257'
WHERE PT.VOIDED = 0
union all
SELECT 	1 								COPIA
	,PT.vendorid 						VENDORID
	,PP.VENDNAME						VENDNAME
	,ISNULL(PA.APTVCHNM,PT.VCHRNMBR)	VOUCHER
	,PT.VCHRNMBR						VCHR_ORI
	,PA.VCHRNMBR						VCHR_JOINT
	,PT.DOCNUMBR						NUMERO_DOC
	,PT.DOCDATE							FECHA_DOC
	,PT.DOCTYPE							TIPO_DOC
	,DT.DOCTYNAM						TIPO_DESC
	,PT.DOCAMNT			
	,PA.ActualApplyToAmount
	--,Total_Apl
	,CASE  PT.DOCTYPE 	
		WHEN 1 THEN  PT.DOCAMNT			
		WHEN 2 THEN  PT.DOCAMNT			
		WHEN 3 THEN  PT.DOCAMNT	
        ELSE 0
		END								MONTO
	,PA.VCHRNMBR						VCHR_PAGO
	,PA.DOCDATE							FECHA_PAGO
	,PA.doctype							TIPODOC_PAGO
	,CASE  PT.DOCTYPE 	
		WHEN 1 THEN 0
		WHEN 2 THEN  0
		WHEN 3 THEN  0
	    else CASE PA.ActualApplyToAmount WHEN 0    THEN PT.DOCAMNT	 - isnull(Total_Apl,0)
		                                 WHEN NULL THEN PT.DOCAMNT	 - isnull(Total_Apl,0)
									     ELSE PA.ActualApplyToAmount	
									     END		
		end MONTO_APLICADO
	,APTVCHNM							APTVCHNM
	,APTODCTY							APTODCTY
	,isnull(Total_Apl,0)  Total_Apl
FROM dbo. PM20000 PT
	join dbo.PM00200 PP on  PP.VENDORID = PT.VENDORID
	join dbo.PM40102 DT on DT.DOCTYPE = PT.DOCTYPE
	left outer join dbo.PM10200   PA on  PT.VCHRNMBR = PA.VCHRNMBR and PT.DOCTYPE = PA.DOCTYPE
	left outer join (select VCHRNMBR,DOCTYPE,sum(isnull(ActualApplyToAmount,0)) Total_Apl
	                 from PM10200 
					 group by VCHRNMBR,DOCTYPE)  PTot on  PT.VCHRNMBR = PTot.VCHRNMBR and PT.DOCTYPE = PTot.DOCTYPE
WHERE PT.VOIDED = 0

GO