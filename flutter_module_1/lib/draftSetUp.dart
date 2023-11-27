import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/dbConnect.dart';
import 'package:flutter_module_1/homePage.dart';

class DraftSetUp extends StatefulWidget {
  final String userLoggedIn;
  const DraftSetUp({super.key, required this.userLoggedIn});

  @override
  State<DraftSetUp> createState() => _DraftSetUpState();
}

class _DraftSetUpState extends State<DraftSetUp> {
  PostgresConnection connection = PostgresConnection();
  PostgresConnection connectionAddOwner = PostgresConnection();
  PostgresConnection connectionAddLeague = PostgresConnection();
  TextEditingController leagueNameController = TextEditingController();
  TextEditingController roundController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  String leagueNameEntered = "";
  String roundEntered = "";

  //fetch the email of the league owner

  Future<void> setLeague(String leagueName, int round) async {
    await connectionAddLeague.setLeague(leagueName, round);
  }
  // Future<void> setOwner() async {
  //   await connectionAddOwner.setOwner(userEmail, )
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("League Create"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Row(children: <Widget>[Text('League Name')]),
            TextFormField(
                controller: leagueNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Leauge Name',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter your League Name.";
                  }
                  return null;
                }),
            const Row(children: <Widget>[Text('Session Key')]),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Ki3j7y',
              ),
            ),
            const Row(children: <Widget>[Text('Rounds')]),
            TextFormField(
                controller: roundController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Total Rounds',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Please enter number of Rounds.";
                  }
                  return null;
                }),
            const Text('Timer'),
            const TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Total Time',
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  leagueNameEntered = leagueNameController.text;
                  roundEntered = roundController.text;
                  connectionAddLeague.setLeague(
                      leagueNameEntered, int.parse(roundEntered));
                  if (leagueNameEntered != "" && roundEntered != "") {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage(
                                userLoggedIn: widget.userLoggedIn,
                                newLeagueName: leagueNameEntered,
                                newRounds: int.parse(roundEntered))));
                  } else {
                    const failSnackBar = SnackBar(
                        content: Text("Enter a League Name and Rounds"));
                    ScaffoldMessenger.of(context).showSnackBar(failSnackBar);
                  }
                },
                child: const Text('Create')),
          ],
        ),
      ),
    );
  }
}
