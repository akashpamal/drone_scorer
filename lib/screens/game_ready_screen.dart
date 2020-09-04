import 'package:drone_scorer/sheet_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'game_scoring_screen.dart';
import 'package:drone_scorer/widgets/game_info_text_display.dart';
import 'package:drone_scorer/game.dart';

class GameReadyScreen extends StatelessWidget {
  SheetManager sheetManager;
  Game myGame;

  GameReadyScreen(this.sheetManager, this.myGame);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Game Info'),
      ),
//      CupertinoNavigationBar(
//        middle: Text('Game Ready'),
//        previousPageTitle: 'New Game',
//      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.0),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GameInfoTextDisplay('Referee ID', this.myGame.refereeID),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GameInfoTextDisplay('Team Number', this.myGame.teamNumber),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child:
                  GameInfoTextDisplay('Round Number', this.myGame.matchNumber),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                color: Colors.blue,
//                color: Theme.of(context).buttonColor,
                onPressed: () async {
                  await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return GameScoringScreen(this.sheetManager, this.myGame);
                  }));
                },
                child: Text('Start Game'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
