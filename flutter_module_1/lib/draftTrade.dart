import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftTradeConfirm.dart';

class DraftTradePage extends StatefulWidget {
  @override
  State<DraftTradePage> createState() => _DraftTradePageState();
}

class _DraftTradePageState extends State<DraftTradePage> {
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
                      builder: (context) => DraftTradeConfirmPage())),
              icon: const Icon(Icons.compare_arrows))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(children: <Widget>[Text('Team Manager Round')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Team manager round to trade',
              ),
            ),
            const Row(children: <Widget>[Text('Your Round')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your round to trade',
              ),
            ),
            const Row(children: <Widget>[Text('Team Manager')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Team Manager trading',
              ),
            ),
            const Row(children: <Widget>[Text('You')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your Username',
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
                                onPressed: () => Navigator.pop(context, 'OK'),
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
