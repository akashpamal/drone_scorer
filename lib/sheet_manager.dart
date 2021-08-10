import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'dart:async';
import 'package:drone_scorer/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheetManager extends StatelessWidget {
// your google auth credentials
  static const _credentials = r'''
  {
  enter credentials here
  
}
  ''';

  // your spreadsheet id
  static const _spreadsheetId = '1pEOQ8EiNgTC6jYq3vmM2ZNi8Q1pDfMafXbaoCEZ4N9M';
  static const _verificationSpreadsheetId =
      '139UhLfqscoV8Hvq8tAl7pAPyFviKCDDrqxw6fotejG4';

  GSheets gSheets;
  Worksheet sheet;
  Worksheet verificationSheet;
  String localAuthCode;

  SheetManager() {
    this._initialize();
  }

  void _initialize() async {
    await this._connect();
    await this.updateLocalAuthCodeFromDisk();
  }

  void _connect() async {
    // init GSheets
    final gsheets = GSheets(_credentials);

    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);
    final ss1 = await gsheets.spreadsheet(_verificationSpreadsheetId);

    // get worksheet by its title
    this.sheet = await ss.worksheetByTitle('Scores');
    this.verificationSheet = await ss1.worksheetByTitle('AuthCode');

    // create worksheet if it does not exist yet
    this.sheet ??= await ss.addWorksheet('Scores');
    this.verificationSheet ??= await ss1.addWorksheet('AuthCode');
  }

  void setLocalAuthCode(String authCode) async {
    print('setting authCode to $authCode');
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authCode', authCode);
    this.localAuthCode = authCode;
  }

  void updateLocalAuthCodeFromDisk() async {
    final prefs = await SharedPreferences.getInstance();
    this.localAuthCode = await prefs.getString('authCode') ?? '';
    print('local authCode updated from disk: ${this.localAuthCode}');
  }

  void startEntry(Game game) async {
    List<List<String>> allRows = await this.sheet.values.allRows();

    Cell verificationCell =
        await this.verificationSheet.cells.cell(row: 1, column: 1);
    String remoteAuthCode = verificationCell.value;

    if (remoteAuthCode != this.localAuthCode) {
      return;
    }

    int indexOfNewRow = allRows.length;
    indexOfNewRow++;

    List<String> pushList = [];
    pushList += game.getMatchInfoRowContentList();

    await this.sheet.values.appendRow(pushList);
  }

  void addGame(Game game) async {
//    await this.sheet.insertRow(2);
//    await this.sheet.values.insertRow(2, game.getSheetsRowContentList());
//    List<Cell> cellsRow = await sheet.cells.row(2);
//    cellsRow = cellsRow.sublist(14);
//    List<String> cellsRowString = cellsRow.map((e) => e.toString()).toList();
    List<List<String>> allRows = await this.sheet.values.allRows();
    int indexOfNewRow = -1;
    for (int i = allRows.length - 1; i >= 0; i--) {
      List<String> row = allRows[i];
      if (row[0] == game.refereeID &&
          row[3] == game.teamNumber &&
          row[4] == game.matchNumber) {
        indexOfNewRow = i;
        break;
      }
    }
    if (indexOfNewRow == -1) {
      // the row wasn't there, which means this device doesn't have the verification code
      return;
    }

    indexOfNewRow += 1;
    print('index of active game is $indexOfNewRow');

    List<String> pushList = [];
    pushList.add('=Sum(T$indexOfNewRow:AA$indexOfNewRow)');
    pushList.add(''); // notes column, empty for now
    pushList.add('');

    pushList += game.getSheetsScoredElementsRowContentList();
    pushList
        .add('=IF(COUNTIF(K$indexOfNewRow:Q$indexOfNewRow, "Y") = 7,"Y","N")');

    print('pushList is $pushList');
    pushList.add('');

    pushList.add('=if(K$indexOfNewRow="Y",100,0)');
    pushList.add('=if(L$indexOfNewRow="Y",200,0)');
    pushList.add('=if(M$indexOfNewRow="Y",100,0)');
    pushList.add('=if(N$indexOfNewRow="Y",200,0)');
    pushList.add('=if(O$indexOfNewRow="Y",100,0)');
    pushList.add('=if(P$indexOfNewRow="Y",200,0)');
    pushList.add('=if(Q$indexOfNewRow="Y",200,0)');
    pushList.add('=if(R$indexOfNewRow="Y",200,0)');

//    await this.sheet.values.appendRow(pushList);
    await this.sheet.values.insertRow(indexOfNewRow, pushList, fromColumn: 7);
  }

  //      List<String> lastRow = await this.sheetManager.sheet.values.lastRow();
//      print('last row: ${lastRow}');
//    this.sheetManager.sheet.values.appendRow(['=SUM(T2:AA2)']);
//      List<Cell> secondRow = await this.sheetManager.sheet.cells.row(2);
//      this.sheetManager.sheet.values
//      print('second row to string: ${secondRow[6].toString()}');
//      final firstColumn = ['0', '1', '2', '3', '4'];
//      await this
//          .sheetManager
//          .sheet
//          .values
//          .insertColumn(1, firstColumn, fromRow: 2);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
