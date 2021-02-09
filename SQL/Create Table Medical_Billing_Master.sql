USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Medical_Billing_Master]    Script Date: 2/8/2021 7:02:16 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Medical_Billing_Master](
	[md_id] [int] IDENTITY(1,1) NOT NULL,
	[medical_billing] [varchar](50) NOT NULL,
	[amount] [decimal](10, 2) NOT NULL,
	[max_discount] [int] NOT NULL,
	[discount_unit] [varchar](5) NOT NULL,
	[modality] [int] NULL,
 CONSTRAINT [PK__Medical___378474477F60ED59] PRIMARY KEY CLUSTERED 
(
	[md_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Medical_Billing_Master]  WITH CHECK ADD  CONSTRAINT [FK_Medical_Billing_Master_Modality_Slot_Details] FOREIGN KEY([modality])
REFERENCES [dbo].[Modality_Slot_Details] ([modality_id])
ON UPDATE CASCADE
ON DELETE SET NULL
GO

ALTER TABLE [dbo].[Medical_Billing_Master] CHECK CONSTRAINT [FK_Medical_Billing_Master_Modality_Slot_Details]
GO


