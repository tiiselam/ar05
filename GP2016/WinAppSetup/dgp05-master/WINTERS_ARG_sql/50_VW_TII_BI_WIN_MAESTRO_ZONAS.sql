USE [PRD01]
GO

/****** Object:  View [dbo].[TII_BI_WIN_MAESTRO_ZONAS]    Script Date: 28/8/2018 15:18:44 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE VIEW [dbo].[TII_BI_WIN_MAESTRO_ZONAS] as
select * 
from RM00303 
where salsterr in('W06','W07','W08','W09','W10','WH0')
GO


