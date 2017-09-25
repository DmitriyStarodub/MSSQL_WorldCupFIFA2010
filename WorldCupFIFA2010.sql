-- Создаем базу данных

CREATE DATABASE WorldCupFIFA2010;
GO

-- Делаем созданную базу данных текущей

USE WorldCupFIFA2010
GO

CREATE TABLE PositionPlayers
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Countries
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE RoundOfPlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (15)
)
GO

CREATE TABLE MatchTime
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (30),
)
GO

CREATE TABLE Association
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE TypeFoul
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (60),
	Comments varchar (50)
)
GO

CREATE TABLE RefereesPosition
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE BrandsForm
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Citys
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Achievements
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Groups
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar(2)
)
GO

CREATE TABLE Colors
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Names
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50)
)
GO

CREATE TABLE Surnames
(
	Id int NOT NULL PRIMARY KEY,
	Surname varchar (50)
)
GO

CREATE TABLE Referees
(
	Id int NOT NULL PRIMARY KEY,
	NamesFk int,
	SurnamesFk int,
	AssociationFk int,
	RefereesPositionFk int,
	FOREIGN KEY (NamesFk) REFERENCES Names(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (SurnamesFk) REFERENCES Surnames(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (AssociationFk) REFERENCES Association(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (RefereesPositionFk) REFERENCES RefereesPosition(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE ColorShapes
(
	Id int NOT NULL PRIMARY KEY,
	MainColorFk int,
	SecondaryColorFk int,
	FOREIGN KEY (MainColorFk) REFERENCES Colors(Id)
        ON DELETE No ACTION
        ON UPDATE No ACTION,
	FOREIGN KEY (SecondaryColorFk) REFERENCES Colors(Id)
        ON DELETE No ACTION
        ON UPDATE No ACTION
)
GO

CREATE TABLE Commands
(
	Id int NOT NULL PRIMARY KEY,
	CountriesFk int,
	BrandsFormFk int,
	ColorShapesFk int,
	FOREIGN KEY (CountriesFk) REFERENCES Countries(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (BrandsFormFk) REFERENCES BrandsForm(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (ColorShapesFk) REFERENCES ColorShapes(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE Players
(
	Id int NOT NULL PRIMARY KEY,
	CommandsFk int,
	PositionPlayersFk int,
	NamesFk int,
	SurnamesFk int,
	Age int,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (PositionPlayersFk) REFERENCES PositionPlayers(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (NamesFk) REFERENCES Names(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (SurnamesFk) REFERENCES Surnames(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE ResultsOfPlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	CommandsFk int,
	AchievementsFk int,
	GoalsFor tinyint,
	GoalsAgainst tinyint,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (AchievementsFk) REFERENCES Achievements(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO


CREATE TABLE ResultsOfGroupMatches
(
	Id int NOT NULL PRIMARY KEY,
	GroupsFk int,
	CommandsFk int,
	Played tinyint,
	Won tinyint,
	Draw tinyint,
	Lost tinyint,
	GoalsFor tinyint,
	GoalsAgainst tinyint,
	Points tinyint,
	FOREIGN KEY (GroupsFk) REFERENCES Groups(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE Stadiums
(
	Id int NOT NULL PRIMARY KEY,
	Name varchar (50),
	CitysFk int,
	NumberOfSeats int,
	FOREIGN KEY (CitysFk) REFERENCES Citys(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE PlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	[Date] date,
	[Time] time,
	Commands1Fk int,
	Commands2Fk int,
	RoundOfPlayoffMatchesFk int,
	StadiumsFk int,
	NumberOfAudience int,
	FOREIGN KEY (Commands1Fk) REFERENCES Commands(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (Commands2Fk) REFERENCES Commands(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (StadiumsFk) REFERENCES Stadiums(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (RoundOfPlayoffMatchesFk) REFERENCES RoundOfPlayoffMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE RefereesPlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	RefereesFk int,
	PlayoffMatchesFk int,
	FOREIGN KEY (RefereesFk) REFERENCES Referees(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (PlayoffMatchesFk) REFERENCES PlayoffMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE GroupMatches
(
	Id int NOT NULL PRIMARY KEY,
	[Date] date,
	[Time] time,
	GroupsFk int,
	Commands1Fk int,
	Commands2Fk int,
	StadiumsFk int,
	NumberOfAudience int,
	FOREIGN KEY (GroupsFk) REFERENCES Groups(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (Commands1Fk) REFERENCES Commands(Id)
        ON DELETE No ACTION
        ON UPDATE No ACTION,
	FOREIGN KEY (Commands2Fk) REFERENCES Commands(Id)
        ON DELETE No ACTION
        ON UPDATE No ACTION,
	FOREIGN KEY (StadiumsFk) REFERENCES Stadiums(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE RefereesGroupMatches
(
	Id int NOT NULL PRIMARY KEY,
	RefereesFk int,
	GroupMatchesFk int,
	FOREIGN KEY (RefereesFk) REFERENCES Referees(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (GroupMatchesFk) REFERENCES GroupMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE StatisticsCommandOfMatch
(
	Id int NOT NULL PRIMARY KEY,
	CommandsFk int,
	Corner int,
	PossessionPercent int,
	MatchTimeFk int,
	BeatToTheSideOfTheGate int,
	BeatOnTarget int,
	OffSide int,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE No ACTION
        ON UPDATE No ACTION,
	FOREIGN KEY (MatchTimeFk) REFERENCES MatchTime(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE FoulGroupMatches
(
	Id int NOT NULL PRIMARY KEY,
	PlayersFk int,
	StatisticsCommandOfMatchFk int,
	RefereesFk int,
	TypeFoulFk int,
	 OnMinute int,
	FOREIGN KEY (PlayersFk) REFERENCES Players(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (RefereesFk) REFERENCES Referees(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (TypeFoulFk) REFERENCES TypeFoul(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE GoalsScored
(
	Id int NOT NULL PRIMARY KEY,
	StatisticsCommandOfMatchFk int,
	PlayersFk int,
	OnMinute int,
	CommandMissedTheBallFk int,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (PlayersFk) REFERENCES Players(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (CommandMissedTheBallFk) REFERENCES Commands(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
GO

CREATE TABLE MatchsGroupStatistics
(
	Id int NOT NULL PRIMARY KEY,
	StatisticsCommandOfMatchFk int,
	GroupMatchesFk int,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (GroupMatchesFk) REFERENCES GroupMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE PlayoffMatchesStatistics
(
	Id int NOT NULL PRIMARY KEY,
	StatisticsCommandOfMatchFk int,
	PlayoffMatchesFk int,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (PlayoffMatchesFk) REFERENCES PlayoffMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE FoulPlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	PlayersFk int,
	StatisticsCommandOfMatchFk int,
	RefereesFk int,
	TypeFoulFk int,
	 OnMinute int,
	FOREIGN KEY (PlayersFk) REFERENCES Players(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (RefereesFk) REFERENCES Referees(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (TypeFoulFk) REFERENCES TypeFoul(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO

CREATE TABLE Сoach
(
	Id int NOT NULL PRIMARY KEY,
	CommandsFk int,
	NamesFk int,
	SurnamesFk int,
	FromCountriesFk int,
	Age int,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (NamesFk) REFERENCES Names(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (SurnamesFk) REFERENCES Surnames(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (FromCountriesFk) REFERENCES Countries(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION
)
GO

CREATE TABLE CompositionCommandsGroupMatches
(
	Id int NOT NULL PRIMARY KEY,
	PlayersFk int,
	GroupMatchesFk int,
	CommandsFk int,
	FOREIGN KEY (PlayersFk) REFERENCES Players(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (GroupMatchesFk) REFERENCES GroupMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION 
)
GO

CREATE TABLE CompositionCommandsPlayoffMatches
(
	Id int NOT NULL PRIMARY KEY,
	PlayersFk int,
	PlayoffMatchesFk int,
	CommandsFk int,
	FOREIGN KEY (PlayersFk) REFERENCES Players(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (PlayoffMatchesFk) REFERENCES PlayoffMatches(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
	FOREIGN KEY (CommandsFk) REFERENCES Commands(Id)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION 
)
GO

CREATE TABLE ReplacementPlayers
(
	Id int NOT NULL PRIMARY KEY,
	PlayerOutFk int,
	PlayerInFk int,
	OnMinute int,
	StatisticsCommandOfMatchFk int,
	FOREIGN KEY (PlayerOutFk) REFERENCES Players(Id)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION ,
	FOREIGN KEY (PlayerInFk) REFERENCES Players(Id)
        ON DELETE NO ACTION 
        ON UPDATE NO ACTION ,
	FOREIGN KEY (StatisticsCommandOfMatchFk) REFERENCES StatisticsCommandOfMatch(Id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
)
GO
-- Заполняем таблицы

INSERT PositionPlayers (Id, Name) VALUES (1, N'goal keeper')
INSERT PositionPlayers (Id, Name) VALUES (2, N'back')
INSERT PositionPlayers (Id, Name) VALUES (3, N'sweeper')
INSERT PositionPlayers (Id, Name) VALUES (4, N'forward')
GO

INSERT RoundOfPlayoffMatches (Id, Name) VALUES (1, N'1/8')
INSERT RoundOfPlayoffMatches (Id, Name) VALUES (2, N'1/4')
INSERT RoundOfPlayoffMatches (Id, Name) VALUES (3, N'1/2')
INSERT RoundOfPlayoffMatches (Id, Name) VALUES (4, N'final')
INSERT RoundOfPlayoffMatches (Id, Name) VALUES (5, N'Third Place')
GO

INSERT Countries (Id, Name) VALUES (1, N'Afghanistan')
INSERT Countries (Id, Name) VALUES (2, N'Albania')
INSERT Countries (Id, Name) VALUES (3, N'Algeria')
INSERT Countries (Id, Name) VALUES (4, N'American Samoa')
INSERT Countries (Id, Name) VALUES (5, N'Andorra')
INSERT Countries (Id, Name) VALUES (6, N'Angola')
INSERT Countries (Id, Name) VALUES (7, N'Anguilla')
INSERT Countries (Id, Name) VALUES (8, N'Antigua and Barbuda')
INSERT Countries (Id, Name) VALUES (9, N'Argentina')
INSERT Countries (Id, Name) VALUES (10, N'Armenia')
INSERT Countries (Id, Name) VALUES (11, N'Aruba')
INSERT Countries (Id, Name) VALUES (12, N'Australia')
INSERT Countries (Id, Name) VALUES (13, N'Austria')
INSERT Countries (Id, Name) VALUES (14, N'Azerbaijan')
INSERT Countries (Id, Name) VALUES (15, N'Bahamas')
INSERT Countries (Id, Name) VALUES (16, N'Bahrain')
INSERT Countries (Id, Name) VALUES (17, N'Bangladesh')
INSERT Countries (Id, Name) VALUES (18, N'Barbados')
INSERT Countries (Id, Name) VALUES (19, N'Belarus')
INSERT Countries (Id, Name) VALUES (20, N'Belgium')
INSERT Countries (Id, Name) VALUES (21, N'Belize')
INSERT Countries (Id, Name) VALUES (22, N'Benin')
INSERT Countries (Id, Name) VALUES (23, N'Bermuda')
INSERT Countries (Id, Name) VALUES (24, N'Bhutan')
INSERT Countries (Id, Name) VALUES (25, N'Bolivia')
INSERT Countries (Id, Name) VALUES (26, N'Bosnia-Herzegovina')
INSERT Countries (Id, Name) VALUES (27, N'Botswana')
INSERT Countries (Id, Name) VALUES (28, N'Bouvet Island')
INSERT Countries (Id, Name) VALUES (29, N'Brazil')
INSERT Countries (Id, Name) VALUES (30, N'Brunei')
INSERT Countries (Id, Name) VALUES (31, N'Bulgaria')
INSERT Countries (Id, Name) VALUES (32, N'Burkina Faso')
INSERT Countries (Id, Name) VALUES (33, N'Burundi')
INSERT Countries (Id, Name) VALUES (34, N'Cambodia')
INSERT Countries (Id, Name) VALUES (35, N'Cameroon')
INSERT Countries (Id, Name) VALUES (36, N'Canada')
INSERT Countries (Id, Name) VALUES (37, N'Cape Verde')
INSERT Countries (Id, Name) VALUES (38, N'Cayman Islands')
INSERT Countries (Id, Name) VALUES (39, N'Central African Republic')
INSERT Countries (Id, Name) VALUES (40, N'Chad')
INSERT Countries (Id, Name) VALUES (41, N'Chile')
INSERT Countries (Id, Name) VALUES (42, N'China')
INSERT Countries (Id, Name) VALUES (43, N'Christmas Island')
INSERT Countries (Id, Name) VALUES (44, N'Cocos (Keeling) Islands')
INSERT Countries (Id, Name) VALUES (45, N'Colombia')
INSERT Countries (Id, Name) VALUES (46, N'Comoros')
INSERT Countries (Id, Name) VALUES (47, N'Congo')
INSERT Countries (Id, Name) VALUES (48, N'Republic of Cook Islands')
INSERT Countries (Id, Name) VALUES (49, N'Costa Rica')
INSERT Countries (Id, Name) VALUES (50, N'Croatia')
INSERT Countries (Id, Name) VALUES (51, N'Cuba')
INSERT Countries (Id, Name) VALUES (52, N'Cyprus')
INSERT Countries (Id, Name) VALUES (53, N'Czech Republic')
INSERT Countries (Id, Name) VALUES (54, N'Denmark')
INSERT Countries (Id, Name) VALUES (55, N'Djibouti')
INSERT Countries (Id, Name) VALUES (56, N'Dominica')
INSERT Countries (Id, Name) VALUES (57, N'Dominican Republic')
INSERT Countries (Id, Name) VALUES (58, N'Ecuador')
INSERT Countries (Id, Name) VALUES (59, N'Egypt')
INSERT Countries (Id, Name) VALUES (60, N'El Salvador')
INSERT Countries (Id, Name) VALUES (61, N'Equatorial Guinea')
INSERT Countries (Id, Name) VALUES (62, N'Eritrea')
INSERT Countries (Id, Name) VALUES (63, N'Estonia')
INSERT Countries (Id, Name) VALUES (64, N'Ethiopia')
INSERT Countries (Id, Name) VALUES (65, N'Falkland Islands')
INSERT Countries (Id, Name) VALUES (66, N'Faroe Islands')
INSERT Countries (Id, Name) VALUES (67, N'Fiji')
INSERT Countries (Id, Name) VALUES (68, N'Finland')
INSERT Countries (Id, Name) VALUES (69, N'France')
INSERT Countries (Id, Name) VALUES (70, N'French Guiana')
INSERT Countries (Id, Name) VALUES (71, N'Gabon')
INSERT Countries (Id, Name) VALUES (72, N'Gambia')
INSERT Countries (Id, Name) VALUES (73, N'Georgia')
INSERT Countries (Id, Name) VALUES (74, N'Germany')
INSERT Countries (Id, Name) VALUES (75, N'Ghana')
INSERT Countries (Id, Name) VALUES (76, N'Gibraltar')
INSERT Countries (Id, Name) VALUES (77, N'Greece')
INSERT Countries (Id, Name) VALUES (78, N'Greenland')
INSERT Countries (Id, Name) VALUES (79, N'Grenada')
INSERT Countries (Id, Name) VALUES (80, N'Guadeloupe')
INSERT Countries (Id, Name) VALUES (81, N'Guatemala')
INSERT Countries (Id, Name) VALUES (82, N'Guinea')
INSERT Countries (Id, Name) VALUES (83, N'Guinea Bissau')
INSERT Countries (Id, Name) VALUES (84, N'Guyana')
INSERT Countries (Id, Name) VALUES (85, N'Haiti')
INSERT Countries (Id, Name) VALUES (86, N'Holy See')
INSERT Countries (Id, Name) VALUES (87, N'Honduras')
INSERT Countries (Id, Name) VALUES (88, N'Hong Kong')
INSERT Countries (Id, Name) VALUES (89, N'Hungary')
INSERT Countries (Id, Name) VALUES (90, N'Iceland')
INSERT Countries (Id, Name) VALUES (91, N'India')
INSERT Countries (Id, Name) VALUES (92, N'Indonesia')
INSERT Countries (Id, Name) VALUES (93, N'Iran')
INSERT Countries (Id, Name) VALUES (94, N'Iraq')
INSERT Countries (Id, Name) VALUES (95, N'Ireland')
INSERT Countries (Id, Name) VALUES (96, N'Israel')
INSERT Countries (Id, Name) VALUES (97, N'Italy')
INSERT Countries (Id, Name) VALUES (98, N'Ivory Coast')
INSERT Countries (Id, Name) VALUES (99, N'Jamaica')
INSERT Countries (Id, Name) VALUES (100, N'Japan')
INSERT Countries (Id, Name) VALUES (101, N'Jordan')
INSERT Countries (Id, Name) VALUES (102, N'Kazakhstan')
INSERT Countries (Id, Name) VALUES (103, N'Kenya')
INSERT Countries (Id, Name) VALUES (104, N'Kiribati')
INSERT Countries (Id, Name) VALUES (105, N'Kuwait')
INSERT Countries (Id, Name) VALUES (106, N'Kyrgyzstan')
INSERT Countries (Id, Name) VALUES (107, N'Laos')
INSERT Countries (Id, Name) VALUES (108, N'Latvia')
INSERT Countries (Id, Name) VALUES (109, N'Lebanon')
INSERT Countries (Id, Name) VALUES (110, N'Lesotho')
INSERT Countries (Id, Name) VALUES (111, N'Liberia')
INSERT Countries (Id, Name) VALUES (112, N'Libya')
INSERT Countries (Id, Name) VALUES (113, N'Liechtenstein')
INSERT Countries (Id, Name) VALUES (114, N'Lithuania')
INSERT Countries (Id, Name) VALUES (115, N'Luxembourg')
INSERT Countries (Id, Name) VALUES (116, N'Macau')
INSERT Countries (Id, Name) VALUES (117, N'Macedonia')
INSERT Countries (Id, Name) VALUES (118, N'Madagascar')
INSERT Countries (Id, Name) VALUES (119, N'Malawi')
INSERT Countries (Id, Name) VALUES (120, N'Malaysia')
INSERT Countries (Id, Name) VALUES (121, N'Maldives')
INSERT Countries (Id, Name) VALUES (122, N'Mali')
INSERT Countries (Id, Name) VALUES (123, N'Malta')
INSERT Countries (Id, Name) VALUES (124, N'Marshall Islands')
INSERT Countries (Id, Name) VALUES (125, N'Martinique')
INSERT Countries (Id, Name) VALUES (126, N'Mauritania')
INSERT Countries (Id, Name) VALUES (127, N'Mauritius')
INSERT Countries (Id, Name) VALUES (128, N'Mayotte')
INSERT Countries (Id, Name) VALUES (129, N'Mexico')
INSERT Countries (Id, Name) VALUES (130, N'Micronesia')
INSERT Countries (Id, Name) VALUES (131, N'Moldova')
INSERT Countries (Id, Name) VALUES (132, N'Monaco')
INSERT Countries (Id, Name) VALUES (133, N'Mongolia')
INSERT Countries (Id, Name) VALUES (134, N'Montenegro')
INSERT Countries (Id, Name) VALUES (135, N'Montserrat')
INSERT Countries (Id, Name) VALUES (136, N'Morocco')
INSERT Countries (Id, Name) VALUES (137, N'Mozambique')
INSERT Countries (Id, Name) VALUES (138, N'Myanmar')
INSERT Countries (Id, Name) VALUES (139, N'Namibia')
INSERT Countries (Id, Name) VALUES (140, N'Nauru')
INSERT Countries (Id, Name) VALUES (141, N'Nepal')
INSERT Countries (Id, Name) VALUES (142, N'Netherlands')
INSERT Countries (Id, Name) VALUES (143, N'Netherlands Antilles')
INSERT Countries (Id, Name) VALUES (144, N'New Caledonia')
INSERT Countries (Id, Name) VALUES (145, N'New Zealand')
INSERT Countries (Id, Name) VALUES (146, N'Nicaragua')
INSERT Countries (Id, Name) VALUES (147, N'Niger')
INSERT Countries (Id, Name) VALUES (148, N'Nigeria')
INSERT Countries (Id, Name) VALUES (149, N'Niue')
INSERT Countries (Id, Name) VALUES (150, N'Norfolk Island')
INSERT Countries (Id, Name) VALUES (151, N'North Korea')
INSERT Countries (Id, Name) VALUES (152, N'Northern Mariana Islands')
INSERT Countries (Id, Name) VALUES (153, N'Norway')
INSERT Countries (Id, Name) VALUES (154, N'Oman')
INSERT Countries (Id, Name) VALUES (155, N'Pakistan')
INSERT Countries (Id, Name) VALUES (156, N'Palau')
INSERT Countries (Id, Name) VALUES (157, N'Panama')
INSERT Countries (Id, Name) VALUES (158, N'Papua New Guinea')
INSERT Countries (Id, Name) VALUES (159, N'Paraguay')
INSERT Countries (Id, Name) VALUES (160, N'Peru')
INSERT Countries (Id, Name) VALUES (161, N'Philippines')
INSERT Countries (Id, Name) VALUES (162, N'Pitcairn Island')
INSERT Countries (Id, Name) VALUES (163, N'Poland')
INSERT Countries (Id, Name) VALUES (164, N'Polynesia')
INSERT Countries (Id, Name) VALUES (165, N'Portugal')
INSERT Countries (Id, Name) VALUES (166, N'Puerto Rico')
INSERT Countries (Id, Name) VALUES (167, N'Qatar')
INSERT Countries (Id, Name) VALUES (168, N'Reunion')
INSERT Countries (Id, Name) VALUES (169, N'Romania')
INSERT Countries (Id, Name) VALUES (170, N'Russia')
INSERT Countries (Id, Name) VALUES (171, N'Rwanda')
INSERT Countries (Id, Name) VALUES (172, N'Saint Helena')
INSERT Countries (Id, Name) VALUES (173, N'Saint Kitts and Nevis')
INSERT Countries (Id, Name) VALUES (174, N'Saint Lucia')
INSERT Countries (Id, Name) VALUES (175, N'Saint Pierre and Miquelon')
INSERT Countries (Id, Name) VALUES (176, N'Saint Vincent and Grenadines')
INSERT Countries (Id, Name) VALUES (177, N'Samoa')
INSERT Countries (Id, Name) VALUES (178, N'San Marino')
INSERT Countries (Id, Name) VALUES (179, N'Sao Tome and Principe')
INSERT Countries (Id, Name) VALUES (180, N'Saudi Arabia')
INSERT Countries (Id, Name) VALUES (181, N'Senegal')
INSERT Countries (Id, Name) VALUES (182, N'Serbia')
INSERT Countries (Id, Name) VALUES (183, N'Seychelles')
INSERT Countries (Id, Name) VALUES (184, N'Sierra Leone')
INSERT Countries (Id, Name) VALUES (185, N'Singapore')
INSERT Countries (Id, Name) VALUES (186, N'Slovakia')
INSERT Countries (Id, Name) VALUES (187, N'Slovenia')
INSERT Countries (Id, Name) VALUES (188, N'Solomon Islands')
INSERT Countries (Id, Name) VALUES (189, N'Somalia')
INSERT Countries (Id, Name) VALUES (190, N'South Africa')
INSERT Countries (Id, Name) VALUES (191, N'South Georgia and South Sandwich Islands')
INSERT Countries (Id, Name) VALUES (192, N'South Korea')
INSERT Countries (Id, Name) VALUES (193, N'South Sudan')
INSERT Countries (Id, Name) VALUES (194, N'Spain')
INSERT Countries (Id, Name) VALUES (195, N'Sri Lanka')
INSERT Countries (Id, Name) VALUES (196, N'Sudan')
INSERT Countries (Id, Name) VALUES (197, N'Suriname')
INSERT Countries (Id, Name) VALUES (198, N'Svalbard and Jan Mayen Islands')
INSERT Countries (Id, Name) VALUES (199, N'Swaziland')
INSERT Countries (Id, Name) VALUES (200, N'Sweden')
INSERT Countries (Id, Name) VALUES (201, N'Switzerland')
INSERT Countries (Id, Name) VALUES (202, N'Syria')
INSERT Countries (Id, Name) VALUES (203, N'Taiwan')
INSERT Countries (Id, Name) VALUES (204, N'Tajikistan')
INSERT Countries (Id, Name) VALUES (205, N'Tanzania')
INSERT Countries (Id, Name) VALUES (206, N'Thailand')
INSERT Countries (Id, Name) VALUES (207, N'Timor-Leste')
INSERT Countries (Id, Name) VALUES (208, N'Togo')
INSERT Countries (Id, Name) VALUES (209, N'Tokelau')
INSERT Countries (Id, Name) VALUES (210, N'Tonga')
INSERT Countries (Id, Name) VALUES (211, N'Trinidad and Tobago')
INSERT Countries (Id, Name) VALUES (212, N'Tunisia')
INSERT Countries (Id, Name) VALUES (213, N'Turkey')
INSERT Countries (Id, Name) VALUES (214, N'Turkmenistan')
INSERT Countries (Id, Name) VALUES (215, N'Turks and Caicos Islands')
INSERT Countries (Id, Name) VALUES (216, N'Tuvalu')
INSERT Countries (Id, Name) VALUES (217, N'Uganda')
INSERT Countries (Id, Name) VALUES (218, N'Ukraine')
INSERT Countries (Id, Name) VALUES (219, N'United Arab Emirates')
INSERT Countries (Id, Name) VALUES (220, N'United Kingdom')
INSERT Countries (Id, Name) VALUES (221, N'United States')
INSERT Countries (Id, Name) VALUES (222, N'Uruguay')
INSERT Countries (Id, Name) VALUES (223, N'Uzbekistan')
INSERT Countries (Id, Name) VALUES (224, N'Vanuatu')
INSERT Countries (Id, Name) VALUES (225, N'Venezuela')
INSERT Countries (Id, Name) VALUES (226, N'Vietnam')
INSERT Countries (Id, Name) VALUES (227, N'Virgin Islands')
INSERT Countries (Id, Name) VALUES (228, N'Wallis and Futuna Islands')
INSERT Countries (Id, Name) VALUES (229, N'Yemen')
INSERT Countries (Id, Name) VALUES (230, N'Zealand')
INSERT Countries (Id, Name) VALUES (231, N'Zimbabwe')
GO

INSERT MatchTime (Id, Name) VALUES (1, N'first half')
INSERT MatchTime (Id, Name) VALUES (2, N'second half')
INSERT MatchTime (Id, Name) VALUES (3, N'overtime')
INSERT MatchTime (Id, Name) VALUES (4, N'penalties')
GO

INSERT Association (Id, Name) VALUES (1, N'AFC')
INSERT Association (Id, Name) VALUES (2, N'CAF')
INSERT Association (Id, Name) VALUES (3, N'CONCACAF')
INSERT Association (Id, Name) VALUES (4, N'CONMEBOL')
INSERT Association (Id, Name) VALUES (5, N'OFC')
INSERT Association (Id, Name) VALUES (6, N'UEFA ')
GO

INSERT TypeFoul (Id, Name, Comments) VALUES (1, N'warning', NULL)
INSERT TypeFoul (Id, Name, Comments) VALUES (2, N'yellow card', NULL)
INSERT TypeFoul (Id, Name, Comments) VALUES (3, N'red card', NULL)
INSERT TypeFoul (Id, Name, Comments) VALUES (4, N'sending off (second yellow card)', NULL)
GO

INSERT RefereesPosition (Id, Name) VALUES (1, N'linesman')
INSERT RefereesPosition (Id, Name) VALUES (2, N'main referee')
GO

INSERT BrandsForm (Id, Name) VALUES (1, N'Adidas')
INSERT BrandsForm (Id, Name) VALUES (2, N'Nike')
INSERT BrandsForm (Id, Name) VALUES (3, N'Puma')
INSERT BrandsForm (Id, Name) VALUES (4, N'Umbro')
INSERT BrandsForm (Id, Name) VALUES (5, N'Joma')
INSERT BrandsForm (Id, Name) VALUES (6, N'Brooks')
INSERT BrandsForm (Id, Name) VALUES (7, N'Legea')
GO

INSERT Citys (Id, Name) VALUES (1, N'Bloemfontein')
INSERT Citys (Id, Name) VALUES (2, N'Cape Town')
INSERT Citys (Id, Name) VALUES (3, N'Durban')
INSERT Citys (Id, Name) VALUES (4, N'Johannesburg')
INSERT Citys (Id, Name) VALUES (5, N'Kimberley')
INSERT Citys (Id, Name) VALUES (6, N'Klerksdorp')
INSERT Citys (Id, Name) VALUES (7, N'Nelspruit')
INSERT Citys (Id, Name) VALUES (8, N'Orkney')
INSERT Citys (Id, Name) VALUES (9, N'Polokwane')
INSERT Citys (Id, Name) VALUES (10, N'Port Elizabeth')
INSERT Citys (Id, Name) VALUES (11, N'Pretoria')
INSERT Citys (Id, Name) VALUES (12, N'Rustenburg')
GO

INSERT Groups (Id, Name) VALUES (1, N'A')
INSERT Groups (Id, Name) VALUES (2, N'B')
INSERT Groups (Id, Name) VALUES (3, N'C')
INSERT Groups (Id, Name) VALUES (4, N'D')
INSERT Groups (Id, Name) VALUES (5, N'E')
INSERT Groups (Id, Name) VALUES (6, N'F')
INSERT Groups (Id, Name) VALUES (7, N'G')
INSERT Groups (Id, Name) VALUES (8, N'H')
GO

INSERT Colors (Id, Name) VALUES (1, N'aqua')
INSERT Colors (Id, Name) VALUES (2, N'beige')
INSERT Colors (Id, Name) VALUES (3, N'black')
INSERT Colors (Id, Name) VALUES (4, N'blue')
INSERT Colors (Id, Name) VALUES (5, N'brown')
INSERT Colors (Id, Name) VALUES (6, N'coral')
INSERT Colors (Id, Name) VALUES (7, N'cornflower')
INSERT Colors (Id, Name) VALUES (8, N'dark blue')
INSERT Colors (Id, Name) VALUES (9, N'dark gray')
INSERT Colors (Id, Name) VALUES (10, N'dark green')
INSERT Colors (Id, Name) VALUES (11, N'dark red')
INSERT Colors (Id, Name) VALUES (12, N'dark yellow')
INSERT Colors (Id, Name) VALUES (13, N'deep blue')
INSERT Colors (Id, Name) VALUES (14, N'deep-brown')
INSERT Colors (Id, Name) VALUES (15, N'deep-green')
INSERT Colors (Id, Name) VALUES (16, N'denim blue')
INSERT Colors (Id, Name) VALUES (17, N'emerald')
INSERT Colors (Id, Name) VALUES (18, N'fallow')
INSERT Colors (Id, Name) VALUES (19, N'firebrick')
INSERT Colors (Id, Name) VALUES (20, N'golden')
INSERT Colors (Id, Name) VALUES (21, N'gray')
INSERT Colors (Id, Name) VALUES (22, N'green')
INSERT Colors (Id, Name) VALUES (23, N'green yellow')
INSERT Colors (Id, Name) VALUES (24, N'grey')
INSERT Colors (Id, Name) VALUES (25, N'indigo')
INSERT Colors (Id, Name) VALUES (26, N'lemon')
INSERT Colors (Id, Name) VALUES (27, N'light blue')
INSERT Colors (Id, Name) VALUES (28, N'light-green')
INSERT Colors (Id, Name) VALUES (29, N'lilac')
INSERT Colors (Id, Name) VALUES (30, N'magenta')
INSERT Colors (Id, Name) VALUES (31, N'maroon')
INSERT Colors (Id, Name) VALUES (32, N'navy')
INSERT Colors (Id, Name) VALUES (33, N'olive green')
INSERT Colors (Id, Name) VALUES (34, N'orange')
INSERT Colors (Id, Name) VALUES (35, N'pale pink')
INSERT Colors (Id, Name) VALUES (36, N'peach')
INSERT Colors (Id, Name) VALUES (37, N'pink')
INSERT Colors (Id, Name) VALUES (38, N'purple')
INSERT Colors (Id, Name) VALUES (39, N'red')
INSERT Colors (Id, Name) VALUES (40, N'sienna')
INSERT Colors (Id, Name) VALUES (41, N'silvery')
INSERT Colors (Id, Name) VALUES (42, N'sky blue')
INSERT Colors (Id, Name) VALUES (43, N'snow')
INSERT Colors (Id, Name) VALUES (44, N'spice orange')
INSERT Colors (Id, Name) VALUES (45, N'tawny')
INSERT Colors (Id, Name) VALUES (46, N'turquoise')
INSERT Colors (Id, Name) VALUES (47, N'vinous')
INSERT Colors (Id, Name) VALUES (48, N'white')
INSERT Colors (Id, Name) VALUES (49, N'yellow')
INSERT Colors (Id, Name) VALUES (50, N'yellow green')
GO

INSERT Names (Id, Name) VALUES (1, N'Moeneeb')
INSERT Names (Id, Name) VALUES (2, N'Itumeleng')
INSERT Names (Id, Name) VALUES (3, N'Shu-Aib')
INSERT Names (Id, Name) VALUES (4, N'Siboniso')
INSERT Names (Id, Name) VALUES (5, N'Tsepo ')
INSERT Names (Id, Name) VALUES (6, N'Aaron')
INSERT Names (Id, Name) VALUES (7, N'Anele')
INSERT Names (Id, Name) VALUES (8, N'Matthew')
INSERT Names (Id, Name) VALUES (9, N'Lucas')
INSERT Names (Id, Name) VALUES (10, N'Bongani')
INSERT Names (Id, Name) VALUES (11, N'Siyabonga')
INSERT Names (Id, Name) VALUES (12, N'MacBeth')
INSERT Names (Id, Name) VALUES (13, N'Lance')
INSERT Names (Id, Name) VALUES (14, N'Siphiwe')
INSERT Names (Id, Name) VALUES (15, N'Steven')
INSERT Names (Id, Name) VALUES (16, N'Teko')
INSERT Names (Id, Name) VALUES (17, N'Reneilwe')
INSERT Names (Id, Name) VALUES (18, N'Kagisho')
INSERT Names (Id, Name) VALUES (19, N'Surprise')
INSERT Names (Id, Name) VALUES (20, N'Thanduyise')
INSERT Names (Id, Name) VALUES (21, N'Katlego')
INSERT Names (Id, Name) VALUES (22, N'Bernard')
INSERT Names (Id, Name) VALUES (23, N'Siyabonga')
INSERT Names (Id, Name) VALUES (24, N'Óscar')
INSERT Names (Id, Name) VALUES (25, N'Guillermo')
INSERT Names (Id, Name) VALUES (26, N'Luis')
INSERT Names (Id, Name) VALUES (27, N'Francisco')
INSERT Names (Id, Name) VALUES (28, N'Carlos')
INSERT Names (Id, Name) VALUES (29, N'Rafael')
INSERT Names (Id, Name) VALUES (30, N'Ricardo')
INSERT Names (Id, Name) VALUES (31, N'Paul')
INSERT Names (Id, Name) VALUES (32, N'Héctor')
INSERT Names (Id, Name) VALUES (33, N'Efraín')
INSERT Names (Id, Name) VALUES (34, N'Jonny')
INSERT Names (Id, Name) VALUES (35, N'Jorge')
INSERT Names (Id, Name) VALUES (36, N'Gerardo')
INSERT Names (Id, Name) VALUES (37, N'Pablo')
INSERT Names (Id, Name) VALUES (38, N'Israel')
INSERT Names (Id, Name) VALUES (39, N'Andrés')
INSERT Names (Id, Name) VALUES (40, N'Alberto')
INSERT Names (Id, Name) VALUES (41, N'Guillermo')
INSERT Names (Id, Name) VALUES (42, N'Cuauhtémoc')
INSERT Names (Id, Name) VALUES (43, N'Carlos')
INSERT Names (Id, Name) VALUES (44, N'Javier')
INSERT Names (Id, Name) VALUES (45, N'Giovani')
INSERT Names (Id, Name) VALUES (46, N'Adolfo')
INSERT Names (Id, Name) VALUES (47, N'Fernando')
INSERT Names (Id, Name) VALUES (48, N'Juan')
INSERT Names (Id, Name) VALUES (49, N'Martín')
INSERT Names (Id, Name) VALUES (50, N'Ignacio')
INSERT Names (Id, Name) VALUES (51, N'Diego')
INSERT Names (Id, Name) VALUES (52, N'Jorge')
INSERT Names (Id, Name) VALUES (53, N'Mauricio')
INSERT Names (Id, Name) VALUES (54, N'Maxi')
INSERT Names (Id, Name) VALUES (55, N'Andrés')
INSERT Names (Id, Name) VALUES (56, N'Martín')
INSERT Names (Id, Name) VALUES (57, N'Walter')
INSERT Names (Id, Name) VALUES (58, N'Sebastián')
INSERT Names (Id, Name) VALUES (59, N'Álvaro')
INSERT Names (Id, Name) VALUES (60, N'Nicolás')
INSERT Names (Id, Name) VALUES (61, N'Egidio')
INSERT Names (Id, Name) VALUES (62, N'Ignacio')
INSERT Names (Id, Name) VALUES (63, N'Álvaro')
INSERT Names (Id, Name) VALUES (64, N'Edinson')
INSERT Names (Id, Name) VALUES (65, N'Luis')
INSERT Names (Id, Name) VALUES (66, N'Sebastián')
INSERT Names (Id, Name) VALUES (67, N'Hugo')
INSERT Names (Id, Name) VALUES (68, N'Steve')
INSERT Names (Id, Name) VALUES (69, N'Cédric')
INSERT Names (Id, Name) VALUES (70, N'Bacary')
INSERT Names (Id, Name) VALUES (71, N'Éric')
INSERT Names (Id, Name) VALUES (72, N'Anthony')
INSERT Names (Id, Name) VALUES (73, N'William')
INSERT Names (Id, Name) VALUES (74, N'Marc')
INSERT Names (Id, Name) VALUES (75, N'Patrice')
INSERT Names (Id, Name) VALUES (76, N'Sébastien')
INSERT Names (Id, Name) VALUES (77, N'Gaël')
INSERT Names (Id, Name) VALUES (78, N'Franck')
INSERT Names (Id, Name) VALUES (79, N'Yoann')
INSERT Names (Id, Name) VALUES (80, N'Jérémy')
INSERT Names (Id, Name) VALUES (81, N'Florent')
INSERT Names (Id, Name) VALUES (82, N'Alou')
INSERT Names (Id, Name) VALUES (83, N'Abou')
INSERT Names (Id, Name) VALUES (84, N'Mathieu')
INSERT Names (Id, Name) VALUES (85, N'Djibril')
INSERT Names (Id, Name) VALUES (86, N'Sidney')
INSERT Names (Id, Name) VALUES (87, N'André-Pierre')
INSERT Names (Id, Name) VALUES (88, N'Thierry')
INSERT Names (Id, Name) VALUES (89, N'Nicolas')
INSERT Names (Id, Name) VALUES (90, N'Diego')
INSERT Names (Id, Name) VALUES (91, N'Mariano')
INSERT Names (Id, Name) VALUES (92, N'Sergio')
INSERT Names (Id, Name) VALUES (93, N'Martín')
INSERT Names (Id, Name) VALUES (94, N'Clemente')
INSERT Names (Id, Name) VALUES (95, N'Nicolás')
INSERT Names (Id, Name) VALUES (96, N'Gabriel')
INSERT Names (Id, Name) VALUES (97, N'Ariel')
INSERT Names (Id, Name) VALUES (98, N'Walter')
INSERT Names (Id, Name) VALUES (99, N'Mario')
INSERT Names (Id, Name) VALUES (100, N'Ángel')
INSERT Names (Id, Name) VALUES (101, N'Juan')
INSERT Names (Id, Name) VALUES (102, N'Javier')
INSERT Names (Id, Name) VALUES (103, N'Jonás')
INSERT Names (Id, Name) VALUES (104, N'Maxi')
INSERT Names (Id, Name) VALUES (105, N'Javier')
INSERT Names (Id, Name) VALUES (106, N'Gonzalo')
INSERT Names (Id, Name) VALUES (107, N'Lionel')
INSERT Names (Id, Name) VALUES (108, N'Carlos')
INSERT Names (Id, Name) VALUES (109, N'Sergio')
INSERT Names (Id, Name) VALUES (110, N'Martín')
INSERT Names (Id, Name) VALUES (111, N'Vincent')
INSERT Names (Id, Name) VALUES (112, N'Austin')
INSERT Names (Id, Name) VALUES (113, N'Dele')
INSERT Names (Id, Name) VALUES (114, N'Joseph')
INSERT Names (Id, Name) VALUES (115, N'Taye')
INSERT Names (Id, Name) VALUES (116, N'Rabiu')
INSERT Names (Id, Name) VALUES (117, N'Danny')
INSERT Names (Id, Name) VALUES (118, N'Chidi')
INSERT Names (Id, Name) VALUES (119, N'Uwa')
INSERT Names (Id, Name) VALUES (120, N'Ayila')
INSERT Names (Id, Name) VALUES (121, N'Sani')
INSERT Names (Id, Name) VALUES (122, N'Lukman')
INSERT Names (Id, Name) VALUES (123, N'Dickson')
INSERT Names (Id, Name) VALUES (124, N'Nwankwo')
INSERT Names (Id, Name) VALUES (125, N'John')
INSERT Names (Id, Name) VALUES (126, N'Yakubu')
INSERT Names (Id, Name) VALUES (127, N'Obafemi')
INSERT Names (Id, Name) VALUES (128, N'Brown')
INSERT Names (Id, Name) VALUES (129, N'Peter')
INSERT Names (Id, Name) VALUES (130, N'Kalu')
INSERT Names (Id, Name) VALUES (131, N'Victor')
INSERT Names (Id, Name) VALUES (132, N'Chinedu')
INSERT Names (Id, Name) VALUES (133, N'Lee')
INSERT Names (Id, Name) VALUES (134, N'Jung')
INSERT Names (Id, Name) VALUES (135, N'Kim')
INSERT Names (Id, Name) VALUES (136, N'Oh')
INSERT Names (Id, Name) VALUES (137, N'Kim')
INSERT Names (Id, Name) VALUES (138, N'Lee')
INSERT Names (Id, Name) VALUES (139, N'Cha')
INSERT Names (Id, Name) VALUES (140, N'Kang')
INSERT Names (Id, Name) VALUES (141, N'Cho')
INSERT Names (Id, Name) VALUES (142, N'Park')
INSERT Names (Id, Name) VALUES (143, N'Ki')
INSERT Names (Id, Name) VALUES (144, N'Ahn')
INSERT Names (Id, Name) VALUES (145, N'Yeom')
INSERT Names (Id, Name) VALUES (146, N'Kostas')
INSERT Names (Id, Name) VALUES (147, N'Alexandros')
INSERT Names (Id, Name) VALUES (148, N'Michalis')
INSERT Names (Id, Name) VALUES (149, N'Giourkas')
INSERT Names (Id, Name) VALUES (150, N'Christos')
INSERT Names (Id, Name) VALUES (151, N'Vangelis')
INSERT Names (Id, Name) VALUES (152, N'Avraam')
INSERT Names (Id, Name) VALUES (153, N'Loukas')
INSERT Names (Id, Name) VALUES (154, N'Vasilis')
INSERT Names (Id, Name) VALUES (155, N'Sotirios')
INSERT Names (Id, Name) VALUES (156, N'Sokratis')
INSERT Names (Id, Name) VALUES (157, N'Stelios')
INSERT Names (Id, Name) VALUES (158, N'Nikos')
INSERT Names (Id, Name) VALUES (159, N'Alexandros')
INSERT Names (Id, Name) VALUES (160, N'Giorgos')
GO
					
INSERT Surnames (Id, Surname) VALUES (1, N'Josephs')
INSERT Surnames (Id, Surname) VALUES (2, N' Khune')
INSERT Surnames (Id, Surname) VALUES (3, N'Walters')
INSERT Surnames (Id, Surname) VALUES (4, N'Gaxa')
INSERT Surnames (Id, Surname) VALUES (5, N'Masilela')
INSERT Surnames (Id, Surname) VALUES (6, N'Mokoena')
INSERT Surnames (Id, Surname) VALUES (7, N'Ngcongca')
INSERT Surnames (Id, Surname) VALUES (8, N'Booth')
INSERT Surnames (Id, Surname) VALUES (9, N'Thwala')
INSERT Surnames (Id, Surname) VALUES (10, N'Khumalo')
INSERT Surnames (Id, Surname) VALUES (11, N'Sangweni')
INSERT Surnames (Id, Surname) VALUES (12, N'Sibaya')
INSERT Surnames (Id, Surname) VALUES (13, N'Davids')
INSERT Surnames (Id, Surname) VALUES (14, N'Tshabalala')
INSERT Surnames (Id, Surname) VALUES (15, N'Pienaar')
INSERT Surnames (Id, Surname) VALUES (16, N'Modise')
INSERT Surnames (Id, Surname) VALUES (17, N'Letsholonyane')
INSERT Surnames (Id, Surname) VALUES (18, N'Dikgacoi')
INSERT Surnames (Id, Surname) VALUES (19, N'Moriri')
INSERT Surnames (Id, Surname) VALUES (20, N'Khuboni')
INSERT Surnames (Id, Surname) VALUES (21, N'Mphela')
INSERT Surnames (Id, Surname) VALUES (22, N'Parker')
INSERT Surnames (Id, Surname) VALUES (23, N'Nomvethe')
INSERT Surnames (Id, Surname) VALUES (24, N'Pérez')
INSERT Surnames (Id, Surname) VALUES (25, N'Ochoa')
INSERT Surnames (Id, Surname) VALUES (26, N'Ernesto Michel')
INSERT Surnames (Id, Surname) VALUES (27, N'Rodríguez')
INSERT Surnames (Id, Surname) VALUES (28, N'Salcido')
INSERT Surnames (Id, Surname) VALUES (29, N'Márquez')
INSERT Surnames (Id, Surname) VALUES (30, N'Osorio')
INSERT Surnames (Id, Surname) VALUES (31, N'Aguilar')
INSERT Surnames (Id, Surname) VALUES (32, N'Moreno')
INSERT Surnames (Id, Surname) VALUES (33, N'Juárez')
INSERT Surnames (Id, Surname) VALUES (34, N'Magallón')
INSERT Surnames (Id, Surname) VALUES (35, N'Torres Nilo')
INSERT Surnames (Id, Surname) VALUES (36, N'Torrado')
INSERT Surnames (Id, Surname) VALUES (37, N'Barrera')
INSERT Surnames (Id, Surname) VALUES (38, N'Castro')
INSERT Surnames (Id, Surname) VALUES (39, N'Guardado')
INSERT Surnames (Id, Surname) VALUES (40, N'Medina')
INSERT Surnames (Id, Surname) VALUES (41, N'Franco')
INSERT Surnames (Id, Surname) VALUES (42, N'Blanco')
INSERT Surnames (Id, Surname) VALUES (43, N'Vela')
INSERT Surnames (Id, Surname) VALUES (44, N'Hernández')
INSERT Surnames (Id, Surname) VALUES (45, N'dos Santos')
INSERT Surnames (Id, Surname) VALUES (46, N'Bautista')
INSERT Surnames (Id, Surname) VALUES (47, N' Muslera')
INSERT Surnames (Id, Surname) VALUES (48, N'Castillo')
INSERT Surnames (Id, Surname) VALUES (49, N'Silva')
INSERT Surnames (Id, Surname) VALUES (50, N'Lugano')
INSERT Surnames (Id, Surname) VALUES (51, N'Godín')
INSERT Surnames (Id, Surname) VALUES (52, N'Fucile')
INSERT Surnames (Id, Surname) VALUES (53, N'Victorino')
INSERT Surnames (Id, Surname) VALUES (54, N'Pereira')
INSERT Surnames (Id, Surname) VALUES (55, N'Scotti')
INSERT Surnames (Id, Surname) VALUES (56, N'Cáceres')
INSERT Surnames (Id, Surname) VALUES (57, N'Gargano')
INSERT Surnames (Id, Surname) VALUES (58, N'Eguren')
INSERT Surnames (Id, Surname) VALUES (59, N'Pereira')
INSERT Surnames (Id, Surname) VALUES (60, N'Lodeiro')
INSERT Surnames (Id, Surname) VALUES (61, N'Pérez')
INSERT Surnames (Id, Surname) VALUES (62, N'Arévalo Ríos')
INSERT Surnames (Id, Surname) VALUES (63, N'González')
INSERT Surnames (Id, Surname) VALUES (64, N'Fernández')
INSERT Surnames (Id, Surname) VALUES (65, N'Suárez')
INSERT Surnames (Id, Surname) VALUES (66, N'Forlán')
INSERT Surnames (Id, Surname) VALUES (67, N'Abreu')
INSERT Surnames (Id, Surname) VALUES (68, N'Fernández')
INSERT Surnames (Id, Surname) VALUES (69, N'Lloris')
INSERT Surnames (Id, Surname) VALUES (70, N'Mandanda')
INSERT Surnames (Id, Surname) VALUES (71, N'Carrasso')
INSERT Surnames (Id, Surname) VALUES (72, N'Sagna')
INSERT Surnames (Id, Surname) VALUES (73, N'Abidal')
INSERT Surnames (Id, Surname) VALUES (74, N'Réveillère')
INSERT Surnames (Id, Surname) VALUES (75, N'Gallas')
INSERT Surnames (Id, Surname) VALUES (76, N'Planus')
INSERT Surnames (Id, Surname) VALUES (77, N'Evra')
INSERT Surnames (Id, Surname) VALUES (78, N'Squillaci')
INSERT Surnames (Id, Surname) VALUES (79, N'Clichy')
INSERT Surnames (Id, Surname) VALUES (80, N'Ribéry')
INSERT Surnames (Id, Surname) VALUES (81, N'Gourcuff')
INSERT Surnames (Id, Surname) VALUES (82, N'Toulalan')
INSERT Surnames (Id, Surname) VALUES (83, N'Malouda')
INSERT Surnames (Id, Surname) VALUES (84, N'Diarra')
INSERT Surnames (Id, Surname) VALUES (85, N'Diaby')
INSERT Surnames (Id, Surname) VALUES (86, N'Valbuena')
INSERT Surnames (Id, Surname) VALUES (87, N'Cissé')
INSERT Surnames (Id, Surname) VALUES (88, N'Govou')
INSERT Surnames (Id, Surname) VALUES (89, N'Gignac')
INSERT Surnames (Id, Surname) VALUES (90, N'Henry')
INSERT Surnames (Id, Surname) VALUES (91, N'Anelka')
INSERT Surnames (Id, Surname) VALUES (92, N'Pozo')
INSERT Surnames (Id, Surname) VALUES (93, N'Andújar')
INSERT Surnames (Id, Surname) VALUES (94, N'Romero')
INSERT Surnames (Id, Surname) VALUES (95, N'Demichelis')
INSERT Surnames (Id, Surname) VALUES (96, N'Rodríguez')
INSERT Surnames (Id, Surname) VALUES (97, N'Burdisso')
INSERT Surnames (Id, Surname) VALUES (98, N'Heinze')
INSERT Surnames (Id, Surname) VALUES (99, N'Garcé')
INSERT Surnames (Id, Surname) VALUES (100, N'Samuel')
INSERT Surnames (Id, Surname) VALUES (101, N'Otamendi')
INSERT Surnames (Id, Surname) VALUES (102, N'Bolatti')
INSERT Surnames (Id, Surname) VALUES (103, N'di María')
INSERT Surnames (Id, Surname) VALUES (104, N'Verón')
INSERT Surnames (Id, Surname) VALUES (105, N'Mascherano')
INSERT Surnames (Id, Surname) VALUES (106, N'Gutiérrez')
INSERT Surnames (Id, Surname) VALUES (107, N'Rodríguez')
INSERT Surnames (Id, Surname) VALUES (108, N'Pastore')
INSERT Surnames (Id, Surname) VALUES (109, N'Higuaín')
INSERT Surnames (Id, Surname) VALUES (110, N'Messi')
INSERT Surnames (Id, Surname) VALUES (111, N'Tévez')
INSERT Surnames (Id, Surname) VALUES (112, N'Agüero')
INSERT Surnames (Id, Surname) VALUES (113, N'Palermo')
INSERT Surnames (Id, Surname) VALUES (114, N'Milito')
INSERT Surnames (Id, Surname) VALUES (115, N'Enyeama')
INSERT Surnames (Id, Surname) VALUES (116, N'Ejide')
INSERT Surnames (Id, Surname) VALUES (117, N'Aiyenugba')
INSERT Surnames (Id, Surname) VALUES (118, N'Yobo')
INSERT Surnames (Id, Surname) VALUES (119, N'Taiwo')
INSERT Surnames (Id, Surname) VALUES (120, N'Afolabi')
INSERT Surnames (Id, Surname) VALUES (121, N'Shittu')
INSERT Surnames (Id, Surname) VALUES (122, N'Odiah')
INSERT Surnames (Id, Surname) VALUES (123, N'Echiéjilé')
INSERT Surnames (Id, Surname) VALUES (124, N'Adeleye')
INSERT Surnames (Id, Surname) VALUES (125, N'Yussuf')
INSERT Surnames (Id, Surname) VALUES (126, N'Kaita')
INSERT Surnames (Id, Surname) VALUES (127, N'Haruna')
INSERT Surnames (Id, Surname) VALUES (128, N'Etuhu')
INSERT Surnames (Id, Surname) VALUES (129, N'Kanu')
INSERT Surnames (Id, Surname) VALUES (130, N'Utaka')
INSERT Surnames (Id, Surname) VALUES (131, N'Aiyegbeni')
INSERT Surnames (Id, Surname) VALUES (132, N'Martins')
INSERT Surnames (Id, Surname) VALUES (133, N'Ideye[4]')
INSERT Surnames (Id, Surname) VALUES (134, N'Odemwingie')
INSERT Surnames (Id, Surname) VALUES (135, N'Uche')
INSERT Surnames (Id, Surname) VALUES (136, N'Obinna')
INSERT Surnames (Id, Surname) VALUES (137, N'Obasi')
INSERT Surnames (Id, Surname) VALUES (138, N'Woon-Jae')
INSERT Surnames (Id, Surname) VALUES (139, N'Sung-Ryong')
INSERT Surnames (Id, Surname) VALUES (140, N'Young-Kwang')
INSERT Surnames (Id, Surname) VALUES (141, N'Beom-Seok')
INSERT Surnames (Id, Surname) VALUES (142, N'Hyung-Il')
INSERT Surnames (Id, Surname) VALUES (143, N'Young-Pyo')
INSERT Surnames (Id, Surname) VALUES (144, N'Jung-Soo')
INSERT Surnames (Id, Surname) VALUES (145, N'Dong-Jin')
INSERT Surnames (Id, Surname) VALUES (146, N'Du-Ri')
INSERT Surnames (Id, Surname) VALUES (147, N'Min-Soo')
INSERT Surnames (Id, Surname) VALUES (148, N'Yong-Hyung')
INSERT Surnames (Id, Surname) VALUES (149, N'Nam-Il')
INSERT Surnames (Id, Surname) VALUES (150, N'Bo-Kyung')
INSERT Surnames (Id, Surname) VALUES (151, N'Ji-Sung')
INSERT Surnames (Id, Surname) VALUES (152, N'Jae-Sung')
INSERT Surnames (Id, Surname) VALUES (153, N'Sung-Yong')
INSERT Surnames (Id, Surname) VALUES (154, N'Chung-Yong')
INSERT Surnames (Id, Surname) VALUES (155, N'Jung-Woo')
INSERT Surnames (Id, Surname) VALUES (156, N'Jung-Hwan')
INSERT Surnames (Id, Surname) VALUES (157, N'Chu-Young')
INSERT Surnames (Id, Surname) VALUES (158, N'Seung-Yeoul')
INSERT Surnames (Id, Surname) VALUES (159, N'Ki-Hun')
INSERT Surnames (Id, Surname) VALUES (160, N'Dong-Gook')
INSERT Surnames (Id, Surname) VALUES (161, N'Chalkias')
INSERT Surnames (Id, Surname) VALUES (162, N'Tzorvas')
INSERT Surnames (Id, Surname) VALUES (163, N'Sifakis')
INSERT Surnames (Id, Surname) VALUES (164, N'Seitaridis')
INSERT Surnames (Id, Surname) VALUES (165, N'Patsatzoglou')
INSERT Surnames (Id, Surname) VALUES (166, N'Moras')
INSERT Surnames (Id, Surname) VALUES (167, N'Papadopoulos')
INSERT Surnames (Id, Surname) VALUES (168, N'Vyntra')
INSERT Surnames (Id, Surname) VALUES (169, N'Torosidis')
INSERT Surnames (Id, Surname) VALUES (170, N'Kyrgiakos')
INSERT Surnames (Id, Surname) VALUES (171, N'Papastathopoulos')
INSERT Surnames (Id, Surname) VALUES (172, N'Malezas')
INSERT Surnames (Id, Surname) VALUES (173, N'Spiropoulos')
INSERT Surnames (Id, Surname) VALUES (174, N'Tziolis')
INSERT Surnames (Id, Surname) VALUES (175, N'Ninis')
INSERT Surnames (Id, Surname) VALUES (176, N'Katsouranis')
INSERT Surnames (Id, Surname) VALUES (177, N'Prittas')
INSERT Surnames (Id, Surname) VALUES (178, N'Samaras')
INSERT Surnames (Id, Surname) VALUES (179, N'Charisteas')
INSERT Surnames (Id, Surname) VALUES (180, N'Gekas')
INSERT Surnames (Id, Surname) VALUES (181, N'Kapetanos')
INSERT Surnames (Id, Surname) VALUES (182, N'James')
INSERT Surnames (Id, Surname) VALUES (183, N'Green')
INSERT Surnames (Id, Surname) VALUES (184, N'Johnson')
INSERT Surnames (Id, Surname) VALUES (185, N'Cole')
INSERT Surnames (Id, Surname) VALUES (186, N'Dawson[5]')
INSERT Surnames (Id, Surname) VALUES (187, N'Terry')
INSERT Surnames (Id, Surname) VALUES (188, N'Warnock')
INSERT Surnames (Id, Surname) VALUES (189, N'Upson')
INSERT Surnames (Id, Surname) VALUES (190, N'Carragher')
INSERT Surnames (Id, Surname) VALUES (191, N'King')
INSERT Surnames (Id, Surname) VALUES (192, N'Gerrard')
INSERT Surnames (Id, Surname) VALUES (193, N'Lennon')
INSERT Surnames (Id, Surname) VALUES (194, N'Lampard')
INSERT Surnames (Id, Surname) VALUES (195, N'Cole')
INSERT Surnames (Id, Surname) VALUES (196, N'Barry')
INSERT Surnames (Id, Surname) VALUES (197, N'Milner')
INSERT Surnames (Id, Surname) VALUES (198, N'Wright-Phillips')
INSERT Surnames (Id, Surname) VALUES (199, N'Carrick')
INSERT Surnames (Id, Surname) VALUES (200, N'Crouch')
INSERT Surnames (Id, Surname) VALUES (201, N'Rooney')
INSERT Surnames (Id, Surname) VALUES (202, N'Defoe')
INSERT Surnames (Id, Surname) VALUES (203, N'Heskey')
INSERT Surnames (Id, Surname) VALUES (204, N'Howard')
INSERT Surnames (Id, Surname) VALUES (205, N'Guzan')
INSERT Surnames (Id, Surname) VALUES (206, N'Hahnemann')
INSERT Surnames (Id, Surname) VALUES (207, N'Spector')
INSERT Surnames (Id, Surname) VALUES (208, N'Bocanegra')
INSERT Surnames (Id, Surname) VALUES (209, N'Onyewu')
INSERT Surnames (Id, Surname) VALUES (210, N'Cherundolo')
INSERT Surnames (Id, Surname) VALUES (211, N'Bornstein')
INSERT Surnames (Id, Surname) VALUES (212, N'DeMerit')
INSERT Surnames (Id, Surname) VALUES (213, N'Goodson')
INSERT Surnames (Id, Surname) VALUES (214, N'Bradley')
INSERT Surnames (Id, Surname) VALUES (215, N'Beasley')
INSERT Surnames (Id, Surname) VALUES (216, N'Dempsey')
INSERT Surnames (Id, Surname) VALUES (217, N'Donovan')
INSERT Surnames (Id, Surname) VALUES (218, N'Holden')
INSERT Surnames (Id, Surname) VALUES (219, N'Clark')
INSERT Surnames (Id, Surname) VALUES (220, N'Francisco Torres')
INSERT Surnames (Id, Surname) VALUES (221, N'Edu')
INSERT Surnames (Id, Surname) VALUES (222, N'Feilhaber')
INSERT Surnames (Id, Surname) VALUES (223, N'Gomez')
INSERT Surnames (Id, Surname) VALUES (224, N'Buddle')
INSERT Surnames (Id, Surname) VALUES (225, N'Altidore')
INSERT Surnames (Id, Surname) VALUES (226, N'Findley')
INSERT Surnames (Id, Surname) VALUES (227, N'Gaouaoui')
INSERT Surnames (Id, Surname) VALUES (228, N'Chaouchi')
INSERT Surnames (Id, Surname) VALUES (229, N'MBohli')
INSERT Surnames (Id, Surname) VALUES (230, N'Bougherra')
INSERT Surnames (Id, Surname) VALUES (231, N'Belhadj')
INSERT Surnames (Id, Surname) VALUES (232, N'Yahia')
INSERT Surnames (Id, Surname) VALUES (233, N'Halliche')
INSERT Surnames (Id, Surname) VALUES (234, N'Bellaïd')
INSERT Surnames (Id, Surname) VALUES (235, N'Laïfaoui')
INSERT Surnames (Id, Surname) VALUES (236, N'Medjani')
INSERT Surnames (Id, Surname) VALUES (237, N'Mesbah')
INSERT Surnames (Id, Surname) VALUES (238, N'Mansouri')
INSERT Surnames (Id, Surname) VALUES (239, N'Boudebouz')
INSERT Surnames (Id, Surname) VALUES (240, N'Lacen')
INSERT Surnames (Id, Surname) VALUES (241, N'Ziani')
INSERT Surnames (Id, Surname) VALUES (242, N'Guedioura')
INSERT Surnames (Id, Surname) VALUES (243, N'Kadir')
INSERT Surnames (Id, Surname) VALUES (244, N'Abdoun')
INSERT Surnames (Id, Surname) VALUES (245, N'Ghezzal')
INSERT Surnames (Id, Surname) VALUES (246, N'Saïfi')
INSERT Surnames (Id, Surname) VALUES (247, N'Djebbour')
INSERT Surnames (Id, Surname) VALUES (248, N'Matmour')
INSERT Surnames (Id, Surname) VALUES (249, N'Handanović')
INSERT Surnames (Id, Surname) VALUES (250, N'Šeliga')
INSERT Surnames (Id, Surname) VALUES (251, N'Brečko')
INSERT Surnames (Id, Surname) VALUES (252, N'Džinić')
INSERT Surnames (Id, Surname) VALUES (253, N'Šuler')
INSERT Surnames (Id, Surname) VALUES (254, N'Cesar')
INSERT Surnames (Id, Surname) VALUES (255, N'Ilič')
INSERT Surnames (Id, Surname) VALUES (256, N'Jokić')
INSERT Surnames (Id, Surname) VALUES (257, N'Filekovič')
INSERT Surnames (Id, Surname) VALUES (258, N'Mavrič')
INSERT Surnames (Id, Surname) VALUES (259, N'Koren')
INSERT Surnames (Id, Surname) VALUES (260, N'Krhin')
INSERT Surnames (Id, Surname) VALUES (261, N'Kirm')
INSERT Surnames (Id, Surname) VALUES (262, N'Radosavljevič')
INSERT Surnames (Id, Surname) VALUES (263, N'Komac')
INSERT Surnames (Id, Surname) VALUES (264, N'Stevanovič')
INSERT Surnames (Id, Surname) VALUES (265, N'Pečnik')
INSERT Surnames (Id, Surname) VALUES (266, N'Ljubijankič')
INSERT Surnames (Id, Surname) VALUES (267, N'Birsa')
INSERT Surnames (Id, Surname) VALUES (268, N'Novakovič')
INSERT Surnames (Id, Surname) VALUES (269, N'Dedič')
INSERT Surnames (Id, Surname) VALUES (270, N'Matavž')
INSERT Surnames (Id, Surname) VALUES (271, N'Neuer')
INSERT Surnames (Id, Surname) VALUES (272, N'Wiese')
INSERT Surnames (Id, Surname) VALUES (273, N'Butt')
INSERT Surnames (Id, Surname) VALUES (274, N'Jansen')
INSERT Surnames (Id, Surname) VALUES (275, N'Friedrich')
INSERT Surnames (Id, Surname) VALUES (276, N'Aogo')
INSERT Surnames (Id, Surname) VALUES (277, N'Tasci')
INSERT Surnames (Id, Surname) VALUES (278, N'Badstuber')
INSERT Surnames (Id, Surname) VALUES (279, N'Lahm')
INSERT Surnames (Id, Surname) VALUES (280, N'Mertesacker')
INSERT Surnames (Id, Surname) VALUES (281, N'Boateng')
INSERT Surnames (Id, Surname) VALUES (282, N'Khedira')
INSERT Surnames (Id, Surname) VALUES (283, N'Schweinsteiger')
INSERT Surnames (Id, Surname) VALUES (284, N'Özil')
INSERT Surnames (Id, Surname) VALUES (285, N'Podolski')
INSERT Surnames (Id, Surname) VALUES (286, N'Müller')
INSERT Surnames (Id, Surname) VALUES (287, N'Trochowski')
INSERT Surnames (Id, Surname) VALUES (288, N'Kroos')
INSERT Surnames (Id, Surname) VALUES (289, N'Marin')
INSERT Surnames (Id, Surname) VALUES (290, N'Kießling')
INSERT Surnames (Id, Surname) VALUES (291, N'Klose')
INSERT Surnames (Id, Surname) VALUES (292, N'Cacau')
INSERT Surnames (Id, Surname) VALUES (293, N'Gómez')
INSERT Surnames (Id, Surname) VALUES (294, N'Schwarzer')
INSERT Surnames (Id, Surname) VALUES (295, N'Federici')
INSERT Surnames (Id, Surname) VALUES (296, N'Galeković[6]')
INSERT Surnames (Id, Surname) VALUES (297, N'Neill')
INSERT Surnames (Id, Surname) VALUES (298, N'Moore')
INSERT Surnames (Id, Surname) VALUES (299, N'Beauchamp')
INSERT Surnames (Id, Surname) VALUES (300, N'Wilkshire')
INSERT Surnames (Id, Surname) VALUES (301, N'Chipperfield')
INSERT Surnames (Id, Surname) VALUES (302, N'Milligan')
INSERT Surnames (Id, Surname) VALUES (303, N'Carney')
GO

DECLARE @IdReferees int = 1;
WHILE (@IdReferees < 22)
BEGIN
	INSERT Referees(Id, NamesFk, SurnamesFk, AssociationFk, RefereesPositionFk) VALUES (@IdReferees, ABS(CHECKSUM(NEWID())) % 160 + 1, ABS(CHECKSUM(NEWID())) % 303 + 1, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 2 + 1)
	SET @IdReferees += 1;
END
GO

DECLARE @IdColorShapes int = 1;
WHILE (@IdColorShapes < 33)
BEGIN
	INSERT ColorShapes(Id, MainColorFk, SecondaryColorFk) VALUES (@IdColorShapes, ABS(CHECKSUM(NEWID())) % 50 + 1, ABS(CHECKSUM(NEWID())) % 50 + 1)
	SET @IdColorShapes += 1;
END
GO

INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (1, 12, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (2, 100, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (3, 151, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (4, 192, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (5, 3, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (6, 35, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (7, 75, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (8, 98, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (9, 148, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (10, 190, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (11, 87, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (12, 129, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (13, 221, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (14, 9, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (15, 29, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (16, 41, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (17, 165, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (18, 222, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (19, 230, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (20, 54, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (21, 220, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (22, 69, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (23, 74, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (24, 77, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (25, 97, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (26, 142, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (27, 165, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (28, 182, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (29, 186, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (30, 187, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (31, 194, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
INSERT Commands(Id, CountriesFk, BrandsFormFk, ColorShapesFk) VALUES (32, 201, ABS(CHECKSUM(NEWID())) % 6 + 1, ABS(CHECKSUM(NEWID())) % 32 + 1)
GO





DECLARE @IdPlayers int = 1;
DECLARE @IdCommands int = 1;
DECLARE @GK int = 1;
DECLARE @DF int = 4;
DECLARE @MF int = 12;
DECLARE @FW int = 21;
DECLARE @PositionPlayersFk int = 1;
WHILE (@IdPlayers < 737)
BEGIN
	IF (@IdPlayers >= @GK AND @IdPlayers < @GK + 3)
		SET @PositionPlayersFk = 1;
	IF (@IdPlayers >= @DF AND @IdPlayers < @DF + 8)
		SET @PositionPlayersFk = 2;
	IF (@IdPlayers >= @MF AND @IdPlayers < @MF + 9)
		SET @PositionPlayersFk = 3;
	IF (@IdPlayers >= @FW AND @IdPlayers < @FW + 3)
		SET @PositionPlayersFk = 4;
	INSERT Players(Id, CommandsFk, PositionPlayersFk, NamesFk, SurnamesFk, Age) VALUES (@IdPlayers, @IdCommands, @PositionPlayersFk, ABS(CHECKSUM(NEWID())) % 160 + 1, ABS(CHECKSUM(NEWID())) % 303 + 1, ABS(CHECKSUM(NEWID())) % 25 + 18)
	IF (@IdPlayers % 23 = 0)
		BEGIN
		SET @IdCommands += 1;
		SET @GK += 23;
		SET @DF += 23;
		SET @MF += 23;
		SET @FW += 23;
		END
		SET @IdPlayers += 1;
END
GO

INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (1, N'Soccer City', 4, 84490)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (2, N'Loftus Versfeld Stadium', 11, 42858)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (3, N'Peter Mokaba Stadium', 9, 41733)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (4, N'Cape Town Stadium', 2, 64100)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (5, N'Mbombela Stadium', 7, 40929)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (6, N'Moses Mabhida Stadium', 3, 62760)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (7, N'Ellis Park Stadium', 4, 55686)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (8, N'Nelson Mandela Bay Stadium', 10, 42486)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (9, N'Free State Stadium', 1, 40911)
INSERT Stadiums(Id, Name, CitysFk, NumberOfSeats) VALUES (10, N'Royal Bafokeng Stadium', 12, 38646)
GO

INSERT Achievements (Id, Name) VALUES (1, N'winner')
INSERT Achievements (Id, Name) VALUES (2, N'second place')
INSERT Achievements (Id, Name) VALUES (3, N'third place')
INSERT Achievements (Id, Name) VALUES (4, N'fourth place')
INSERT Achievements (Id, Name) VALUES (5, N'Quarter-finals')
INSERT Achievements (Id, Name) VALUES (6, N'Round of 16')
GO

--Сохраненная процедура заполнение таблицы групповых матчей
CREATE PROCEDURE InsertGroupMatches
AS
BEGIN
	DECLARE @CommandInGroup TABLE (Id int, CommandsFk int);
	DECLARE @CommandsFkTmp int = ABS(CHECKSUM(NEWID())) % 32 + 1;
	DECLARE @IdTmp int = 1;
	WHILE(@IdTmp < 33)
	BEGIN
		SET @CommandsFkTmp = ABS(CHECKSUM(NEWID())) % 32 + 1;
		IF ((SELECT Count(CommandsFk) 
			FROM @CommandInGroup
			WHERE CommandsFk = @CommandsFkTmp) > 0)
		SET @IdTmp -= 1;
		ELSE
		INSERT INTO @CommandInGroup VALUES (@IdTmp, @CommandsFkTmp);
		SET @IdTmp += 1;
	END 
	DECLARE @IdGroupMatches int = 1;
	DECLARE @time TABLE (Id int, [hour] time);
	DECLARE @IdTime int = ABS(CHECKSUM(NEWID())) % 3 + 1;
	DECLARE @Group int = 1;
	DECLARE @Stadium int;
	DECLARE @IdCommandInGroup1 int = 3;
	DECLARE @IdCommandInGroup2 int = 2;
	DECLARE @GroupTmp int = 0;
	INSERT INTO @time VALUES (1, CAST(N'14:30:00.000' AS TIME))
	INSERT INTO @time VALUES (2, CAST(N'17:00:00.000' AS TIME))
	INSERT INTO @time VALUES (3, CAST(N'21:30:00.000' AS TIME))
	WHILE (@IdGroupMatches < 49)
	BEGIN
		SET @Stadium = ABS(CHECKSUM(NEWID())) % 10 + 1;
		INSERT GroupMatches(Id, [Date], [Time], GroupsFk, Commands1Fk, Commands2Fk, StadiumsFk, NumberOfAudience) VALUES 
		(@IdGroupMatches, DATEFROMPARTS (2010, 6, ABS(CHECKSUM(NEWID())) % 14 + 11), (SELECT [hour] FROM @time WHERE Id = @IdTime), @Group, (SELECT CommandsFk FROM @CommandInGroup WHERE Id = @IdCommandInGroup1), (SELECT CommandsFk FROM @CommandInGroup WHERE Id = @IdCommandInGroup2), @Stadium, ABS(CHECKSUM(NEWID())) % (SELECT NumberOfSeats FROM Stadiums WHERE Id = @Stadium) + 1)
		IF (@IdGroupMatches % 6 = 0)																		
		BEGIN
			SET @Group += 1;
			SET @GroupTmp += 4;
			SET @IdCommandInGroup1 = 3 + @GroupTmp;
			SET @IdCommandInGroup2 = 2 + @GroupTmp;
		END
		ELSE IF (@IdGroupMatches % 6 = 1)
		BEGIN
			SET @IdCommandInGroup2 = 4 + @GroupTmp;
			SET @IdCommandInGroup1 = 1 + @GroupTmp;
		END
		ELSE IF (@IdGroupMatches % 6 = 2)
		BEGIN
			SET @IdCommandInGroup1 = 3 + @GroupTmp;
			SET @IdCommandInGroup2 = 1 + @GroupTmp;
		END
		ELSE IF (@IdGroupMatches % 6 = 3)
		BEGIN
		SET @IdCommandInGroup1 = 4 + @GroupTmp;
		SET @IdCommandInGroup2 = 2 + @GroupTmp;
	END
		ELSE IF (@IdGroupMatches % 6 = 4)
		BEGIN
			SET @IdCommandInGroup1 = 2 + @GroupTmp;
			SET @IdCommandInGroup2 = 1 + @GroupTmp;
		END
		ELSE IF (@IdGroupMatches % 6 = 5)
		BEGIN
			SET @IdCommandInGroup1 = 4 + @GroupTmp;
			SET @IdCommandInGroup2 = 3 + @GroupTmp;
		END
		SET @IdGroupMatches += 1;
		SET @IdTime = ABS(CHECKSUM(NEWID())) % 3 + 1;
	END
END;
GO

--Сохраненная процедура заполнение таблицы заявленый основной состав команд на групповые матчи
CREATE PROCEDURE InsertCompositionCommandsGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = 21;
	DECLARE @GroupMatchesFk int = 1;
	WHILE (@Id < 1056)
	BEGIN
		INSERT CompositionCommandsGroupMatches(Id, PlayersFk, GroupMatchesFk, CommandsFk) VALUES (@Id, ABS(CHECKSUM(NEWID())) % 11 +(SELECT MIN(Id) FROM Players WHERE CommandsFk = (SELECT GroupMatches.Commands1Fk FROM GroupMatches WHERE Id = @GroupMatchesFk)), @GroupMatchesFk, (SELECT GroupMatches.Commands1Fk FROM GroupMatches WHERE Id = @GroupMatchesFk))
		INSERT CompositionCommandsGroupMatches(Id, PlayersFk, GroupMatchesFk, CommandsFk) VALUES (@Id + 1, ABS(CHECKSUM(NEWID())) % 11 +(SELECT MIN(Id) FROM Players WHERE CommandsFk = (SELECT GroupMatches.Commands2Fk FROM GroupMatches WHERE Id = @GroupMatchesFk)), @GroupMatchesFk, (SELECT GroupMatches.Commands2Fk FROM GroupMatches WHERE Id = @GroupMatchesFk))
		IF (@Id = @Tmp)
		BEGIN
		SET @GroupMatchesFk += 1;
		SET @Tmp += 22;
		END
		SET @Id += 2;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу статистики матчей для груповых матчей
CREATE PROCEDURE InsertStatisticsCommandOfMatch
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = 1;
	DECLARE @IdGroupMatches int = 1;
	DECLARE @MatchTimeFk int = 1;
	DECLARE @Commands1Fk int = (SELECT Commands1Fk FROM  GroupMatches WHERE Id = @IdGroupMatches);
	DECLARE @Commands2Fk int = (SELECT Commands2Fk FROM  GroupMatches WHERE Id = @IdGroupMatches);
	DECLARE @PossessionPercent int = ABS(CHECKSUM(NEWID())) % 100;
	DECLARE @BeatOnTarget int = ABS(CHECKSUM(NEWID())) % 20;
	WHILE (@Id < 193)
	BEGIN
		INSERT StatisticsCommandOfMatch(Id, CommandsFk, Corner, PossessionPercent, MatchTimeFk, BeatToTheSideOfTheGate, BeatOnTarget, OffSide) VALUES (@Id, @Commands1Fk, ABS(CHECKSUM(NEWID())) % 20, @PossessionPercent, @MatchTimeFk, ABS(CHECKSUM(NEWID())) % 20 + @BeatOnTarget, @BeatOnTarget, ABS(CHECKSUM(NEWID())) % 20)
		INSERT StatisticsCommandOfMatch(Id, CommandsFk, Corner, PossessionPercent, MatchTimeFk, BeatToTheSideOfTheGate, BeatOnTarget, OffSide) VALUES (@Id + 1, @Commands2Fk, ABS(CHECKSUM(NEWID())) % 20, 100 - @PossessionPercent, @MatchTimeFk, ABS(CHECKSUM(NEWID())) % 20 + @BeatOnTarget, @BeatOnTarget, ABS(CHECKSUM(NEWID())) % 20)
		SET @Id += 2;
		SET @PossessionPercent = ABS(CHECKSUM(NEWID())) % 100;
		SET @BeatOnTarget = ABS(CHECKSUM(NEWID())) % 20;
		IF (@MatchTimeFk = 1)
			SET @MatchTimeFk = 2;
		ELSE
			SET @MatchTimeFk = 1;
		IF (@Id = @Tmp + 4)
		BEGIN
			SET @Tmp += 4;
			SET @IdGroupMatches += 1; 
			SET @Commands1Fk = (SELECT Commands1Fk FROM  GroupMatches WHERE Id = @IdGroupMatches);
			SET @Commands2Fk = (SELECT Commands2Fk FROM  GroupMatches WHERE Id = @IdGroupMatches);
		END
	END
END;
GO

--Сохраненная процедура заполняющая дополнительную таблицу статистики матчей - груповые матчи
CREATE PROCEDURE InsertMatchsGroupStatistics
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = 1;
	DECLARE @MatchsGroup int = 1;
	WHILE (@Id < 193)
	BEGIN
		INSERT MatchsGroupStatistics(Id, StatisticsCommandOfMatchFk, GroupMatchesFk) VALUES (@Id, @Id, @MatchsGroup)
		SET @Id += 1;
		IF (@Id = @Tmp + 4)
		BEGIN
			SET @Tmp += 4;
			SET @MatchsGroup += 1;
		END
	END
END;
GO

--Сохраненная процедура заполняющая таблицу нарушений в груповых матчах
CREATE PROCEDURE InsertFoulGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = ABS(CHECKSUM(NEWID())) % 11 + 1;
	DECLARE @OnMinute int = NULL;
	DECLARE @CountFoul int = ABS(CHECKSUM(NEWID())) % 96;
	DECLARE @StatisticsCommandOfMatchFk int = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	DECLARE @PlayersFk int ;
	WHILE (@Id < @CountFoul)
	BEGIN
		SET @PlayersFk = (SELECT TOP 1 A.PlayersFk
							  FROM CompositionCommandsGroupMatches A JOIN MatchsGroupStatistics B ON A.GroupMatchesFk = B.GroupMatchesFk
										   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
							  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
							  ORDER BY NEWID());
		IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 1)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 5;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 2)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 50;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 3)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 25 + 95;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 4)
			SET @OnMinute = NULL;
		INSERT FoulGroupMatches(Id, PlayersFk, StatisticsCommandOfMatchFk, RefereesFk, TypeFoulFk, OnMinute) VALUES (@Id, @PlayersFk, @StatisticsCommandOfMatchFk, ABS(CHECKSUM(NEWID())) % 21 + 1, ABS(CHECKSUM(NEWID())) % 4 + 1, @OnMinute)
		SET @Id += 1;
		SET @StatisticsCommandOfMatchFk = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
		SET @Tmp = ABS(CHECKSUM(NEWID())) % 11 + 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу забитых голов для групповых матчей
CREATE PROCEDURE InsertGoalsScoredGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @OnMinute int = NULL;
	DECLARE @StatisticsCommandOfMatchFk int = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	DECLARE @CommandMissedTheBallFk int;
	DECLARE @Tmp int = ABS(CHECKSUM(NEWID())) % 100 + 100;
	DECLARE @PlayersFk int ;
	WHILE (@Id < @Tmp)
	BEGIN
		SET @PlayersFk = (SELECT TOP 1 A.PlayersFk
							  FROM CompositionCommandsGroupMatches A JOIN MatchsGroupStatistics B ON A.GroupMatchesFk = B.GroupMatchesFk
										   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
							  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
							  ORDER BY NEWID());
		SET @CommandMissedTheBallFk = (SELECT TOP 1 A.CommandsFk
									   FROM CompositionCommandsGroupMatches A JOIN MatchsGroupStatistics B ON A.GroupMatchesFk = B.GroupMatchesFk
																			  JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
									   WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk != C.CommandsFk);
		IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 1)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 5;
		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 2)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 50;
		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 3)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 25 + 95;
		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 4)
			SET @OnMinute = NULL;
		INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
		SET @Id += 1;
		SET @StatisticsCommandOfMatchFk = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу замен игроков в групповых матчах
CREATE PROCEDURE InsertReplacementPlayersGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @StatisticsCommandOfMatchFk int = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	DECLARE @OnMinute int = NULL;
	DECLARE @PlayersIn int;
	DECLARE @PlayersOut int;
	WHILE (@Id < ABS(CHECKSUM(NEWID())) % 200)
	BEGIN
		SET @PlayersIn = (SELECT TOP 1 Id
						  FROM Players
						  WHERE CommandsFk =(SELECT CommandsFk
											 FROM Players
											 WHERE Id = (SELECT TOP 1 A.PlayersFk
											 FROM CompositionCommandsGroupMatches A JOIN MatchsGroupStatistics B ON A.GroupMatchesFk = B.GroupMatchesFk
							                                 					   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
											 WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk))
						 ORDER BY NEWID());
	 SET @PlayersOut = (SELECT TOP 1 A.PlayersFk
						  FROM CompositionCommandsGroupMatches A JOIN MatchsGroupStatistics B ON A.GroupMatchesFk = B.GroupMatchesFk
									   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
						  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
						  ORDER BY NEWID())
	 IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 1)
   			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 5;
		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 2)
   			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 40 + 50;
		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 3)
   			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 25 + 95;
   		ELSE IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 4)
   			SET @OnMinute = NULL;
		INSERT ReplacementPlayers(Id, PlayerOutFk, PlayerInFk, OnMinute, StatisticsCommandOfMatchFk) VALUES (@Id, @PlayersOut, @PlayersIn, @OnMinute, @StatisticsCommandOfMatchFk)
		SET @Id += 1;
		SET @StatisticsCommandOfMatchFk = ABS(CHECKSUM(NEWID())) % (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу результатов групповых матчей
CREATE PROCEDURE InsertResultsOfGroupMatches
AS
BEGIN
	DECLARE @GroupMatches int = 1;
	DECLARE @Commands1Fk int = 1;
	DECLARE @Commands2Fk int = 1;
	DECLARE @Goal1 int = 0;
	DECLARE @Goal2 int = 0;
	DECLARE @Won int = 0;
	DECLARE @Draw int = 0;
	DECLARE @Lost int = 0;
	DECLARE @GroupsFk int;
	DECLARE @Played int;
	DECLARE @GoalsFor int;
	DECLARE @GoalsAgainst int;
	WHILE (@Commands1Fk < 33)
	BEGIN
		WHILE (@GroupMatches < 49)
		BEGIN
			IF ((SELECT Commands1Fk FROM GroupMatches WHERE Id = @GroupMatches) = @Commands1Fk)
				SET @Commands2Fk = (SELECT Commands2Fk FROM GroupMatches WHERE Id = @GroupMatches)
			ELSE IF ((SELECT Commands2Fk FROM GroupMatches WHERE Id = @GroupMatches) = @Commands1Fk)
				SET @Commands2Fk = (SELECT Commands1Fk FROM GroupMatches WHERE Id = @GroupMatches)
			ELSE
			BEGIN
				SET @GroupMatches += 1;
				CONTINUE
			END
			SET @Goal1 = (SELECT Count(G.Id)
						  FROM GoalsScored G JOIN Players P ON G.PlayersFk = P.Id
						  WHERE P.CommandsFk = @Commands1Fk AND G.CommandMissedTheBallFk = @Commands2Fk)
			SET @Goal2 = (SELECT Count(G.Id)
						  FROM GoalsScored G JOIN Players P ON G.PlayersFk = P.Id
						  WHERE P.CommandsFk = @Commands2Fk AND G.CommandMissedTheBallFk = @Commands1Fk)
			IF (@Goal1 > @Goal2)
				SET @Won += 1;
			ELSE IF (@Goal1 < @Goal2)
				SET @Lost += 1;
			ELSE
				SET @Draw += 1;
			SET @GroupMatches += 1;
		END
		SET @GroupsFk = (SELECT TOP 1 GroupsFk
							   FROM GroupMatches
							   WHERE Commands1Fk = @Commands1Fk)
		SET @Played = (SELECT Count (Id)
					   FROM GroupMatches
					   WHERE Commands1Fk = @Commands1Fk OR Commands2Fk = @Commands1Fk)
		SET @GoalsFor = (SELECT Count(G.Id)
						 FROM GoalsScored G JOIN Players P ON G.PlayersFk = P.Id
						 WHERE P.CommandsFk = @Commands1Fk);
		SET @GoalsAgainst = (SELECT Count(Id)
							 FROM GoalsScored
							 WHERE CommandMissedTheBallFk = @Commands1Fk)
		INSERT ResultsOfGroupMatches(Id, GroupsFk, CommandsFk, Played, Won, Draw, Lost, GoalsFor, GoalsAgainst, Points) VALUES (@Commands1Fk, @GroupsFk, @Commands1Fk, @Played, @Won, @Draw, @Lost, @GoalsFor, @GoalsAgainst, ((@Won * 3) + @Draw))
		SET @Commands1Fk += 1;
		SET @Won = 0;
		SET @Draw = 0;
		SET @Lost = 0;
		SET @GroupMatches = 1;
	END
END;
GO


--Сохраненная процедура перезаписывающая таблицу групповых матчей
CREATE PROCEDURE RewriteGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @EndId int = (SELECT MAX(Id) FROM GroupMatches);
	WHILE (@Id <= @EndId)
	BEGIN
		DELETE
		FROM GroupMatches
		WHERE Id = @Id;
		SET @Id += 1;
	END
	EXEC InsertGroupMatches;
END;
GO

--Сохраненная процедура перезаписывающая таблицу статистики матчей для групповых матчей
CREATE PROCEDURE RewriteStatisticsCommandOfMatch
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @EndId int = 193;
	WHILE (@Id < @EndId)
	BEGIN
		DELETE
		FROM StatisticsCommandOfMatch
		WHERE Id = @Id;
		SET @Id += 1;
	END
	EXEC InsertStatisticsCommandOfMatch;
END;
GO

--Сохраненная процедура перезаписывающая таблицу результатов групповых матчей
CREATE PROCEDURE RewriteResultsOfGroupMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @EndId int = (SELECT MAX(Id) FROM ResultsOfGroupMatches);
	WHILE (@Id <= @EndId)
	BEGIN
		DELETE
		FROM ResultsOfGroupMatches
		WHERE Id = @Id;
		SET @Id += 1;
	END
	EXEC InsertResultsOfGroupMatches;
END;
GO

EXEC InsertGroupMatches;--EXEC RewriteGroupMatches;
GO

--Заполнение таблицы арбитров обслуживающих групповые матчи
DECLARE @Id int = 1;
DECLARE @GroupMatches int = 1;
WHILE (@Id < 145)
BEGIN
	INSERT RefereesGroupMatches(Id, RefereesFk, GroupMatchesFk) VALUES (@Id, ABS(CHECKSUM(NEWID())) % 21 + 1, @GroupMatches)
	IF (@Id % 3 = 0)
	SET @GroupMatches += 1;
	SET @Id += 1;
END
GO

-- Заполнение таблицы тренеров
DECLARE @IdСoach int = 1;
DECLARE @IdCommands int = 1;
WHILE (@IdСoach < 33)
BEGIN
	INSERT Сoach(Id, CommandsFk, NamesFk, SurnamesFk, FromCountriesFk, Age) VALUES (@IdСoach, @IdСoach, ABS(CHECKSUM(NEWID())) % 160 + 1, ABS(CHECKSUM(NEWID())) % 303 + 1, ABS(CHECKSUM(NEWID())) % 231 + 1, ABS(CHECKSUM(NEWID())) % 60 + 18)
	SET @IdСoach += 1;
END
GO

EXEC InsertCompositionCommandsGroupMatches;
GO
EXEC InsertStatisticsCommandOfMatch;--EXEC RewriteStatisticsCommandOfMatch;
GO
EXEC InsertMatchsGroupStatistics;
GO
EXEC InsertFoulGroupMatches;
GO
EXEC InsertGoalsScoredGroupMatches;
GO
EXEC InsertReplacementPlayersGroupMatches;
GO
EXEC InsertResultsOfGroupMatches;--EXEC RewriteResultsOfGroupMatches;
GO


--Сохраненная процедура записывающая таблицу playoff матчей
CREATE PROCEDURE InsertPlayoffMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Round int;
	DECLARE @Commands1Fk int;
	DECLARE @Commands2Fk int;
	DECLARE @RoundOfPlayoffMatchesFk int = 1;
	DECLARE @Time time = CAST(N'16:00:00.000' AS TIME);
	DECLARE @Time2 time = CAST(N'20:30:00.000' AS TIME);
	DECLARE @Date  date = CAST(N'2010-06-26' AS date);
	DECLARE @Stadium int = ABS(CHECKSUM(NEWID())) % 10 + 1;
	WHILE (@Id < 17)
	BEGIN
		If(@Id < 9)
			SET @RoundOfPlayoffMatchesFk = 1;
		ELSE If (@Id > 8 AND @Id < 13)
		BEGIN
			SET @RoundOfPlayoffMatchesFk = 2;
			SET @Round = @Id % 8 * 2 - 1;
		END
		ELSE If (@Id > 12 AND @Id < 15)
		BEGIN
			SET @RoundOfPlayoffMatchesFk = 3;
			SET @Round = @Id - 5 + @Id % 12;
		END
		ELSE If (@Id = 15)
		BEGIN
			SET @RoundOfPlayoffMatchesFk = 4;
			SET @Round = 13
		END
		ELSE If (@Id = 16)
		BEGIN
			SET @RoundOfPlayoffMatchesFk = 5;
			IF ((SELECT Commands1Fk FROM PlayoffMatches WHERE Id = 15) = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = 13))
			SET @Commands1Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = 13);
			ELSE
			SET @Commands1Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = 13);
			IF ((SELECT Commands2Fk FROM PlayoffMatches WHERE Id = 15) = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = 14))
			SET @Commands2Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = 14);
			ELSE
			SET @Commands2Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = 14);
		END
		IF (@Id < 9)
			SET @Date = DATEFROMPARTS (2010, 6, (25 + @Id / 4));
		ELSE IF (@Id = 9 OR @Id = 10)
			SET @Date = CAST(N'2010-07-2' AS date);
		ELSE IF (@Id = 11 OR @Id = 12)
			SET @Date = CAST(N'2010-07-3' AS date);
		ELSE IF (@Id = 13)
			SET @Date = CAST(N'2010-07-6' AS date);
		ELSE IF (@Id = 14)
			SET @Date = CAST(N'2010-07-7' AS date);
		ELSE IF (@Id = 15)
			SET @Date = CAST(N'2010-07-11' AS date);
		ELSE IF (@Id = 16)
			SET @Date = CAST(N'2010-07-10' AS date);
		IF(@Id < 13)
		BEGIN
			IF (ABS(CHECKSUM(NEWID())) % 2 = 0)
				SET @Time = CAST(N'16:00:00.000' AS TIME);
			ELSE
				SET @Time = CAST(N'20:30:00.000' AS TIME);
		END
			ELSE
				SET @Time = CAST(N'20:30:00.000' AS TIME);
		IF(@Id <= 4)
		BEGIN
			SET @Commands1Fk = (SELECT TOP 1 CommandsFk
								FROM ResultsOfGroupMatches  
								WHERE GroupsFk = @Id * 2 - 1
								ORDER BY GoalsFor DESC, Points DESC);
			SET @Commands2Fk = (SELECT TOP 1 CommandsFk
								FROM ResultsOfGroupMatches  
								WHERE GroupsFk = @Id * 2 AND CommandsFk != (SELECT TOP 1 CommandsFk FROM ResultsOfGroupMatches WHERE GroupsFk = @Id * 2 ORDER BY GoalsFor DESC, Points DESC)
								ORDER BY GoalsFor DESC, Points DESC);
		END
		ELSE IF (@Id > 4 AND @Id < 9)
		BEGIN
			SET @Commands1Fk = (SELECT TOP 1 CommandsFk
								FROM ResultsOfGroupMatches  
								WHERE GroupsFk = (@Id - 4) * 2
								ORDER BY GoalsFor DESC, Points DESC);
			SET @Commands2Fk = (SELECT TOP 1 CommandsFk
								FROM ResultsOfGroupMatches  
								WHERE GroupsFk = (@Id - 4) * 2 - 1 AND CommandsFk != (SELECT TOP 1 CommandsFk FROM ResultsOfGroupMatches WHERE GroupsFk = (@Id - 4) * 2 - 1 ORDER BY GoalsFor DESC, Points DESC)
								ORDER BY GoalsFor DESC, Points DESC);	
		END
		IF (@Id > 8 AND @Id < 16)
		BEGIN
		IF (ABS(CHECKSUM(NEWID())) % 2 = 0)
			SET @Commands1Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @Round);
		ELSE
			SET @Commands1Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @Round);
		IF (ABS(CHECKSUM(NEWID())) % 2 = 0)
			SET @Commands2Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @Round + 1);
		ELSE
			SET @Commands2Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @Round + 1);
		END
		INSERT PlayoffMatches(Id, [Date], [Time], Commands1Fk, Commands2Fk, RoundOfPlayoffMatchesFk, StadiumsFk, NumberOfAudience) VALUES (@Id, @Date, @Time, @Commands1Fk, @Commands2Fk, @RoundOfPlayoffMatchesFk, @Stadium, ABS(CHECKSUM(NEWID())) % (SELECT S.NumberOfSeats FROM Stadiums S WHERE S.Id = @Stadium) + 1)
		SET @Id += 1;
		SET @Stadium = ABS(CHECKSUM(NEWID())) % 10 + 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу арбитров обслуживающих playoff матчей
CREATE PROCEDURE InsertRefereesPlayoffMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @PlayoffMatchesFk int = 1;
	WHILE (@Id < 48)
	BEGIN
		INSERT RefereesPlayoffMatches(Id, RefereesFk, PlayoffMatchesFk) VALUES (@Id, ABS(CHECKSUM(NEWID())) % 21 + 1, @PlayoffMatchesFk)
		IF (@Id % 3 = 0)
		SET @PlayoffMatchesFk += 1;
		SET @Id += 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу заявленого основного состава playoff матчей
CREATE PROCEDURE InsertCompositionCommandsPlayoffMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = 21;
	DECLARE @PlayoffMatchesFk int = 1;
	WHILE (@Id < 353)
	BEGIN
		INSERT CompositionCommandsPlayoffMatches(Id, PlayersFk, PlayoffMatchesFk, CommandsFk) VALUES (@Id, ABS(CHECKSUM(NEWID())) % 11 +(SELECT MIN(Id) FROM Players WHERE CommandsFk = (SELECT PlayoffMatches.Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatchesFk)), @PlayoffMatchesFk, (SELECT PlayoffMatches.Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatchesFk))
		INSERT CompositionCommandsPlayoffMatches(Id, PlayersFk, PlayoffMatchesFk, CommandsFk) VALUES (@Id + 1, ABS(CHECKSUM(NEWID())) % 11 +(SELECT MIN(Id) FROM Players WHERE CommandsFk = (SELECT PlayoffMatches.Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatchesFk)), @PlayoffMatchesFk, (SELECT PlayoffMatches.Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatchesFk))
		IF (@Id = @Tmp)
		BEGIN
		SET @PlayoffMatchesFk += 1;
		SET @Tmp += 22;
		END
		SET @Id += 2;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу статистики матчей для playoff матчей
CREATE PROCEDURE InsertStatisticsCommandOfPlayoffMatch
AS
BEGIN
	DECLARE @BeatOnTarget int;
	DECLARE @BeatToTheSideOfTheGate int;
	DECLARE @PossessionPercent1 int;
	DECLARE @PossessionPercent2 int;
	DECLARE @Commands1Fk int ;
	DECLARE @Commands2Fk int ;
	DECLARE @PlayoffMatches int = 1;
	DECLARE @Id int = (SELECT MAX(Id) FROM StatisticsCommandOfMatch) + 1;
	DECLARE @MatchTimeFk int = 1;
	DECLARE @MatchTimeTmp int;
	DECLARE @OffSide int;
	DECLARE @Corner int;
	WHILE (@PlayoffMatches < 17)
	BEGIN
		SET @Commands1Fk = (SELECT Commands1Fk FROM  PlayoffMatches WHERE Id = @PlayoffMatches);
		SET @Commands2Fk = (SELECT Commands2Fk FROM  PlayoffMatches WHERE Id = @PlayoffMatches);
		SET @MatchTimeTmp = ABS(CHECKSUM(NEWID())) % 3 + 2;
		SET @MatchTimeFk = 1;
		WHILE (@MatchTimeFk <=  @MatchTimeTmp)
		BEGIN
			SET @BeatOnTarget = ABS(CHECKSUM(NEWID())) % 20;
			SET @BeatToTheSideOfTheGate =  ABS(CHECKSUM(NEWID())) % 20 + @BeatOnTarget;
			SET @PossessionPercent1 = ABS(CHECKSUM(NEWID())) % 100;
			SET @PossessionPercent2 = 100 - @PossessionPercent1;
			SET @OffSide = ABS(CHECKSUM(NEWID())) % 20;
				SET @Corner = ABS(CHECKSUM(NEWID())) % 20;
			IF (@MatchTimeFk = 4)
			BEGIN
				SET @OffSide = NULL;
				SET @PossessionPercent1 = NULL;
				SET @PossessionPercent2 = NULL;
				SET @Corner = NULL;
				SET @BeatToTheSideOfTheGate = NULL;
				SET @BeatOnTarget = NULL;
			END
			INSERT StatisticsCommandOfMatch(Id, CommandsFk, Corner, PossessionPercent, MatchTimeFk, BeatToTheSideOfTheGate, BeatOnTarget, OffSide) VALUES (@Id, @Commands1Fk, @Corner, @PossessionPercent1, @MatchTimeFk, @BeatToTheSideOfTheGate, @BeatOnTarget, @OffSide)
			SET @Id += 1;
			IF (@MatchTimeFk != 4)
			BEGIN
				SET @OffSide = ABS(CHECKSUM(NEWID())) % 20;
				SET @Corner = ABS(CHECKSUM(NEWID())) % 20;
				SET @BeatOnTarget = ABS(CHECKSUM(NEWID())) % 20;
				SET @BeatToTheSideOfTheGate =  ABS(CHECKSUM(NEWID())) % 20 + @BeatOnTarget;
			END
			INSERT StatisticsCommandOfMatch(Id, CommandsFk, Corner, PossessionPercent, MatchTimeFk, BeatToTheSideOfTheGate, BeatOnTarget, OffSide) VALUES (@Id, @Commands2Fk, @Corner, @PossessionPercent2, @MatchTimeFk, @BeatToTheSideOfTheGate, @BeatOnTarget, @OffSide)
			SET @MatchTimeFk += 1;
			SET @Id += 1;
		END
		SET @PlayoffMatches +=1;
	END
END;
GO

--Сохраненная процедура заполняющая дополнительную таблицу статистики матчей и playoff матчей
CREATE PROCEDURE InsertPlayoffMatchesStatistics
AS
BEGIN
	DECLARE @Id int = 193;
	DECLARE @IdMax int = (SELECT MAX(Id) FROM StatisticsCommandOfMatch);
	DECLARE @Tmp int = 1;
	DECLARE @PlayoffMatches int = 0;
	WHILE (@Id < @IdMax + 1)
	BEGIN
		IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @Id) = 1 AND (SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @Id - 1) != 1)
		SET @PlayoffMatches += 1;
		INSERT PlayoffMatchesStatistics(Id, StatisticsCommandOfMatchFk, PlayoffMatchesFk) VALUES (@Id - 192, @Id, @PlayoffMatches)
		SET @Id += 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу нарушений в матче playoff
CREATE PROCEDURE InsertFoulPlayoffMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @Tmp int = ABS(CHECKSUM(NEWID())) % 11 + 1;
	DECLARE @OnMinute int = NULL;
	DECLARE @CountFoul int = ABS(CHECKSUM(NEWID())) % 96;
	DECLARE @StatisticsCommandOfMatchFk int = ABS(CHECKSUM(NEWID())) % ((SELECT MAX(Id) FROM StatisticsCommandOfMatch) - 192) + 193;
	DECLARE @PlayersFk int ;
	WHILE (@Id < @CountFoul)
	BEGIN
		SET @PlayersFk = (SELECT TOP 1 A.PlayersFk
						 FROM CompositionCommandsPlayoffMatches A JOIN PlayoffMatchesStatistics B ON A.PlayoffMatchesFk = B.PlayoffMatchesFk
						 WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk
						  ORDER BY NEWID());
		IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 1)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 45 + 5;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 2)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 45 + 50;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 3)
			SET @OnMinute = ABS(CHECKSUM(NEWID())) % 30 + 95;
		ELSE IF ((SELECT TOP 1 MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = 4)
		BEGIN
			SET @StatisticsCommandOfMatchFk =  ABS(CHECKSUM(NEWID())) % ((SELECT MAX(Id) FROM StatisticsCommandOfMatch) - 192) + 193;
			CONTINUE;
		END
		INSERT FoulPlayoffMatches(Id, PlayersFk, StatisticsCommandOfMatchFk, RefereesFk, TypeFoulFk, OnMinute) VALUES (@Id, @PlayersFk, @StatisticsCommandOfMatchFk, ABS(CHECKSUM(NEWID())) % 21 + 1, ABS(CHECKSUM(NEWID())) % 4 + 1, @OnMinute)
		SET @Id += 1;
		SET @StatisticsCommandOfMatchFk =  ABS(CHECKSUM(NEWID())) % ((SELECT MAX(Id) FROM StatisticsCommandOfMatch) - 192) + 193;
		SET @Tmp = ABS(CHECKSUM(NEWID())) % 11 + 1;
	END
END;
GO

--Сохраненная процедура заполняющая таблицу голов в playoff матчах
CREATE PROCEDURE InsertGoalsScoredToPlayoffMatches
AS
BEGIN
	DECLARE @Id int = (SELECT MAX(Id) FROM GoalsScored) + 1;
	DECLARE @GoalCommand1 int = 0;
	DECLARE @GoalCommand2 int = 0;
	DECLARE @StatisticsCommandOfMatchFk int = 193;
	DECLARE @PlayoffMatches int = 1;
	DECLARE @MatchTime int;
	DECLARE @OnMinute int;
	DECLARE @PlayersFk int;
	DECLARE @GoalInTime int;
	DECLARE @CommandMissedTheBallFk int;
	DECLARE @GoalFor int = 0;
	DECLARE @j int = 0;
	DECLARE @i int = 0;
	WHILE (@StatisticsCommandOfMatchFk < (SELECT MAX(Id) FROM StatisticsCommandOfMatch))
	BEGIN
		DECLARE @tmp int = 0;
		WHILE (@tmp < @GoalInTime)
		BEGIN
			SET @PlayersFk = (SELECT TOP 1 A.PlayersFk    -- Игрок играющий за команду из таблицы статистики
								  FROM CompositionCommandsPlayoffMatches A JOIN PlayoffMatchesStatistics B ON A.PlayoffMatchesFk = B.PlayoffMatchesFk
											   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
								  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
								  ORDER BY NEWID());
			SET @MatchTime = (SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk);
			IF (@MatchTime = 1)-- если статитика первого тайма
				BEGIN 
				SET @OnMinute = ABS(CHECKSUM(NEWID())) % 50 + 5;
				SET @GoalCommand1 += 0;
				SET @GoalCommand2 += 0;
				END
			ELSE IF (@MatchTime = 2)-- если статитика второго тайма
				SET @OnMinute = ABS(CHECKSUM(NEWID())) % 50 + 50;
			ELSE IF (@MatchTime = 3)-- если статитика овер тайма
				SET @OnMinute = ABS(CHECKSUM(NEWID())) % 35 + 95;
			ELSE IF (@MatchTime = 4)-- если статитика пенальти
				SET @OnMinute = NULL;
			IF ((SELECT CommandsFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches))
			BEGIN
				SET @CommandMissedTheBallFk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);
				SET @GoalCommand1 += 1;--голы 1 команды
			END
			ELSE
			BEGIN
				SET @CommandMissedTheBallFk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);
				SET @GoalCommand2 += 1;--голы 2 команды
			END
			INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
			SET @tmp += 1;
			SET @Id += 1;
			-- условие на конец 2 тайма и конец 3
			IF(@tmp = @GoalInTime AND @MatchTime > 1 AND @MatchTime < 4 AND (SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = (@StatisticsCommandOfMatchFk + 1)) != @MatchTime)
			BEGIN
				-- условие на продолжение матча
				IF((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = (@StatisticsCommandOfMatchFk + 1)) > @MatchTime AND @GoalCommand1 != @GoalCommand2)
				BEGIN
					IF(@GoalCommand1 > @GoalCommand2)
					BEGIN
						SET @CommandMissedTheBallFk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);
						SET @GoalFor = @GoalCommand1 - @GoalCommand2;
					END
					ELSE
					BEGIN
						SET @CommandMissedTheBallFk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);
						SET @GoalFor = @GoalCommand2 - @GoalCommand1;
					END
					SET @i = 0;
					WHILE(@i < @GoalFor)
					BEGIN
						SET @MatchTime = (SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk);
						IF (@MatchTime = 2)-- если статитика второго тайма
							SET @OnMinute = ABS(CHECKSUM(NEWID())) % 50 + 50;
						ELSE IF (@MatchTime = 3)-- если статитика овер тайма
							SET @OnMinute = ABS(CHECKSUM(NEWID())) % 35 + 95;
						SET @PlayersFk = (SELECT TOP 1 A.PlayersFk    -- Игрок играющий за команду из таблицы статистики
										  FROM CompositionCommandsPlayoffMatches A JOIN PlayoffMatchesStatistics B ON A.PlayoffMatchesFk = B.PlayoffMatchesFk
																				   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
										  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
										  ORDER BY NEWID());
						IF (@CommandMissedTheBallFk = (SELECT CommandsFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk))
							INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
						ELSE
							INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk - 1, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
						SET @i += 1;
						SET @Id += 1;
					END
				END
				--условие на конец матча
				ELSE IF((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = (@StatisticsCommandOfMatchFk + 1)) < @MatchTime)-- AND @GoalCommand1 != @GoalCommand2)
				BEGIN
					IF((SELECT COUNT(Id) FROM PlayoffMatches P WHERE Id > @PlayoffMatches AND Commands1Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches) OR Commands2Fk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches)) > 0 AND @GoalCommand1 <= @GoalCommand2)
					BEGIN
						SET @CommandMissedTheBallFk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);	--если первая команда проходит дальше и у нее меньше голов, то забивать надо второй
						SET @GoalFor = @GoalCommand2 - @GoalCommand1 + ABS(CHECKSUM(NEWID())) % 3 + 1;
					END
					ELSE IF((SELECT COUNT(Id) FROM PlayoffMatches P WHERE Id > @PlayoffMatches AND Commands1Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches) OR Commands2Fk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches)) > 0 AND @GoalCommand1 >= @GoalCommand2)  --<=
					BEGIN
						SET @CommandMissedTheBallFk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @PlayoffMatches);	--если вторая команда проходит дальше и у нее меньше голов, то забивать надо первой
						SET @GoalFor = @GoalCommand1 - @GoalCommand2 + ABS(CHECKSUM(NEWID())) % 3 + 1;
					END
					SET @j = 0;
					WHILE(@j < @GoalFor)
					BEGIN
						SET @MatchTime = (SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk);
						IF (@MatchTime = 2)-- если статитика второго тайма
							SET @OnMinute = ABS(CHECKSUM(NEWID())) % 50 + 50;
						ELSE IF (@MatchTime = 3)-- если статитика овер тайма
							SET @OnMinute = ABS(CHECKSUM(NEWID())) % 35 + 95;
						SET @PlayersFk = (SELECT TOP 1 A.PlayersFk    -- Игрок играющий за команду из таблицы статистики
										  FROM CompositionCommandsPlayoffMatches A JOIN PlayoffMatchesStatistics B ON A.PlayoffMatchesFk = B.PlayoffMatchesFk
																				   JOIN StatisticsCommandOfMatch C ON B.StatisticsCommandOfMatchFk = C.Id
										  WHERE B.StatisticsCommandOfMatchFk = @StatisticsCommandOfMatchFk AND A.CommandsFk = C.CommandsFk
										  ORDER BY NEWID());
						IF (@CommandMissedTheBallFk = (SELECT CommandsFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk))
							INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
						ELSE
							INSERT GoalsScored(Id, StatisticsCommandOfMatchFk, PlayersFk, OnMinute, CommandMissedTheBallFk) VALUES (@Id, @StatisticsCommandOfMatchFk - 1, @PlayersFk, @OnMinute, @CommandMissedTheBallFk)
						SET @j += 1;
						SET @Id += 1;
					END
				END
			END
		END
		SET @StatisticsCommandOfMatchFk += 1;
		SET @GoalInTime = ABS(CHECKSUM(NEWID())) % 4;
		IF ((SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk) != 1 AND (SELECT MatchTimeFk FROM StatisticsCommandOfMatch WHERE Id = @StatisticsCommandOfMatchFk + 1) = 1)
		SET @PlayoffMatches +=1;
	END
END;
GO
	
--Сохраненная процедура заполняющая таблицу результатов команд вышедших в playoff
CREATE PROCEDURE InsertResultsOfPlayoffMatches
AS
BEGIN
	DECLARE @PlayoffMatches int = 1;
	DECLARE @Id int = 1;
	DECLARE @i int = 1;
	DECLARE @@PlayoffMatches int = 1;
	DECLARE @CommandsFk int = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @@PlayoffMatches);
	DECLARE @Goal1 int = 0;
	DECLARE @Goal2 int = 0;
	DECLARE @GoalsFor int;
	DECLARE @GoalsAgainst int;
	DECLARE @AchievementsFk int = 6;
	WHILE (@@PlayoffMatches < 9)
	BEGIN
		SET @i = @@PlayoffMatches;
		SET @PlayoffMatches = @@PlayoffMatches;
		WHILE (@i < 17)
		BEGIN
			IF((SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @i) = @CommandsFk OR (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @i) = @CommandsFk)
				SET @PlayoffMatches = @i;
				SET @i += 1;
		END
		SET @GoalsFor = (SELECT Count(G.Id)
						 FROM GoalsScored G JOIN Players P ON G.PlayersFk = P.Id
									 	    JOIN StatisticsCommandOfMatch St On G.StatisticsCommandOfMatchFk = St.Id
						 WHERE P.CommandsFk = @CommandsFk AND St.Id > 192);
		SET @GoalsAgainst = (SELECT Count(G.Id)
							 FROM GoalsScored G JOIN StatisticsCommandOfMatch St On G.StatisticsCommandOfMatchFk = St.Id
							 WHERE G.CommandMissedTheBallFk = @CommandsFk AND St.Id > 192);
		IF (@PlayoffMatches <= 8)
			SET @AchievementsFk = 6;	--Round of 16
		ELSE IF (@PlayoffMatches > 8 AND @PlayoffMatches < 13)
			SET @AchievementsFk = 5;	--Quarter-finals
		ELSE IF (@PlayoffMatches = 15)
		BEGIN
			IF((SELECT COUNT (G.CommandMissedTheBallFk)
				FROM GoalsScored G JOIN StatisticsCommandOfMatch St ON G.StatisticsCommandOfMatchFk = St.Id
								   JOIN PlayoffMatchesStatistics PMSt On PMSt.StatisticsCommandOfMatchFk = St.Id
				WHERE PMSt.PlayoffMatchesFk = @PlayoffMatches AND G.CommandMissedTheBallFk != @CommandsFk) >
			   (SELECT COUNT(G.CommandMissedTheBallFk)
				FROM GoalsScored G JOIN StatisticsCommandOfMatch St ON G.StatisticsCommandOfMatchFk = St.Id
								   JOIN PlayoffMatchesStatistics PMSt On PMSt.StatisticsCommandOfMatchFk = St.Id
				WHERE PMSt.PlayoffMatchesFk = @PlayoffMatches AND G.CommandMissedTheBallFk = @CommandsFk))
				SET @AchievementsFk = 1;
			ELSE
				SET @AchievementsFk = 2;
		END
		ELSE IF (@PlayoffMatches = 16)
		BEGIN
			IF((SELECT COUNT (G.CommandMissedTheBallFk)
				FROM GoalsScored G JOIN StatisticsCommandOfMatch St ON G.StatisticsCommandOfMatchFk = St.Id
								   JOIN PlayoffMatchesStatistics PMSt On PMSt.StatisticsCommandOfMatchFk = St.Id
				WHERE PMSt.PlayoffMatchesFk = @PlayoffMatches AND G.CommandMissedTheBallFk != @CommandsFk) >
				   (SELECT COUNT(G.CommandMissedTheBallFk)
				FROM GoalsScored G JOIN StatisticsCommandOfMatch St ON G.StatisticsCommandOfMatchFk = St.Id
								   JOIN PlayoffMatchesStatistics PMSt On PMSt.StatisticsCommandOfMatchFk = St.Id
				WHERE PMSt.PlayoffMatchesFk = @PlayoffMatches AND G.CommandMissedTheBallFk = @CommandsFk))
				SET @AchievementsFk = 3;
			ELSE
				SET @AchievementsFk = 4;
		END
		INSERT ResultsOfPlayoffMatches(Id, CommandsFk, AchievementsFk, GoalsFor, GoalsAgainst) VALUES (@Id, @CommandsFk, @AchievementsFk, @GoalsFor, @GoalsAgainst)
		SET @Id += 1;
		IF (@CommandsFk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @@PlayoffMatches))
			SET @CommandsFk = (SELECT Commands2Fk FROM PlayoffMatches WHERE Id = @@PlayoffMatches);
		ELSE
		BEGIN
			SET @@PlayoffMatches += 1;
			SET @CommandsFk = (SELECT Commands1Fk FROM PlayoffMatches WHERE Id = @@PlayoffMatches);
		END
	END
END;
GO

--Сохраненная процедура перезаписывающая таблицу playoff матчей
CREATE PROCEDURE RewritePlayoffMatches
AS
BEGIN
	DECLARE @Id int = 1;
	DECLARE @EndId int = (SELECT MAX(Id) FROM PlayoffMatches);
	WHILE (@Id <= @EndId)
	BEGIN
		DELETE
		FROM PlayoffMatches
		WHERE Id = @Id;
		SET @Id += 1;
	END
	EXEC InsertPlayoffMatches;
END;
GO

--Сохраненная процедура перезаписывающая таблицу статистики матчей для playoff матчей
CREATE PROCEDURE RewriteStatisticsCommandOfPlayoffMatch
AS
BEGIN
	DECLARE @Id int = 193;
	DECLARE @EndId int = (SELECT MAX(Id) FROM StatisticsCommandOfMatch);
	WHILE (@Id <= @EndId)
	BEGIN
		DELETE
		FROM StatisticsCommandOfMatch
		WHERE Id = @Id;
		SET @Id += 1;
	END
	EXEC InsertStatisticsCommandOfPlayoffMatch;
END;
GO

EXEC InsertPlayoffMatches;--EXEC RewritePlayoffMatches;
GO
EXEC InsertRefereesPlayoffMatches;
GO
EXEC InsertCompositionCommandsPlayoffMatches;
GO
EXEC InsertStatisticsCommandOfPlayoffMatch;--EXEC RewriteStatisticsCommandOfPlayoffMatch;
GO
EXEC InsertPlayoffMatchesStatistics;
GO
EXEC InsertFoulPlayoffMatches;
GO
EXEC InsertGoalsScoredToPlayoffMatches
GO
EXEC InsertResultsOfPlayoffMatches
GO



-------------------------------------------Запросы--------------------------------------------------------

-- Общее количество голов, забитых в чемпионате
SELECT COUNT(G.Id) AS [the total number of goals in the match]
FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id
WHERE S.MatchTimeFk != 4;
GO

--Среднее количество голов в каждом матче
SELECT (COUNT(G.Id) / ((SELECT COUNT(Id) FROM PlayoffMatches) + (SELECT COUNT(Id) FROM GroupMatches))) AS [the average number of goals in the match]
FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id
WHERE S.MatchTimeFk != 4;
GO

--Найбольшее и найменьшее количество мячей, забитых командами
SELECT Co.Name, Goals
FROM (SELECT P.CommandsFk AS IdCommands, COUNT(G.Id) AS Goals
	  FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id
				   JOIN Players P ON P.Id = G.PlayersFk
      WHERE S.MatchTimeFk != 4
      GROUP BY P.CommandsFk) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id
							JOIN Countries Co ON C.CountriesFk = Co.Id
WHERE Goals = (SELECT TOP 1 Goals
			   FROM (SELECT P.CommandsFk AS IdCommands, COUNT(G.Id) AS Goals 
			         FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id JOIN Players P ON P.Id = G.PlayersFk
				     WHERE S.MatchTimeFk != 4
				     GROUP BY P.CommandsFk) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id JOIN Countries Co ON C.CountriesFk = Co.Id
			  ORDER BY Goals ASC) OR
	Goals = (SELECT TOP 1 Goals
			   FROM (SELECT P.CommandsFk AS IdCommands, COUNT(G.Id) AS Goals 
			         FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id JOIN Players P ON P.Id = G.PlayersFk
				     WHERE S.MatchTimeFk != 4
				     GROUP BY P.CommandsFk) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id JOIN Countries Co ON C.CountriesFk = Co.Id
			  ORDER BY Goals DESC)
ORDER BY Goals DESC;
GO

--Наибольшее и наименьшее количество мячей, пропущенных командами
SELECT Co.Name, Goals
FROM (SELECT Com.Id AS IdCommands, COUNT(G.Id) AS Goals 
			         FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id JOIN Commands Com ON G.CommandMissedTheBallFk = Com.Id
				     WHERE S.MatchTimeFk != 4
				     GROUP BY Com.Id) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id
							JOIN Countries Co ON C.CountriesFk = Co.Id
WHERE Goals = (SELECT TOP 1 Goals
			 FROM (SELECT Com.Id AS IdCommands, COUNT(G.Id) AS Goals 
			         FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id JOIN Commands Com ON G.CommandMissedTheBallFk = Com.Id
				     WHERE S.MatchTimeFk != 4
				     GROUP BY Com.Id) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id JOIN Countries Co ON C.CountriesFk = Co.Id
			 ORDER BY Goals ASC) OR
	Goals = (SELECT TOP 1 Goals
			 FROM (SELECT Com.Id AS IdCommands, COUNT(G.Id) AS Goals 
			         FROM GoalsScored G JOIN StatisticsCommandOfMatch S ON G.StatisticsCommandOfMatchFk = S.Id JOIN Commands Com ON G.CommandMissedTheBallFk = Com.Id
				     WHERE S.MatchTimeFk != 4
				     GROUP BY Com.Id) AS A LEFT JOIN Commands C ON A.IdCommands = C.Id JOIN Countries Co ON C.CountriesFk = Co.Id
			 ORDER BY Goals DESC)
ORDER BY Goals DESC;
GO

--Суммарная посещаемость всех матчей
SELECT (SUM(NumberOfAudience) + (SELECT SUM(NumberOfAudience) FROM PlayoffMatches)) AS [The total attendance of all matches]
FROM GroupMatches;
GO

--Средняя посещаемость одного матча
SELECT (((SUM(NumberOfAudience) + (SELECT SUM(NumberOfAudience) FROM PlayoffMatches))) / ((SELECT COUNT(Id) FROM PlayoffMatches) + (SELECT COUNT(Id) FROM GroupMatches))) AS [the average attendance of all matches]
FROM GroupMatches;
GO

--Наибольшее число побед
SELECT Name, Wons
FROM (SELECT Cou.Name AS Name, (GM.Won + (SELECT 4 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + 
						  ((SELECT TOP 1 3 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 2 OR AchievementsFk = 3))) AS Wons
	  FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id
	 WHERE PM.AchievementsFk < 4) AS Victory
WHERE Wons = (SELECT TOP 1 (GM.Won + (SELECT 4 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + 
						  ((SELECT TOP 1 3 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 2 OR AchievementsFk = 3))) AS Wons
FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id
WHERE PM.AchievementsFk < 4
ORDER BY Wons DESC);
GO

--Наименьшее число побед
SELECT Cou.Name, GM.Won
FROM ResultsOfGroupMatches GM JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id
WHERE GM.Won = (SELECT MIN(Won) FROM ResultsOfGroupMatches);
GO

--Наибольшее количество поражений
SELECT Name, Losts
FROM (SELECT Cou.Name AS Name, (GM.Lost + (SELECT 0 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + (SELECT 2 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 4) +
									     ((SELECT TOP 1 1 FROM ResultsOfPlayoffMatches WHERE AchievementsFk != 1 OR AchievementsFk != 4))) AS Losts
	  FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id) AS Defeat
WHERE Losts = (SELECT TOP 1 (GM.Lost + (SELECT 0 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + (SELECT 2 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 4) +
						  ((SELECT TOP 1 1 FROM ResultsOfPlayoffMatches WHERE AchievementsFk != 1 OR AchievementsFk != 4))) AS Losts
			  FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id
			  ORDER BY Losts DESC);
GO

--Наибольшее и наименьшее количество поражений
SELECT Name, Losts
FROM (SELECT Cou.Name AS Name, (GM.Lost + (SELECT 0 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + (SELECT 2 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 4) +
									     ((SELECT TOP 1 1 FROM ResultsOfPlayoffMatches WHERE AchievementsFk != 1 OR AchievementsFk != 4))) AS Losts
	  FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id) AS Defeat
WHERE Losts = (SELECT TOP 1 (GM.Lost + (SELECT 0 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 1) + (SELECT 2 FROM ResultsOfPlayoffMatches WHERE AchievementsFk = 4) +
						  ((SELECT TOP 1 1 FROM ResultsOfPlayoffMatches WHERE AchievementsFk != 1 OR AchievementsFk != 4))) AS Losts
			  FROM ResultsOfGroupMatches GM JOIN ResultsOfPlayoffMatches PM ON GM.CommandsFk = PM.CommandsFk
							  JOIN Commands C ON GM.CommandsFk = C.Id
							  JOIN Countries Cou ON C.CountriesFk = Cou.Id
			  ORDER BY Losts ASC);
GO

--Лучшие бомбардиры (игроки, забившие наибольшее количество голов)
SELECT TOP 5 N.Name, S.Surname, CountGoals
FROM (SELECT P.Id AS Id, COUNT(G.Id) AS CountGoals
FROM GoalsScored G JOIN StatisticsCommandOfMatch St ON G.StatisticsCommandOfMatchFk = St.Id
				   JOIN Players P ON G.PlayersFk = P.Id
WHERE St.MatchTimeFk != 4
GROUP BY P.Id) AS A JOIN Players P ON A.Id = P.Id
					JOIN Names N ON N.Id = P.NamesFk
					JOIN Surnames S ON S.Id = P.SurnamesFk
ORDER BY CountGoals DESC;
GO

--Список команд, занявших призовые места
SELECT Coun.Name , A.Name
FROM ResultsOfPlayoffMatches R JOIN Commands Com ON Com.Id = R.CommandsFk
							   JOIN Countries Coun ON Coun.Id = Com.CountriesFk
							   JOIN Achievements A ON A.Id = R.AchievementsFk
WHERE R.AchievementsFk < 4
ORDER BY A.Id ASC;



----Сохраненная процедура перезаписывающая таблицу групповых матчей
--EXEC RewriteGroupMatches;
--GO

----Сохраненная процедура перезаписывающая таблицу статистики в групповых матчах
--EXEC RewriteStatisticsCommandOfMatch;
--GO


----Сохраненная процедура перезаписывающая таблицу результатор групповых матчах
--EXEC RewriteResultsOfGroupMatches;
--GO

----Сохраненная процедура перезаписывающая таблицу Playoff матчей
--EXEC RewritePlayoffMatches;
--GO

----Сохраненная процедура перезаписывающая таблицу статистики в  Playoff матчах
--EXEC RewriteStatisticsCommandOfPlayoffMatch;
--GO