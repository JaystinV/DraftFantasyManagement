import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftSession.dart';

class DraftStartPage extends StatefulWidget {
  const DraftStartPage({super.key});

  @override
  State<DraftStartPage> createState() => _DraftStartPageState();
}

class _DraftStartPageState extends State<DraftStartPage> {
  //final List<int> _items = List<int>.generate(50, (int index) => index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Draft Start"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(children: <Widget>[
              const Row(children: <Widget>[Text('Session Tolken')]),
              const TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Ki3j7y',
                ),
              ),
              const Row(children: <Widget>[Text('Team Manager Order')]),
              Column(children: <Widget>[
                SizedBox(
                    height: 550,
                    child: ListView.builder(
                      itemCount: 16,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(title: Text('Team Manager $index'));
                      },
                      //onReorder: (int oldIndex, int newIndex) {
                      // setState(() {
                      //   if (oldIndex < newIndex) {
                      //     newIndex -= 1;
                      //   }
                      //   final int item = _items.removeAt(oldIndex);
                      //   _items.insert(newIndex, item);
                      // });
                    )),
              ]),
            ]),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DraftSessionPage()));
                  // SystemChrome.setPreferredOrientations(
                  //     [DeviceOrientation.landscapeRight]);
                },
                child: const Text('Start')),
          ],
        ),
      ),
    );
  }
}
