USE BasketballLeague;

SHOW TABLES;

SET GLOBAL local_infile=1;

-- Load teams data from the csv file
LOAD DATA LOCAL INFILE "/Users/matilda/Desktop/DSTI_andcourses/CFG-IntrotoDataandSQL/Project/teams.csv"
	INTO TABLE Teams
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(TeamID, TeamName, City, Conference, Wins, Losses);

-- Check the teams data that was loaded
SELECT * FROM Teams;

-- Load the players data from the csv file
LOAD DATA LOCAL INFILE "/Users/matilda/Desktop/DSTI_andcourses/CFG-IntrotoDataandSQL/Project/players.csv"
	INTO TABLE Players
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(PlayerID, PlayerName, TeamID, Age, Pos);

-- Check the players data that was loaded
SELECT COUNT(*) FROM Players;

-- Load the games data from the csv file
LOAD DATA LOCAL INFILE "/Users/matilda/Desktop/DSTI_andcourses/CFG-IntrotoDataandSQL/Project/games.csv"
	INTO TABLE Games
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(GameID, @gamedatevar, HomeTeamID, HomeScore, AwayTeamID, AwayScore, Season)
set GameDate = str_to_date(@gamedatevar, '%Y-%m-%d');

-- Check the games data was loaded
SELECT COUNT(*) FROM Games;

-- Load the game stats data from the csv file
LOAD DATA LOCAL INFILE "/Users/matilda/Desktop/DSTI_andcourses/CFG-IntrotoDataandSQL/Project/game_stats.csv"
	INTO TABLE GameStats
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(GameID, PlayerID, Rebounds, Assists, Steals, Blocks, Turnovers, PersonalFouls, Points, Minutes);

-- Check that the game stats data was loaded
SELECT COUNT(*) FROM GameStats;

-- Load the champions data from the csv file
LOAD DATA LOCAL INFILE "/Users/matilda/Desktop/DSTI_andcourses/CFG-IntrotoDataandSQL/Project/champions.csv"
	INTO TABLE Champions
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(Season, Champion, ChampionID, RunnerUp, RunnerUpID, FinalsMVP, TopPerformer_Points, TopPerformer_Rebounds, TopPerformer_Assists);

-- Check that the champions data was loaded
SELECT * FROM Champions;
