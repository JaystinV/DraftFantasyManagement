import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftStart.dart';

class DraftSetUp extends StatefulWidget {
  @override
  State<DraftSetUp> createState() => _DraftSetUpState();
}

class _DraftSetUpState extends State<DraftSetUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Create"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(children: <Widget>[Text('League Name')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Leauge Name',
              ),
            ),
            const Row(children: <Widget>[Text('Session Tolken')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ki3j7y',
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const DraftStartPage())),
                child: const Text('Create')),
          ],
        ),
      ),
    );
  }
}
