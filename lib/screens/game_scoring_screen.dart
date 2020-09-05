import 'package:drone_scorer/widgets/game_info_text_field.dart';
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
  List<ScoreButton> scoreButtons;

  TextEditingController timeFieldController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    this.scoreButtons = [
      ScoreButton('Fly north through hoop 1', 100),
      ScoreButton('Land on tile 1', 200),
      ScoreButton('Fly north through hoop 2', 100),
      ScoreButton('Land on tile 2', 200),
      ScoreButton('Fly north through hoop 3', 100),
      ScoreButton('Land on tile 3', 200),
      ScoreButton('Land on start', 200),
    ];
    ScoreButton.rebuildScoreScreenWidget = this.setState;
  }

  @override
  Widget build(BuildContext context) {
    this.updateScore();
    return Scaffold(
      appBar:
//        CupertinoNavigationBar(
//        middle: Text(this.timer.toString()),
//        trailing: Column(
//          children: [
//            Text('Match #' + widget.myGame.matchNumber.toString()),
//            Text('Team #' + widget.myGame.teamNumber.toString()),
//          ],
//        ),
//      ),
          AppBar(
        title: Text('Total score: ${widget.myGame.getTotalScoredPoints()}'),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 4, 8, 0),
            child: Column(
              children: [
                Text('Round #' + widget.myGame.matchNumber.toString()),
                Text('Team #' + widget.myGame.teamNumber.toString()),
              ],
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          ListView.separated(
              physics: NeverScrollableScrollPhysics(),
              separatorBuilder: (context, index) => Divider(
                    color: Colors.grey,
                  ),
              shrinkWrap: true,
              itemCount: this.scoreButtons.length,
              itemBuilder: (context, index) {
                return this.scoreButtons[index];
              }),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: this.timeFieldController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Seconds remaining',
//            labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),
//        disabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.green, width: 20)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                hintText: 'Enter seconds remaining',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Text(
//              'Total Score: ' + widget.myGame.getTotalScoredPoints().toString(),
//              style: TextStyle(fontSize: 18, color: Colors.white),
//            ),
//          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: CupertinoButton(
              onPressed: () {
                this.updateScore();
                widget.sheetManager.addGame(widget.myGame);
                int count = 0;
                Navigator.of(context).popUntil((_) => count++ >= 2);
              },
              color: Colors.blue,
//                    color: Theme.of(context).buttonColor,
              padding: EdgeInsets.all(20),
              child: Text('Save & Return Home'),
            ),
          ),
//          Padding(
//            padding: const EdgeInsets.all(8.0),
//            child: Row(
//              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////              crossAxisAlignment: CrossAxisAlignment.stretch,
//              children: [
////                Flexible(
////                  flex: 1,
////                  child: CupertinoButton(
////                    onPressed: () {
////                      this.setState(() {
////                        this.updateScore();
////                      });
////                      print('my game: ${widget.myGame.getTotalScoredPoints()}');
////                    },
////                    color: Colors.blue,
//////                    color: Theme.of(context).buttonColor,
////                    padding: EdgeInsets.all(20),
////                    child: Text(
////                      'End Game',
////                      style: TextStyle(fontSize: 16),
////                    ),
////                  ),
////                ),
//                Flexible(
//                  flex: 1,
//                  child: CupertinoButton(
//                    onPressed: () {
//                      this.updateScore();
//                      widget.sheetManager.addGame(widget.myGame);
//                      int count = 0;
//                      Navigator.of(context).popUntil((_) => count++ >= 2);
//                    },
//                    color: Colors.blue,
////                    color: Theme.of(context).buttonColor,
//                    padding: EdgeInsets.all(20),
//                    child: Text('Save & Return Home'),
//                  ),
//                ),
//              ],
//            ),
//          ),
        ],
      ),
    );
  }

  void updateScore() {
    widget.myGame.scoredElements =
        this.scoreButtons.map((button) => button.isPressed).toList();
    widget.myGame.secondsRemaining = this.timeFieldController.text;
  }
}
