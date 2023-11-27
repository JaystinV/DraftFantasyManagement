import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraftUpdate extends StatefulWidget {
  @override
  State<DraftUpdate> createState() => _DraftUpdateState();
}

class _DraftUpdateState extends State<DraftUpdate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Update"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            //const Row(children: <Widget>[Text('League Name')]),
            const Text('League Name'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Leauge Name',
              ),
            ),
            //const Row(children: <Widget>[Text('Session Key')]),
            const Text('Session Key'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ki3j7y',
              ),
            ),
            //const Row(children: <Widget>[Text('Rounds')]),
            const Text('Rounds'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Total Rounds',
              ),
            ),
            const Text('Timer'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Total Time',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    showDialog<String>(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                        title: const Text(''),
                        content: const Text('Updated!'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () => Navigator.pop(context, 'OK'),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                  });
                },
                child: const Text('Update')),
          ],
        ),
      ),
    );
  }
}
