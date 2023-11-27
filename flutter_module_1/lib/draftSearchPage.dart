import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/draftSession.dart';
import 'package:flutter_module_1/footballPlayers.dart';

class DraftSearchPage extends StatefulWidget {
  final int leagueId;
  final String userLoggedIn;
  final int roundId;
  final String username;
  final int indexOfPlayerPicked;
  const DraftSearchPage(
      {super.key,
      required this.leagueId,
      required this.userLoggedIn,
      required this.roundId,
      required this.username,
      required this.indexOfPlayerPicked});
  @override
  State<DraftSearchPage> createState() => _DraftSearchPageState();
}

class _DraftSearchPageState extends State<DraftSearchPage> {
  TextEditingController searchController = TextEditingController();
  PostgresConnection connectFavPlayer = PostgresConnection();
  PostgresConnection connectPlayerName = PostgresConnection();
  PostgresConnection connectUpdatePlayerRound = PostgresConnection();
  List<dynamic> players = []; //[0][index for name][0]
  List<dynamic> searchedPlayers = [];
  int listTileLength = 0;

  Future<List<dynamic>> getPlayers() async {
    List<dynamic> favPlayers = await connectFavPlayer.getPlayersList(
        widget.userLoggedIn); // change later from static usernam
    return favPlayers;
  }

  Future<List<dynamic>> getPlayerName(int playerId) async {
    List<dynamic> players = await connectPlayerName.getPlayerName(playerId);
    return players;
  }

  Future<void> updatePlayerRound(String playerId) async {
    await connectUpdatePlayerRound.setPlayerRoundData(
        widget.leagueId, widget.roundId, widget.username, playerId);
  }

  void searchPlayers(String query) {
    setState(() {
      String stringOfPlayer;
      searchedPlayers = [[]];
      if (query.isEmpty) {
        searchedPlayers = players;
        listTileLength = searchedPlayers[0].length;
      } else {
        for (int i = 0; i < players[0].length; i++) {
          stringOfPlayer = players[0][i][0];
          bool contains =
              (stringOfPlayer.toLowerCase()).contains(query.toLowerCase());
          if (contains) {
            searchedPlayers[0].add(players[0][i]);
          }
        }
        listTileLength = searchedPlayers[0].length;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //place listview here with widget helper
    return Scaffold(
        appBar: AppBar(title: const Text('Draft Pick')),
        body: FutureBuilder(
            builder: (context, favPlaySnap) {
              if (!favPlaySnap.hasData) {
                //if not have data then create loading animation
                return const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      )
                    ],
                  ),
                );
              } else {
                if (players.isEmpty) {
                  players = favPlaySnap.data!;
                  searchedPlayers = favPlaySnap.data!;
                  listTileLength =
                      searchedPlayers[0].length; //replace this variable later
                }

                //print("players: $players");
                return Column(children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      onChanged: (text) {
                        searchPlayers(text);
                        //print(searchedPlayers);
                      },
                      controller: searchController,
                      decoration: const InputDecoration(
                          labelText: "Search",
                          hintText: "Search",
                          prefixIcon: Icon(Icons.search),
                          border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)))),
                    ),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemCount: listTileLength,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                              onLongPress: () {
                                setState(() {
                                  showDialog<String>(
                                    context: context,
                                    builder: (BuildContext context) =>
                                        AlertDialog(
                                      title: const Text('Pick Player?'),
                                      content: Text(
                                          '${searchedPlayers[0][index][0]}'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            //add player to database
                                            //return playerId so it updates correctly into the database for Rounds
                                            await updatePlayerRound(
                                                searchedPlayers[0][index][
                                                    1]); //the playerId is returned here
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DraftSessionPage(
                                                            leagueId:
                                                                widget.leagueId,
                                                            userLoggedIn: widget
                                                                .userLoggedIn)));
                                          },
                                          child: const Text('OK'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                              title: Text('${searchedPlayers[0][index][0]}'));
                        },
                        separatorBuilder: (context, index) {
                          return const Divider();
                        }),
                  )
                ]);
              }
            },
            future: Future.wait([getPlayers()])));
  }
}
