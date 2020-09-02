import 'package:drone_scorer/widgets/countdown_timer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drone_scorer/widgets/score_button.dart';
import 'package:drone_scorer/game.dart';
import 'package:drone_scorer/sheet_manager.dart';

class GameScoringScreen extends StatefulWidget {
  Game myGame;

  SheetManager sheetManager;

  GameScoringScreen(this.sheetManager, this.myGame);

  @override
  _GameScoringScreenState createState() => _GameScoringScreenState();
}

class _GameScoringScreenState extends State<GameScoringScreen> {
  CountdownTimer timer = CountdownTimer();
  List<ScoreButton> scoreButtons = [
    ScoreButton('Fly north through hoop 1', 100),
    ScoreButton('Land on tile 1', 200),
    ScoreButton('Fly north through hoop 2', 100),
    ScoreButton('Land on tile 2', 200),
    ScoreButton('Fly north through hoop 3', 100),
    ScoreButton('Land on tile 3', 200),
    ScoreButton('Land on start', 200),
  ];

  @override
  void initState() {
    super.initState();
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
                Text('Match #' + widget.myGame.matchNumber.toString()),
                Text('Team #' + widget.myGame.teamNumber.toString()),
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
              'Total Score: ' + widget.myGame.getTotalScoredPoints().toString(),
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
                      print('my game: ${widget.myGame.getTotalScoredPoints()}');
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
                      widget.sheetManager.addGame(widget.myGame);
                      int count = 0;
//                      Navigator.of(context).popUntil((_) => count++ >= 1);
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
    widget.myGame.scoredElements =
        this.scoreButtons.map((button) => button.isPressed).toList();
    widget.myGame.secondsRemaining = this.timer.timeRemaining;
  }
}
