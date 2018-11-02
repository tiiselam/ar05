USE [DYNAMICS]
GO

/****** Object:  UserDefinedFunction [dbo].[fncNUMLET]    Script Date: 28/8/2018 17:01:00 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO






CREATE FUNCTION [dbo].[fncNUMLET] (@CURNCYID CHAR(15), @MONTO DECIMAL (19,5))

RETURNS VARCHAR(400)

AS

BEGIN
	DECLARE	@AMT001												INT
	DECLARE	@AMT002												INT
	DECLARE	@AMT003												INT
	DECLARE	@AMT004												INT
	DECLARE	@AMT005												INT
	DECLARE	@AMT006												INT
	DECLARE	@AMT007												INT
	DECLARE	@AMT008												INT
	DECLARE	@AMT009												INT
	DECLARE	@AMT010												INT
	DECLARE	@AMTDEC												INT
	DECLARE	@NUMLET												VARCHAR(400)
	DECLARE @NUMLE1												VARCHAR(100)
	DECLARE	@NUMLE2												VARCHAR(100)
	DECLARE	@NUMLE3												VARCHAR(100)
	DECLARE	@NUMLE4												VARCHAR(100)
	DECLARE @CURTEXT1											CHAR(30)
	DECLARE @CURTEXT2											CHAR(30)
	DECLARE @CURTEXT3											CHAR(30)

--SELECT DE NUMERO
	SELECT @CURTEXT1 = CURTEXT_1, @CURTEXT2 = CURTEXT_2, @CURTEXT3 = CURTEXT_3 FROM DYNAMICS..MC40200 WHERE CURNCYID = @CURNCYID

	SET	@MONTO											=	CONVERT ( DECIMAL (19,2) ,ROUND ( @MONTO , 2 ) )

	SELECT
		@AMT001											=	  CONVERT ( INT , ( @MONTO / 1000000000 ) )
	,	@AMT002											=	( CONVERT ( INT , ( @MONTO / 100000000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 1000000000 ) ) * 10 )
	,	@AMT003											=	( CONVERT ( INT , ( @MONTO / 10000000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 100000000 ) ) * 10 )
	,	@AMT004											= 	( CONVERT ( INT , ( @MONTO / 1000000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 10000000 ) ) * 10 )
	,	@AMT005											=	( CONVERT ( INT , ( @MONTO / 100000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 1000000 ) ) * 10 )
	,	@AMT006											=	( CONVERT ( INT , ( @MONTO / 10000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 100000 ) ) * 10 )
	,	@AMT007											=	( CONVERT ( INT , ( @MONTO / 1000 ) ) ) - ( CONVERT ( INT , ( @MONTO / 10000 ) ) * 10 )
	,	@AMT008											=	( CONVERT ( INT , ( @MONTO / 100 ) ) ) - ( CONVERT ( INT , ( @MONTO / 1000 ) ) * 10 )
	,	@AMT009											=	( CONVERT ( INT , ( @MONTO / 10 ) ) ) - ( CONVERT ( INT , ( @MONTO / 100 ) ) * 10 )
	,	@AMT010											=	( CONVERT ( INT , ( @MONTO / 1 ) ) ) - ( CONVERT ( INT , ( @MONTO / 10 ) ) * 10 )
	,	@AMTDEC											=	 CONVERT ( INT , ( ( @MONTO - CONVERT ( INT , @MONTO ) ) * 100 ) )

--- NUM A LETRAS

	SELECT
		@NUMLET											=	''

	IF	@AMT001	= 2											SELECT	@NUMLET	=	' dos'
	IF	@AMT001	= 3											SELECT	@NUMLET	=	' tres'
	IF	@AMT001	= 4											SELECT	@NUMLET	=	' cuatro'
	IF	@AMT001	= 5											SELECT	@NUMLET =	' cinco'
	IF	@AMT001	= 6											SELECT	@NUMLET =	' seis'
	IF	@AMT001	= 7											SELECT	@NUMLET =	' siete'
	IF	@AMT001	= 8											SELECT	@NUMLET =	' ocho'
	IF	@AMT001	= 9											SELECT	@NUMLET =	' nueve'
	IF	@AMT001	> 0											SELECT	@NUMLET =	@NUMLET + '  mil'

	IF	@AMT002	= 1 AND ( @AMT003 <> 0 OR @AMT004 <> 0 )	SELECT	@NUMLET = @NUMLET + ' ciento'
	IF	@AMT002 = 1 AND @AMT003 =  0 AND @AMT004 = 0		SELECT	@NUMLET = @NUMLET + ' cien'
	IF	@AMT002 = 2											SELECT	@NUMLET = @NUMLET + ' doscientos'
	IF	@AMT002 = 3											SELECT	@NUMLET = @NUMLET + ' trescientos'
	IF	@AMT002 = 4											SELECT	@NUMLET = @NUMLET + ' cuatrocientos'
	IF	@AMT002 = 5											SELECT	@NUMLET = @NUMLET + ' quinientos'
	IF	@AMT002 = 6											SELECT	@NUMLET = @NUMLET + ' seiscientos'
	IF	@AMT002 = 7											SELECT	@NUMLET = @NUMLET + ' setecientos'
	IF	@AMT002 = 8											SELECT	@NUMLET = @NUMLET + ' ochocientos'
	IF	@AMT002 = 9											SELECT	@NUMLET = @NUMLET + ' novecientos'

	IF	@AMT003 = 1 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' diez'
	IF	@AMT003 = 1 AND @AMT004 = 1									SELECT	@NUMLET = @NUMLET + ' once'
	IF	@AMT003 = 1 AND @AMT004 = 2									SELECT	@NUMLET = @NUMLET + ' doce'
	IF	@AMT003 = 1 AND @AMT004 = 3									SELECT	@NUMLET = @NUMLET + ' trece'
	IF	@AMT003 = 1 AND @AMT004 = 4									SELECT	@NUMLET = @NUMLET + ' catorce'
	IF	@AMT003 = 1 AND @AMT004 = 5									SELECT	@NUMLET = @NUMLET + ' quince'
	IF	@AMT003 = 1 AND @AMT004 = 6									SELECT	@NUMLET = @NUMLET + ' dieciseis'
	IF	@AMT003 = 1 AND @AMT004 = 7									SELECT	@NUMLET = @NUMLET + ' diecisiete'
	IF	@AMT003 = 1 AND @AMT004 = 8									SELECT	@NUMLET = @NUMLET + ' dieciocho'
	IF	@AMT003 = 1 AND @AMT004 = 9									SELECT	@NUMLET = @NUMLET + ' diecinueve'
	IF	@AMT003 = 2 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' veinte'
	IF	@AMT003 = 2 AND @AMT004 = 1									SELECT	@NUMLET = @NUMLET + ' veintiun'
	IF	@AMT003 = 2 AND @AMT004 = 2									SELECT	@NUMLET = @NUMLET + ' veintidos'
	IF	@AMT003 = 2 AND @AMT004 = 3									SELECT	@NUMLET = @NUMLET + ' veintitres'
	IF	@AMT003 = 2 AND @AMT004 = 4									SELECT	@NUMLET = @NUMLET + ' veinticuatro'
	IF	@AMT003 = 2 AND @AMT004 = 5									SELECT	@NUMLET = @NUMLET + ' veinticinco'
	IF	@AMT003 = 2 AND @AMT004 = 6									SELECT	@NUMLET = @NUMLET + ' veintiseis'
	IF	@AMT003 = 2 AND @AMT004 = 7									SELECT	@NUMLET = @NUMLET + ' veintisiete'
	IF	@AMT003 = 2 AND @AMT004 = 8									SELECT	@NUMLET = @NUMLET + ' veintiocho'
	IF	@AMT003 = 2 AND @AMT004 = 9									SELECT	@NUMLET = @NUMLET + ' veintinueve'
	IF	@AMT003 = 3 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' treinta'
	IF	@AMT003 = 3 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' treinta y'
	IF	@AMT003 = 4 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' cuarenta'
	IF	@AMT003 = 4 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' cuarenta y'
	IF	@AMT003 = 5 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' cincuenta'
	IF	@AMT003 = 5 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' cincuenta y'
	IF	@AMT003 = 6 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' sesenta'
	IF	@AMT003 = 6 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' sesenta y'
	IF	@AMT003 = 7 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' setenta'
	IF	@AMT003 = 7 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' setenta y'
	IF	@AMT003 = 8 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' ochenta'
	IF	@AMT003 = 8 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' ochenta y'
	IF	@AMT003 = 9 AND @AMT004 = 0									SELECT	@NUMLET = @NUMLET + ' noventa'
	IF	@AMT003 = 9 AND @AMT004 <> 0								SELECT	@NUMLET = @NUMLET + ' noventa y'

	IF	@AMT004 = 1 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' un'
	IF	@AMT004 = 2 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' dos'
	IF	@AMT004 = 3 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' tres'
	IF	@AMT004 = 4 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' cuatro'
	IF	@AMT004 = 5 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' cinco'
	IF	@AMT004 = 6 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' seis'
	IF	@AMT004 = 7 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' siete'
	IF	@AMT004 = 8 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' ocho'
	IF	@AMT004 = 9 AND NOT ( @AMT003 = 1 OR @AMT003 = 2 )						SELECT	@NUMLET = @NUMLET + ' nueve'

	IF	@AMT002 <> 0 OR @AMT003 <> 0										SELECT	@NUMLET = @NUMLET + ' millones'
	IF	@AMT002 = 0 AND @AMT003 = 0 AND @AMT004 > 1							SELECT	@NUMLET = @NUMLET + ' millones'
	IF	@AMT002 = 0 AND @AMT003 = 0 AND @AMT004 = 1							SELECT	@NUMLET = @NUMLET + ' millón'

	IF	@AMT005 = 1 AND ( @AMT006 <> 0 OR @AMT007 <> 0 )						SELECT	@NUMLET = @NUMLET + ' ciento'
	IF	@AMT005 = 1 AND @AMT006 =  0 AND @AMT007 = 0							SELECT	@NUMLET = @NUMLET + ' cien'
	IF	@AMT005 = 2											SELECT	@NUMLET = @NUMLET + ' doscientos'
	IF	@AMT005 = 3											SELECT	@NUMLET = @NUMLET + ' trescientos'
	IF	@AMT005 = 4											SELECT	@NUMLET = @NUMLET + ' cuatrocientos'
	IF	@AMT005 = 5											SELECT	@NUMLET = @NUMLET + ' quinientos'
	IF	@AMT005 = 6											SELECT	@NUMLET = @NUMLET + ' seiscientos'
	IF	@AMT005 = 7											SELECT	@NUMLET = @NUMLET + ' setecientos'
	IF	@AMT005 = 8											SELECT	@NUMLET = @NUMLET + ' ochocientos'
	IF	@AMT005 = 9											SELECT	@NUMLET = @NUMLET + ' novecientos'

	IF	@AMT006 = 1 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' diez'
	IF	@AMT006 = 1 AND @AMT007 = 1									SELECT	@NUMLET = @NUMLET + ' once'
	IF	@AMT006 = 1 AND @AMT007 = 2									SELECT	@NUMLET = @NUMLET + ' doce'
	IF	@AMT006 = 1 AND @AMT007 = 3									SELECT	@NUMLET = @NUMLET + ' trece'
	IF	@AMT006 = 1 AND @AMT007 = 4									SELECT	@NUMLET = @NUMLET + ' catorce'
	IF	@AMT006 = 1 AND @AMT007 = 5									SELECT	@NUMLET = @NUMLET + ' quince'
	IF	@AMT006 = 1 AND @AMT007 = 6									SELECT	@NUMLET = @NUMLET + ' dieciseis'
	IF	@AMT006 = 1 AND @AMT007 = 7									SELECT	@NUMLET = @NUMLET + ' diecisiete'
	IF	@AMT006 = 1 AND @AMT007 = 8									SELECT	@NUMLET = @NUMLET + ' dieciocho'
	IF	@AMT006 = 1 AND @AMT007 = 9									SELECT	@NUMLET = @NUMLET + ' diecinueve'
	IF	@AMT006 = 2 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' veinte'
	IF	@AMT006 = 2 AND @AMT007 = 1									SELECT	@NUMLET = @NUMLET + ' veintiuno'
	IF	@AMT006 = 2 AND @AMT007 = 2									SELECT	@NUMLET = @NUMLET + ' veintidos'
	IF	@AMT006 = 2 AND @AMT007 = 3									SELECT	@NUMLET = @NUMLET + ' veintitres'
	IF	@AMT006 = 2 AND @AMT007 = 4									SELECT	@NUMLET = @NUMLET + ' veinticuatro'
	IF	@AMT006 = 2 AND @AMT007 = 5									SELECT	@NUMLET = @NUMLET + ' veinticinco'
	IF	@AMT006 = 2 AND @AMT007 = 6									SELECT	@NUMLET = @NUMLET + ' veintiseis'
	IF	@AMT006 = 2 AND @AMT007 = 7									SELECT	@NUMLET = @NUMLET + ' veintisiete'
	IF	@AMT006 = 2 AND @AMT007 = 8									SELECT	@NUMLET = @NUMLET + ' veintiocho'
	IF	@AMT006 = 2 AND @AMT007 = 9									SELECT	@NUMLET = @NUMLET + ' veintinueve'
	IF	@AMT006 = 3 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' treinta'
	IF	@AMT006 = 3 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' treinta y'
	IF	@AMT006 = 4 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' cuarenta'
	IF	@AMT006 = 4 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' cuarenta y'
	IF	@AMT006 = 5 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' cincuenta'
	IF	@AMT006 = 5 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' cincuenta y'
	IF	@AMT006 = 6 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' sesenta'
	IF	@AMT006 = 6 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' sesenta y'
	IF	@AMT006 = 7 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' setenta'
	IF	@AMT006 = 7 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' setenta y'
	IF	@AMT006 = 8 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' ochenta'
	IF	@AMT006 = 8 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' ochenta y'
	IF	@AMT006 = 9 AND @AMT007 = 0									SELECT	@NUMLET = @NUMLET + ' noventa'
	IF	@AMT006 = 9 AND @AMT007 <> 0								SELECT	@NUMLET = @NUMLET + ' noventa y'

	IF	@AMT007 = 1 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' un'
	IF	@AMT007 = 2 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' dos'
	IF	@AMT007 = 3 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' tres'
	IF	@AMT007 = 4 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' cuatro'
	IF	@AMT007 = 5 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' cinco'
	IF	@AMT007 = 6 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' seis'
	IF	@AMT007 = 7 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' siete'
	IF	@AMT007 = 8 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' ocho'
	IF	@AMT007 = 9 AND NOT ( @AMT006 = 1 OR @AMT006 = 2 )						SELECT	@NUMLET = @NUMLET + ' nueve'

	IF	@AMT005 <> 0 OR @AMT006 <> 0 OR @AMT007 <> 0							SELECT	@NUMLET = @NUMLET + ' mil'

	IF	@AMT008 = 1 AND ( @AMT009 <> 0 OR @AMT010 <> 0 )						SELECT	@NUMLET = @NUMLET + ' ciento'
	IF	@AMT008 = 1 AND @AMT009 =  0 AND @AMT010 = 0							SELECT	@NUMLET = @NUMLET + ' cien'
	IF	@AMT008 = 2											SELECT	@NUMLET = @NUMLET + ' doscientos'
	IF	@AMT008 = 3											SELECT	@NUMLET = @NUMLET + ' trescientos'
	IF	@AMT008 = 4											SELECT	@NUMLET = @NUMLET + ' cuatrocientos'
	IF	@AMT008 = 5											SELECT	@NUMLET = @NUMLET + ' quinientos'
	IF	@AMT008 = 6											SELECT	@NUMLET = @NUMLET + ' seiscientos'
	IF	@AMT008 = 7											SELECT	@NUMLET = @NUMLET + ' setecientos'
	IF	@AMT008 = 8											SELECT	@NUMLET = @NUMLET + ' ochocientos'
	IF	@AMT008 = 9											SELECT	@NUMLET = @NUMLET + ' novecientos'

	IF	@AMT009 = 1 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' diez'
	IF	@AMT009 = 1 AND @AMT010 = 1									SELECT	@NUMLET = @NUMLET + ' once'
	IF	@AMT009 = 1 AND @AMT010 = 2									SELECT	@NUMLET = @NUMLET + ' doce'
	IF	@AMT009 = 1 AND @AMT010 = 3									SELECT	@NUMLET = @NUMLET + ' trece'
	IF	@AMT009 = 1 AND @AMT010 = 4									SELECT	@NUMLET = @NUMLET + ' catorce'
	IF	@AMT009 = 1 AND @AMT010 = 5									SELECT	@NUMLET = @NUMLET + ' quince'
	IF	@AMT009 = 1 AND @AMT010 = 6									SELECT	@NUMLET = @NUMLET + ' dieciseis'
	IF	@AMT009 = 1 AND @AMT010 = 7									SELECT	@NUMLET = @NUMLET + ' diecisiete'
	IF	@AMT009 = 1 AND @AMT010 = 8									SELECT	@NUMLET = @NUMLET + ' dieciocho'
	IF	@AMT009 = 1 AND @AMT010 = 9									SELECT	@NUMLET = @NUMLET + ' diecinueve'
	IF	@AMT009 = 2 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' veinte'
	IF	@AMT009 = 2 AND @AMT010 = 1									SELECT	@NUMLET = @NUMLET + ' veintiuno'
	IF	@AMT009 = 2 AND @AMT010 = 2									SELECT	@NUMLET = @NUMLET + ' veintidos'
	IF	@AMT009 = 2 AND @AMT010 = 3									SELECT	@NUMLET = @NUMLET + ' veintitres'
	IF	@AMT009 = 2 AND @AMT010 = 4									SELECT	@NUMLET = @NUMLET + ' veinticuatro'
	IF	@AMT009 = 2 AND @AMT010 = 5									SELECT	@NUMLET = @NUMLET + ' veinticinco'
	IF	@AMT009 = 2 AND @AMT010 = 6									SELECT	@NUMLET = @NUMLET + ' veintiseis'
	IF	@AMT009 = 2 AND @AMT010 = 7									SELECT	@NUMLET = @NUMLET + ' veintisiete'
	IF	@AMT009 = 2 AND @AMT010 = 8									SELECT	@NUMLET = @NUMLET + ' veintiocho'
	IF	@AMT009 = 2 AND @AMT010 = 9									SELECT	@NUMLET = @NUMLET + ' veintinueve'
	IF	@AMT009 = 3 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' treinta'
	IF	@AMT009 = 3 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' treinta y'
	IF	@AMT009 = 4 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' cuarenta'
	IF	@AMT009 = 4 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' cuarenta y'
	IF	@AMT009 = 5 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' cincuenta'
	IF	@AMT009 = 5 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' cincuenta y'
	IF	@AMT009 = 6 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' sesenta'
	IF	@AMT009 = 6 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' sesenta y'
	IF	@AMT009 = 7 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' setenta'
	IF	@AMT009 = 7 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' setenta y'
	IF	@AMT009 = 8 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' ochenta'
	IF	@AMT009 = 8 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' ochenta y'
	IF	@AMT009 = 9 AND @AMT010 = 0									SELECT	@NUMLET = @NUMLET + ' noventa'
	IF	@AMT009 = 9 AND @AMT010 <> 0								SELECT	@NUMLET = @NUMLET + ' noventa y'

	IF	@AMT010 = 1 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' uno'
	IF	@AMT010 = 2 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' dos'
	IF	@AMT010 = 3 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' tres'
	IF	@AMT010 = 4 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' cuatro'
	IF	@AMT010 = 5 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' cinco'
	IF	@AMT010 = 6 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' seis'
	IF	@AMT010 = 7 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' siete'
	IF	@AMT010 = 8 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' ocho'
	IF	@AMT010 = 9 AND NOT ( @AMT009 = 1 OR @AMT009 = 2 )						SELECT	@NUMLET = @NUMLET + ' nueve'

	/*SELECT	@NUMLET											=	UPPER(RTRIM(@CURTEXT1) +  ' ' + RTRIM ( LTRIM ( REPLACE ( @NUMLET , '  ' , ' ' ) ) ))*/
	SELECT	@NUMLET											=	UPPER(RTRIM ( LTRIM ( REPLACE ( @NUMLET , '  ' , ' ' ) ) ) + ' ' + RTRIM(@CURTEXT1))
															
	
	IF @AMTDEC <> 0 
	BEGIN
		SELECT @NUMLET = UPPER(@NUMLET +	' ' + LTRIM(RTRIM(@CURTEXT3)) + ' ' + CONVERT ( VARCHAR , @AMTDEC ) +	' ' + LTRIM(RTRIM(@CURTEXT2)))
	END

RETURN ( @NUMLET )
END





GO


