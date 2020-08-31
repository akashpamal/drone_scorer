//import 'package:flutter/material.dart';
//import 'package:drone_scorer/widgets/score_button.dart';
//
//class GameScoringScreenOld extends StatefulWidget {
//  List<String> gameInfoValues;
//
//  GameScoringScreenOld(this.gameInfoValues) {
//    print('game info values: ${this.gameInfoValues}');
//  }
//
//  @override
//  _GameScoringScreenOldState createState() => _GameScoringScreenOldState();
//}
//
//class _GameScoringScreenOldState extends State<GameScoringScreenOld> {
//  int totalScore = 0;
//  bool pressAttention = false;
//
//
//  List<ScoreButton> scoreButtons = [];
//
//  @override
//  void initState() {
//    super.initState();
//    this.scoreButtons.add(ScoreButton(100, '100 points'));
//    this.scoreButtons.add(ScoreButton(200, '200 points'));
//    this.scoreButtons.add(ScoreButton(50, '50 points'));
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        backgroundColor: Colors.amber,
//        title: Text('Scoring Page'),
//      ),
//      backgroundColor: Colors.amberAccent,
//      body: Column(
//        crossAxisAlignment: CrossAxisAlignment.center,
//        mainAxisAlignment: MainAxisAlignment.center,
//        children: [
//          ListView.builder(
//            shrinkWrap: true,
//            itemCount: this.scoreButtons.length,
//            itemBuilder: (context, index) {
//              return this.scoreButtons[index];
//            },
//          ),
//          Text('Total Score: ${this.totalScore}'),
//        ],
//      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          this.setState(() {
//            this.totalScore = 0;
//            for (ScoreButton b in this.scoreButtons) {
//              this.totalScore += b.scoredPoints;
//            }
//          });
//        },
//        child: Icon(Icons.refresh),
//      ),
//    );
//  }
//}
