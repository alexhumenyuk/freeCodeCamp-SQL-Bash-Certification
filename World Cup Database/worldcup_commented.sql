-- CREATE DATABASE worldcup;

-- Create tables
CREATE TABLE teams (
	team_id SERIAL PRIMARY KEY NOT NULL,
	name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE games (
	game_id SERIAL PRIMARY KEY NOT NULL,
	year INT NOT NULL,
	round VARCHAR(20) NOT NULL,
	winner_id INT REFERENCES teams(team_id) NOT NULL,
	opponent_id INT REFERENCES teams(team_id) NOT NULL,
	winner_goals INT NOT NULL,
	opponent_goals INT NOT NULL
);

-- Copy the .csv file to a temporary table
CREATE TABLE temp (
	year INT,
	round VARCHAR(20),
	winner VARCHAR(20),
	opponent VARCHAR(20),
	winner_goals INT,
	opponent_goals INT
);

COPY temp (year, round, winner, opponent, winner_goals, opponent_goals)
FROM 'G:\Users\Documents\Git\freeCodeCamp-SQL-Bash-Certification\World Cup Database\games.csv'
WITH (FORMAT csv, HEADER true); -- HEADER true not to include the first row as data

--SELECT * FROM temp LIMIT 5; -- Check the first 5 rows of the temp table


-- Extract the unique team names from temp and check that there are 24
/*SELECT COUNT (*) FROM (
	SELECT DISTINCT winner AS team_name FROM temp -- Retrieve all unique names from the winner column
	UNION -- Retrieve all unique names from both queries
	SELECT DISTINCT opponent AS team_name FROM temp -- Retrieve all unique names from the opponent column
) AS unique_teams; -- Alias names are required in subqueries (AS <alias>)
*/
-- Add the unique team names to teams (name) using the checked subquery
INSERT INTO teams (name)
SELECT DISTINCT winner AS team_name FROM temp
UNION
SELECT DISTINCT opponent AS team_name FROM temp;

SELECT * FROM teams;

-- Populate the games table with values from temp and teams tables
INSERT INTO games (year, round, winner_id, opponent_id, winner_goals, opponent_goals)
SELECT -- instead of VALUES to insert all the needed rows in each column at once
	temp.year,
	temp.round,
	teams_winner.team_id,
	teams_opponent.team_id,
	temp.winner_goals,
	temp.opponent_goals
FROM temp
-- For each row in temp, if temp.winner = teams.name, extract the team_id from teams
-- JOIN needs aliases, so teams is referred to as teams_winner/opponent
JOIN teams AS teams_winner ON temp.winner = teams_winner.name
JOIN teams AS teams_opponent ON temp.opponent = teams_opponent.name;

SELECT * FROM games;

DROP TABLE temp;