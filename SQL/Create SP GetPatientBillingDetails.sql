USE [SQL_PM_DEV_03]
GO

/****** Object:  StoredProcedure [dbo].[GetPatientBillingDetails]    Script Date: 2/8/2021 7:10:39 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:      Krunal Panchal 
-- Create date: 8-Feb-2021
-- =============================================  
CREATE PROCEDURE [dbo].[GetPatientBillingDetails]  
    -- Add the parameters for the stored procedure here  
    @patient_id int
      
AS  
BEGIN  
    -- SET NOCOUNT ON added to prevent extra result sets from  
    -- interfering with SELECT statements.  
    SET NOCOUNT ON;  
  
	;with base as (
	select a.PATIENT_ID, a.name, a.age, a.gender, 
	b.total_amount, b.total_discount, b.paid_amount as b_paid_amount, b.balance,  b.appointment_date,
	c.TX_ID, c.payment_date, c.paid_amount, c.mode_of_payment
	from Patient_Detail_Master a, Patient_Billing_Transaction b, Transaction_Details c
	where a.PATIENT_ID = b.PATIENT_ID 
	and b.pbt_id = c.pbt_id 
	) 
	select top 10 * from base where patient_id =@patient_id; 
          
END  
GO


