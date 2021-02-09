USE [SQL_PM_DEV_03]
GO

/****** Object:  StoredProcedure [dbo].[InsertTransaction_Details]    Script Date: 2/8/2021 7:11:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


-- =============================================  
-- Author:      Krunal Panchal  
-- Create date: 7-Feb-2021  
-- Description: To create a new SP
-- =============================================  
CREATE PROCEDURE [dbo].[InsertTransaction_Details]
	@PBT_ID int,
	@Paid_Amount decimal(10,2),
	@Mode_Of_Payment varchar(6),  
	@CCTXN_ID varchar(max),  
	@Status int OUT
AS  
BEGIN  
	Set NOCOUNT ON;
	
	Begin Try
		Declare @last_paid_amt decimal(10,2);
		Declare @last_bal decimal(10,2);
		Declare @tot_payable decimal(10,2);
		Declare @flg_ins int;
		Declare @ctrTrans int;
		Declare @Bal_per real;
		Declare @payment_status varchar(20);
		Set @last_paid_amt = 0;
		Set @last_bal = 0;
		Set @flg_ins = 0;
		Set @Status = 0;

		Begin Transaction
		-- Check if Payment done is atleast 20% of bal.
		Select @tot_payable = Total_Payable, @last_paid_amt = paid_amount, @last_bal = balance, @ctrTrans = no_of_txn from Patient_Billing_Transaction where  pbt_id = @PBT_ID	
		
		If (@ctrTrans <= 1) -- Allowed to pay 20%
		Begin
			Set @Bal_per = (@Paid_Amount/@tot_payable)*100;

			If (@Bal_per < 20)
				Begin
					Set @Status = 1 -- Bal amount is less than 20%.
					GOTO QuitWithRollback
				End
			Else
				Begin
					Set @flg_ins = 1;
				End
		End
		Else -- Ask to Pay Full Balance
		Begin
			If(@Paid_Amount < @last_bal)
				Begin
					Set @Status = 2 -- Last transaction, you have to pay full
					GOTO QuitWithRollback
				End
			Else
				Begin
					Set @flg_ins = 1;
				End
		End

		print @flg_ins ;

		if(@flg_ins = 0)
		Begin
			Set @Status = 3 -- 20% criteria not satisfying
			GOTO QuitWithRollback
		End


			-- Ins Transaction Details
			INSERT INTO Transaction_Details 
				(PBT_ID, Paid_Amount, Mode_Of_Payment, Payment_Date, CCTXN_ID) 
			VALUES
				(@PBT_ID, @Paid_Amount, @Mode_Of_Payment, getdate(), @CCTXN_ID);
	
			-- Update Balance & # of Trans. in Patient_Billing_Transaction
		

			Set @last_paid_amt += @Paid_Amount; 
			Set @last_bal = (@tot_payable - @last_paid_amt);

			If (@last_bal <= 0)
				Set @payment_status = 'Fully Billed';
			Else
				Set @payment_status = 'Due Billed';

			Update Patient_Billing_Transaction set Paid_Amount = @last_paid_amt,  Balance = @last_bal, no_of_txn = no_of_txn+1, payment_status = @payment_status where pbt_id = @PBT_ID
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


