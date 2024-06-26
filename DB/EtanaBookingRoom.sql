USE [master]
GO
/****** Object:  Database [EtanaBookingRoom]    Script Date: 22/05/2024 22:44:11 ******/
CREATE DATABASE [EtanaBookingRoom]
 CONTAINMENT = NONE

GO
ALTER DATABASE [EtanaBookingRoom] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [EtanaBookingRoom].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [EtanaBookingRoom] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET ARITHABORT OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [EtanaBookingRoom] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [EtanaBookingRoom] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET  DISABLE_BROKER 
GO
ALTER DATABASE [EtanaBookingRoom] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [EtanaBookingRoom] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET RECOVERY FULL 
GO
ALTER DATABASE [EtanaBookingRoom] SET  MULTI_USER 
GO
ALTER DATABASE [EtanaBookingRoom] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [EtanaBookingRoom] SET DB_CHAINING OFF 
GO
ALTER DATABASE [EtanaBookingRoom] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [EtanaBookingRoom] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [EtanaBookingRoom] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [EtanaBookingRoom] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [EtanaBookingRoom] SET QUERY_STORE = OFF
GO
USE [EtanaBookingRoom]
GO
/****** Object:  Table [dbo].[BookingRooms]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingRooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Date] [date] NULL,
	[TotalParticipant] [int] NULL,
	[IsInternal] [int] NULL,
	[AdditionalInformation] [text] NULL,
	[CreatedBy] [varchar](200) NULL,
	[CreatedDate] [datetime] NULL,
	[Status] [int] NULL,
	[IdRooms] [int] NULL,
	[Approver] [varchar](200) NULL,
	[ApproveDate] [datetime] NULL,
	[NoteApprove] [text] NULL,
 CONSTRAINT [PK_BookingRooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SesssionBookingRooms]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SesssionBookingRooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdBookingRooms] [int] NULL,
	[IdSessionTime] [int] NULL,
 CONSTRAINT [PK_SesssionBookingRooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[vwGetSessionBookingRoom]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[vwGetSessionBookingRoom]

as 
Select 
b.IdRooms,b.Date,
a.* From SesssionBookingRooms a
left join BookingRooms b 
on a.IdBookingRooms = b.Id
where b.Status in (1,2)
GO
/****** Object:  Table [dbo].[Facilities]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Facilities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Status] [int] NULL,
	[Color] [varchar](200) NULL,
 CONSTRAINT [PK_Facilities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomFacilities]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomFacilities](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdFacilities] [int] NULL,
	[IdRoom] [int] NULL,
 CONSTRAINT [PK_RoomFacilities] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rooms]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rooms](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Time] [varchar](200) NULL,
	[MaxPerson] [int] NULL,
	[Location] [varchar](200) NULL,
	[Status] [int] NULL,
	[CreatedDate] [datetime] NULL,
	[CreatedBy] [varchar](200) NULL,
	[UpdatedDate] [datetime] NULL,
	[UpdatedBy] [varchar](200) NULL,
	[Image] [varchar](255) NULL,
 CONSTRAINT [PK_Rooms] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SessionTime]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SessionTime](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IdRooms] [int] NULL,
	[StartTime] [time](7) NULL,
	[EndTime] [time](7) NULL,
	[Status] [int] NULL,
 CONSTRAINT [PK_SessionTime] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[Id] [int] NULL,
	[Name] [varchar](200) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[NIP] [varchar](200) NOT NULL,
	[FullName] [varchar](200) NULL,
	[Email] [varchar](200) NULL,
	[Sex] [varchar](200) NULL,
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[IsApprover] [varchar](200) NULL,
	[Level] [varchar](200) NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[NIP] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[BookingRooms] ON 

INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (8, CAST(N'2024-02-21' AS Date), 12, 1, N'Meeting Dynamic ', N'E0179', CAST(N'2024-02-27T10:18:14.893' AS DateTime), 0, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (9, CAST(N'2024-02-28' AS Date), 5, 1, N'Meeting Dynamic Tahap 2', N'E0179', CAST(N'2024-02-27T17:36:25.643' AS DateTime), 1, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (10, CAST(N'2024-02-29' AS Date), 4, 0, N'fsdffs', N'E0179', CAST(N'2024-02-27T17:36:56.737' AS DateTime), 1, 2, N'E0179', CAST(N'2024-03-04T13:47:53.963' AS DateTime), N'Note')
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (11, CAST(N'2024-03-04' AS Date), 5, 1, N'Meeting Aplikasi Sunfish', N'E0179', CAST(N'2024-02-28T15:07:24.740' AS DateTime), 1, 1, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (12, CAST(N'2024-03-12' AS Date), 5, 0, N'Additional Information', N'E0179', CAST(N'2024-03-04T13:51:51.737' AS DateTime), 2, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (13, CAST(N'2024-03-13' AS Date), 20, 1, N'Additional Information', N'E0179', CAST(N'2024-03-26T08:16:41.603' AS DateTime), 2, 4, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (23, CAST(N'2024-05-22' AS Date), 12, 0, N'tes', N'E0179', CAST(N'2024-05-21T17:38:04.520' AS DateTime), 1, 2, N'E0001', CAST(N'2024-05-21T22:29:03.620' AS DateTime), N'Test Approve')
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (24, CAST(N'2024-05-22' AS Date), 14, 0, N'tes14', N'E0179', CAST(N'2024-05-21T17:42:27.770' AS DateTime), 1, 2, N'E0001', CAST(N'2024-05-21T23:00:11.700' AS DateTime), N'Test Approve')
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (25, CAST(N'2024-05-22' AS Date), 13, 0, N'Tes123', N'E0179', CAST(N'2024-05-21T22:08:51.447' AS DateTime), 2, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (26, CAST(N'2024-05-22' AS Date), 13, 0, N'Tes4', N'E0179', CAST(N'2024-05-21T22:10:12.560' AS DateTime), 1, 2, N'E0001', CAST(N'2024-05-21T23:01:47.217' AS DateTime), N'Test Approve')
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (27, CAST(N'2024-05-22' AS Date), 15, 0, N'Tes5', N'E0179', CAST(N'2024-05-21T22:13:11.417' AS DateTime), 2, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (28, CAST(N'2024-05-22' AS Date), 16, 0, N'Tes6', N'E0179', CAST(N'2024-05-21T22:14:00.057' AS DateTime), 2, 2, NULL, NULL, NULL)
INSERT [dbo].[BookingRooms] ([Id], [Date], [TotalParticipant], [IsInternal], [AdditionalInformation], [CreatedBy], [CreatedDate], [Status], [IdRooms], [Approver], [ApproveDate], [NoteApprove]) VALUES (29, CAST(N'2024-05-22' AS Date), 7, 0, N'Tes7', N'E0179', CAST(N'2024-05-21T22:46:30.077' AS DateTime), 2, 2, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[BookingRooms] OFF
GO
SET IDENTITY_INSERT [dbo].[Facilities] ON 

INSERT [dbo].[Facilities] ([Id], [Name], [Status], [Color]) VALUES (1, N'WIFI', 1, N'bg-primary')
INSERT [dbo].[Facilities] ([Id], [Name], [Status], [Color]) VALUES (2, N'TV', 1, N'bg-secondary')
INSERT [dbo].[Facilities] ([Id], [Name], [Status], [Color]) VALUES (3, N'AC', 1, N'bg-success')
INSERT [dbo].[Facilities] ([Id], [Name], [Status], [Color]) VALUES (4, N'White Board', 1, N'bg-danger')
INSERT [dbo].[Facilities] ([Id], [Name], [Status], [Color]) VALUES (5, N'White Board', 1, N'bg-danger')
SET IDENTITY_INSERT [dbo].[Facilities] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomFacilities] ON 

INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (1, 1, 1)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (2, 2, 1)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (3, 3, 1)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (4, 4, 1)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (5, 1, 2)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (6, 2, 2)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (7, 4, 2)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (8, 1, 3)
INSERT [dbo].[RoomFacilities] ([Id], [IdFacilities], [IdRoom]) VALUES (9, 1, 4)
SET IDENTITY_INSERT [dbo].[RoomFacilities] OFF
GO
SET IDENTITY_INSERT [dbo].[Rooms] ON 

INSERT [dbo].[Rooms] ([Id], [Name], [Time], [MaxPerson], [Location], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Image]) VALUES (1, N'Bevagen', N'08.00 - 17.00', 10, N'Second Floor Head Offie', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Rooms] ([Id], [Name], [Time], [MaxPerson], [Location], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Image]) VALUES (2, N'Renogen', N'08.00 - 17.00', 10, N'Second Floor Head Offie', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Rooms] ([Id], [Name], [Time], [MaxPerson], [Location], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Image]) VALUES (3, N'Etaplat', N'08.00 - 17.00', 10, N'Second Floor Head Offie', 1, NULL, NULL, NULL, NULL, NULL)
INSERT [dbo].[Rooms] ([Id], [Name], [Time], [MaxPerson], [Location], [Status], [CreatedDate], [CreatedBy], [UpdatedDate], [UpdatedBy], [Image]) VALUES (4, N'Healive', N'08.00 - 17.00', 10, N'Second Floor Head Offie', 1, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[Rooms] OFF
GO
SET IDENTITY_INSERT [dbo].[SessionTime] ON 

INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (1, 1, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (2, 1, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (3, 1, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (4, 1, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (5, 1, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (6, 1, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (7, 1, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (8, 1, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (9, 1, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (10, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (11, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (12, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (13, 2, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (14, 2, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (15, 2, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (16, 2, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (17, 2, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (18, 2, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (19, 3, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (20, 3, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (21, 3, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (22, 3, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (23, 3, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (24, 3, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (25, 3, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (26, 3, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (27, 3, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (28, 3, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (29, 3, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (30, 3, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (31, 3, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (32, 3, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (33, 3, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (34, 3, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (35, 3, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (36, 3, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (37, 4, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (38, 4, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (39, 4, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (40, 4, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (41, 4, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (42, 4, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (43, 4, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (44, 4, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (45, 4, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (46, 4, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (47, 4, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (48, 4, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (49, 4, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (50, 4, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (51, 4, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (52, 4, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (53, 4, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (54, 4, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (55, 4, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (56, 4, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (57, 4, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (58, 4, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (59, 4, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (60, 4, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (61, 4, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (62, 4, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (63, 4, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (64, 4, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (65, 4, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (66, 4, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (67, 4, CAST(N'11:00:00' AS Time), CAST(N'12:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (68, 4, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (69, 4, CAST(N'14:00:00' AS Time), CAST(N'15:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (70, 4, CAST(N'15:00:00' AS Time), CAST(N'16:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (71, 4, CAST(N'16:00:00' AS Time), CAST(N'17:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (72, 4, CAST(N'17:00:00' AS Time), CAST(N'18:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (87, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (88, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (89, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (90, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (91, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (92, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (93, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (94, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (95, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (96, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (97, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (98, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 1)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (99, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (100, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (101, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (102, 2, CAST(N'08:00:00' AS Time), CAST(N'09:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (103, 2, CAST(N'09:00:00' AS Time), CAST(N'10:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (104, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (105, 2, CAST(N'12:00:00' AS Time), CAST(N'13:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (106, 2, CAST(N'13:00:00' AS Time), CAST(N'14:00:00' AS Time), 2)
INSERT [dbo].[SessionTime] ([Id], [IdRooms], [StartTime], [EndTime], [Status]) VALUES (107, 2, CAST(N'10:00:00' AS Time), CAST(N'11:00:00' AS Time), 2)
SET IDENTITY_INSERT [dbo].[SessionTime] OFF
GO
SET IDENTITY_INSERT [dbo].[SesssionBookingRooms] ON 

INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (4, 8, 10)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (5, 8, 11)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (6, 8, 12)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (7, 8, 13)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (8, 9, 10)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (9, 9, 15)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (10, 9, 16)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (11, 9, 17)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (12, 10, 10)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (13, 10, 12)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (14, 11, 1)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (15, 11, 2)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (16, 11, 3)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (17, 12, 10)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (18, 12, 11)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (19, 13, 37)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (20, 13, 38)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (21, 13, 39)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (22, 23, 88)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (23, 23, 87)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (24, 23, 89)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (25, 24, 91)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (26, 24, 92)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (27, 24, 90)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (28, 25, 94)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (29, 25, 93)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (30, 25, 95)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (31, 26, 97)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (32, 26, 96)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (33, 26, 98)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (34, 27, 99)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (35, 27, 100)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (36, 27, 101)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (37, 28, 102)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (38, 28, 103)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (39, 28, 104)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (40, 29, 106)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (41, 29, 105)
INSERT [dbo].[SesssionBookingRooms] ([Id], [IdBookingRooms], [IdSessionTime]) VALUES (42, 29, 107)
SET IDENTITY_INSERT [dbo].[SesssionBookingRooms] OFF
GO
INSERT [dbo].[Status] ([Id], [Name]) VALUES (2, N'Pending Approve HR')
INSERT [dbo].[Status] ([Id], [Name]) VALUES (1, N'Approved')
INSERT [dbo].[Status] ([Id], [Name]) VALUES (0, N'Reject')
GO
SET IDENTITY_INSERT [dbo].[Users] ON 

INSERT [dbo].[Users] ([NIP], [FullName], [Email], [Sex], [Id], [IsApprover], [Level]) VALUES (N'E0001', N'Staff HR', N'staff@gmail.com', N'Female', 2, N'1', N'Staff')
INSERT [dbo].[Users] ([NIP], [FullName], [Email], [Sex], [Id], [IsApprover], [Level]) VALUES (N'E0179', N'Cahyo Prabowo', N'cahyoprabowo@gmail.com', N'Male', 1, N'0', N'Staff')
SET IDENTITY_INSERT [dbo].[Users] OFF
GO
/****** Object:  StoredProcedure [dbo].[LoginUser]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[LoginUser]
@NIP VARCHAR(200) = ''
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

Select * From Users 
Where NIP = @NIP

	
END
GO
/****** Object:  StoredProcedure [dbo].[TransactionRooms]    Script Date: 22/05/2024 22:44:11 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TransactionRooms]
@Param VARCHAR(200),
@IdRoom VARCHAR(200) = '',
@Date VARCHAR(200) = null,
@TotalParticipant VARCHAR(200) = '',
@IsInternal VARCHAR(200) = '',
@AdditionalInformation TEXT = '',
@Code VARCHAR(200) = '',
@IdBookingRooms VARCHAR(200) = '',
@IdSessionTime VARCHAR(200) = '',
@Note TEXT = '',
@Status VARCHAR(200) = '',
@StartTime VARCHAR(200) = '',
@EndTime VARCHAR(200) = ''

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here

	IF @Param = 'ApprovalRoom'
	BEGIN 

	DECLARE @CountDataAproved int = 0;

	SELECT @CountDataAproved=COUNT(0) FROM SessionTime st
	JOIN SesssionBookingRooms sbr
		ON st.Id = sbr.IdSessionTime 
	JOIN BookingRooms br
		ON br.Id = sbr.IdBookingRooms
	JOIN (SELECT st.StartTime,ST.EndTime,br.* FROM SessionTime st
	JOIN SesssionBookingRooms sbr
		ON st.Id = sbr.IdSessionTime 
	JOIN BookingRooms br
		ON br.Id = sbr.IdBookingRooms
	WHERE br.Date = @Date and st.Status = 1) B
	ON ST.StartTime = B.StartTime AND ST.EndTime = B.EndTime
	WHERE br.Id = @IdBookingRooms and st.Status = 2
	
		IF @CountDataAproved > 0
		BEGIN
			SELECT 'Gagal Approve, Terdapat Sesi yang sudah digunakan !!!' AS [Message]
		END
		ELSE
		BEGIN
			Update BookingRooms
			set Approver = @Code,
			ApproveDate = getdate(),
			NoteApprove = @Note,
			Status = @Status
			Where Id = @IdBookingRooms

			UPDATE st
			SET status = @Status
			FROM SessionTime st
			JOIN SesssionBookingRooms sbr
				ON st.Id = sbr.IdSessionTime 
			JOIN BookingRooms br
				ON br.Id = sbr.IdBookingRooms
			WHERE br.Id = @IdBookingRooms
			
			SELECT 'Success' AS [Message]
		END
	END 
	
	IF @Param = 'GetSessionBookingRoom'
	BEGIN 

	Select 
	a.IdBookingRooms,
		convert(varchar,b.StartTime,108) as StartTime,
	convert(varchar,b.EndTime,108) as EndTime
	From [SesssionBookingRooms] a 
	left join SessionTime b 
	on a.IdSessionTime = b.Id

	END

	IF @Param = 'GetMyBookingRoom'
	BEGIN 

	Select 
a.*
,b.Name as StatusName
,c.Name as RoomName,
(
select convert(nvarchar(MAX), min(suba.StartTime), 8) StartTime from(
SELECT 
(SELECT d.StartTime FROM SessionTime d where d.Id=c.IdSessionTime) StartTime FROM SesssionBookingRooms c
where c.IdBookingRooms = a.Id) as suba
) + ' - ' + (
select convert(nvarchar(MAX), max(subb.EndTime), 8) EndTime from(
SELECT 
(SELECT d.EndTime FROM SessionTime d where d.Id=c.IdSessionTime) EndTime FROM SesssionBookingRooms c
where c.IdBookingRooms = a.Id) as subb
) as Session
From BookingRooms a
left join Status b
on a.Status = b.Id
left join Rooms c
on a.IdRooms  = c.Id
where a.CreatedBy = @Code
and Date >= getdate()

	END 

	IF @Param = 'GetMyHistoryBooking'
	BEGIN
		Select 
		a.*
		,b.Name as StatusName
		,c.Name as RoomName,
		(
		select convert(nvarchar(MAX), min(suba.StartTime), 8) StartTime from(
		SELECT 
		(SELECT d.StartTime FROM SessionTime d where d.Id=c.IdSessionTime) StartTime FROM SesssionBookingRooms c
		where c.IdBookingRooms = a.Id) as suba
		) + ' - ' + (
		select convert(nvarchar(MAX), max(subb.EndTime), 8) EndTime from(
		SELECT 
		(SELECT d.EndTime FROM SessionTime d where d.Id=c.IdSessionTime) EndTime FROM SesssionBookingRooms c
		where c.IdBookingRooms = a.Id) as subb
		) as Session
		From BookingRooms a
		left join Status b
		on a.Status = b.Id
		left join Rooms c
		on a.IdRooms  = c.Id
		where a.CreatedBy = @Code
		and Date < getdate()
	END 

	IF @Param = 'GetPendingApproval'
	BEGIN
		Select 
		a.*
		,b.Name as StatusName
		,c.Name as RoomName,
		(
		select convert(nvarchar(MAX), min(suba.StartTime), 8) StartTime from(
		SELECT 
		(SELECT d.StartTime FROM SessionTime d where d.Id=c.IdSessionTime) StartTime FROM SesssionBookingRooms c
		where c.IdBookingRooms = a.Id) as suba
		) + ' - ' + (
		select convert(nvarchar(MAX), max(subb.EndTime), 8) EndTime from(
		SELECT 
		(SELECT d.EndTime FROM SessionTime d where d.Id=c.IdSessionTime) EndTime FROM SesssionBookingRooms c
		where c.IdBookingRooms = a.Id) as subb
		) as Session
		From BookingRooms a
		left join Status b
		on a.Status = b.Id
		left join Rooms c
		on a.IdRooms  = c.Id
		where a.Status = 2
		--and Date < getdate()
	END 

	IF @Param  = 'GetSessionTimePerDay'
	BEGIN
		Select a.*,b.IdSessionTime From SessionTime a 
		left join  (Select * From vwGetSessionBookingRoom Where Date  = @Date) b
		on a.IdRooms = b.IdRooms and a.Id = b.IdSessionTime 
		Where a.IdRooms = @IdRoom
	END
	
	IF @Param = 'InsertSessionBookingRoom'
	BEGIN 
		INSERT INTO [SesssionBookingRooms](
		[IdBookingRooms],
		[IdSessionTime]
		)
		VALUES (
		@IdBookingRooms,
		@IdSessionTime
		)
	END

	IF @Param = 'InsertBookingRooms'
	BEGIN 
		Insert Into BookingRooms(
		[Date]
		,[TotalParticipant]
		,[IsInternal]
		,[AdditionalInformation]
		,[CreatedBy]
		,[CreatedDate]
		,[Status]
		,[IdRooms]
		)
		VALUES (
		@Date,
		@TotalParticipant,
		@IsInternal,
		@AdditionalInformation,
		@Code,
		getdate(),
		'2',
		@IdRoom
		)

		SELECT SCOPE_IDENTITY() as Id
	END

	IF @Param = 'InsertSessionTime'
	BEGIN 
		Insert Into SessionTime(
		[IdRooms]
		,[StartTime]
		,[EndTime]
		,[Status]
		)
		VALUES (
		@IdRoom,
		@StartTime,
		@EndTime,
		'2'
		)

		SELECT SCOPE_IDENTITY() as Id
	END

	IF @Param = 'GetSessionTimePerRoom'
	BEGIN
		Select * From SessionTime Where Status = 1 
		and IdRooms = @IdRoom
	END

	IF @Param = 'GetDetailRoom'
	BEGIN
		Select * From Rooms Where Status = 1 And Id = @IdRoom
	END

	IF @Param = 'GetSessioPerRoom'
	BEGIN
		Select 
		c.Id,
		b.Date,
		--c.StartTime,
		--c.EndTime,
		CONCAT(b.Date,'T',convert(varchar,c.StartTime,108)) as StartTime,
		CONCAT(b.Date,'T',convert(varchar,c.EndTime,108)) as EndTime,
		b.IdRooms
		From SesssionBookingRooms a
		left join BookingRooms b
		on a.IdBookingRooms = b.Id 
		left join SessionTime c
		on a.IdSessionTime = c.Id
		where b.IdRooms = @IdRoom
		and b.Status in (1,2)
	END
	
	IF @Param = 'GetAllRoom'
	BEGIN

	Select * From Rooms Where Status = 1 

	END

	IF @Param = 'GetRoomFacilities'
	BEGIN
		Select c.Name,c.Color,b.Id From RoomFacilities a
		left join Rooms b
		on a.IdRoom = b.Id
		left join Facilities c
		on a.IdFacilities = c.Id
	END

	IF @Param = 'GetRoomFacilitiesbyIdRoom'
	BEGIN
		Select c.Name,c.Color,b.Id From RoomFacilities a
		left join Rooms b
		on a.IdRoom = b.Id
		left join Facilities c
		on a.IdFacilities = c.Id
		where b.Id = @IdRoom
	END

	IF @Param = 'GetSessioRoomApprovePerDay'
	BEGIN
		Select distinct a.IdRooms, a.StartTime, a.EndTime, b.Date From SessionTime a 
	left join  (Select * From vwGetSessionBookingRoom Where Date  = @Date) b
	on a.IdRooms = b.IdRooms and a.Id = b.IdSessionTime 
	Where a.IdRooms = @IdRoom and a.Status = 1 and b.IdSessionTime IS NOT null
	END

END
GO
USE [master]
GO
ALTER DATABASE [EtanaBookingRoom] SET  READ_WRITE 
GO
