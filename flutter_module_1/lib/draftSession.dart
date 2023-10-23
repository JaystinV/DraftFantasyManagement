import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_module_1/draftSearchPage.dart';
import 'package:flutter_module_1/draftTrade.dart';
import 'package:flutter_module_1/draftUpdate.dart';

class DraftSessionPage extends StatefulWidget {
  @override
  State<DraftSessionPage> createState() => _DraftSessionPageState();
}

class _DraftSessionPageState extends State<DraftSessionPage> {
  List<Widget> _buildCells(int count) {
    return List.generate(
      count,
      (index) => Container(
        alignment: Alignment.center,
        width: 100.0,
        height: 50.0,
        color: Colors.white,
        margin: const EdgeInsets.all(4.0),
        child: Text("${index + 1}"),
      ),
    );
  }

  List<Widget> _buildRows(int count) {
    return List.generate(
      count,
      (index) => Row(
        //get number of rounds and multiply by 2
        children: _buildCells(6 * 2),
      ),
    );
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
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    const Text('Round'),
                    const Text('Timer'),
                    ElevatedButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DraftSearchPage())),
                        child: const Text('Pick Player'))
                  ]),
              Expanded(
                  child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildCells(18), //number of team managers
                    ),
                    Flexible(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildRows(18), //number of team managers
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
                                builder: (context) => DraftTradePage())),
                        child: const Text('Trade')),
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
