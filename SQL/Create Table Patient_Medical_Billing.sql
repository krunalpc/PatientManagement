USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Patient_Medical_Billing]    Script Date: 2/8/2021 7:05:29 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Patient_Medical_Billing](
	[pbt_id] [int] NOT NULL,
	[md_id] [int] NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[discount] [decimal](10, 2) NOT NULL,
	[final_amt] [decimal](10, 2) NOT NULL
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Patient_Medical_Billing] ADD  CONSTRAINT [DF_Patient_Medical_Billing_amount]  DEFAULT ((0)) FOR [amount]
GO

ALTER TABLE [dbo].[Patient_Medical_Billing] ADD  CONSTRAINT [DF_Patient_Medical_Billing_discount]  DEFAULT ((0)) FOR [discount]
GO

ALTER TABLE [dbo].[Patient_Medical_Billing] ADD  CONSTRAINT [DF_Patient_Medical_Billing_final_amt]  DEFAULT ((0)) FOR [final_amt]
GO

ALTER TABLE [dbo].[Patient_Medical_Billing]  WITH CHECK ADD  CONSTRAINT [FK_Patient_Medical_Billing_Patient_Billing_Transaction] FOREIGN KEY([pbt_id])
REFERENCES [dbo].[Patient_Billing_Transaction] ([PBT_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Patient_Medical_Billing] CHECK CONSTRAINT [FK_Patient_Medical_Billing_Patient_Billing_Transaction]
GO


