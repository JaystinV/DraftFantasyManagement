import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftStart.dart';

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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DraftStartPage())),
                child: const Text('Join'))
          ],
        ),
      ),
    );
  }
}
