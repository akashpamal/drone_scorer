import 'package:flutter/material.dart';
import 'game_info_screen.dart';
import 'package:drone_scorer/sheet_manager.dart';

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
