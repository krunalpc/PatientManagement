USE [SQL_PM_DEV_03]
GO

/****** Object:  Table [dbo].[Modality_Slot_Details]    Script Date: 2/8/2021 7:04:09 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Modality_Slot_Details](
	[modality_id] [int] IDENTITY(1,1) NOT NULL,
	[modality] [varchar](20) NOT NULL,
	[No_Of_Slots_Per_Day] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[modality_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO


