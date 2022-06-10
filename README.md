# Basketball league in SQL

A mySQL mini-project where I've created a database with information on games, players and teams for a basketball league. To simplify this I've only used NBA data from the 2020-2021 season. My database includes five tables:
1. Teams: TeamID, TeamName, City, Conference, Wins, Losses
2. Players: PlayerID, PlayerName, TeamID, Age, Pos
3. Games: GameID, GameDate, HomeTeamID, HomeTeamScore, AwayTeamID, AwayTeamScore, Season
4. GameStats: GameID, PlayerID, Points, Minutes, Rebounds, Assists, Steals, Blocks, Turnovers, PersonalFouls
5. Champions: Season, Champion, ChampionID, RunnerUp, RunnerUpID, FinalsMVP, TopPerformer_Points, TopPerformer_Assists, TopPerformer_Rebounds

## Description and purpose

I have downloaded data from Basketball-reference.com for the 2020-2021 season. Adjusted and saved them as csv files and then loaded on mysql.
- Teams: data on 30 teams
- Players: data on 200 players (chosen based on minutes played, therefore mainly starters)
- Games: data on 1080 games
- GameStats: 18768 rows of game statistics
- Champions: data on championships since 2004

Queries: 
- Select all teams from the east conference, order by wins starting with the team that has most wins
- Select all point-guards over 25 years old and show in which teams they are
- Show the average stats of all players playing in the Utah Jazz (UTA)
- Find the stats of all players played in games on 2021-02-02
- Find the current wins and losses of last year's champion and runner-up teams
- Find which teams have won at least 2 times in the last 13 seasons
- Find in which team currently plays the FinalsMVP from 2018
- See how many games where played each month during the first half of the year
Views:
- View of Players and all their Game stats - vw_playerstats. Use the vw_playerstats view to find the maximum rebounds scored by centres
- View of Players and all their Average Game Stats - vw_avgplayerstats. Use the vw_avgplayerstats view to find which players had double points per game and double rebounds per game. Use the vw_avgplayerstats view to find how many players had double points per game, double rebounds per game, double assists or blocks or steals per game 
Functions:
- Function calc_winpct that calculates the win % of a team (win% = wins / (wins+losses) * 100). Use the function calc_winpct to find which teams have a winning percentage of more than 50% this season
- Function per36min that finds a specific statistic per 36 minutes played for a player. Use the function per36min to find the points and assists per 36 minutes of all players played on 2021-03-21
Procedures:
- Procedure TeamPlayers that returns the players of a team. Use TeamPlayers to find the players of Utah Jazz and Milwaukee Bucks for that season
- Procedure TeamStandings that returns the top X teams (team standings) of either overall or east or west conference. Use TeamStandings to find the top 8 teams overall  and the top 3 teams in the West.

## Files
- basketballleague_db_backup.sql: a backup file of the mysql database
- ERdiagram.pn: ER diagram of the implemented tables
- data: all data saved as csv files. Inludes data on teams, players, games, game-stats, champions.
- queries: all files with queries saved separately
