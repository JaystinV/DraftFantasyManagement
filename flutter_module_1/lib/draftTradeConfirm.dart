import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class DraftTradeConfirmPage extends StatefulWidget {
  @override
  State<DraftTradeConfirmPage> createState() => _DraftTradeConfirmPageState();
}

class _DraftTradeConfirmPageState extends State<DraftTradeConfirmPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Draft Trade Confirmation"),
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              const Row(children: <Widget>[Text('Trades Available')]),
              Expanded(
                  child: ListView.separated(
                itemCount: 2,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                      onTap: () {
                        setState(() {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: const Text('Confirm Trade?'),
                              content: Text('Trade $index'),
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
                      title: Text('Trade $index'));
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
              ))
            ]));
  }
}
