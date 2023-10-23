import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';

class DraftJoin extends StatefulWidget {
  @override
  State<DraftJoin> createState() => _DraftJoinState();
}

class _DraftJoinState extends State<DraftJoin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Join"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(children: <Widget>[Text('Username')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Team Manager\'s Name',
              ),
            ),
            const Row(children: <Widget>[Text('Session Key')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter League Session Key',
              ),
            ),
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage())),
                child: const Text('Join'))
          ],
        ),
      ),
    );
  }
}
