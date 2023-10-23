import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraftSummaryPage extends StatefulWidget {
  @override
  State<DraftSummaryPage> createState() => _DraftSummaryPageState();
}

class _DraftSummaryPageState extends State<DraftSummaryPage> {
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
        children: _buildCells(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Draft Summary"),
        ),
        body: Column(children: <Widget>[
          const Row(children: [Text('League Name')]),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _buildCells(20),
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _buildRows(20),
                    ),
                  ),
                )
              ],
            ),
          ))
        ]));
  }
}
