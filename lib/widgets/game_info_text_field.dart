import 'package:drone_scorer/Game.dart';
import 'package:flutter/material.dart';

class GameInfoTextField extends StatefulWidget {
  TextEditingController textFieldController = new TextEditingController();
  String hintText;

  GameInfoTextField(this.hintText);

  @override
  _GameInfoTextFieldState createState() => _GameInfoTextFieldState();
}

class _GameInfoTextFieldState extends State<GameInfoTextField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.hintText + ':',
          textAlign: TextAlign.left,
        ),
        TextField(
          controller: widget.textFieldController,
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Enter ' + widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
