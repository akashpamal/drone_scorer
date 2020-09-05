import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'dart:async';
import 'package:drone_scorer/game.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SheetManager extends StatelessWidget {
// your google auth credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-288017",
  "private_key_id": "b1427cc130a142b64b0eb05909d42b5176d5cdbd",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCl8uGubIuOp05S\nm20fKi+KQufii8OI5cKFi+HjcQlOEVVGrbpr30FC5JAZysn0i2G52Oejq7e2Ax6B\nPkZGUTpYnfBv0M75hbYTYr88WiSKvWtynCz1quMWTtSSEiENHGiNehw2kzd2b2Zw\nha/XT8qoUOr4snNXNMmGejj9HDBV7an6MHkPfkXcPMsouibZ7+zHpIVXS0Z2uEf+\nKJ02GMVSuB0Ji5vunVFT5ACNs5zi8SUJ3vZ7L1wcTz+2mpDEogze46/8GrESKpD0\n1Rd1hHlNQaOO0kckbHOHcHm6Tmo/pYuLISkX+C+ehIrQvCaSaJYv46yNZWVneDnN\nGbs32y/RAgMBAAECggEAUZjOGEZeDqw8SkkLTF4hVxIT0+SWJjuXPLQtw3his2S5\nchHdTspNXBdntY7tY5WfXVMGfwdhwxjgiHs28b9h+Y3bWhepla6F+x08W/AU9LUz\n3nxlbPx0QZVMV3CbmMdFr38B3WHgzRb0n1JUxoGA6+cxykxwg0o85yc021vfdngk\nnTbhG994Rp30hOvX9V560RNNIgrhRGjEq5g9QloyTQ4Sb6sb6WB333nuej1dbfuY\nXtC/efgqKj9Et9zl2ChoB4SjRyzneDGxB4xeJ8blPXaGep0n/Ncs4jFn5aymZ3iD\n9nSpB+QTbUpvjGeroFfnlPTg1Pvsnxv3xl6qs0/5mwKBgQDlJYHYuqovO7LHVjzd\nbj04BPmLbL+ozIyRDm0xzpxYcFUR7H7F+icyVnf8b6yg/0iTY5mqosPVQYXQ92OG\nURoyh0nCOIOsGpwfCgNdUYkEETc5WkiaJ+NUWGCWD+anJHl/8E3cXHNCD/HcDuVo\n5B4ITvtOOpDBImJit5AvxkpS4wKBgQC5ZWowFrtC6WbvmeAsi6qR10lJtKbAQ4C0\nqFRrWRBGXE78+YjxxZplhQIej/kfswP6EdPBJxVBRH1j7wnfPvcnkKXRqKApf3k9\nbnr6Y38K6+ii5PeKRyqvwS/E2WUxCLG/c4cxmzyj+28xYtHX0kI2nKSW842SSaoa\n3Kcf5voMuwKBgH0Za/kpd23P9rty7kmpPIzP0nj2xu/dtEQhDyYo+RwjP55IcbGd\n7zZBFMJhKWq/1Bx7PNJ2h9luKyM5XEFhF59MUs1Q0znrUR509f9FWzs4NuD91DMs\n4aQTl691QOQxOo/JXoiWhGolkFImY8JO/8JjdDlyKcL3BaWFN5eNdtgnAoGAPX3G\np6aSe9IAY04tTXkRnQfD9h9mA3UgNktynJxQypWJWVzGsDIzUKK6HjrwjTQKCKJr\nErCM2zYFROUe6B3xSf0vEogUf08ZfmergGsJ0yyF36mD9Sg/n0W7O1ZDuuzAT9jY\nqXpstZMKwV2ebi/96DEyYiLr/O5T7k7rW6h3nUsCgYEA4KwBOx/uqOv65Sr5JUGs\nXAX7gmXZk9PoiH+pkp0tURJ+45Fuu2fG78NifCJ+DU+BikVAEA1dLd0oJChhx5Ta\nFTcO0e25kBBlO3P/YvzRUyiLCgrPqOFoAKWxOlBQDCe/pSj/ZdoB5gU67c+0o72D\nLmj/3BTEPud9ZuOQTg1LXUY=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-288017.iam.gserviceaccount.com",
  "client_id": "101543282645222022271",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-288017.iam.gserviceaccount.com"
}
  ''';

  // your spreadsheet id
  static const _spreadsheetId = '1pEOQ8EiNgTC6jYq3vmM2ZNi8Q1pDfMafXbaoCEZ4N9M';
  static const _verificationSpreadsheetId = '139UhLfqscoV8Hvq8tAl7pAPyFviKCDDrqxw6fotejG4';

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

    Cell verificationCell = await this.verificationSheet.cells.cell(row: 1, column: 1);
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
    if (indexOfNewRow == -1) { // the row wasn't there, which means this device doesn't have the verification code
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
