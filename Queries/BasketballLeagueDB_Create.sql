-- Create a database for a small basketball league
-- DROP DATABASE BasketballLeague;

CREATE DATABASE BasketballLeague;

USE BasketballLeague;

-- Create a table that will store information on teams
CREATE TABLE Teams (
	TeamID VARCHAR(3) NOT NULL,
	TeamName VARCHAR(50) NOT NULL,
	City VARCHAR(50) NOT NULL,
    Conference VARCHAR(4) NOT NULL,
    Wins INT,
    Losses INT,
	CONSTRAINT PK_TeamID
	PRIMARY KEY (TeamID) 
);

-- Create a table that will store information on players
CREATE TABLE Players (
	PlayerID VARCHAR(20) NOT NULL,
    PlayerName VARCHAR(50) NOT NULL,
    TeamID VARCHAR(3) NOT NULL,
    Age INT,
    Pos VARCHAR(2),
    CONSTRAINT PK_PlayerID
    PRIMARY KEY (PlayerID),

    CONSTRAINT FK_Player_TeamID
    FOREIGN KEY (TeamID) REFERENCES Teams (TeamID)
);

-- Create a table that will store information on the games
CREATE TABLE Games (
	GameID VARCHAR(20) NOT NULL,
    GameDate DATE NOT NULL,
    HomeTeamID VARCHAR(3) NOT NULL,
    HomeScore INT NOT NULL,
    AwayTeamID VARCHAR(3) NOT NULL,
    AwayScore INT NOT NULL,
    Season YEAR,
    CONSTRAINT PK_GameID
    PRIMARY KEY (GameID),
    
    CONSTRAINT FK_HomeTeamID
    FOREIGN KEY (HomeTeamID) REFERENCES Teams (TeamID),
    
    CONSTRAINT FK_AwayTeamID
    FOREIGN KEY (AwayTeamID) REFERENCES Teams (TeamID)
);

-- Create a table that will store performance statistics of each player within a game
CREATE TABLE GameStats (
	GameID VARCHAR(20) NOT NULL,
    PlayerID VARCHAR(20) NOT NULL,
    Rebounds INT,
    Assists INT,
    Steals INT,
    Blocks INT,
    Turnovers INT,
    PersonalFouls INT,
    Points INT,
    Minutes INT,
    CONSTRAINT FK_GameID
    FOREIGN KEY (GameID) REFERENCES Games (GameID),
    
    CONSTRAINT FK_PlayerID 
    FOREIGN KEY (PlayerID) REFERENCES Players (PlayerID)
);

-- DROP TABLE Champions;

-- Create a table with the champions from previous seasons and stats
CREATE TABLE Champions (
	Season YEAR,
    Champion VARCHAR(20),
    ChampionID VARCHAR(3),
    RunnerUp VARCHAR(20),
    RunnerUpID VARCHAR(3),
    FinalsMVP VARCHAR(50),
    TopPerformer_Points VARCHAR(50),
    TopPerformer_Assists VARCHAR(50),
    TopPerformer_Rebounds VARCHAR(50),
    CONSTRAINT FK_ChampionID
    FOREIGN KEY (ChampionID) REFERENCES Teams (TeamID),
    
    CONSTRAINT FK_RunnerUpID
    FOREIGN KEY (RunnerUpID) REFERENCES Teams (TeamID)
);

SHOW TABLES;

