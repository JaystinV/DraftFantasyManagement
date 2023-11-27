import 'package:flutter/material.dart';

class Leagues extends ChangeNotifier{
  int id;
  String leagueName;

  //Constructor
  Leagues(this.id, this.leagueName);
}

class LeagueModel extends ChangeNotifier {
  List<Leagues> currLeagues = [];
}
