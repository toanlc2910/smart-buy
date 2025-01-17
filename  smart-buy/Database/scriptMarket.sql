USE [SmartBuy]
GO
/****** Object:  FullTextCatalog [ProductName]    Script Date: 03/03/2014 21:39:45 ******/
CREATE FULLTEXT CATALOG [ProductName]WITH ACCENT_SENSITIVITY = ON
AUTHORIZATION [dbo]
GO
/****** Object:  Table [dbo].[Market]    Script Date: 03/03/2014 21:39:45 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Market](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NOT NULL,
	[Address] [nvarchar](200) NULL,
	[Latitude] [varchar](20) NULL,
	[Longitude] [varchar](20) NULL,
	[IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_Market] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[Market] ON
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (29, N'Chợ Gò vấp', N'Chợ Gò Vấp, phường 4, Ho Chi Minh City', N'10.8234919', N'106.6872132', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (30, N'BigC Gò Vấp', N'Phạm Ngũ Lão, Phường 3, Gò Vấp', N'10.8257002', N'106.6801375', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (31, N'Chợ Bình Tây', N'24 NGUYỄN HỮU THẬN, P.2, Q.6, TP. HCM', N'10.7493304', N'106.651098', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (32, N'Chợ Bến Thành', N'CỬA NAM CHỢ BẾN THÀNH P.BT, Q.1, TP. HCM', N'10.772434', N'106.697845', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (34, N'Chợ Cô Giang', N'110 CÔ GIANG, P.CG, Q.1, TP. HCM', N'10.7627491', N'106.6945771', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (35, N'Chợ Đakao', N'23-25 NGUYỄN HUY TỰ, P.ĐK, Q.1, TP. HCM', N'10.7923263', N'106.6965822', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (36, N'Chợ Cầu Kho', N'26A NGUYỄN VĂN CỪ, P.CK, Q.1, TP. HCM', N'10.7554294', N'106.6857295', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (37, N'Chợ Tân Định', N'1 BÀ LÊ CHÂN, P.TĐ, Q.1, TP. HCM', N'10.789875', N'106.6900623', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (38, N'Chợ Thái Bình', N'PHẠM NGŨ LÃO, P.PNL, Q.1, TP. HCM', N'10.7666817', N'106.6888761', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (39, N'Chợ Cửa khẩu mộc bài', N'275B PHẠM NGŨ LÃO, P.PNL, Q.1, TP. HCM', N'10.7679963', N'106.6915732', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (40, N'Chợ Bàn Cờ', N'664/2 NGUYỄN ĐÌNH CHIỂU, P.3, Q.3, TP. HCM', N'10.768797', N'106.6804958', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (41, N'Chợ Bùi Phát', N'453/130 LÊ VĂN SỸ, P.12, Q.3, TP. HCM', N'10.7894083', N'106.6745972', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (42, N'Chợ Nguyễn Văn Trỗi', N'CHỢ NGUYỄN VĂN TRỖI P.13, Q.3, TP. HCM', N'10.7862701', N'106.6797915', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (43, N'Chợ Vườn Chuối', N'CHỢ VƯỜN CHUỐI P.4, Q.3, TP. HCM', N'10.7735227', N'106.6843083', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (44, N'Chợ Xóm Chiếu', N'1 ĐINH LỄ, P.12, Q.4, TP. HCM', N'10.7633833', N'106.7060362', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (45, N'Chợ Bàu Sen', N'381/28 AN DƯƠNG VƯƠNG, P.3, Q.5, TP. HCM', N'10.7582182', N'106.6784715', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (46, N'Chợ Hà Tôn Quyền', N'165/17 TÂN THÀNH, P.15, Q.5, TP. HCM', N'10.755637', N'106.6532772', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (47, N'Chợ Hòa Bình', N'37 Bạch Vân,phường 5, Quận 5', N'10.7525343', N'106.6758592', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (48, N'Chợ Kim Biên', N'CHỢ KIM BIÊN P.13, Q.5, TP. HCM', N'10.7501116', N'106.6560295', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (49, N'Chợ Phùng Hưng', N'214C PHÙNG HƯNG, P.14, Q.5, TP. HCM', N'10.7534064', N'106.6573355', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (50, N'Chợ Soái Kình Lâm', N'545 TRẦN HƯNG ĐẠO B, P.14, Q.5, TP. HCM', N'10.7519645', N'106.6566991', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (51, N'Chợ Tân Thành', N'68 PHẠM HỮU CHÍ, P.12, Q.5, TP. HCM', N'10.7554417', N'106.6568029', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (52, N'Chợ Trần Chánh Chiếu', N'1 PHÚ GIÁO, P.14, Q.5, TP. HCM', N'10.7517604', N'106.6524488', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (54, N'Chợ Phú Lâm', N'54B BÀ HOM, P.13, Q.6, TP. HCM', N'10.7520272', N'106.6690466', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (55, N'Chợ Tân Phú', N'P.TÂN PHÚ, Q.7, TP. HCM', N'10.7839911', N'106.6256269', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (56, N'Chợ Ba Đình', N'66C BA ĐÌNH, P.10, Q.8, TP. HCM', N'10.7478597', N'106.6678659', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (57, N'Chợ Bình Đông', N'301F BÌNH ĐÔNG, P.14, Q.8, TP. HCM', N'10.7379122', N'106.6436987', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (58, N'Chợ Xóm Củi', N'TÙNG THIỆN VƯƠNG, P.11, Q.8, TP. HCM', N'10.7393233', N'106.6458963', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (59, N'Chợ Bình Điền', N'KP6 NGUYỄN VĂN LINH, P.7, Q.8, TP. HCM', N'10.702906', N'106.608131', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (60, N'Chợ Phước Bình', N'74 KP3 ĐL2, P.PHƯỚC BÌNH, Q.9, TP. HCM', N'10.8172307', N'106.772105', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (61, N'Chợ Tăng Nhơn Phú', N'Lã Xuân Oai,Tăng Nhơn Phú A, Quận 9', N'10.844528', N'106.787839', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (62, N'Chợ Chí Hòa', N'24 TÔ HIẾN THÀNH, P.15, Q.10, TP. HCM', N'10.7824478', N'106.671476', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (63, N'Chợ Hòa Hưng', N'539A CÁCH MẠNG THÁNG TÁM, P.15, Q.10, TP. HCM', N'10.7833425', N'106.6711104', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (64, N'Chợ Nguyễn Tri Phương', N'NGUYỄN LÂM, P.6, Q.10, TP. HCM', N'10.7644361', N'106.663716', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (65, N'Chợ Bình Tiên', N'18 Phạm Phú Thứ,P4, Q.6, TP. HCM', N'10.7452146', N'106.6433835', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (66, N'Chợ Hồ Trọng Quý', N'LÝ CHIÊU HOÀNG, P.10, Q.6, TP. HCM', N'10.7401599', N'106.632177', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (69, N'Chợ Chim Xanh', N'Bình Thới, Phường 11, Quận 11', N'10.7505373', N'106.6545205', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (70, N'Chợ Lãnh Binh Thăng', N'297 LÃNH BINH THĂNG, P.8, Q.11, TP. HCM', N'10.7640414', N'106.6488207', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (71, N'Chợ Phú Thọ', N'124 LÃNH BINH THĂNG, P.13, Q.11, TP. HCM', N'10.7623672', N'106.6544558', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (72, N'Chợ Hiệp Thành', N'P.HIỆP THÀNH, Q.12, TP. HCM', N'10.8785991', N'106.6380292', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (73, N'Chợ Lạc Quang', N'QL22, P.TÂN THỚI NHẤT, Q.12, TP. HCM', N'10.834365', N'106.6196698', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (74, N'Chợ Tân Nhựt', N'CHỢ TÂN NHỰT X.TÂN NHỰT, H.BC, TP. HCM', N'10.7153383', N'106.5651288', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (75, N'Chợ Bà Chiểu', N'40 DIÊN HỒNG, P.1, Q.BT, TP. HCM', N'10.8025147', N'106.6984574', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (76, N'Chợ Phan Văn Trị', N'233A PHAN VĂN TRỊ, P.11, Q.BT, TP. HCM', N'10.8123976', N'106.6953403', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (77, N'Chợ Thanh Đa', N'THANH ĐA, P.27, Q.BT, TP. HCM', N'10.8160119', N'106.7210332', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (79, N'Chợ Văn Thánh', N'ĐIỆN BIÊN PHỦ, P.25, Q.BT, TP. HCM', N'10.8018778', N'106.720848', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (80, N'Chợ An Nhơn', N'6 LÊ ĐỨC THỌ, P.17, Q.GV, TP. HCM', N'10.8413928', N'106.6771856', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (81, N'Chợ Hạnh Thông Tây', N'10/2 QUANG TRUNG, P.11, Q.GV, TP. HCM', N'10.8355532', N'106.6588226', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (82, N'Chợ Xóm Mới', N'4/2 THỐNG NHẤT, P.16, Q.GV, TP. HCM', N'10.8499431', N'106.6643768', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (83, N'Chợ Nguyễn Đình Chiểu', N'34 LÊ TỰ TÀI, P.4, Q.PN, TP. HCM', N'10.8047099', N'106.6799458', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (84, N'Chợ Phú Nhuận', N'51 CAO THẮNG, P.17, Q.PN, TP. HCM', N'10.7946721', N'106.6833639', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (85, N'Chợ Hoàng Hoa Thám', N'19 HOÀNG HOA THÁM, P.13, Q.TB, TP. HCM', N'10.7981727', N'106.6470303', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (86, N'Chợ Phạm Văn Hai', N'CHỢ PHẠM VĂN HAI P.3, Q.TB, TP. HCM', N'10.7943205', N'106.663106', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (87, N'Chợ Tân Bình', N'172-174M LÝ THƯỜNG KIỆT, P.8, Q.TB, TP. HCM', N'10.7862021', N'106.6534444', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (88, N'Chợ Bình Triệu', N'182 KP2 QL13, P.HIỆP BÌNH CHÁNH, Q.TĐ, TP. HCM', N'10.8301618', N'106.7147541', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (89, N'Chợ Thủ Đức', N'CHỢ THỦ ĐỨC P.TRƯỜNG THỌ, Q.TĐ, TP. HCM', N'10.8735529', N'106.7679446', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (91, N'Chợ Hiệp Tân', N'6/20F CÂY KEO, P.HIỆP TÂN, Q.TP, TP. HCM', N'10.7717903', N'106.6294739', 1)
INSERT [dbo].[Market] ([Id], [Name], [Address], [Latitude], [Longitude], [IsActive]) VALUES (92, N'Siêu thị Co.op mart Nguyễn Kiệm', N'571 Nguyễn Kiệm, Phú nhuận', N'10.8085726', N'106.6784127', 1)
SET IDENTITY_INSERT [dbo].[Market] OFF
