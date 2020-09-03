import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:drone_scorer/widgets/game_info_text_field.dart';
import 'game_scoring_screen.dart';
import 'package:drone_scorer/sheet_manager.dart';
import 'package:gsheets/gsheets.dart';
import 'game_ready_screen.dart';
import 'package:drone_scorer/game.dart';

class GameInfoScreen extends StatefulWidget {
  SheetManager sheetManager;

  GameInfoScreen(this.sheetManager);

  @override
  _GameInfoScreenState createState() => _GameInfoScreenState();
}

class _GameInfoScreenState extends State<GameInfoScreen> {
  GameInfoTextField refereeIDField =
      GameInfoTextField('Referee ID', TextInputType.text);

  GameInfoTextField matchNumberField =
      GameInfoTextField('Match Number', TextInputType.number);

  GameInfoTextField teamNumberField =
      GameInfoTextField('Team Number', TextInputType.number);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Game'),
//        backgroundColor: Colors.blue,
      ),
//      CupertinoNavigationBar(
//        middle: Text('New Game'),
//      ),
      body: Center(
        child: Form(
          key: this._formKey,
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
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoButton(
                  color: Colors.blue,
//                  color: Theme.of(context).buttonColor,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      String refereeIDText =
                          this.refereeIDField.textFieldController.text;
                      String matchNumberText =
                          this.matchNumberField.textFieldController.text;
                      String teamNumberText =
                          this.teamNumberField.textFieldController.text;
                      Game newGame = Game(
                        refereeIDText,
                        matchNumberText,
                        teamNumberText,
                      );
                      this.widget.sheetManager.startEntry(newGame);
                      await Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return GameReadyScreen(
                            this.widget.sheetManager, newGame);
                      }));
                      this.matchNumberField.textFieldController.text = '';
                      this.teamNumberField.textFieldController.text = '';
                    }
//                  if (this.refereeIDField.)
                  },
                  child: Text("I'm Ready"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
