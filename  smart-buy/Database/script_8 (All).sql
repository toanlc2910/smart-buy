USE [master]
GO
/****** Object:  Database [SmartBuy]    Script Date: 04/05/2014 00:22:46 ******/
CREATE DATABASE [SmartBuy] ON  PRIMARY 
( NAME = N'SmartBuy', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER2008\MSSQL\DATA\SmartBuy.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'SmartBuy_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL10_50.SQLSERVER2008\MSSQL\DATA\SmartBuy_log.ldf' , SIZE = 2560KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [SmartBuy] SET COMPATIBILITY_LEVEL = 100
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [SmartBuy].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [SmartBuy] SET ANSI_NULL_DEFAULT OFF
GO
ALTER DATABASE [SmartBuy] SET ANSI_NULLS OFF
GO
ALTER DATABASE [SmartBuy] SET ANSI_PADDING OFF
GO
ALTER DATABASE [SmartBuy] SET ANSI_WARNINGS OFF
GO
ALTER DATABASE [SmartBuy] SET ARITHABORT OFF
GO
ALTER DATABASE [SmartBuy] SET AUTO_CLOSE OFF
GO
ALTER DATABASE [SmartBuy] SET AUTO_CREATE_STATISTICS ON
GO
ALTER DATABASE [SmartBuy] SET AUTO_SHRINK OFF
GO
ALTER DATABASE [SmartBuy] SET AUTO_UPDATE_STATISTICS ON
GO
ALTER DATABASE [SmartBuy] SET CURSOR_CLOSE_ON_COMMIT OFF
GO
ALTER DATABASE [SmartBuy] SET CURSOR_DEFAULT  GLOBAL
GO
ALTER DATABASE [SmartBuy] SET CONCAT_NULL_YIELDS_NULL OFF
GO
ALTER DATABASE [SmartBuy] SET NUMERIC_ROUNDABORT OFF
GO
ALTER DATABASE [SmartBuy] SET QUOTED_IDENTIFIER OFF
GO
ALTER DATABASE [SmartBuy] SET RECURSIVE_TRIGGERS OFF
GO
ALTER DATABASE [SmartBuy] SET  DISABLE_BROKER
GO
ALTER DATABASE [SmartBuy] SET AUTO_UPDATE_STATISTICS_ASYNC OFF
GO
ALTER DATABASE [SmartBuy] SET DATE_CORRELATION_OPTIMIZATION OFF
GO
ALTER DATABASE [SmartBuy] SET TRUSTWORTHY OFF
GO
ALTER DATABASE [SmartBuy] SET ALLOW_SNAPSHOT_ISOLATION OFF
GO
ALTER DATABASE [SmartBuy] SET PARAMETERIZATION SIMPLE
GO
ALTER DATABASE [SmartBuy] SET READ_COMMITTED_SNAPSHOT OFF
GO
ALTER DATABASE [SmartBuy] SET HONOR_BROKER_PRIORITY OFF
GO
ALTER DATABASE [SmartBuy] SET  READ_WRITE
GO
ALTER DATABASE [SmartBuy] SET RECOVERY FULL
GO
ALTER DATABASE [SmartBuy] SET  MULTI_USER
GO
ALTER DATABASE [SmartBuy] SET PAGE_VERIFY CHECKSUM
GO
ALTER DATABASE [SmartBuy] SET DB_CHAINING OFF
GO
EXEC sys.sp_db_vardecimal_storage_format N'SmartBuy', N'ON'
GO
USE [SmartBuy]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Market]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Market](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NULL,
	[Latitude] [float] NULL,
	[Longitude] [float] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogFile]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[LogFile](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FileName] [varchar](200) NULL,
	[CreatedTime] [datetime] NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_LogFile] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Product]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](300) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParseInfo]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParseInfo](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MarketId] [int] NULL,
	[ParseLink] [nvarchar](500) NOT NULL,
	[ProductNameXpath] [nvarchar](300) NULL,
	[PriceXpath] [nvarchar](300) NULL,
	[PagingXpath] [nvarchar](300) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ParseInfo] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MarketDistance]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MarketDistance](
	[FromMarket] [int] NOT NULL,
	[ToMarket] [int] NOT NULL,
	[Distance] [float] NULL,
 CONSTRAINT [PK_MarketDistance] PRIMARY KEY CLUSTERED 
(
	[FromMarket] ASC,
	[ToMarket] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductAttribute]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductAttribute](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[MinPrice] [int] NULL,
	[MaxPrice] [int] NULL,
	[LastUpdatedTime] [datetime] NULL,
 CONSTRAINT [PK_ProductAttribute] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Dictionary]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Dictionary](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](300) NULL,
	[ProductId] [int] NULL,
 CONSTRAINT [PK_Dictionary] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[Username] [varchar](50) NOT NULL,
	[Password] [varchar](20) NOT NULL,
	[RoleId] [int] NOT NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SellProduct]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SellProduct](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[MarketId] [int] NULL,
	[ProductId] [int] NULL,
	[SellPrice] [int] NULL,
	[LastUpdatedTime] [datetime] NOT NULL,
 CONSTRAINT [PK_SellProduct] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserPrice]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[UserPrice](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NULL,
	[MarketId] [int] NULL,
	[ProductId] [int] NULL,
	[UpdatedPrice] [int] NULL,
	[LastUpdatedTime] [datetime] NULL,
 CONSTRAINT [PK_UserPrice] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Profile]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Profile](
	[Username] [varchar](50) NOT NULL,
	[FirstStartAddress] [nvarchar](300) NULL,
	[FirstEndAddress] [nvarchar](300) NULL,
	[FirstRoute] [nvarchar](300) NULL,
	[FirstMarkets] [nvarchar](100) NULL,
	[FirstStartDistance] [nvarchar](200) NULL,
	[FirstEndDistance] [nvarchar](200) NULL,
	[FirstRouteName] [nvarchar](100) NULL,
	[SecondStartAddress] [nvarchar](300) NULL,
	[SecondEndAddress] [nvarchar](300) NULL,
	[SecondRoute] [nvarchar](300) NULL,
	[SecondMarkets] [nvarchar](100) NULL,
	[SecondStartDistance] [nvarchar](200) NULL,
	[SecondEndDistance] [nvarchar](200) NULL,
	[SecondRouteName] [nvarchar](100) NULL,
	[ThirdStartAddress] [nvarchar](300) NULL,
	[ThirdEndAddress] [nvarchar](300) NULL,
	[ThirdRoute] [nvarchar](300) NULL,
	[ThirdMarkets] [nvarchar](100) NULL,
	[ThirdStartDistance] [nvarchar](200) NULL,
	[ThirdEndDistance] [nvarchar](200) NULL,
	[ThirdRouteName] [nvarchar](100) NULL,
 CONSTRAINT [PK_Profile] PRIMARY KEY CLUSTERED 
(
	[Username] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[History]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[History](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](50) NOT NULL,
	[BuyTime] [datetime] NOT NULL,
 CONSTRAINT [PK_History] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HistoryDetail]    Script Date: 04/05/2014 00:22:48 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryDetail](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[HistoryId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[MinPrice] [int] NULL,
	[MaxPrice] [int] NULL,
 CONSTRAINT [PK_HistoryDetail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_ParseInfo_Market]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[ParseInfo]  WITH CHECK ADD  CONSTRAINT [FK_ParseInfo_Market] FOREIGN KEY([MarketId])
REFERENCES [dbo].[Market] ([Id])
GO
ALTER TABLE [dbo].[ParseInfo] CHECK CONSTRAINT [FK_ParseInfo_Market]
GO
/****** Object:  ForeignKey [FK_MarketDistance_Market]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[MarketDistance]  WITH CHECK ADD  CONSTRAINT [FK_MarketDistance_Market] FOREIGN KEY([FromMarket])
REFERENCES [dbo].[Market] ([Id])
GO
ALTER TABLE [dbo].[MarketDistance] CHECK CONSTRAINT [FK_MarketDistance_Market]
GO
/****** Object:  ForeignKey [FK_ProductAttribute_Product]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[ProductAttribute]  WITH CHECK ADD  CONSTRAINT [FK_ProductAttribute_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[ProductAttribute] CHECK CONSTRAINT [FK_ProductAttribute_Product]
GO
/****** Object:  ForeignKey [FK_Dictionary_Product]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[Dictionary]  WITH CHECK ADD  CONSTRAINT [FK_Dictionary_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[Dictionary] CHECK CONSTRAINT [FK_Dictionary_Product]
GO
/****** Object:  ForeignKey [FK_User_Role]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([Id])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
/****** Object:  ForeignKey [FK_SellProduct_Market]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[SellProduct]  WITH CHECK ADD  CONSTRAINT [FK_SellProduct_Market] FOREIGN KEY([MarketId])
REFERENCES [dbo].[Market] ([Id])
GO
ALTER TABLE [dbo].[SellProduct] CHECK CONSTRAINT [FK_SellProduct_Market]
GO
/****** Object:  ForeignKey [FK_SellProduct_Product]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[SellProduct]  WITH CHECK ADD  CONSTRAINT [FK_SellProduct_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[SellProduct] CHECK CONSTRAINT [FK_SellProduct_Product]
GO
/****** Object:  ForeignKey [FK_UserPrice_Market]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[UserPrice]  WITH CHECK ADD  CONSTRAINT [FK_UserPrice_Market] FOREIGN KEY([MarketId])
REFERENCES [dbo].[Market] ([Id])
GO
ALTER TABLE [dbo].[UserPrice] CHECK CONSTRAINT [FK_UserPrice_Market]
GO
/****** Object:  ForeignKey [FK_UserPrice_Product]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[UserPrice]  WITH CHECK ADD  CONSTRAINT [FK_UserPrice_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[UserPrice] CHECK CONSTRAINT [FK_UserPrice_Product]
GO
/****** Object:  ForeignKey [FK_UserPrice_User]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[UserPrice]  WITH CHECK ADD  CONSTRAINT [FK_UserPrice_User] FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[UserPrice] CHECK CONSTRAINT [FK_UserPrice_User]
GO
/****** Object:  ForeignKey [FK_Profile_User]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[Profile]  WITH CHECK ADD  CONSTRAINT [FK_Profile_User] FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[Profile] CHECK CONSTRAINT [FK_Profile_User]
GO
/****** Object:  ForeignKey [FK_History_User]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[History]  WITH CHECK ADD  CONSTRAINT [FK_History_User] FOREIGN KEY([Username])
REFERENCES [dbo].[User] ([Username])
GO
ALTER TABLE [dbo].[History] CHECK CONSTRAINT [FK_History_User]
GO
/****** Object:  ForeignKey [FK_HistoryDetail_History]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[HistoryDetail]  WITH CHECK ADD  CONSTRAINT [FK_HistoryDetail_History] FOREIGN KEY([HistoryId])
REFERENCES [dbo].[History] ([Id])
GO
ALTER TABLE [dbo].[HistoryDetail] CHECK CONSTRAINT [FK_HistoryDetail_History]
GO
/****** Object:  ForeignKey [FK_HistoryDetail_Product]    Script Date: 04/05/2014 00:22:48 ******/
ALTER TABLE [dbo].[HistoryDetail]  WITH CHECK ADD  CONSTRAINT [FK_HistoryDetail_Product] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
GO
ALTER TABLE [dbo].[HistoryDetail] CHECK CONSTRAINT [FK_HistoryDetail_Product]
GO
