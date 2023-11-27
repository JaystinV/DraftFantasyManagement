import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/draftSession.dart';

class DraftStartPage extends StatefulWidget {
  final int leagueId;
  final String userLoggedIn;
  const DraftStartPage(
      {super.key, required this.leagueId, required this.userLoggedIn});

  @override
  State<DraftStartPage> createState() => _DraftStartPageState();
}

class _DraftStartPageState extends State<DraftStartPage> {
  //final List<int> _items = List<int>.generate(50, (int index) => index);
  PostgresConnection connectTeamManagersInLeague = PostgresConnection();
  List<dynamic> teamManagers = [];

  Future<List<dynamic>> getTeamManagersInLeague() async {
    List<dynamic> teamManagers =
        await connectTeamManagersInLeague.getTeamManagers(widget.leagueId);
    print(teamManagers);
    return teamManagers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Draft Start"),
        ),
        body: FutureBuilder(
            builder: (context, teamManagerSnap) {
              if (!teamManagerSnap.hasData) {
                return const Center(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                      Column(children: <Widget>[
                        Row(children: <Widget>[Text('Session Tolken')]),
                        TextField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Ki3j7y',
                          ),
                        ),
                        Row(children: <Widget>[Text('Team Manager Order')]),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            SizedBox(
                              width: 60,
                              height: 60,
                              child: CircularProgressIndicator(),
                            )
                          ],
                        ),
                      ])
                    ]));
              } else {
                //print(data);
                if (teamManagers.isEmpty) {
                  teamManagers = teamManagerSnap.data!;
                }
                return Center(
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
                        const Row(
                            children: <Widget>[Text('Team Manager Order')]),
                        Column(children: <Widget>[
                          SizedBox(
                              height: 550,
                              child: ListView.builder(
                                itemCount: teamManagers[0].length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ListTile(
                                      title: Text(teamManagers[0][index][0]));
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
                                    builder: (context) => DraftSessionPage(
                                        leagueId: widget.leagueId,
                                        userLoggedIn: widget.userLoggedIn)));
                            // SystemChrome.setPreferredOrientations(
                            //     [DeviceOrientation.landscapeRight]);
                          },
                          child: const Text('Start')),
                    ],
                  ),
                );
              }
            },
            future: Future.wait([getTeamManagersInLeague()])));
  }
}
