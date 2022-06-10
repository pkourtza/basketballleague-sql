USE BasketballLeague;

SELECT * FROM Teams;
SELECT * FROM Players;
SELECT * FROM GameStats;
SELECT * FROM Games;
SELECT * FROM Champions;

-- Select all teams from the east conference, order by wins starting with the team that has most wins
SELECT TeamID, TeamName, Wins, Losses
FROM Teams
WHERE Conference = 'East'
ORDER BY Wins DESC;

-- Select all pointguards over 25 years old and show in which teams they are
SELECT p.PlayerID, p.PlayerName, p.TeamID, t.TeamName
FROM Players p
INNER JOIN  Teams t ON p.TeamID = t.TeamID
WHERE p.Pos LIKE 'PG' AND Age > 25;

-- Show the average stats of all players playing in the Utah Jazz (UTA) (Combines 2 tables)
SELECT p.PlayerName, AVG(g.Points) AS PTS, AVG(g.Rebounds) AS TRB, AVG(g.Assists) AS AST,
	AVG(g.Steals) AS STL, AVG(g.Blocks) AS BLK, AVG(g.Turnovers) AS TOV, AVG(g.PersonalFouls) AS PF, AVG(g.Minutes) AS MP
FROM GameStats g
INNER JOIN Players p ON p.PlayerID = g.PlayerID
WHERE p.TeamID = 'UTA'
GROUP BY g.PlayerID
ORDER BY PTS DESC;

-- Find the stats of all players played in games on 2021-02-02 (Combines 4 tables)
SELECT DISTINCT p.PlayerName, t.TeamName, gs.Points AS PTS, gs.Rebounds AS TRB, gs.Assists AS AST, gs.Steals AS STL, 
	gs.Blocks AS BLK, gs.Turnovers AS TOV, gs.PersonalFouls AS PF, gs.Minutes AS MP
FROM GameStats gs
INNER JOIN Players p ON p.PlayerID = gs.PlayerID
INNER JOIN Teams t ON t.TeamID = p.TeamID
WHERE gs.GameID IN (
	SELECT g.GameID
	FROM Games g
	WHERE g.GameDate = DATE('2021-02-02'))
ORDER BY gs.Points DESC;

-- Find the current wins and losses of last year's champion and runner-up teams (combines 2 tables)
SELECT t.TeamID, t.TeamName, t.Wins, t.Losses
FROM Teams t
WHERE t.TeamID IN (
	SELECT c.ChampionID
	FROM Champions c
	WHERE c.Season = 2020) 
    
    OR t.TeamID IN(
    SELECT c.RunnerUpID
	FROM Champions c
	WHERE c.Season = 2020);
    
-- Find which teams have won at least 2 times in the last 13 seasons
SELECT Champion, COUNT(Season) AS Championships
FROM Champions
GROUP BY Champion
HAVING COUNT(Season) >= 2;

-- Find in which team currently plays the FinalsMVP from 2018 (combines 3 tables)
SELECT c.FinalsMVP AS Finals2018MVP, p.TeamID as Current_TeamID, t.TeamName AS Current_TeamName
FROM Champions c
INNER JOIN Players p ON c.FinalsMVP = p.PlayerName
INNER JOIN Teams t ON t.TeamID = p.TeamID
WHERE c.Season = 2018;

-- See how many games where played each month during the first half of the year
SELECT MONTH(GameDate) AS Month, COUNT(GameID) AS Number_of_games
FROM Games
WHERE MONTH(GameDate) <= 6
GROUP BY MONTH(GameDate);
