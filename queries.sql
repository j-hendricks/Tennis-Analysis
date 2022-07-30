CREATE TABLE players(
	player_id INT NOT NULL,
	first_name VARCHAR,
	last_name VARCHAR,
	hand VARCHAR(1),
	country_code VARCHAR,
	PRIMARY KEY(player_id)
);

CREATE TABLE matches(
	loser_age FLOAT,
	loser_id INT,
	loser_name VARCHAR,
	loser_rank INT,
	winner_age FLOAT,
	winner_id INT,
	winner_name VARCHAR,
	winner_rank INT,
	FOREIGN KEY(loser_id) REFERENCES players(player_id),
	FOREIGN KEY(winner_id) REFERENCES players(player_id)
);

SELECT * FROM players;
SELECT * FROM matches;

-- Dominant Hand Analysis
SELECT COUNT(player_id) as "Total Number of Players"
FROM players;

SELECT hand, COUNT(player_id)
FROM players
GROUP BY hand;

SELECT hand, 100 * COUNT(player_id) / (SELECT COUNT(player_id) FROM players)
FROM players
GROUP BY hand;

SELECT hand as "Hand", COUNT(player_id) as "Total" , 
ROUND(100 * COUNT(player_id) / cast((SELECT COUNT(player_id) FROM players) as DECIMAL(9,2)), 2) as "Percentage"
FROM players
GROUP BY hand;
--

-- Matches Serena Has Won
SELECT COUNT(winner_name) as "Total Won Matches by Serena Williams" 
FROM matches
WHERE winner_name = 'Serena Williams';

-- Matches Serena Has Lost
SELECT COUNT(loser_name) as "Total Lossed Matches by Serena Williams" 
FROM matches
WHERE loser_name = 'Serena Williams';

-- Matches won by dominant hand
SELECT p.hand as "Hand", COUNT(m.winner_id) as "Wins"
FROM players as p
INNER JOIN matches as m
ON (p.player_id = m.winner_id)
GROUP BY p.hand;

SELECT COUNT(winner_id) FROM matches;

SELECT p.hand as "Hand", COUNT(m.winner_id) as "Wins", 
ROUND(100 * COUNT(m.winner_id) / cast((SELECT COUNT(winner_id) FROM matches) as DECIMAL(9,2)),2) as "Percentage of Wins"
FROM players as p
INNER JOIN matches as m
ON (p.player_id = m.winner_id)
GROUP BY p.hand
ORDER BY "Wins" DESC;

-- Country_code
SELECT country_code, COUNT(player_id) as "Total Number of Players"
FROM players
GROUP BY country_code
ORDER BY "Total Number of Players" DESC; 

SELECT country_code, COUNT(player_id) as "Total Number of Players", 
ROUND(100 *  COUNT(player_id) / cast((SELECT COUNT(player_id) FROM players) as DECIMAL(9,2)),2) as "Percentage of Players"
FROM players
GROUP BY country_code
ORDER BY "Total Number of Players" DESC; 

-- Winnings by Country Code
SELECT p.country_code as "Country", COUNT(m.winner_id) as "Number of Wins"
FROM players as p
INNER JOIN matches as m
ON (p.player_id = m.winner_id)
GROUP BY p.country_code
ORDER BY "Number of Wins" DESC; 

SELECT p.country_code as "Country", COUNT(m.winner_id) as "Number of Wins", 
ROUND(100 * COUNT(m.winner_id) / cast((SELECT COUNT(winner_id) FROM matches) as DECIMAL(9,2)),2) as "Percetange of Wins"
FROM players as p
INNER JOIN matches as m
ON (p.player_id = m.winner_id)
GROUP BY p.country_code
ORDER BY "Number of Wins" DESC;

-- Player with most wins
SELECT winner_name, COUNT(winner_name) as "Number of Wins"
FROM matches
GROUP BY winner_name
ORDER BY "Number of Wins" DESC;

-- Player with most wins with more info
SELECT m.winner_name, COUNT(m.winner_name) as "Number of Wins", p.hand, p.country_code
FROM matches as m
INNER JOIN players as p
ON (p.player_id = m.winner_id)
GROUP BY m.winner_name, p.hand, p.country_code
ORDER BY "Number of Wins" DESC;
