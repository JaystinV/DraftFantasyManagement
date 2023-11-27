import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';

class DraftJoin extends StatefulWidget {
  final String userLoggedIn;
  const DraftJoin({super.key, required this.userLoggedIn});
  @override
  State<DraftJoin> createState() => _DraftJoinState();
}

class _DraftJoinState extends State<DraftJoin> {
  TextEditingController leagueNameController = TextEditingController();
  TextEditingController ownerEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join League"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(children: <Widget>[Text('Username')]),
            TextField(
              enabled: false,
              readOnly: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: widget.userLoggedIn,
              ),
            ),
            const Row(children: <Widget>[Text('Owner' 's Email')]),
            TextFormField(
              controller: ownerEmailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter Owner'
                    's Email', //instead of a session key, the owner creates own password for league? or auto generate a key
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                              userLoggedIn: widget.userLoggedIn,
                              newLeagueName: "",
                              newRounds: 0)));
                },
                child: const Text('Join'))
          ],
        ),
      ),
    );
  }
}
