import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'sheet_manager.dart';
import 'game.dart';
import 'screens/game_info_screen.dart';
import 'screens/game_info_screen.dart';

void main() {
  SheetManager sheetManager = SheetManager();

  runApp(MaterialApp(home: GameInfoScreen(sheetManager)));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SheetManager sheetManager = SheetManager();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
          child: Text('Game history will be displayed here - in development')),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return GameInfoScreen(this.sheetManager);
            }),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
