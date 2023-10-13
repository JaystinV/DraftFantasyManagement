import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftSession.dart';
import 'package:flutter_module_1/draftSettingsPage.dart';

class DraftSearchPage extends StatefulWidget {
  @override
  State<DraftSearchPage> createState() => _DraftSearchPageState();
}

class _DraftSearchPageState extends State<DraftSearchPage> {
  int selectedIndex = 0;
  List<Widget> bottomNavigation = [
    DraftSearchPage(),
    DraftSessionPage(),
    DraftSettingsPage()
  ];
  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 1) {
        //Take out back button later
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DraftSessionPage();
        }));
      } else if (selectedIndex == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DraftSearchPage();
        }));
      } else if (selectedIndex == 2) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return DraftSettingsPage();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Draft Search'), actions: [
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
              icon: Icon(Icons.edit),
              label: 'Draft',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            )
          ],
          currentIndex: selectedIndex,
          selectedItemColor: Colors.blueGrey,
          onTap: onIconTapped,
        ));
  }
}
