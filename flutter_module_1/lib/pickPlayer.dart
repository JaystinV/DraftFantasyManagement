import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PickPlayersPage extends StatefulWidget {
  @override
  State<PickPlayersPage> createState() => _PickPlayersPageState();
}

class _PickPlayersPageState extends State<PickPlayersPage> {
  @override
  Widget build(BuildContext context) {
    //place listview here with widget helper
    return Scaffold(
        appBar: AppBar(title: const Text('Draft Fantasy Management'), actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.search))
        ]),
        body: ListView.builder(
          itemCount: 8,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(title: Text('Favorite Player $index'));
          },
        ));
  }
}
