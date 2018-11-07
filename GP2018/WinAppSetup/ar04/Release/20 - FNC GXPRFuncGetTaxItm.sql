GO
/****** Object:  UserDefinedFunction [dbo].[GXPRFuncGetTaxItm]    Script Date: 16/08/2018 11:57:20 ******/
SET ANSI_NULLS ON
GO

if exists (select * from dbo.sysobjects where name = 'GXPRFuncGetTaxItm' and type = 'FN') 
	
DROP FUNCTION GXPRFuncGetTaxItm
GO

SET QUOTED_IDENTIFIER ON
GO




CREATE FUNCTION [dbo].[GXPRFuncGetTaxItm] (@INSopType smallint
		 							      ,@INSopNumbe CHAR(21)
									      ,@INLnItmSeq CHAR(15))
RETURNS decimal(10,2)
AS
BEGIN
	DECLARE @TaxImport decimal(10,2)
	SELECT @TaxImport=SUM(convert(decimal(3,1),Substring(A.TAXDTLID,charindex('V-IV-',A.TAXDTLID,1)+5,6) ))
	FROM SOP10105 A
	WHERE A.SOPTYPE = @INSopType
	  AND A.SOPNUMBE = @INSopNumbe
	  AND A.TAXDTLID LIKE '%'+ rtrim('V-IV-')+'%' AND A.TAXDTLID NOT LIKE '%EXENTO%'
	  AND A.LNITMSEQ = @INLnItmSeq
RETURN (@TaxImport)
END
GO


