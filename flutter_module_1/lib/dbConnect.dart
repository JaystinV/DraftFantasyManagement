import 'package:flutter/material.dart';
import 'package:flutter_module_1/leagues.dart';
import 'package:postgres/postgres.dart';

class PostgresConnection {
  final connection = PostgreSQLConnection(
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

  initDatabaseConnection() async {
    await connection.open().then((value) {
      print("Database Connected!");
    });
    //connection.open();
    List<Map<String, Map<String, dynamic>>> result =
        await connection.mappedResultsQuery(
      "SELECT * FROM Leagues",
    );
    if (result.length == 1) {
      for (var element in result) {
        var teamManagers = element.values.toList();
        print('$teamManagers');
      }
    }
    print("BRUH");
  }

  Future<List<List<dynamic>>> getLeagues() async {
    await connection.open().then((value) {
      print("Database Connected!");
    });
    //connection.open();
    List<List<dynamic>> result = await connection.query(
      "SELECT leagueName FROM Leagues", //later when accounts are added then get add WHERE account = account
    );
    print(result);
    return result;
    // print(result[0]);
    // for (final row in result) {
    //   var a = row[0];
    //   print(a);
    // }

    // print("bruh");
  }
  // Future<List<Leagues>> getUserLeagues() async {
  //   List<Map> list = await connection.mappedResultsQuery('SELECT * FROM Countries');
  //   return list.map((countries) => Leagues.fromMapObject(countries)).toList();
  // }
}
// await connection.open();
// await connection.transaction((ctx) async {                         
//   await ctx.query("""
//               INSERT INTO public.tester (a, b)
//               VALUES 4, 5;
//               """);
// var result =
// await ctx.query("SELECT b FROM public.tester");
// print(result);
