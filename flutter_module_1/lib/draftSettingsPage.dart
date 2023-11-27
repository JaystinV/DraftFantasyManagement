// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_module_1/draftSearchPage.dart';
// import 'package:flutter_module_1/draftSession.dart';
// import 'package:flutter_module_1/homePage.dart';

// class DraftSettingsPage extends StatefulWidget {
//   @override
//   State<DraftSettingsPage> createState() => _DraftSettingsPageState();
// }

// class _DraftSettingsPageState extends State<DraftSettingsPage> {
//   int selectedIndex = 2;
//   List<Widget> bottomNavigation = [
//     DraftSearchPage(),
//     //DraftSessionPage(),
//     DraftSettingsPage()
//   ];
//   // void onIconTapped(int index) {
//   //   setState(() {
//   //     selectedIndex = index;
//   //     if (selectedIndex == 1) {
//   //       //Take out back button later
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //         //return DraftSessionPage();
//   //       }));
//   //     } else if (selectedIndex == 0) {
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //         return DraftSearchPage();
//   //       }));
//   //     } else if (selectedIndex == 2) {
//   //       Navigator.push(context, MaterialPageRoute(builder: (context) {
//   //         //return DraftSettingsPage();
//   //       }));
//   //     }
//   //   });
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("Draft Settings"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(context,
//                         MaterialPageRoute(builder: (context) => HomePage()));
//                     SystemChrome.setPreferredOrientations(
//                         [DeviceOrientation.portraitUp]);
//                   },
//                   child: const Text('End Draft')),
//             ],
//           ),
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           //Displays a navigation bar at the bottom of the screen
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.search),
//               label: 'Search',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.edit),
//               label: 'Draft',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               label: 'Settings',
//             )
//           ],
//           currentIndex: selectedIndex,
//           selectedItemColor: Colors.blueGrey,
//           //onTap:// onIconTapped,
//         ));
//   }
// }
