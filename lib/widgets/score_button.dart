import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';
import 'package:drone_scorer/game.dart';

class ScoreButton extends StatefulWidget {
  final int possiblePoints;
  final String bodyString;
  bool isPressed = false;
  static Function rebuildScoreScreenWidget;

  ScoreButton(this.bodyString, this.possiblePoints);

  int get scoredPoints {
    if (this.isPressed) {
      return this.possiblePoints;
    } else {
      return 0;
    }
  }

  @override
  _ScoreButtonState createState() => _ScoreButtonState();
}

class _ScoreButtonState extends State<ScoreButton> {
  Function rebuildScoreScreenWidget;
  @override
  void initState() {
    this.rebuildScoreScreenWidget = ScoreButton.rebuildScoreScreenWidget;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.bodyString,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      trailing: CupertinoSwitch(
        value: widget.isPressed,
        onChanged: (value) {
          this.rebuildScoreScreenWidget((){
          });
//          print("VALUE for ${widget.bodyString}: $value");
//          ScoreButton.updateScore();
//          print('updating score');
          setState(() {
            widget.isPressed = value;
          });
        },
      ),
    );
  }
}
