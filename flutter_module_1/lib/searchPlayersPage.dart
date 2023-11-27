//This has the drafts the user is in, as well as a draft join or draft create
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/homePage.dart';

class SearchPlayersPage extends StatefulWidget {
  final String userLoggedIn;
  const SearchPlayersPage({super.key, required this.userLoggedIn});
  @override
  State<SearchPlayersPage> createState() => _SearchPlayersPageState();
}

class _SearchPlayersPageState extends State<SearchPlayersPage> {
  int selectedIndex = 0;
  List<Widget> bottomNavigation = [
    const HomePage(userLoggedIn: "", newLeagueName: "", newRounds: 0),
    const SearchPlayersPage(userLoggedIn: "")
  ];
  TextEditingController searchController = TextEditingController();
  PostgresConnection connectFavPlayer = PostgresConnection();
  List<dynamic> players = []; //[0][index for name][0]
  List<dynamic> searchedPlayers = [];
  int listTileLength = 0;

  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        //NavigationBar
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(userLoggedIn: widget.userLoggedIn, newLeagueName: "", newRounds: 0);
        }));
      } else if (selectedIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPlayersPage(userLoggedIn: widget.userLoggedIn);
        }));
      }
    });
  }

  Future<List<dynamic>> getPlayers() async {
    List<dynamic> favPlayers = await connectFavPlayer.getPlayersList(
        widget.userLoggedIn); // change later from static usernam
    return favPlayers;
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
          print(stringOfPlayer);
          print(query.toLowerCase());

          bool contains =
              (stringOfPlayer.toLowerCase()).contains(query.toLowerCase());
          print(contains);
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
        appBar: AppBar(title: const Text('Draft Fantasy Management')),
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
                        print(searchedPlayers);
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
                                      title: const Text(''),
                                      content: Text(
                                          '${searchedPlayers[0][index][0]}'),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'Cancel'),
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context, 'OK'),
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
            future: Future.wait([getPlayers()])),
        bottomNavigationBar: BottomNavigationBar(
          //Displays a navigation bar at the bottom of the screen
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blueGrey,
          onTap: onIconTapped,
        ));
  }
}
