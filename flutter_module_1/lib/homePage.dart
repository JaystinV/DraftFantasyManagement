//This has the drafts the user is in, as well as a draft join or draft create
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/draftStart.dart';
import 'package:flutter_module_1/draftSummary.dart';
import 'package:flutter_module_1/profilePage.dart';
import 'package:flutter_module_1/searchPlayersPage.dart';
import 'package:flutter_module_1/teamStatisticsPage.dart';
//import 'package:go_router/go_router.dart';
import "userLoggedIn.dart";
import 'draftJoin.dart';
import 'draftSetUp.dart';

class HomePage extends StatefulWidget {
  final String userLoggedIn;
  //if null then ignore
  final String newLeagueName;
  final int newRounds;
  //time as well later
  const HomePage(
      {super.key,
      required this.userLoggedIn,
      required this.newLeagueName,
      required this.newRounds});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  PostgresConnection connectLeague = PostgresConnection();
  PostgresConnection connectLeagueId = PostgresConnection();
  PostgresConnection connectNewLeagueId = PostgresConnection();
  PostgresConnection connectAddLeague = PostgresConnection();
  PostgresConnection connectionEmail = PostgresConnection();
  PostgresConnection connectAddOwner = PostgresConnection();
  String userEmail = "";
  List<dynamic> leagueIds = [];
  List<Widget> bottomNavigation = [
    const HomePage(userLoggedIn: "", newLeagueName: "", newRounds: 0),
    const SearchPlayersPage(userLoggedIn: "")
  ];

  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        //Take out back button later
        //context.go('home');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage(
              userLoggedIn: widget.userLoggedIn,
              newLeagueName: "",
              newRounds: 0);
        }));
      } else if (selectedIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPlayersPage(userLoggedIn: widget.userLoggedIn);
        }));
      }
    });
  }

  Future<List<dynamic>> getLeagueId() async {
    List<dynamic> result = await connectLeagueId.getLeagueId();
    return result;
  }

  Future<List<List<dynamic>>> getLeaguesCurrentlyIn() async {
    List<List<dynamic>> leagues =
        await connectLeague.getLeagues(widget.userLoggedIn);
    return leagues;
  }

  Future<void> addNewLeagueAndOwner() async {
    await connectAddLeague.setLeague(widget.newLeagueName, widget.newRounds);
    List<dynamic> result =
        await connectNewLeagueId.getNewLeagueId(widget.newLeagueName);
    await connectAddOwner.setOwner(
        userEmail, result[0][0], widget.userLoggedIn, 1);
  }

  Future<void> fetchEmail() async {
    await connectionEmail
        .getTeamManagerEmail(widget.userLoggedIn)
        .then((result) {
      //print(result);
      setState(() {
        userEmail = result[0][0]; //for user2 account it gets the correct email
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchEmail();
    if (widget.newLeagueName != "") {
      addNewLeagueAndOwner();
    }
  }

  @override
  Widget build(BuildContext context) {
    //place listview here with widget helper
    return Scaffold(
        appBar: AppBar(title: const Text('Draft Fantasy Management'), actions: [
          IconButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ProfilePage())),
              icon: const Icon(Icons.face_unlock_outlined))
        ]),
        body: FutureBuilder(
          builder: (context, leaguesSnap) {
            if (!leaguesSnap.hasData) {
              //if not have data then create loading animation
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const SizedBox(
                      width: 60,
                      height: 60,
                      child: CircularProgressIndicator(),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftSetUp(
                                          userLoggedIn: widget.userLoggedIn))),
                              child: const Text('Create League')),
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftJoin(
                                          userLoggedIn: widget.userLoggedIn))),
                              child: const Text('Join League')),
                        ]),
                  ],
                ),
              );
            } else {
              //once the data has been returned then display proper leagues of user
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 575,
                      child: ListView.builder(
                          itemCount: leaguesSnap
                              .data![0]?.length, //get value from list builder
                          itemBuilder: (BuildContext context, int index) {
                            return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  SizedBox(
                                      width: 250,
                                      height: 35,
                                      child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DraftStartPage(
                                                            leagueId:
                                                                leagueIds[index][0],
                                                            userLoggedIn: widget
                                                                .userLoggedIn)));
                                          },
                                          child: Text(
                                              "${leaguesSnap.data![0]?[index][0]}"))),
                                  ElevatedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DraftSummaryPage())),
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.list)),
                                  ElevatedButton(
                                      onPressed: () => Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TeamStatisticPage())),
                                      style: ElevatedButton.styleFrom(
                                        shape: const CircleBorder(),
                                      ),
                                      child: const Icon(Icons.insert_chart)),
                                ]);
                          }),
                    ),
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftSetUp(
                                          userLoggedIn: widget.userLoggedIn))),
                              child: const Text('Create League')),
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftJoin(
                                          userLoggedIn: widget.userLoggedIn))),
                              child: const Text('Join League')),
                        ]),
                  ],
                ),
              );
            }
          },
          future: Future.wait([
            getLeaguesCurrentlyIn(),
            getLeagueId().then((result) {
              leagueIds = result;
              //print(leagueIds);
            })
          ]),
        ),
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
