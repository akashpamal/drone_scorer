import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drone_scorer/widgets/game_info_text_field.dart';
import 'game_scoring_screen.dart';
import 'package:drone_scorer/sheet_manager.dart';

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
            this.matchNumberField,
            this.teamNumberField,
            this.refereeIDField,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoButton(
                color: Colors.blue,
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    List<String> pushList = [];
                    pushList.add(this.matchNumberField.textFieldController.text);
                    pushList.add(this.teamNumberField.textFieldController.text);
                    pushList.add(this.refereeIDField.textFieldController.text);
                    return GameScoringScreen(pushList, this.sheetManager);
                  }));
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
