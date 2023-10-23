//This has the drafts the user is in, as well as a draft join or draft create
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';

class SearchPlayersPage extends StatefulWidget {
  @override
  State<SearchPlayersPage> createState() => _SearchPlayersPageState();
}

class _SearchPlayersPageState extends State<SearchPlayersPage> {
  int selectedIndex = 0;
  List<Widget> bottomNavigation = [HomePage(), SearchPlayersPage()];
  TextEditingController editingController = TextEditingController();
  void onIconTapped(int index) {
    setState(() {
      selectedIndex = index;
      if (selectedIndex == 0) {
        //NavigationBar
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

  @override
  Widget build(BuildContext context) {
    //place listview here with widget helper
    return Scaffold(
        appBar: AppBar(title: const Text('Draft Fantasy Management')),
        body: Column(children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {},
              controller: editingController,
              decoration: const InputDecoration(
                  labelText: "Search",
                  hintText: "Search",
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25.0)))),
            ),
          ),
          Expanded(
            child: ListView.separated(
                itemCount: 8,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onLongPress: () {
                        setState(() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text(''),
                              content: Text('Favorited Player $index'),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        });
                      },
                      title: Text('Favorite Player $index'));
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                }),
          )
        ]),
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
