DROP TABLE IF EXISTS Trade;
DROP TABLE IF EXISTS FavoritePlayer;
DROP TABLE IF EXISTS Round;
DROP TABLE IF EXISTS Draft;
DROP TABLE IF EXISTS Owner;
DROP TABLE IF EXISTS League;
DROP TABLE IF EXISTS Player;
DROP TABLE IF EXISTS TeamManagers;

CREATE TABLE IF NOT EXISTS TeamManagers (
	email VARCHAR(50) NOT NULL,
	password VARCHAR(20) UNIQUE,
	username VARCHAR(30) PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS Player (
	playerName VARCHAR(80),
	team VARCHAR(25),
	playerId VARCHAR(30) PRIMARY KEY,
	points INTEGER
);
CREATE TABLE IF NOT EXISTS League (
	leagueId INTEGER PRIMARY KEY,
	leagueName VARCHAR(20)
);
CREATE TABLE IF NOT EXISTS Owner (
	ownerId INTEGER PRIMARY KEY,
	leagueId INTEGER NOT NULL REFERENCES league(leagueId) ON DELETE RESTRICT,
	username VARCHAR(30) NOT NULL REFERENCES teammanager(username) ON DELETE RESTRICT,
	FOREIGN KEY -------------------------change all to this and check if works beekeeper 
);
CREATE TABLE IF NOT EXISTS Draft (
	orderId INTEGER PRIMARY KEY,
	leagueId INTEGER NOT NULL REFERENCES league(leagueId) ON DELETE RESTRICT,
	time VARCHAR(20),
	username VARCHAR(30) NOT NULL REFERENCES teammanager(username) ON DELETE RESTRICT
);
CREATE TABLE IF NOT EXISTS Round (
	roundId INTEGER NOT NULL,
	leagueId INTEGER REFERENCES League (leagueId) ON DELETE RESTRICT,
	username VARCHAR(50) REFERENCES TeamManager (username) ON DELETE RESTRICT,
	playerId VARCHAR(30) REFERENCES Player (playerId) ON DELETE CASCADE
);
CREATE TABLE IF NOT EXISTS FavoritePlayer (
	username VARCHAR(50) NOT NULL REFERENCES TeamManager (username) ON DELETE CASCADE,
	playerId VARCHAR(20) NOT NULL REFERENCES Player (playerId) ON DELETE CASCADE
);

//doesn’t currently work
CREATE TABLE IF NOT EXISTS Trade (
	tradeId INTEGER PRIMARY KEY,
	leagueId INTEGER REFERENCES League (leagueId) ON DELETE RESTRICT,
	username1 VARCHAR(50) REFERENCES TeamManager (username) ON DELETE RESTRICT,
	username2 VARCHAR(50) REFERENCES TeamManager (username) ON DELETE RESTRICT,
	round1 INTEGER REFERENCES Round (roundId) ON DELETE CASCADE,
	round2 INTEGER REFERENCES Round (roundId) ON DELETE CASCADE
);

INSERT INTO tester (a,b) VALUES (3, 4);
INSERT INTO teammanagers (email, password, username) VALUES ('testAccount@gmail.com', 'password123', 'theFirstUser');
INSERT INTO Leagues (leagueId, leagueName) VALUES (1, 'League of Leagues');
INSERT INTO Leagues (leagueId, leagueName) VALUES (2, 'Kashia''s League 2023');
INSERT INTO Leagues (leagueId, leagueName) VALUES (3, 'Ben''s League 2023');

