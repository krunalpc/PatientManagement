USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Patient_Detail_Master]    Script Date: 2/8/2021 7:05:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Patient_Detail_Master](
	[Patient_id] [int] IDENTITY(1,1) NOT NULL,
	[Salutation] [varchar](5) NULL,
	[Name] [varchar](150) NULL,
	[Gender] [varchar](10) NULL,
	[DOB] [datetime] NULL,
	[Age] [int] NULL,
	[Age_Type] [varchar](15) NULL,
	[Phone_Number] [varchar](15) NULL,
	[Address_1] [varchar](150) NULL,
	[Address_2] [varchar](150) NULL,
	[City] [varchar](15) NULL,
	[State] [varchar](15) NULL,
	[Postal] [varchar](15) NULL,
	[Country] [varchar](20) NULL,
	[Billing_details] [varchar](400) NULL,
 CONSTRAINT [PK__Patient___AA0B606809DE7BCC] PRIMARY KEY CLUSTERED 
(
	[Patient_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


