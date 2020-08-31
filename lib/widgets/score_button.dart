import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:custom_switch/custom_switch.dart';

class ScoreButton extends StatefulWidget {

  final int possiblePoints;
  final String bodyString;
  bool isPressed = false;


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
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.bodyString),
      trailing: CupertinoSwitch(
        activeColor: Colors.green,
        value: widget.isPressed,
        onChanged: (value) {
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
