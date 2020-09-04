import 'dart:ffi';

import 'package:drone_scorer/screens/game_ready_screen.dart';
import 'package:drone_scorer/screens/game_scoring_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sheet_manager.dart';
import 'game.dart';
import 'screens/game_info_screen.dart';
import 'screens/game_info_screen.dart';

void main() {
  SheetManager sheetManager = SheetManager();

  runApp(
    MaterialApp(
//      home: GameScoringScreen(sheetManager, Game('123', '456', '789')),
      home: GameInfoScreen(sheetManager),
//      theme: ThemeData(),
//      darkTheme: ThemeData.dark(),
      theme: theme1(),
    ),
  );
}

ThemeData theme1() {
  return ThemeData(
    appBarTheme: AppBarTheme(color: Colors.black),
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blue,
    hintColor: Colors.blue,
//    textTheme: TextTheme(
//      bodyText1: TextStyle(color: Colors.white),
//      bodyText2: TextStyle(color: Colors.white),
//    ),
  );
}
