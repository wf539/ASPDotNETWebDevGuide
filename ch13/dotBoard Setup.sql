CREATE TABLE [dbo].[Board] (
	[BoardID] [int] IDENTITY (1, 1) NOT NULL ,
	[BoardName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[BoardDescription] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Posts] (
	[PostID] [int] IDENTITY (1, 1) NOT NULL ,
	[PostSubject] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[PostBody] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CreatorID] [int] NOT NULL ,
	[ThreadID] [int] NOT NULL ,
	[PostDate] [datetime] NOT NULL DEFAULT getDate()
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

CREATE TABLE [dbo].[Threads] (
	[ThreadID] [int] IDENTITY (1, 1) NOT NULL ,
	[ThreadSubject] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[CreatorID] [int] NOT NULL ,
	[BoardID] [int] NOT NULL 
) ON [PRIMARY]
GO

CREATE TABLE [dbo].[Users] (
	[UserID] [int] IDENTITY (1, 1) NOT NULL ,
	[Username] [varchar] (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[FirstName] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[LastName] [varchar] (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[Email] [varchar] (255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
	[IsAdmin] [bit] NOT NULL ,
	[IsBanned] [bit] NOT NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Board] WITH NOCHECK ADD 
	CONSTRAINT [PK_Board] PRIMARY KEY  CLUSTERED 
	(
		[BoardID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Posts] WITH NOCHECK ADD 
	CONSTRAINT [PK_Posts] PRIMARY KEY  CLUSTERED 
	(
		[PostID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Threads] WITH NOCHECK ADD 
	CONSTRAINT [PK_Threads] PRIMARY KEY  CLUSTERED 
	(
		[ThreadID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
	CONSTRAINT [PK_Users] PRIMARY KEY  CLUSTERED 
	(
		[UserID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Users] WITH NOCHECK ADD 
	CONSTRAINT [DF_Users_IsAdmin] DEFAULT (0) FOR [IsAdmin],
	CONSTRAINT [DF_Users_IsBanned] DEFAULT (0) FOR [IsBanned]
GO


ALTER TABLE [dbo].[Posts] ADD 
	CONSTRAINT [FK_Posts_Threads] FOREIGN KEY 
	(
		[ThreadID]
	) REFERENCES [dbo].[Threads] (
		[ThreadID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_Posts_Users] FOREIGN KEY 
	(
		[CreatorID]
	) REFERENCES [dbo].[Users] (
		[UserID]
	)
GO

ALTER TABLE [dbo].[Threads] ADD 
	CONSTRAINT [FK_Threads_Board] FOREIGN KEY 
	(
		[BoardID]
	) REFERENCES [dbo].[Board] (
		[BoardID]
	) ON DELETE CASCADE  ON UPDATE CASCADE ,
	CONSTRAINT [FK_Threads_Users] FOREIGN KEY 
	(
		[CreatorID]
	) REFERENCES [dbo].[Users] (
		[UserID]
	)
GO

