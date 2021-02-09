USE [SQL_PM_DEV_03]
GO

/****** Object:  StoredProcedure [dbo].[GetPatientViewAppointment]    Script Date: 2/8/2021 7:10:56 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE  PROCEDURE [dbo].[GetPatientViewAppointment]
	@dt_from varchar(20) = null,
	@dt_to varchar(20) = null,
	@status varchar(100) = null,
	@strSearch varchar(max) = null
AS
BEGIN
	Declare @strDtCriteria varchar(max)
	Declare @strStatusCriteria varchar(max)
	Declare @strSearchCriteria varchar(max)

	-- Appointment Date Criteria
	If(@dt_from is not NULL and @dt_to is not NULL)
		Set @strDtCriteria = '(b.appointment_date >= '''+@dt_from+''' and b.appointment_date <= '''+@dt_to+''')'
	Else if(@dt_from is not NULL and @dt_to is NULL)
		Set @strDtCriteria = '(b.appointment_date >= '''+@dt_from+''')'
	Else if(@dt_from is NULL and @dt_to is not NULL)
		Set @strDtCriteria = '(b.appointment_date <= '''+@dt_to+''')'
	Else
		Set @strDtCriteria = '(1=1)'

	-- Status
	If(@status is not null)
		Set @strStatusCriteria = '(b.payment_status = '''+@status+''')'
	Else
		Set @strStatusCriteria = '(1=1)'
	
	-- Common Search
	If(@strSearch is not null or @strSearch <> '')
		Set @strSearchCriteria = '([name] like ''%'+@strSearch+'%'')'
	Else
		Set @strSearchCriteria = '(1=1)'

	Declare @sql nvarchar(max), @paramDefinition nvarchar(max)
	Set @sql = 'select a.PATIENT_ID, a.name, a.age, a.gender, b.appointment_date, b.balance, b.payment_status from Patient_Detail_Master a, Patient_Billing_Transaction b where a.PATIENT_ID = b.PATIENT_ID '
	Set @sql += ' and ' + @strDtCriteria + ' and '+ @strStatusCriteria + ' and ' + @strSearchCriteria
	
	print @sql

	--Set @paramDefinition = '';
	EXECUTE sp_executesql @sql;
		
END
GO


