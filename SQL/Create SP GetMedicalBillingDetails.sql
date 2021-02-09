USE [SQL_PM_DEV_03]
GO

/****** Object:  StoredProcedure [dbo].[GetMedicalBillingDetails]    Script Date: 2/8/2021 7:10:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE  PROCEDURE [dbo].[GetMedicalBillingDetails]

AS
	BEGIN
	SELECT * FROM Medical_Billing_Master 
END
GO


