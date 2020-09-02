import 'package:drone_scorer/Game.dart';
import 'package:flutter/material.dart';

class GameInfoTextField extends StatelessWidget {
  Color borderColor = Colors.purple;

  TextEditingController textFieldController = new TextEditingController();
  String hintText;

  GameInfoTextField(this.hintText);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.textFieldController,
      textAlign: TextAlign.left,
      decoration: InputDecoration(
        labelText: '${this.hintText}',
//            labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.deepPurple, width: 20)),
        disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green, width: 20)),
        hintText: 'Enter ' + this.hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter ${this.hintText}';
        }
      },
    );
  }
}
