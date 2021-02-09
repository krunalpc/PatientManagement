USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Patient_Billing_Transaction]    Script Date: 2/8/2021 7:04:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Patient_Billing_Transaction](
	[PBT_ID] [int] IDENTITY(1,1) NOT NULL,
	[PATIENT_ID] [int] NOT NULL,
	[Total_Amount] [decimal](10, 2) NOT NULL,
	[Total_Discount] [decimal](10, 2) NOT NULL,
	[Total_Payable] [decimal](10, 2) NOT NULL,
	[Paid_Amount] [decimal](10, 2) NOT NULL,
	[Balance] [decimal](10, 2) NOT NULL,
	[Payment_Status] [varchar](25) NULL,
	[no_of_txn] [int] NULL,
	[appointment_date] [datetime] NOT NULL,
 CONSTRAINT [PK__Patient___6B3B0D6C0F975522] PRIMARY KEY CLUSTERED 
(
	[PBT_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF__Patient_B__Total__117F9D94]  DEFAULT ((0)) FOR [Total_Amount]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF__Patient_B__Total__1273C1CD]  DEFAULT ((0)) FOR [Total_Discount]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF_Patient_Billing_Transaction_Total_Payable]  DEFAULT ((0)) FOR [Total_Payable]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF__Patient_B__Paid___1367E606]  DEFAULT ((0)) FOR [Paid_Amount]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF__Patient_B__Balan__145C0A3F]  DEFAULT ((0)) FOR [Balance]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF_Patient_Billing_Transaction_Payment_Status]  DEFAULT ('Not yet billed') FOR [Payment_Status]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] ADD  CONSTRAINT [DF__Patient_B__no_of__15502E78]  DEFAULT ((0)) FOR [no_of_txn]
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction]  WITH CHECK ADD  CONSTRAINT [FK__Patient_B__PATIE__164452B1] FOREIGN KEY([PATIENT_ID])
REFERENCES [dbo].[Patient_Detail_Master] ([Patient_id])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Patient_Billing_Transaction] CHECK CONSTRAINT [FK__Patient_B__PATIE__164452B1]
GO


