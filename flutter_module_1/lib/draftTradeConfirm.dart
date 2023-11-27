import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';

class DraftTradeConfirmPage extends StatefulWidget {
  final String userLoggedIn;
  final int leagueId;
  const DraftTradeConfirmPage(
      {super.key, required this.userLoggedIn, required this.leagueId});

  @override
  State<DraftTradeConfirmPage> createState() => _DraftTradeConfirmPageState();
}

class _DraftTradeConfirmPageState extends State<DraftTradeConfirmPage> {
  PostgresConnection connection = PostgresConnection();
  List<dynamic> currentTrades = [];
  List<dynamic> roundOrder = [];

  Future<List<dynamic>> getTrades() async {
    List<dynamic> results =
        await connection.getTradesAvailable(widget.userLoggedIn);
    return results;
  }

  Future<List<dynamic>> getRoundOrder(int tradeId) async {
    List<dynamic> results =
        await connection.getRoundOrderFromTradesTable(tradeId);
    return results;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Draft Trade Confirmation"),
        ),
        body: FutureBuilder(
          builder: (context, tradesSnap) {
            if (!tradesSnap.hasData) {
              return const Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                    SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    )
                  ]));
            } else {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Row(children: <Widget>[Text('Trades Available')]),
                    Expanded(
                        child: ListView.separated(
                      itemCount: currentTrades.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            onTap: () {
                              setState(() {
                                showDialog<String>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                    title: const Text('Confirm Trade?'),
                                    content: Text('Trade $index'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context, 'Cancel'),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () async {
                                          //update rounds
                                          //later have an option to delete trade if not wanted or declined
                                          //delete trade
                                          List<dynamic> roundOrder =
                                              await getRoundOrder(
                                                  currentTrades[index][0]);
                                          await connection
                                              .updateRoundsAfterTrade(
                                                  currentTrades[index][1],
                                                  widget.userLoggedIn,
                                                  widget.leagueId,
                                                  currentTrades[index][2],
                                                  currentTrades[index][3],
                                                  roundOrder[0][0],
                                                  roundOrder[0][1],
                                                  currentTrades[index][0]);
                                          Navigator.pop(context, 'OK');
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                                );
                              });
                            },
                            title: Text(
                                'Trade From: ${currentTrades[index][1]}, TradeId: ${currentTrades[index][0]}'));
                      },
                      separatorBuilder: (context, index) {
                        return const Divider();
                      },
                    ))
                  ]);
            }
          },
          future: Future.wait(
              [getTrades().then((results) => currentTrades = results)]),
        ));
  }
}
