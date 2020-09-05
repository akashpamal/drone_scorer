import 'package:drone_scorer/sheet_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AuthorizationScreen extends StatelessWidget {
  SheetManager sheetManager;
  TextEditingController authCodeController = TextEditingController();

  AuthorizationScreen(this.sheetManager);

  @override
  Widget build(BuildContext context) {
    this.authCodeController.text = this.sheetManager.localAuthCode;

    return Scaffold(
      appBar: AppBar(
        title: Text('Authorization'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: this.authCodeController,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Authorization Code',
//            labelStyle: TextStyle(height:5, fontWeight: FontWeight.bold),
                border: OutlineInputBorder(),
//        disabledBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.green, width: 20)),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue, width: 2)),
                hintText: 'Enter authorization code',
                hintStyle: TextStyle(color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: CupertinoButton(
                color: Colors.blue,
//                color: Theme.of(context).buttonColor,
                onPressed: () async {
                  this.sheetManager.setLocalAuthCode(this.authCodeController.text);
                  Navigator.pop(context);
                },
                child: Text('Save Code'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
