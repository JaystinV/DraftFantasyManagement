import "package:circular_countdown_timer/circular_countdown_timer.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_module_1/dbConnect.dart";
import "package:flutter_module_1/draftSearchPage.dart";
import "package:flutter_module_1/draftTrade.dart";
import "package:flutter_module_1/draftUpdate.dart";

class DraftSessionPage extends StatefulWidget {
  final int leagueId;
  final String userLoggedIn;
  const DraftSessionPage(
      {super.key, required this.leagueId, required this.userLoggedIn});

  @override
  State<DraftSessionPage> createState() => _DraftSessionPageState();
}

class _DraftSessionPageState extends State<DraftSessionPage> {
  List<dynamic> rounds = []; //number of rounds, needs from database
  int currManager = 0; //keeps track of current manager's turn
  int order = 1;
  int boxNumber = 1;
  bool paused = false;
  bool turn = false;
  bool checkSetRound = false;
  final CountDownController _controller = CountDownController();
  PostgresConnection connectTeamManagersInLeague = PostgresConnection();
  PostgresConnection connectSetRound = PostgresConnection();
  PostgresConnection connectCheckSetRound = PostgresConnection();
  PostgresConnection connectUpdateRound = PostgresConnection();
  PostgresConnection connectPlayer = PostgresConnection();
  PostgresConnection connectPlayerName = PostgresConnection();
  PostgresConnection connectNumberRounds = PostgresConnection();
  PostgresConnection connect = PostgresConnection();
  List<dynamic> teamManagers = [];
  List<dynamic> playerId = [
    [""]
  ];
  List<dynamic> roundInfo = [];
  List<dynamic> playerNames = [];

  Future<List<dynamic>> getRoundInformation() async {
    List<dynamic> allRoundInfo =
        await connect.getAllRoundInformation(widget.leagueId);
    return allRoundInfo;
  }

  //get all team managers in current league
  Future<List<dynamic>> getTeamManagersInLeague() async {
    List<dynamic> teamManagers =
        await connectTeamManagersInLeague.getTeamManagers(widget.leagueId);
    //print(teamManagers);
    return teamManagers;
  }

  // //get player from id for round
  // Future<List<dynamic>> getPlayer(int playerId) async {
  //   List<dynamic> player = await connectPlayer.getPlayerName(playerId);
  //   return player;
  // }

  //set the round data
  Future<void> setTotalRoundData(
      int leagueId, int roundId, int roundOrder, String username) async {
    connectSetRound.setRoundData(leagueId, roundId, roundOrder, username);
  }

  Future<bool> checkForSetRoundData(int roundId) async {
    Future<bool> check =
        connectCheckSetRound.checkRoundData(widget.leagueId, roundId);
    return check;
  }

  Future<List<dynamic>> getPlayerIdFromRound(int roundId) async {
    List<dynamic> results =
        await connectPlayerName.getPlayerNameRound(roundId, widget.leagueId);
    return results;
  }

  Future<List<dynamic>> getNumberOfRounds() async {
    Future<List<dynamic>> rounds =
        connectNumberRounds.getRound(widget.leagueId);
    return rounds;
  }

  Future<void> populatePlayerId(int currIndex) async {
    await getPlayerIdFromRound(currIndex).then((result) {
      if (result.isNotEmpty) {
        playerId = result;
        print(result);
        print(playerId);
      }
    });
  }
  //team manager that is "logined" in will be Billy
  //Static team manager list
  //18 team managers and 6 rounds

  //checks for if it is their turn
  // bool checkNotTurn(int index) {
  //   if (teamManagerList[index] == teamManagerList[order]) {
  //     //if current manager is equal to the order number
  //     return false;
  //   } else {
  //     return true;
  //   }
  // }

  //creates trade columns with trade navigation screen
  List<Widget> _buildTradeCells(int length, int currIndex, int currRound) {
    return List.generate(
        length,
        (index) => Container(
            alignment: Alignment.center,
            width: 100.0,
            height: 50.0,
            color: Colors.white,
            margin: const EdgeInsets.all(4.0),
            child: ListTile(
                onLongPress: () {
                  //add to round
                  // if (checkNotTurn(index) || ((currIndex + 1) != currRound)) {
                  //   //currIndex + 1 because it will be 0 but it is round 1
                  //   print("$currIndex : $currRound");
                  //   checkTeamManagerTurn();
                  // } else {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DraftTradePage(
                              leagueId: widget.leagueId,
                              userLoggedIn: widget.userLoggedIn)));
                  //}
                },
                title:
                    Text(teamManagers[0][index][0]) // get from Rounds database
                )));
  }

  //widget for getting playerId from round
  Widget getPlayerNamesFromRoundWidget(int index) {
    //if the player id is not in rounds database then return with empty title
    if (index > playerId.length - 1) {
      return const Text("");
    } else {
      //if playerid is in rounds then return the playername
      return Text(
          "${playerId[index][0]}"); //get playerId from database, initial is empty, from Rounds database
    }
  }

  //creates player pick columns with player pick navigation screen
  List<Widget> _buildPlayerCells(int length, int currIndex, int currRound) {
    //bool from rounds table to see if data, if not then set data
    //print(playerId); //returns only one value because there are no other values of playerIds in rounds because it is null
    return List.generate(length, (index) {
      return Container(
          alignment: Alignment.center,
          width: 100.0,
          height: 50.0,
          color: Colors.white,
          margin: const EdgeInsets.all(4.0),
          child: ListTile(
              onLongPress: () {
                // if (checkNotTurn(index) || (currIndex != currRound)) {
                //   checkTeamManagerTurn();
                // } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DraftSearchPage(
                            leagueId: widget.leagueId,
                            userLoggedIn: widget.userLoggedIn,
                            roundId: currRound,
                            username: teamManagers[0][index][0],
                            indexOfPlayerPicked: index + 1)));
                //}
              },
              title: getPlayerNamesFromRoundWidget(index)));
    });
  }

  //creates two different columns, one for picking and one for trading
  List<Widget> createCells(int managers, int currIndex) {
    //check which column is being called
    //currIndex splits columns between trade and player tiles
    //currIndex runs through all 12 columns, need to split 12 into 6
    if ((currIndex % 2) == 0) {
      //print((currIndex ~/ 2.floor()) + 1);
      return _buildTradeCells(
          managers, currIndex, ((currIndex ~/ 2.floor()) + 1));
    } else {
      //populatePlayerId((currIndex ~/ 2.floor()) + 1);
      return _buildPlayerCells(
          managers, currIndex, (currIndex ~/ 2.floor()) + 1);
    }
  }

  //returns the alert dialog for when it is not the user's account's turn
  void checkTeamManagerTurn() {
    setState(() {
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          content: const Text("It is not your turn. Or YOU SHALL NOT PASS!!!."),
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

  //create order column on left side
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
                  teamManagers[0][index][0])) //populate with team manager names
          ),
    );
  }

  //create columns of playerId and team managers
  List<Widget> _buildColumns(int managers) {
    //rounds contain the number of rounds the league has, multiply by 2 so there is enough columns for trades and players
    return List.generate(
      rounds[0][0] * 2,
      (index) => Column(
        //get number of rounds and multiply by 2
        children: createCells(managers, index),
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
                  //info about how to trade or pick
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
        body: FutureBuilder(
          builder: (context, teamManagerSnap) {
            if (!teamManagerSnap.hasData) {
              return const Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: CircularProgressIndicator(),
                  )
                ],
              );
            } else {
              if (teamManagers.isEmpty) {
                teamManagers = teamManagerSnap.data!;
                if (checkSetRound) {
                  for (int i = 0; i < rounds[0][0]; i++) {
                    for (int j = 0; j < teamManagers[0].length; i++) {
                      setTotalRoundData(
                          widget.leagueId, i, j, teamManagers[0][j][0]);
                    }
                  }
                  checkSetRound = false;
                }
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              //displays who's turn it is
                              Text(
                                  "Turn: ${teamManagers[0][currManager][0]}"), //will grab from Rounds table later
                              const Text("Timer:"),
                              //The countdown timer
                              CircularCountDownTimer(
                                  duration: 90,
                                  initialDuration: 0,
                                  controller: _controller,
                                  width: 40,
                                  height: 50,
                                  fillColor: Colors.white,
                                  ringColor: Colors.white,
                                  isReverse: true,
                                  onStart: () {},
                                  onComplete: () {})
                            ]),
                        //displays title for column team manager
                        const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text("Team Manager"),
                            ]),
                      ],
                    ),
                    //Create scrollable table, if not in expanded, then the screen will break
                    Expanded(
                        //vertical scroll of order and all columns
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //create team manager order that will remain at start of horizontal scroll
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: _buildOrder(teamManagers[0]
                                .length), //number of team managers
                          ),
                          Flexible(
                            //horizontal scroll of all columns excluding order column
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: _buildColumns(teamManagers[0]
                                    .length), //number of team managers, round * 2 since each round needs two
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
                    //creates icon buttons for timer and editing league
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          IconButton(
                              icon: const Icon(Icons.restart_alt),
                              onPressed: () {
                                _controller.start();
                              }),
                          IconButton(
                              icon: const Icon(Icons.play_arrow),
                              onPressed: () {
                                _controller.resume();
                              }),
                          IconButton(
                              icon: const Icon(Icons.pause),
                              onPressed: () {
                                _controller.pause();
                              }),
                          ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DraftUpdate()));
                              }, // need to switch all
                              style: ElevatedButton.styleFrom(
                                shape: const CircleBorder(),
                              ),
                              child: const Icon(Icons.edit)),
                        ]),
                  ],
                ),
              );
            }
          },
          future: Future.wait([
            getTeamManagersInLeague(),
            getNumberOfRounds().then((result) => rounds = result),
            getRoundInformation().then((result) {
              roundInfo = result;
              print(roundInfo);
            }),
            getPlayerIdFromRound(1).then((result) {
              //////////////////////////////////////////////////////////////////how to do for each round??!!!!
              if (result.isNotEmpty) {
                playerId = result;
                print(result);
                print(playerId);
              }
            }),
            checkForSetRoundData(6).then((result) => checkSetRound =
                result) ////////////////////////////////////////////////////////////////////////////////
          ]),
        ));
  }
}
