import 'package:flutter/cupertino.dart';
import 'package:gsheets/gsheets.dart';
import 'dart:async';
import 'package:drone_scorer/game.dart';

class SheetManager extends StatelessWidget {
// your google auth credentials
  static const _credentials = r'''
  {
  "type": "service_account",
  "project_id": "gsheets-288017",
  "private_key_id": "c7b90b9d35a3c8d7739abcd962ff3dc72c2c93b5",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvgIBADANBgkqhkiG9w0BAQEFAASCBKgwggSkAgEAAoIBAQCz7vnj2KAXazLO\nzwOGF2G6vC7KEOMHufD6LcucV5nMDWnwK0oIAXWC+F41XkL2m3kz5xKoeJPIUIyH\n9csJC+j6q9CBieRsiCQMOPGmqxpOiwn3tMC4wjXnlfeyR+NJaSudaOBbF7JST6kG\nNhPYM4f3q0djHmviyIFDCxoYgDBu1QU7UC8etqpx1iOWKsbdikuxdJqQ3HS3w53k\neRu8Ao0o3js1l0Plnu00Bl1fIj7PUES6qVcDnwRsIdfOCSUz9VWOmBPgE/LWvX/W\nPBkB0u2qwprna7WfrWVGxffjq2uOCLxWMpaPN0znf4fw/mrC6Ux8AxcRv1pP3PAD\nZDMVrT/LAgMBAAECggEABcpR9lgZRsenWeplhaIo/fZiVxRWCgCc1aA1pjFXfK6N\n0zHBbyKE4pMVjQgchY0ZSGdOPWer8c1NyG5Le14LwE1ZJ2IFnMyAxHfspt1oulBV\nIMiLTybIz0wPLYiMsucUhTtDxQqtLWLs4ItK9jEqVfkIEhN/i0vChSLNUy6E4Hwi\nhlYgwygMfUL8IH2vxo2IVfZtnLZXzz6iHJcmGF9mg3lgEaHVrSkUPfSjJr0A3w+8\nC5ecLpHKp6Q4j+jDJPVxYAJ25jP0mSLqH03OJN9Vvuz5zKcrI4iYrwkyhsdOxWs9\nkiS7oh1Yaf8uRWeVv5cgwOG+JOgSIjumx1lAbhogWQKBgQDx7JA6lyBn4NmUicRa\nrhnKN+YEX12ECsnrA49Jp8CDvYjB7msn4qJhwV7Ghh2fR+qaPN+QnE1BXyRwdad2\n0d1VvqTgopBquOaDvgXp9wjEGIjGv97H9Ys5/GgZXM9bDZGu57lX7uy1oDa1QJkq\nqtJNckXVPObdtr3HNuG4HK20hQKBgQC+ZxGij3/34I6omlI9i2lbivGRFAE+aW6M\nfnBaVKcp9y6vqEqpLrbxSQjOJ0rUr/zG2w2oCSDRFCqnyN2buUxGhkoATJVHKiil\nKB8wDWbqin23T15XjE4VfGQ7/u3XXOXgtyVlH6BYeyozmq9l0stU+iRPOe7RC331\nkxdTHZa8DwKBgQDK6ruHCV/bAZQ+rNePn9xt6zj5jevoZww6HYBALX6igYWF9K7Y\ng5XkHMecCL4r7axvtoNmzlNWc7EiyuyuExVtaDzvVit/+JsRAYAAYH5vzIxc+G6q\nleAzwOyn6VrbaqQ5ao/hm7vcFAgPO6G9Ug6XezPryetzKGZCBFyLizJ/6QKBgBiv\nolCyTEQmIDjp8Tm7hohw5ksKDfM6ljOu/QApM5c0TiBGMI/o151G+9ZGr+QNgTeD\nFS0xKckR1Un1uA3Fo4cNSDDrvPsCE0z+e7SuOCa2mAAZUUEGluUgQJqqvcmLaN6O\nwFFxHUf7iAgyyQTppKU63VRMTZNa6xTY4lBLaMyvAoGBAJOZacOQAbDAkoLD09R8\nBW2jaHtCdtpnfG0w7mnCxhglIcUHBWufwXTNk5GjDEYIEo/RMNCmXWiGvaZHec3y\nEQo7qqq7dVF1W3uMe3bdpaNmFe6kv4f59DZlWuniwjLWDN4R9oOBN0xHyPivtOzU\nwvt5NKLJdjAc8Ini7ewqWYga\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheets@gsheets-288017.iam.gserviceaccount.com",
  "client_id": "105299539832981888941",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheets%40gsheets-288017.iam.gserviceaccount.com"
}

  ''';

  // your spreadsheet id
  static const _spreadsheetId = '1pEOQ8EiNgTC6jYq3vmM2ZNi8Q1pDfMafXbaoCEZ4N9M';

  GSheets gSheets;
  Worksheet sheet;

  SheetManager() {
    this._initialize();
  }

  void _initialize() async {
    await this._connect();
  }

  void _connect() async {
    // init GSheets
    final gsheets = GSheets(_credentials);

    // fetch spreadsheet by its id
    final ss = await gsheets.spreadsheet(_spreadsheetId);

    // get worksheet by its title
    this.sheet = await ss.worksheetByTitle('example');

    // create worksheet if it does not exist yet
    this.sheet ??= await ss.addWorksheet('example');
  }

  void addGame(Game game) async {
//    await this.sheet.insertRow(2);
//    await this.sheet.values.insertRow(2, game.getSheetsRowContentList());
//    List<Cell> cellsRow = await sheet.cells.row(2);
//    cellsRow = cellsRow.sublist(14);
//    List<String> cellsRowString = cellsRow.map((e) => e.toString()).toList();
    List<String> pushList = game.getSheetsFirstHalfRowContentList() + ['', '', ''] + game.getSheetsSecondHalfRowContentList();
    
    await this.sheet.values.appendRow(pushList);
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
