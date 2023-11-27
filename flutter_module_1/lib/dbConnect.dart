import 'package:flutter/material.dart';
import 'package:flutter_module_1/leagues.dart';
import 'package:postgres/postgres.dart';
import 'dart:io';

class PostgresConnection {
  PostgreSQLConnection connection = PostgreSQLConnection(
      'shaped-badger-13180.5xj.cockroachlabs.cloud', 26257, 'defaultdb',
      queryTimeoutInSeconds: 3600,
      timeoutInSeconds: 3600,
      useSSL: true,
      username: 'justinvang_jk_gmail_',
      password: 'pX0U096Ls1KhnSlwRV_QYQ');
  // void createConnection() {
  //   final connection = PostgreSQLConnection(
  //       'shaped-badger-13180.5xj.cockroachlabs.cloud', 26257, 'defaultdb',
  //       queryTimeoutInSeconds: 3600,
  //       timeoutInSeconds: 3600,
  //       username: 'justinvang_jk_gmail_',
  //       password: 'pX0U096Ls1KhnSlwRV_QYQ');
  // }

  //connect to the database
  initDatabaseConnection() async {
    await connection.open().then((value) {
      //print("Database Connected!");
    });
  }

  PostgreSQLConnection connectTo() {
    PostgreSQLConnection connection = PostgreSQLConnection(
        'shaped-badger-13180.5xj.cockroachlabs.cloud', 26257, 'defaultdb',
        queryTimeoutInSeconds: 3600,
        timeoutInSeconds: 3600,
        useSSL: true,
        username: 'justinvang_jk_gmail_',
        password: 'pX0U096Ls1KhnSlwRV_QYQ');

    return connection;
  }

  //////////////////////////////////////////////account
  //return a bool and check if the account is in the database
  Future<bool> checkAccount(String username, String password) async {
    //later do hashing
    PostgreSQLConnection connection = connectTo();
    await connection.open().then((value) {
      //   print("Database Connected!");
    });

    List<List<dynamic>> result = await connection.query(
        "SELECT username FROM TeamManagers WHERE username = @username AND password = @password",
        substitutionValues: {
          "username": username,
          "password": password
        } //later when accounts are added then get add WHERE account = account
        );
    //print(result);
    if (result.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  ///////////////////////////////////////////////////////////////home page
  //get the name of the league the user is in
  Future<List<List<dynamic>>> getLeagues(String username) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open().then((value) {
      //print("Database Connected!");
    });
    List<List<dynamic>> result = await connection.query(
        "SELECT DISTINCT leagueName FROM Leagues, TeamManagersInLeagues WHERE username = @username AND Leagues.leagueId = TeamManagersInLeagues.leagueId",
        substitutionValues: {"username": username});
    //print(result);
    return result;
  }

  Future<List<dynamic>> getLeagueId() async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result =
        await connection.query("SELECT leagueId FROM Leagues");
    return result;
  }

  List<dynamic> addFlagFav(List<dynamic> players, bool flag, int index) {
    for (int i = index; i < players.length; i++) {
      if (flag) {
        players[i].add(1);
      } else {
        players[i].add(0);
      }
    }
    return players;
  }

  //-----------------------------------------------------------search pages
  //get favorite players
  Future<List<dynamic>> getPlayersList(String username) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open().then((value) {
      //print("Database Connected!");
    });
    List<List<dynamic>> favPlayers = await connection.query(
        "SELECT playerName, Players.playerId FROM Players, FavoritePlayers WHERE Players.playerId = FavoritePlayers.playerId AND username = @username",
        substitutionValues: {"username": username});
    //print(favPlayers);
    List<List<dynamic>> players = await connection.query(
        "SELECT playerName, Players.playerId FROM Players WHERE playerId NOT IN (SELECT Players.playerId FROM Players, FavoritePlayers WHERE Players.playerId = FavoritePlayers.playerId AND username = @username)",
        substitutionValues: {"username": username});
    //print(players);
    List<dynamic> totalPlayers = [];
    totalPlayers.addAll(favPlayers);
    int favLength = favPlayers.length;
    //totalPlayers = addFlagFav(totalPlayers, true, 0);
    totalPlayers.addAll(players);
    //totalPlayers = addFlagFav(totalPlayers, false, favLength);
    print(totalPlayers);
    return totalPlayers;
  }

  //get players from database
  Future<List<List<dynamic>>> getPlayers() async {
    PostgreSQLConnection connection = connectTo();
    await connection.open().then((value) {
      print("Database Connected!");
    });
    List<List<dynamic>> result =
        await connection.query("SELECT playerName, team FROM Players");
    print(result);
    return result;
  }

  //get the team managers from one league
  Future<List<List<dynamic>>> getTeamManagers(int leagueId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<List<dynamic>> result = await connection.query(
        "SELECT username FROM teammanagersinleagues WHERE leagueId = @leagueId ORDER BY orderId ASC",
        substitutionValues: {"leagueId": leagueId});
    print(result);
    return result;
  }

  Future<void> setRoundData(
      int leagueId, int roundId, int roundOrder, String username) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "INSERT INTO Rounds (leagueId, roundId, roundOrder, username) VALUES (@leagueId, @roundId, @roundOrder, @username)",
        substitutionValues: {
          "leagueId": leagueId,
          "roundId": roundId,
          "roundOrder": roundOrder,
          "username": username
        });
  }

  Future<bool> checkRoundData(int leagueId, int roundId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<List<dynamic>> result = await connection.query(
        "SELECT * FROM Rounds WHERE leagueId = @leagueId AND roundId = @roundId",
        substitutionValues: {"leagueId": leagueId, "roundId": roundId});
    if (result.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////////////////////////////Search Players for league
  //INSERT INTO Rounds (leagueId, roundId, username) VALUES (6, 1, 'user2');
  //UPDATE Rounds SET playerId = 1 WHERE leagueId = 6 AND roundId = 1 AND username = 'user2';
  Future<void> setPlayerRoundData(
      int leagueId, int roundId, String username, String playerId) async {
    print("$leagueId, $roundId, $username, $playerId");
    //check if playerId is valid
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "UPDATE Rounds SET playerId = @playerId WHERE leagueId = @leagueId AND roundId = @roundId AND username = @username",
        substitutionValues: {
          "playerId": playerId,
          "leagueId": leagueId,
          "roundId": roundId,
          "username": username
        });
  }
  ///////////////////////////////////////////////////session get player name from player id

  //get the players from playerId
  Future<List<List<dynamic>>> getPlayerName(int playerId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT playerName, playerId FROM Players WHERE playerId = @playerId",
        substitutionValues: {"playerId": playerId});
    return results;
  }

  //get the team managers and player they picked for specific round
  //SELECT username, playerId FROM Rounds WHERE roundId = '1' AND leagueId = 918759293838098433 ORDER BY roundId, roundOrder;
  Future<List<List<dynamic>>> getAllRoundInformation(int leagueId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT roundId, username, playerId FROM Rounds WHERE leagueId = @leagueId ORDER BY roundId, roundOrder",
        substitutionValues: {"leagueId": leagueId});
    return results;
  }

  //instead of one play name get all play names
  Future<List<dynamic>> getPlayerNameRound(int roundId, int leagueId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> results = await connection.query(
        "SELECT playerName FROM Players, Rounds WHERE Players.playerId = Rounds.playerId AND roundId = @roundId AND leagueId = @leagueId ORDER BY roundorder",
        //"SELECT playerId FROM Rounds WHERE roundId = @roundId AND leagueId = @leagueId ORDER BY roundOrder ASC",
        //"SELECT playerName FROM Players WHERE playerId IN (SELECT playerId FROM Rounds WHERE roundId = @roundId AND leagueId = @leagueId)",
        substitutionValues: {"roundId": roundId, "leagueId": leagueId});
    return results;
  }

  Future<List<List<dynamic>>> getRound(int leagueId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<List<dynamic>> results = await connection.query(
        "SELECT round FROM Leagues WHERE leagueId = @leagueId",
        substitutionValues: {"leagueId": leagueId});
    return results;
  }

  //-------------------------------------------Create League
  Future<void> setLeague(String leagueName, int round) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "INSERT INTO Leagues (leagueName, round) VALUES (@leagueName, @round)",
        substitutionValues: {"leagueName": leagueName, "round": round});
  }

  Future<List<dynamic>> getTeamManagerEmail(String username) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result = await connection.query(
        "SELECT email FROM TeamManagers WHERE username = @username",
        substitutionValues: {"username": username});
    return result;
  }

  Future<void> setOwner(
      String email, int leagueId, String username, int orderId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "INSERT INTO Owners(email, leagueId) VALUES (@email, @leagueId)",
        substitutionValues: {"email": email, "leagueId": leagueId});
    await connection.execute(
        "INSERT INTO TeamManagersInLeagues(leagueId, username, orderId) VALUES (@leagueId, @username, @orderId)",
        substitutionValues: {
          "leagueId": leagueId,
          "username": username,
          "orderId": orderId
        });
  }

  Future<void> addOwnerToLeague() async {}

  Future<List<dynamic>> getNewLeagueId(String leagueName) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result = await connection.query(
        "SELECT leagueId FROM Leagues WHERE leagueName = @leagueName",
        substitutionValues: {"leagueName": leagueName});
    return result;
  }

  ////////////////////////////////////trades

  Future<void> addTrades(int leagueId, String username1, String username2,
      int round1, int round2) async {
    //int roundOrder1, int roundOrder2
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "INSERT INTO Trades(leagueId, username1, username2, round1, round2) VALUES (@leagueId, @username1, @username2, @round1, @round2)",
        substitutionValues: {
          "leagueId": leagueId,
          "username1": username1,
          "username2": username2,
          "round1": round1,
          "round2": round2,
          //"roundOrder1": roundOrder1,
          //"roundOrder2": roundOrder2
        });
  }

  Future<List<dynamic>> getRoundOrder(String username1, String username2,
      int round1, int round2, int leagueId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result = await connection.query(
        "SELECT roundOrder FROM Rounds WHERE username = @username2 AND roundId = @round2 AND leagueId = @leagueId",
        substitutionValues: {
          "username2": username2,
          "roundId": round2,
          "leagueId": leagueId
        });
    List<dynamic> result2 = await connection.query(
        "SELECT roundOrder FROM Rounds WHERE username = @username1 AND roundId = @round1 AND leagueId = @leagueId",
        substitutionValues: {
          "username1": username1,
          "roundId": round1,
          "leagueId": leagueId
        });
    List<dynamic> roundOrderIds = [];
    roundOrderIds.addAll(result);
    roundOrderIds.addAll(result2);
    return roundOrderIds;
  }

  Future<List<dynamic>> getRoundOrderFromTradesTable(int tradeId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result = await connection.query(
        "SELECT roundOrder1, roundOrder2 FROM Trades WHERE tradeId = @tradeId",
        substitutionValues: {"tradeId": tradeId});

    return result;
  }

  Future<List<dynamic>> getTradesAvailable(String username) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    List<dynamic> result = await connection.query(
        "SELECT tradeId, username1, round1, round2 FROM Trades WHERE username2 = @username2",
        substitutionValues: {"username2": username});
    return result;
  }

  //username1 is team manager who asked for trade, username2 is accepting trade, round1 is round first team manager is trading, round 2 is acceptor,
  //same for roundOrder 1 and 2
  Future<void> updateRoundsAfterTrade(
      String username1,
      String username2,
      int leagueId,
      int round1,
      int round2,
      int roundOrder1,
      int roundOrder2,
      int tradeId) async {
    PostgreSQLConnection connection = connectTo();
    await connection.open();
    await connection.execute(
        "UPDATE Rounds SET username = @username1 WHERE leagueId = @leagueId AND roundId = @round1 AND roundOrder = @roundOrder",
        substitutionValues: {
          "username1": username1,
          "leagueId": leagueId,
          "roundId": round1,
          "roundOrder": roundOrder1
        });
    await connection.execute(
        "UPDATE Rounds SET username = @username2 WHERE leagueId = @leagueId AND roundId = @round2 AND roundOrder = @roundOrder",
        substitutionValues: {
          "username2": username2,
          "leagueId": leagueId,
          "roundId": round2,
          "roundOrder": roundOrder2
        });
    await connection.execute("DELETE FROM Trades WHERE tradeId = @tradeId",
        substitutionValues: {"tradeId": tradeId});
  }
}
