import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/homePage.dart';
import 'package:flutter_module_1/searchPlayersPage.dart';

class TeamStatisticPage extends StatefulWidget {
  const TeamStatisticPage({super.key});

  @override
  State<TeamStatisticPage> createState() {
    return _TeamStatisticPage();
  }
}

class _TeamStatisticPage extends State<TeamStatisticPage> {
  int selectedIndex = 2;
  List<Widget> bottomNavigation = [
    SearchPlayersPage(),
    HomePage(),
    const TeamStatisticPage()
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
      appBar: AppBar(title: const Text('Draft Fantasy Management')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[Text('Player Statistics For ... League')]),
            SizedBox(
                height: 600,
                child: ListView.separated(
                    itemCount: 6,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(title: Text('Player $index'));
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    }))
          ],
        ),
      ),
    );
  }
}
