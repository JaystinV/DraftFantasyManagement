//This has the drafts the user is in, as well as a draft join or draft create
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/draftStart.dart';
import 'package:flutter_module_1/draftSummary.dart';
import 'package:flutter_module_1/profilePage.dart';
import 'package:flutter_module_1/searchPlayersPage.dart';
import 'package:flutter_module_1/teamStatisticsPage.dart';
//import 'package:go_router/go_router.dart';
import 'draftJoin.dart';
import 'draftSetUp.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 1;
  PostgresConnection connectLeague = PostgresConnection();
  PostgresConnection connectLeagueCount = PostgresConnection();
  List<Widget> bottomNavigation = [HomePage(), SearchPlayersPage()];
  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        //Take out back button later
        //context.go('home');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else if (selectedIndex == 1) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPlayersPage();
        }));
      }
    });
  }

  Future<List<List<dynamic>>> getLeaguesCurrentlyIn() async {
    List<List<dynamic>> leagues = await connectLeague.getLeagues();
    return leagues;
  }
  // Future<List<List<dynamic>>> leagues = Future<List<List<dynamic>>>.delayed(
  //   const Duration(seconds: 2), () => getLeaguesCurrentlyIn();
  // ) ;

  Future<int> getNumberOfLeagues() async {
    List<List<dynamic>> leagues = await connectLeagueCount.getLeagues();
    return leagues.length;
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
                                      builder: (context) => DraftSetUp())),
                              child: const Text('Create League')),
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftJoin())),
                              child: const Text('Join League')),
                        ]),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 575,
                      child: ListView.builder(
                          itemCount: 3,
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
                                                        const DraftStartPage()));
                                          },
                                          child: Text(
                                              "${leaguesSnap.data?[0][index][0]}"))),
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
                                      builder: (context) => DraftSetUp())),
                              child: const Text('Create League')),
                          ElevatedButton(
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DraftJoin())),
                              child: const Text('Join League')),
                        ]),
                  ],
                ),
              );
            }
          },
          future: Future.wait([
            //getNumberOfLeagues(),
            getLeaguesCurrentlyIn()
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
