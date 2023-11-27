import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/draftTradeConfirm.dart';

class DraftTradePage extends StatefulWidget {
  final int leagueId;
  final String userLoggedIn;
  const DraftTradePage(
      {super.key, required this.leagueId, required this.userLoggedIn});

  @override
  State<DraftTradePage> createState() => _DraftTradePageState();
}

class _DraftTradePageState extends State<DraftTradePage> {
  TextEditingController roundRecieving = TextEditingController();
  TextEditingController teamManagerController = TextEditingController();
  TextEditingController roundGiving = TextEditingController();
  PostgresConnection connection = PostgresConnection();
  PostgresConnection connection2 = PostgresConnection();
  List<dynamic> roundOrderIds = [];

  Future<void> updateTrades() async {
    await connection.addTrades(
        widget.leagueId,
        widget.userLoggedIn,
        teamManagerController.text,
        int.parse(roundGiving.text),
        int.parse(roundRecieving.text));
    //roundOrderIds[0][0],
    //roundOrderIds[0][1]);
  }

  // Future<List<dynamic>> getTeamManagerRoundOrders() async {
  //   List<dynamic> roundOrderIds = await connection2.getRoundOrder(
  //       teamManagerController.text,
  //       widget.userLoggedIn,
  //       int.parse(roundGiving.text),
  //       int.parse(roundRecieving.text),
  //       widget.leagueId);
  //   return roundOrderIds;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Trade"),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DraftTradeConfirmPage(
                          userLoggedIn: widget.userLoggedIn,
                          leagueId: widget.leagueId))),
              icon: const Icon(Icons.compare_arrows))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(children: <Widget>[Text('Team Manager Round')]),
            TextFormField(
                controller: roundRecieving,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Team manager round to trade',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Rounds.";
                  }
                  return null;
                }),
            const Row(children: <Widget>[Text('Your Round')]),
            TextFormField(
                controller: roundGiving,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Your round to trade',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Rounds.";
                  }
                  return null;
                }),
            const Row(children: <Widget>[
              Text('Team Manager')
            ]), ///////////////change later to listview of team managers
            TextFormField(
                controller: teamManagerController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Team Manager trading',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter Other Team Manager.";
                  }
                  return null;
                }),
            const Row(children: <Widget>[Text('You')]),
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget
                    .userLoggedIn, //take username label from round (roundId, roundOrder)
              ),
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () {
                        showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text(''),
                            content: const Text('Trade Requested!'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, 'Cancel'),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () async {
                                  //roundOrderIds = await getTeamManagerRoundOrders();
                                  await updateTrades();
                                  Navigator.pop(context, 'OK');
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                      child: const Text('Request'))
                ])
          ],
        ),
      ),
    );
  }
}
