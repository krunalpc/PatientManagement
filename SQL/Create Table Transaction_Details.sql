USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Transaction_Details]    Script Date: 2/8/2021 7:05:36 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Transaction_Details](
	[TX_ID] [int] IDENTITY(1,1) NOT NULL,
	[PBT_ID] [int] NOT NULL,
	[Mode_Of_Payment] [varchar](6) NULL,
	[Paid_Amount] [int] NOT NULL,
	[Payment_Date] [datetime] NULL,
	[CCTXN_ID] [varchar](max) NULL,
 CONSTRAINT [PK__Transact__B6B1EEC224927208] PRIMARY KEY CLUSTERED 
(
	[TX_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Transaction_Details] ADD  CONSTRAINT [DF__Transacti__Payme__267ABA7A]  DEFAULT (getdate()) FOR [Payment_Date]
GO

ALTER TABLE [dbo].[Transaction_Details]  WITH CHECK ADD  CONSTRAINT [FK__Transacti__PBT_I__276EDEB3] FOREIGN KEY([PBT_ID])
REFERENCES [dbo].[Patient_Billing_Transaction] ([PBT_ID])
ON DELETE CASCADE
GO

ALTER TABLE [dbo].[Transaction_Details] CHECK CONSTRAINT [FK__Transacti__PBT_I__276EDEB3]
GO


