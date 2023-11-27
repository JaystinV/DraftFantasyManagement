DROP TABLE IF EXISTS Trades;
DROP TABLE IF EXISTS Rounds;
DROP TABLE IF EXISTS Drafts;
DROP TABLE IF EXISTS Owners;
DROP TABLE IF EXISTS FavoritePlayers;
DROP TABLE IF EXISTS TeamManagersInLeagues;
DROP TABLE IF EXISTS Leagues;
DROP TABLE IF EXISTS Players;
DROP TABLE IF EXISTS TeamManagers;

CREATE TABLE IF NOT EXISTS TeamManagers (
	email VARCHAR(50) UNIQUE,
	password VARCHAR(20) NOT NULL,
	username VARCHAR(30) PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS Players (
	playerName VARCHAR(80) NOT NULL,
	team VARCHAR(25) NOT NULL,
	position VARCHAR(25), --not null later
	playerId VARCHAR(30) PRIMARY KEY,
	points INTEGER
);
CREATE TABLE IF NOT EXISTS Leagues (
	leagueId SERIAL PRIMARY KEY,
	leagueName VARCHAR(20),
    round INTEGER NOT NULL
);

CREATE TABLE IF NOT EXISTS TeamManagersInLeagues (
	orderId INTEGER NOT NULL,
	time INTEGER,
	leagueId INTEGER REFERENCES Leagues(leagueId),
	username VARCHAR(30) REFERENCES Teammanagers(username),
	PRIMARY KEY (leagueId, username, orderId)
);
CREATE TABLE IF NOT EXISTS FavoritePlayers (
	username VARCHAR(50) NOT NULL REFERENCES TeamManagers (username) ON DELETE CASCADE,
	playerId VARCHAR(20) NOT NULL REFERENCES Players (playerId) ON DELETE CASCADE
);

CREATE TABLE IF NOT EXISTS Rounds (
	roundId INTEGER NOT NULL,
	roundOrder INTEGER NOT NULL,
	leagueId SERIAL REFERENCES Leagues (leagueId) ON DELETE RESTRICT,
	username VARCHAR(50) REFERENCES TeamManagers (username) ON DELETE RESTRICT,
	playerId VARCHAR(30) REFERENCES Players (playerId) ON DELETE CASCADE,
	PRIMARY KEY (roundId, leagueId, username)
);

--this is used for join
CREATE TABLE IF NOT EXISTS Owners (
	email VARCHAR(50) REFERENCES TeamManagers(email),
	leagueId SERIAL NOT NULL REFERENCES Leagues(leagueId) ON DELETE RESTRICT,
	PRIMARY KEY (email, leagueId)
);

CREATE TABLE IF NOT EXISTS Drafts (
	currentRound INTEGER NOT NULL,
	leagueId SERIAL NOT NULL REFERENCES Leagues(leagueId),
	time INTEGER,
	
);

CREATE SEQUENCE IF NOT EXISTS rounds_sequence start 1 increment 1;


//does currently work
CREATE TABLE IF NOT EXISTS Trades (
	tradeId SERIAL NOT NULL,
	leagueId SERIAL REFERENCES Leagues (leagueId) ON DELETE RESTRICT,
	username1 VARCHAR(50),
	username2 VARCHAR(50),
	round1 INTEGER,
	round2 INTEGER,
	-- roundOrder1 INTEGER,
	-- roundOrder2 INTEGER,
	PRIMARY KEY (tradeId, leagueId)
);

--INSERT INTO tester (a,b) VALUES (3, 4);

INSERT INTO teammanagers (email, password, username) VALUES ('testAccount@gmail.com', 'password123', 'theFirstUser');
INSERT INTO teammanagers (email, password, username) VALUES ('user2@gmail.com', 'password1234', 'user2');
INSERT INTO teammanagers (email, password, username) VALUES ('kv@gmail.com', 'password1234', 'KevinV');
INSERT INTO teammanagers (email, password, username) VALUES ('kt123@gmail.com', 'password1234', 'KashiaT');
INSERT INTO teammanagers (email, password, username) VALUES ('kou@gmail.com', 'password1234', 'Billy123');
INSERT INTO teammanagers (email, password, username) VALUES ('ben4@gmail.com', 'password1234', 'Ben10');
INSERT INTO teammanagers (email, password, username) VALUES ('footballMan@gmail.com', 'password1234', 'Xai9');
INSERT INTO teammanagers (email, password, username) VALUES ('timYang@gmail.com', 'password1234', 'Tim Y');

INSERT INTO Leagues (leagueName, round) VALUES ('League of Leagues', 6);
INSERT INTO Leagues (leagueName, round) VALUES ('Kashia''s League 2023', 6);
INSERT INTO Leagues (leagueName, round) VALUES ('Ben''s League 2023', 5);
INSERT INTO Leagues (leagueName, round) VALUES ('user1''s League 2020', 6);
INSERT INTO Leagues (leagueName, round) VALUES ('user2''s League 2022', 8);
INSERT INTO Leagues (leagueName, round) VALUES ('user3''s League 2023', 7);

INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'theFirstUser', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293846323201, 'theFirstUser', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293853794305, 'theFirstUser', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293881712641, 'theFirstUser', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'user2', 2);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293846323201, 'user2', 2);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293875159041, 'user2', 2);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293881712641, 'user2', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293853794305, 'user2', 1);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'KevinV', 3);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'KashiaT', 4);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'Billy123', 5);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'Ben10', 6);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'Xai9', 7);
INSERT INTO TeamManagersInLeagues (leagueId, username, orderId) VALUES (918759293838098433, 'Tim Y', 8);


INSERT INTO Players (playerName, team, playerId) VALUES ('Patrick Mahomes', 'KCC', 1);
INSERT INTO Players (playerName, team, playerId) VALUES ('Travis Kelce', 'KCC', 2);
INSERT INTO Players (playerName, team, playerId) VALUES ('Aaron Rodgers', 'NYJ', 3);
INSERT INTO Players (playerName, team, playerId) VALUES ('Tom Brady', 'NEP', 4);
INSERT INTO Players (playerName, team, playerId) VALUES ('Josh Allen', 'BB', 5);
INSERT INTO Players (playerName, team, playerId) VALUES ('Aaron Donlad', 'LAR', 6);
INSERT INTO Players (playerName, team, playerId) VALUES ('Lamar Jackson', 'BR', 7);
INSERT INTO Players (playerName, team, playerId) VALUES ('Jalen Hurts', 'PE', 8);
INSERT INTO Players (playerName, team, playerId) VALUES ('Justin Jefferson', 'MV', 9);
INSERT INTO Players (playerName, team, playerId) VALUES ('Nick Bosa', 'SF49', 10);

INSERT INTO FavoritePlayers (username, playerId) VALUES ('user2', 1);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('user2', 4);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('user2', 6);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('theFirstUser', 2);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('theFirstUser', 4);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('theFirstUser', 7);
INSERT INTO FavoritePlayers (username, playerId) VALUES ('theFirstUser', 9);

INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (1, 8, 918759293838098433, 'Tim Y');

INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (2, 8, 918759293838098433, 'Tim Y');

INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (3, 8, 918759293838098433, 'Tim Y');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (4, 8, 918759293838098433, 'Tim Y');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (5, 8, 918759293838098433, 'Tim Y');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 1, 918759293838098433, 'theFirstUser');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 2, 918759293838098433, 'user2');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 3, 918759293838098433, 'KevinV');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 4, 918759293838098433, 'KashiaT');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 5, 918759293838098433, 'Billy123');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 6, 918759293838098433, 'Ben10');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 7, 918759293838098433, 'Xai9');
INSERT INTO Rounds (roundId, roundOrder, leagueId, username) VALUES (6, 8, 918759293838098433, 'Tim Y');

SELECT COUNT(username) FROM TeamManagersInLeagues GROUP BY username; --get count for leagues in 
SELECT playerName FROM Players, FavoritePlayers WHERE Players.playerId = FavoritePlayers.playerId AND username = 'user2'; --select favorite player name
SELECT playerName FROM Players WHERE playerId NOT IN (SELECT Players.playerId FROM Players, FavoritePlayers WHERE Players.playerId = FavoritePlayers.playerId AND username = 'user2');


CREATE TABLE IF NOT EXISTS TeamManagers (
	email VARCHAR(50) UNIQUE,
	password VARCHAR(20) NOT NULL,
	username VARCHAR(30) NOT NULL,
	PRIMARY KEY (username)
);
CREATE TABLE IF NOT EXISTS Players (
	playerName VARCHAR(80) NOT NULL,
	team VARCHAR(25) NOT NULL,
	position VARCHAR(25), --not null later
	playerId VARCHAR(30) PRIMARY KEY,
	points INTEGER
);
CREATE TABLE IF NOT EXISTS Leagues (
	email VARCHAR(50) REFERENCES TeamManagers(email),
	leagueId SERIAL,
	leagueName VARCHAR(20),
    round INTEGER NOT NULL,
	PRIMARY KEY (email, leagueId)
);

CREATE TABLE IF NOT EXISTS TeamManagersInLeagues (
	orderId INTEGER NOT NULL,
	time INTEGER,
	email VARCHAR(50) REFERENCES Leagues(email),
	leagueId SERIAL REFERENCES Leagues(leagueId),
	PRIMARY KEY (leagueId, email, orderId)
);
CREATE TABLE IF NOT EXISTS FavoritePlayers (
	username VARCHAR(50) NOT NULL REFERENCES TeamManagers (username) ON DELETE CASCADE,
	playerId VARCHAR(20) NOT NULL REFERENCES Players (playerId) ON DELETE CASCADE,
	PRIMARY KEY (username, playerId)
);