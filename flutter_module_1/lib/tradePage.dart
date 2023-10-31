import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftStart.dart';

class TradePage extends StatefulWidget {
  @override
  State<TradePage> createState() => _TradePageState();
}

class _TradePageState extends State<TradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Trade"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
            const Text('You'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Your Username',
              ),
            ),
            ElevatedButton(onPressed: () {}, child: const Text('Request')),
          ],
        ),
      ),
    );
  }
}
