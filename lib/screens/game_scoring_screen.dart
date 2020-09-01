import 'package:drone_scorer/widgets/countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drone_scorer/widgets/score_button.dart';
import 'package:drone_scorer/game.dart';
import 'package:drone_scorer/sheet_manager.dart';

class GameScoringScreen extends StatefulWidget {

  String matchNumber;
  String teamNumber;
  String refereeID;

  SheetManager sheetManager;

  GameScoringScreen(this.sheetManager, this.matchNumber, this.teamNumber, this.refereeID);

  @override
  _GameScoringScreenState createState() => _GameScoringScreenState();
}

class _GameScoringScreenState extends State<GameScoringScreen> {
  CountdownTimer timer = CountdownTimer();
  List<ScoreButton> scoreButtons = [
    ScoreButton('Hoop 1', 100),
    ScoreButton('Tile 1', 200),
    ScoreButton('Hoop 2', 100),
    ScoreButton('Tile 2', 200),
    ScoreButton('Hoop 3', 100),
    ScoreButton('Tile 3', 200),
    ScoreButton('Land on start', 200),
  ];

  Game myGame;

  @override
  void initState() {
    super.initState();
    this.myGame = Game(widget.matchNumber, widget.teamNumber, widget.refereeID);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: this.timer,
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
            child: Column(
              children: [
                Text('Match #' + this.myGame.matchNumber.toString()),
                Text('Team #' + this.myGame.teamNumber.toString()),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: this.scoreButtons.length,
              itemBuilder: (context, index) {
                return this.scoreButtons[index];
              }),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total Score: ' + this.myGame.getTotalScoredPoints().toString(),
              style: TextStyle(fontSize: 18),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  flex: 1,
                  child: CupertinoButton(
                    onPressed: () {
                      this.timer.stopGame();
                      this.setState(() {
                        this.updateScore();
                      });
                      print('my game: ${this.myGame.getTotalScoredPoints()}');
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      'End Game',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Flexible(
                  flex: 1,
                  child: CupertinoButton(
                    onPressed: () {
                      this.timer.stopGame();
                      this.updateScore();
                      widget.sheetManager.addGame(this.myGame);
                      int count = 0;
                      Navigator.of(context).popUntil((_) => count++ >= 1);
                    },
                    color: Colors.blue,
                    padding: EdgeInsets.all(20),
                    child: Text('Save & Return Home'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void updateScore() {
    print('update score method from game scoring screen');
    this.myGame.scoredElements =
        this.scoreButtons.map((button) => button.isPressed).toList();
    this.myGame.secondsRemaining = this.timer.timeRemaining;
  }
}
