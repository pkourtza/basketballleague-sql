USE BasketballLeague;

SELECT * FROM Teams;
SELECT * FROM Players;
SELECT * FROM GameStats;
SELECT * FROM Games;
SELECT * FROM Champions;

-- DROP VIEW vw_playerstats;

-- Create a view of Players and all their Game stats
CREATE VIEW vw_playerstats
AS
	SELECT p.PlayerName, p.Pos, gs.Points, gs.Rebounds, gs.Assists, gs.Steals, gs.Blocks, gs.Turnovers, gs.PersonalFouls, gs.Minutes
    FROM Players p, GameStats gs
    WHERE p.PlayerID = gs.PlayerID;

-- Use the vw_playerstats view to find the maximum rebounds scored by centers
SELECT PlayerName, MAX(Rebounds) AS MAX_TRB_pergame
FROM vw_playerstats
WHERE Pos LIKE 'C%'
GROUP BY PlayerName
ORDER BY MAX_TRB_pergame DESC;

-- Create a view of Players and all their Average Game Stats
CREATE VIEW vw_avgplayerstats
AS
	SELECT p.PlayerName, AVG(g.Points) AS PTS, AVG(g.Rebounds) AS TRB, AVG(g.Assists) AS AST,
	AVG(g.Steals) AS STL, AVG(g.Blocks) AS BLK, AVG(g.Turnovers) AS TOV, AVG(g.PersonalFouls) AS PF, AVG(g.Minutes) AS MP
	FROM GameStats g, Players p
	WHERE p.PlayerID = g.PlayerID
	GROUP BY g.PlayerID;

-- Find which players had double points per game and double rebounds per game
SELECT PlayerName, PTS, TRB
FROM vw_avgplayerstats
WHERE PTS >= 10 AND TRB >= 10;

-- Find how many players had double points per game, double rebounds per game, double assists or blocks or steals per game
SELECT COUNT(PlayerName)
FROM vw_avgplayerstats
WHERE PTS >=10 AND TRB >= 10 AND (AST >= 10 OR BLK >= 10 OR STL >= 10);

-- DROP FUNCTION calc_winpct;

-- Function which finds the win% of a team
DELIMITER //
CREATE FUNCTION calc_winpct (Wins INT, Losses INT)
RETURNS DECIMAL(9, 2)
DETERMINISTIC
BEGIN
	DECLARE winpct DECIMAL(9, 2);
    IF (Wins > 0) AND (Losses > 0) THEN SET winpct = (Wins / (Wins + Losses))*100;
    ELSEIF (Wins = 0) AND (Losses = 0) THEN SET winpct = 0;
    END IF;
    RETURN winpct;
END //
DELIMITER ;

-- Find which teams have a winning percentage of more than 50% this season
SELECT TeamName, Conference, calc_winpct(Wins, Losses) AS Win_PCT
FROM Teams
WHERE calc_winpct(Wins, Losses) >= 50.0
ORDER BY Win_PCT DESC;

-- Create a function that finds a specific statistic per 36 minutes played for a player
DELIMITER //
CREATE FUNCTION per36min (Stat INT, Minutes INT)
RETURNS DECIMAL(9, 2)
DETERMINISTIC
BEGIN
	DECLARE per36min DECIMAL(9, 2);
    IF (Minutes > 0) THEN SET per36min = (Stat / Minutes)*36;
    ELSEIF (Minutes = 0) THEN SET per36min = 0;
    END IF;
    RETURN per36min;
END //
DELIMITER ;

-- Find the points and assists per 36 minutes of all players played on 2021-03-21
SELECT DISTINCT p.PlayerName, p.TeamID, per36min(gs.Points, gs.Minutes) AS PTS_per36min, per36min(gs.Assists, gs.Minutes) AS AST_per36min
FROM Players p, GameStats gs
WHERE p.PlayerID = gs.PlayerID
AND gs.GameID IN (
	SELECT GameID
    FROM Games
    WHERE GameDate = DATE('2021-03-21')
)
ORDER BY PTS_per36min DESC;

-- Create a procedure that returns the players of a team
DELIMITER //
CREATE PROCEDURE TeamPlayers (Team_ID VARCHAR(3))
BEGIN
	SELECT p.PlayerID, p.PlayerName, p.Age, p.Pos
    FROM Players p
    WHERE p.TeamID = Team_ID;
END //
DELIMITER ;

-- Find the players of Utah Jazz and Milwaukee Bucks
CALL TeamPlayers('UTA');
CALL TeamPlayers('MIL');

-- DROP PROCEDURE TeamStandings;

-- Create a procedure that returns the top X teams (team standings) of either overall or east or west
DELIMITER //
CREATE PROCEDURE TeamStandings (Division VARCHAR(10), Top INT)
BEGIN
	IF Division = 'Overall' THEN (
		SELECT TeamName, Conference, calc_winpct(Wins, Losses) AS Win_PCT
		FROM Teams
		ORDER BY Win_PCT DESC
        LIMIT Top);
	ELSEIF Division = 'East' THEN (	
		SELECT TeamName, Conference, calc_winpct(Wins, Losses) AS Win_PCT
		FROM Teams
        WHERE Conference = 'East'
		ORDER BY Win_PCT DESC
        LIMIT Top);
	ELSEIF Division = 'West' THEN (
		SELECT TeamName, Conference, calc_winpct(Wins, Losses) AS Win_PCT
		FROM Teams
        WHERE Conference = 'West'
		ORDER BY Win_PCT DESC
        LIMIT Top);
	END IF;
END //
DELIMITER ;

CALL TeamStandings('Overall', 8);
CALL TeamStandings('West', 3);

/*
CREATE VIEW Fixture AS 
SELECT 
  MatchDate 
, HomeTeam AS Team
, AwayTeam AS Opponent
,'H' AS HomeAway
, HomeScore AS ScoreFor
, AwayScore AS ScoreAgainst
UNION ALL
SELECT 
  MatchDate 
, AwayTeam AS Team
, HomeTeam AS Opponent
,'A' AS HomeAway
, AwayScore AS ScoreFor
, HomeScore AS ScoreAgainst
*/

-- Make season as primary key in champions table
-- Players could change teams, how to add sth to incorporate that?