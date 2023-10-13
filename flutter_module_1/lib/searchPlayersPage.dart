//This has the drafts the user is in, as well as a draft join or draft create
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';
import 'teamStatisticsPage.dart';

class SearchPlayersPage extends StatefulWidget {
  @override
  State<SearchPlayersPage> createState() => _SearchPlayersPageState();
}

class _SearchPlayersPageState extends State<SearchPlayersPage> {
  int selectedIndex = 0;
  List<Widget> bottomNavigation = [
    SearchPlayersPage(),
    HomePage(),
    TeamStatisticPage()
  ];
  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 1) {
        //NavigationBar
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomePage();
        }));
      } else if (selectedIndex == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SearchPlayersPage();
        }));
      } else if (selectedIndex == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return TeamStatisticPage();
        }));
      }
    });
  }

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
        ),
        bottomNavigationBar: BottomNavigationBar(
          //Displays a navigation bar at the bottom of the screen
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'SearchPlayers',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Teams',
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blueGrey,
          onTap: onIconTapped,
        ));
  }
}
