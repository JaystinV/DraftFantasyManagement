import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_module_1/draftSearchPage.dart";
import "package:flutter_module_1/draftTrade.dart";
import "package:flutter_module_1/draftUpdate.dart";
import "package:flutter_timer_countdown/flutter_timer_countdown.dart";

class DraftSessionPage extends StatefulWidget {
  @override
  State<DraftSessionPage> createState() => _DraftSessionPageState();
}

class _DraftSessionPageState extends State<DraftSessionPage> {
  int rounds = 6;
  int currRound = 1; //keeps track of current round
  int currManager = 1; //keeps track of current manager's turn
  int order = 1;
  //Static team manager list
  List<String> teamManagerList = [
    "Kelvin",
    "Kevin",
    "Billy",
    "Jacob",
    "Jacob M",
    "Kou",
    "Kashia",
    "Xai",
    "Tommy",
    "Ethan",
    "John",
    "Ben",
    "Tim",
    "Anthony",
    "Adam",
    "Justin",
    "Tony",
    "Alex"
  ];

  bool checkTurn(int currManager) {
    bool result = false;
    if (currManager == order) {
      //if current manager is equal to the order number
      return result = true;
    } else {
      return result;
    }
  }

  bool checkPickOrTrade(int round) {
    //not round
    bool result = false;
    if (currRound == 0) {
      return result = true;
    } else {
      return result;
    }
  }

  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 50.0,
        color: Colors.white,
        margin: const EdgeInsets.all(4.0),
        child: ListTile(
            onLongPress: () {
              bool turn = checkTurn(currManager);
              bool checkPick = checkPickOrTrade(currRound);
              //checks whether it is their turn
              if (turn) {
                //check if it is your turn then go ahead
                if (checkPick) {
                  //check if the manager is picking or trading
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DraftSearchPage()));
                } else {
                  //trades instead
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DraftTradePage()));
                }
              } else {
                setState(() {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(""),
                      content: const Text("It is not your turn."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, "Cancel"),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, "OK"),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                });
              }
            },
            title: const Text("")),
      ),
    );
  }

  List<Widget> _buildOrder(int count) {
    return List.generate(
      count,
      (index) => Container(
          alignment: Alignment.center,
          width: 100.0,
          height: 50.0,
          color: Colors.white,
          margin: const EdgeInsets.all(4.0),
          child: ListTile(
              title: Text(
                  teamManagerList[index])) //populate with team manager names
          ),
    );
  }

  //create columns of players and team managers
  List<Widget> _buildColumns(int managers, int rounds) {
    return List.generate(
      rounds,
      (index) => Column(
        //get number of rounds and multiply by 2
        children: _buildCells(managers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Draft Session"),
          actions: [
            IconButton(
                onPressed: () {
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text("How To Select an Option"),
                      content: const Text(
                          "Trade by holding a team manager column, or pick by holding a player column"),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, "Cancel"),
                          child: const Text("Cancel"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, "OK"),
                          child: const Text("OK"),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.info))
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("Turn - ${teamManagerList[0]}"),
                        const Text("Timer -"),
                        TimerCountdown(
                            format: CountDownTimerFormat.minutesSeconds,
                            endTime: DateTime.now()
                                .add(const Duration(minutes: 1, seconds: 30)),
                            enableDescriptions: false)
                      ]),
                  const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("Team Manager"),
                      ]),
                ],
              ),

              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildOrder(
                          teamManagerList.length), //number of team managers
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildColumns(teamManagerList.length,
                              rounds), //number of team managers, round
                        ),
                      ),
                    )
                  ],
                ),
              )),
              //]),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    IconButton(icon: const Icon(Icons.pause), onPressed: () {}),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DraftUpdate())),
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                        ),
                        child: const Icon(Icons.edit)),
                  ]),
            ],
          ),
        ));
  }
}
