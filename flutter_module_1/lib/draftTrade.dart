import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraftTradePage extends StatefulWidget {
  @override
  State<DraftTradePage> createState() => _DraftTradeState();
}

class _DraftTradeState extends State<DraftTradePage> {
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
            ElevatedButton(onPressed: () {}, child: const Text('Trade Request'))
          ],
        ),
      ),
    );
  }
}
