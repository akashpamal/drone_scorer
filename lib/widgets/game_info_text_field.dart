import 'package:drone_scorer/Game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameInfoTextField extends StatelessWidget {
  Color borderColor = Colors.purple;
  TextInputType keyboardType;

  TextEditingController textFieldController = new TextEditingController();
  String hintText;

  GameInfoTextField(this.hintText, this.keyboardType);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: this.textFieldController,
      textAlign: TextAlign.left,
      style: TextStyle(color: Colors.white),
      keyboardType: this.keyboardType,
      decoration: InputDecoration(
        labelText: '${this.hintText}',
//            labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold),
        border: OutlineInputBorder(),
//        disabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.green, width: 20)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blue, width: 2)),
        hintText: 'Enter ' + this.hintText,
        hintStyle: TextStyle(color: Colors.grey),
      ),
      // ignore: missing_return
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter ${this.hintText}';
        }
      },
    );
  }
}
