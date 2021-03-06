/****** Object:  Database shopDb    Script Date: 9/9/2001 10:37:42 PM ******/
CREATE DATABASE [shopDb]  ON (NAME = N'shopDb_dat', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL\data\shopDb.mdf' , SIZE = 2, FILEGROWTH = 10%) LOG ON (NAME = N'shopDb_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL\data\shopDb.ldf' , SIZE = 2, FILEGROWTH = 10%)
GO

exec sp_dboption N'shopDb', N'autoclose', N'false'
GO

exec sp_dboption N'shopDb', N'bulkcopy', N'true'
GO

exec sp_dboption N'shopDb', N'trunc. log', N'true'
GO

exec sp_dboption N'shopDb', N'torn page detection', N'true'
GO

exec sp_dboption N'shopDb', N'read only', N'false'
GO

exec sp_dboption N'shopDb', N'dbo use', N'false'
GO

exec sp_dboption N'shopDb', N'single', N'false'
GO

exec sp_dboption N'shopDb', N'autoshrink', N'false'
GO

exec sp_dboption N'shopDb', N'ANSI null default', N'false'
GO

exec sp_dboption N'shopDb', N'recursive triggers', N'false'
GO

exec sp_dboption N'shopDb', N'ANSI nulls', N'false'
GO

exec sp_dboption N'shopDb', N'concat null yields null', N'false'
GO

exec sp_dboption N'shopDb', N'cursor close on commit', N'false'
GO

exec sp_dboption N'shopDb', N'default to local cursor', N'false'
GO

exec sp_dboption N'shopDb', N'quoted identifier', N'false'
GO

exec sp_dboption N'shopDb', N'ANSI warnings', N'false'
GO

exec sp_dboption N'shopDb', N'auto create statistics', N'true'
GO

exec sp_dboption N'shopDb', N'auto update statistics', N'true'
GO

use [shopDb]
GO

/****** Object:  Table [dbo].[Categories]    Script Date: 9/9/2001 10:37:54 PM ******/
CREATE TABLE [dbo].[Categories] (
	[CAT_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[CAT_Name] [nvarchar] (50) NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Customers]    Script Date: 9/9/2001 10:37:56 PM ******/
CREATE TABLE [dbo].[Customers] (
	[CT_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[CT_FirstName] [nvarchar] (20) NULL ,
	[CT_LastName] [nvarchar] (80) NULL ,
	[CT_Email] [nvarchar] (75) NULL ,
	[CT_Password] [nvarchar] (6) NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Results]    Script Date: 9/9/2001 10:37:57 PM ******/
CREATE TABLE [dbo].[Results] (
	[BK_Author] [nvarchar] (80) NULL ,
	[BK_Description] [nvarchar] (255) NULL ,
	[BK_ImagePath] [nvarchar] (50) NULL ,
	[BK_ISBN] [nvarchar] (15) NULL ,
	[BK_Price] [money] NULL ,
	[BK_Title] [nvarchar] (75) NULL ,
	[CAT_ID] [int] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Books]    Script Date: 9/9/2001 10:37:57 PM ******/
CREATE TABLE [dbo].[Books] (
	[BK_ISBN] [char] (15) NOT NULL ,
	[BK_Author] [nvarchar] (80) NULL ,
	[BK_Price] [money] NULL ,
	[BK_Title] [nvarchar] (75) NULL ,
	[BK_Description] [nvarchar] (255) NULL ,
	[CAT_ID] [int] NULL ,
	[BK_ImagePath] [nvarchar] (50) NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[Orders]    Script Date: 9/9/2001 10:37:58 PM ******/
CREATE TABLE [dbo].[Orders] (
	[OR_ID] [int] IDENTITY (1, 1) NOT NULL ,
	[CT_ID] [int] NOT NULL ,
	[OR_Date] [smalldatetime] NULL ,
	[OR_ShipDate] [smalldatetime] NULL 
) ON [PRIMARY]
GO

/****** Object:  Table [dbo].[BookOrders]    Script Date: 9/9/2001 10:37:59 PM ******/
CREATE TABLE [dbo].[BookOrders] (
	[OR_ID] [int] NOT NULL ,
	[BK_ISBN] [char] (15) NOT NULL ,
	[BKOR_Quantity] [int] NULL ,
	[BKOR_Price] [money] NULL 
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Categories] WITH NOCHECK ADD 
	CONSTRAINT [PK_Categories] PRIMARY KEY  CLUSTERED 
	(
		[CAT_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Customers] WITH NOCHECK ADD 
	CONSTRAINT [PK_Customers] PRIMARY KEY  CLUSTERED 
	(
		[CT_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Books] WITH NOCHECK ADD 
	CONSTRAINT [PK_Books] PRIMARY KEY  CLUSTERED 
	(
		[BK_ISBN]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Orders] WITH NOCHECK ADD 
	CONSTRAINT [PK_Orders] PRIMARY KEY  CLUSTERED 
	(
		[OR_ID]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[BookOrders] WITH NOCHECK ADD 
	CONSTRAINT [PK_BookOrders] PRIMARY KEY  CLUSTERED 
	(
		[OR_ID],
		[BK_ISBN]
	)  ON [PRIMARY] 
GO

ALTER TABLE [dbo].[Books] ADD 
	CONSTRAINT [FK_Books_Categories] FOREIGN KEY 
	(
		[CAT_ID]
	) REFERENCES [dbo].[Categories] (
		[CAT_ID]
	)
GO

ALTER TABLE [dbo].[Orders] ADD 
	CONSTRAINT [FK_Orders_Customers] FOREIGN KEY 
	(
		[CT_ID]
	) REFERENCES [dbo].[Customers] (
		[CT_ID]
	)
GO

ALTER TABLE [dbo].[BookOrders] ADD 
	CONSTRAINT [FK_BookOrders_Books] FOREIGN KEY 
	(
		[BK_ISBN]
	) REFERENCES [dbo].[Books] (
		[BK_ISBN]
	),
	CONSTRAINT [FK_BookOrders_Orders] FOREIGN KEY 
	(
		[OR_ID]
	) REFERENCES [dbo].[Orders] (
		[OR_ID]
	)
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.OrderBook    Script Date: 9/9/2001 10:37:59 PM ******/


create  Procedure OrderBook
(
    @CT_ID int,
    @BK_ISBN int,
    @BKOR_Quantity int,
    @BKOR_Price money	
    
)
AS

declare @OR_Date datetime
declare @OR_ShipDate datetime
declare @OR_ID int


select @OR_Date = getdate()
select @OR_ShipDate = getdate()

begin tran NewBook


INSERT INTO Orders
(
    CT_ID, 
    OR_Date, 
    OR_ShipDate
)
VALUES
(   
    @CT_ID, 
    @OR_Date, 
    @OR_ShipDate 
)

SELECT @OR_ID = @@Identity 
   

INSERT INTO BookOrders
(
    OR_ID, 
    BK_ISBN, 
    BKOR_Quantity, 
    BKOR_Price
)
VALUES
(
	@OR_ID,
	@BK_ISBN,
	@BKOR_Quantity,
	@BKOR_Price
)


commit tran NewBook




GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminAddCat    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminAddCat
	(@CAT_Name 	nvarchar(50))

AS


 INSERT INTO Categories 
	 (CAT_Name) 
 
VALUES 
	( @CAT_Name)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminAddCustomer    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminAddCustomer
	(@CT_FirstName 	nvarchar(20),
	 @CT_LastName 	nvarchar(50),
	 @CT_Email 	nvarchar(75),
	 @CT_Password 	nvarchar(6))

AS INSERT INTO  Customers 
	 ( CT_FirstName,
	 CT_LastName,
	 CT_Email,
	 CT_Password) 
 
VALUES 
	( @CT_FirstName,
	 @CT_LastName,
	 @CT_Email,
	 @CT_Password)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminDeleteCat    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminDeleteCat
	(@CAT_ID 	int)

AS 

DELETE FROM Categories 

WHERE 
	( CAT_ID  = @CAT_ID)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminDeleteCustomer    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminDeleteCustomer
	(@CT_ID 	int)

AS 

DELETE FROM Customers

WHERE 
	( CT_ID	 = @CT_ID)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminUpdateCat    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminUpdateCat
	(@CAT_ID 	int,
	 @CAT_Name 	nvarchar(50))

AS 


UPDATE Categories 

SET  CAT_Name	 = @CAT_Name 

WHERE 
	( CAT_ID	 = @CAT_ID)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminUpdateCustomer    Script Date: 9/9/2001 10:37:59 PM ******/

CREATE PROCEDURE AdminUpdateCustomer
	(@CT_ID 	int,
	 @CT_FirstName 	nvarchar(20),
	 @CT_LastName 	nvarchar(50),
	 @CT_Email 	nvarchar(75),
	 @CT_Password 	nvarchar(6))

AS 

UPDATE Customers 

SET 
	 CT_FirstName	 = @CT_FirstName,
	 CT_LastName	 = @CT_LastName,
	 CT_Email	 = @CT_Email,
	 CT_Password	 = @CT_Password 

WHERE 
	( CT_ID	 = @CT_ID)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AllCustById    Script Date: 9/9/2001 10:38:00 PM ******/

CREATE PROC AllCustById

	@CT_ID int

AS


SELECT *
FROM customers
WHERE CT_ID = @CT_ID
 


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetAllCat    Script Date: 9/9/2001 10:38:00 PM ******/

CREATE PROC GetAllCat

AS

SELECT * FROM Categories



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.LoginCustomers    Script Date: 9/9/2001 10:38:00 PM ******/

create proc LoginCustomers
	@CT_Email nvarchar(75),
	@CT_Password nvarchar(6)

as

SELECT [CT_ID]
FROM Customers
WHERE CT_Email = @CT_Email And CT_Password = @CT_Password



GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminAddBook    Script Date: 9/9/2001 10:38:00 PM ******/

CREATE PROCEDURE AdminAddBook
	(@BK_ISBN 	char(15),
	 @BK_Author 	char(80),
	 @BK_Price 	money,
	 @BK_Title 	char(75),
	 @BK_Description 	char(255),
	 @BK_ImagePath char(50),
	 @CAT_ID 	int)

AS 

INSERT INTO Books 
	 ( [BK_ISBN],
	 [BK_Author],
	 [BK_Price],
	 [BK_Title],
	 [BK_Description],
	 [BK_ImagePath],
	 [CAT_ID]) 
 
VALUES 
	( @BK_ISBN,
	 @BK_Author,
	 @BK_Price,
	 @BK_Title,
	 @BK_Description,
	 @BK_ImagePath,
	 @CAT_ID)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminRemoveBook    Script Date: 9/9/2001 10:38:00 PM ******/


create  PROCEDURE AdminRemoveBook
	(@BK_ISBN 	char(15) )

AS

DELETE FROM Books

WHERE 
	( BK_ISBN	 = @BK_ISBN )


GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.AdminUpdateBook    Script Date: 9/9/2001 10:38:00 PM ******/


CREATE  PROCEDURE [AdminUpdateBook]
	( @BK_ISBN 	char(15),
	 @BK_Author 	char(90),
	 @BK_Price 	money,
	 @BK_Title 	char(150),
	 @BK_Description 	char(255),
	 @BK_ImagePath char(50),
	 @CAT_ID int
	)

AS 

UPDATE Books


SET 
		BK_Author	 = @BK_Author,
	 	BK_Price	 = @BK_Price,
	 	BK_Title	 = @BK_Title,
	 	BK_Description	 = @BK_Description,
		BK_ImagePath = @BK_ImagePath,
		CAT_ID = @CAT_ID
	
WHERE 
	( BK_ISBN	 = @BK_ISBN)

GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetAllBooks    Script Date: 9/9/2001 10:38:00 PM ******/


CREATE  PROCEDURE GetAllBooks

AS

SELECT BK_ISBN isbn,category.CAT_Name "name", category.CAT_ID "id", BK_ImagePath imgSrc, BK_author author, BK_Price price, BK_Title title, BK_Description "description"
FROM Books book inner Join Categories category
on book.CAT_ID = category.CAT_ID

ORDER BY "name"





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

SET QUOTED_IDENTIFIER ON 
GO
SET ANSI_NULLS ON 
GO

/****** Object:  Stored Procedure dbo.GetAllBooksbyCat    Script Date: 9/9/2001 10:38:00 PM ******/


CREATE  PROCEDURE GetAllBooksbyCat


	@CAT_ID int
AS

SELECT BK_ISBN isbn,category.CAT_Name "name", category.CAT_ID "id", BK_ImagePath imgSrc, BK_author author, BK_Price price, BK_Title title, BK_Description "description"
FROM Books book inner Join Categories category
on book.CAT_ID = category.CAT_ID
WHERE book.CAT_ID = @CAT_ID 
ORDER BY "name"





GO

SET QUOTED_IDENTIFIER OFF 
GO
SET ANSI_NULLS ON 
GO

