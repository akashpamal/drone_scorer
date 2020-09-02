import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drone_scorer/widgets/game_info_text_field.dart';
import 'game_scoring_screen.dart';
import 'package:drone_scorer/sheet_manager.dart';
import 'package:gsheets/gsheets.dart';

class GameInfoScreen extends StatelessWidget {
  GameInfoTextField matchNumberField = GameInfoTextField('Match Number');
  GameInfoTextField teamNumberField = GameInfoTextField('Team Number');
  GameInfoTextField refereeIDField = GameInfoTextField('Referee ID');

  SheetManager sheetManager;

  GameInfoScreen(this.sheetManager);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Game'),
      ),
      body: Align(
        alignment: Alignment.center,
        child: ListView(
          children: [
            SizedBox(
              height: 20.0,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: this.refereeIDField,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: this.matchNumberField,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: this.teamNumberField,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                color: Colors.blue,
                onPressed: () async {
                  await Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return GameScoringScreen(
                        this.sheetManager,
                        this.matchNumberField.textFieldController.text,
                        this.teamNumberField.textFieldController.text,
                        this.refereeIDField.textFieldController.text);
                  }));
                  this.matchNumberField.textFieldController.text ='';
                  this.teamNumberField.textFieldController.text = '';
                },
                child: Text('Start Game'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
