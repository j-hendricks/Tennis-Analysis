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

