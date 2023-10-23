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
  TextEditingController editingController = TextEditingController();
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
        appBar: AppBar(title: const Text('Draft Search')),
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
                      onTap: () {
                        setState(() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Pick Player?'),
                              content: Text('Player $index'),
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
                      title: Text('Favorite Player $index'),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  })),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
                onPressed: () {}, child: const Text('Tap To Pick Player')),
            ElevatedButton(
                onPressed: () {}, child: const Text('Hold to Favorite'))
          ])
        ]));
  }
}
