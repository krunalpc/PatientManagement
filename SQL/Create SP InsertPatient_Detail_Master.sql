USE [SQL_PM_DEV_03]
GO

/****** Object:  StoredProcedure [dbo].[InsertPatient_Detail_Master]    Script Date: 2/8/2021 7:11:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



-- =============================================  
-- Author:      Krunal Panchal  
-- Create date: 7-Feb-2021  
-- Description: To create a new SP
-- =============================================  
CREATE PROCEDURE [dbo].[InsertPatient_Detail_Master]
	@Salutation varchar(5),  
	@Name varchar(150),  
	@Gender varchar(10),
	@DOB DATETIME,  
	@Age int,  
	@Age_Type varchar(15),
	@Phone_Number varchar(15),
	@Appointment_Date DATETIME,
	@Address_1 varchar(150),  
	@Address_2 varchar(150),
	@City varchar(15),
	@State varchar(15),  
	@Postal varchar(15),  
	@Country varchar(20),
	@billing_details varchar(400),
	@scan_dtls xml = null,
	@Status int OUT
AS  
BEGIN  
	Set NOCOUNT ON;
	Set @Status = 0;

	Begin Try
		Declare @xml_hndl int;
		Declare @patient_id int;
		Declare @pbt_id int;

		Begin Transaction
		-- Insert Patient Details
		If Exists(Select [Name] from [Patient_Detail_Master] where [Name] = @Name)
			Begin
				Set @Status = 1 -- Patient already Exists.
				GOTO QuitWithRollback
			End
		Else
			Begin		
			INSERT INTO [Patient_Detail_Master]
			   ([Salutation],[Name],[Gender],[DOB],[Age],[Age_Type],[Phone_Number],[Address_1],[Address_2],[City],[State],[Postal],[Country],[Billing_details])
			VALUES
			   (@Salutation, @Name, @Gender, @DOB, @Age, @Age_Type, @Phone_Number, @Address_1, @Address_2, @City, @State, @Postal, @Country, @billing_details)
		
			Set @patient_id = SCOPE_IDENTITY();


			-- Medical SCan Details 
			-- 1. Check if Apointment SLots are open
			-- 2. Ins PAtient Billing Trans. (Master)
			-- 3. Ins PAtient Medical Billing - (details)
			-- 4. Upd Patient Billing Trans. (Master)
			
			-- 2. Insert Patient Billing Transaction (Master)
			INSERT INTO [Patient_Billing_Transaction] ([PATIENT_ID],[appointment_date]) VALUES (@patient_id, @Appointment_Date)
			Set @pbt_id = SCOPE_IDENTITY();
			
			-- Iterate thru Scan records
			Declare @scan_md_id int
			Declare @scan_amt decimal(10,2)
			Declare @scan_discount decimal(10,2) 
			Declare @scan_tot_amt decimal(10,2)
			Declare @scan_finaltot decimal(10,2)
			Declare @scan_tot_discount decimal(10,2)
			Declare @scan_final_amt decimal(10,2)
			Declare @max_ctr_slot int;
			Declare @ctr_slot int;
			Declare @flg_Slot int;
			Set @scan_tot_amt = 0;
			Set @scan_finaltot = 0;
			Set @scan_tot_discount = 0;
			Set @scan_final_amt = 0;
			Set @flg_slot = 0;
			Set @ctr_slot = 0;

			exec sp_xml_preparedocument @xml_hndl OUTPUT, @scan_dtls 
	
			DECLARE xml_cursor CURSOR FOR 
			SELECT md_id FROM OPENXML(@xml_hndl, '/Scans/Scan', 3)
			With
			(
				md_id int
			) x;

			-- Check if Apointment SLots are open
			OPEN xml_cursor;
			FETCH NEXT FROM xml_cursor 
			INTO @scan_md_id;
			WHILE @@FETCH_STATUS = 0
			BEGIN

				Select @max_ctr_slot = No_Of_Slots_Per_Day from Modality_Slot_Details where modality_id = @scan_md_id;
				Select @ctr_slot = count(md_id) from Patient_Billing_Transaction T1 Join Patient_Medical_Billing T2 on T1.pbt_id = t2.pbt_id where appointment_date = @Appointment_Date and md_id = @scan_md_id

				if (@ctr_slot >= @max_ctr_slot)
					Set @flg_Slot = 1
			
			FETCH NEXT FROM xml_cursor 
			INTO @scan_md_id;
			END
			CLOSE xml_cursor;
			DEALLOCATE xml_cursor;

			If(@flg_Slot = 1)
			Begin
				Set @Status = 2 -- Slot not available.
				GOTO QuitWithRollback
			End
			Else
			Begin
				
				DECLARE xml_curr CURSOR FOR 
				SELECT md_id, Cast(amount as decimal(10,2)), Cast(discount as decimal(10,2)), Cast(total_amount as decimal(10,2)) FROM OPENXML(@xml_hndl, '/Scans/Scan', 3)
				With
				(
					md_id int,
					amount decimal(10,2),
					discount decimal(10,2),
					total_amount decimal(10,2)
				)x;

				OPEN xml_curr;
				FETCH NEXT FROM xml_curr 
				INTO @scan_md_id, @scan_amt, @scan_discount, @scan_tot_amt;
				WHILE @@FETCH_STATUS = 0
				BEGIN

				--Ins Patient Medical Billing - (details)
				INSERT INTO [Patient_Medical_Billing] ([pbt_id],[md_id],[amount],[discount],[final_amt]) VALUES (@pbt_id, @scan_md_id, @scan_amt, @scan_discount,@scan_tot_amt)

				Set @scan_finaltot += @scan_amt;
				Set @scan_tot_discount += @scan_discount;
				Set @scan_final_amt += @scan_tot_amt;

				FETCH NEXT FROM xml_curr 
				INTO @scan_md_id, @scan_amt, @scan_discount, @scan_tot_amt;
				END
				CLOSE xml_curr;
				DEALLOCATE xml_curr;

				-- Update [Patient_Billing_Transaction]
				Update [Patient_Billing_Transaction] set total_amount = @scan_finaltot, total_discount = @scan_tot_discount, Total_Payable =  @scan_final_amt, Balance =  @scan_final_amt where pbt_id = @pbt_id

			End

				
			--	exec sp_xml_removedocument  @xml_hndl;
		End -- If Exists Patient Details

		Commit Transaction
		GOTO EndSave
	End Try
	Begin Catch		
		If @@ERROR <> 0 GOTO QuitWithRollback
	End Catch

	QuitWithRollback:
		IF (@@TRANCOUNT > 0)
		Begin
			ROLLBACK TRANSACTION
		End
		Return @status
     
	EndSave:	
		Set @status = 0	-- Success
		Return @status

	END
GO


