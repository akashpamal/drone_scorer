import 'package:flutter/material.dart';

class GameInfoTextDisplay extends StatelessWidget {
  String labelText = '';
  String valueText = '';

  GameInfoTextDisplay(this.labelText, this.valueText);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        '${this.labelText}: ${this.valueText}',
        style: TextStyle(fontSize: 18.0),
      ),
    );
  }
}
