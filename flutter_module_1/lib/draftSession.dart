import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftSearchPage.dart';
import 'package:flutter_module_1/draftSettingsPage.dart';
import 'package:flutter_module_1/draftTrade.dart';

class DraftSessionPage extends StatefulWidget {
  @override
  State<DraftSessionPage> createState() => _DraftSessionPageState();
}

class _DraftSessionPageState extends State<DraftSessionPage> {
  int selectedIndex = 1;
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
        appBar: AppBar(
          title: const Text("Draft Session"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Row(children: <Widget>[
                Text('Round'),
                Text('Timer'),
              ]),
              Row(children: <Widget>[
                Column(children: <Widget>[
                  SizedBox(
                      height: 200,
                      width: 115,
                      child: ListView.builder(
                          itemCount: 18,
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(title: Text('Team Manager $index'));
                          }))
                ]),
                // Column(
                //   children: <Widget>[
                //     SizedBox(
                //         height: 40,
                //         width: 40,
                //         child: ListView.builder(
                //             scrollDirection: Axis.horizontal,
                //             itemCount: 18,
                //             itemBuilder: (BuildContext context, int index) {
                //               return ListTile(title: Text('Player $index'));
                //             }))
                //   ],
                // )
              ]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.pause), onPressed: () {}),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DraftTradePage())),
                        child: const Text('Trade'))
                  ])
            ],
          ),
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
