class Game {
  final List<int> POINT_VALUES = [100, 200, 100, 200, 100, 200, 200];
  final int BONUS_POINTS = 200;

  String matchNumber = '';
  String teamNumber = '';
  String refereeID = '';

  int secondsRemaining;

  List<bool> scoredElements;

  Game(this.matchNumber, this.teamNumber, this.refereeID) {
    this.scoredElements = POINT_VALUES.map((e) => false).toList();
  }

  int getTotalScoredPoints() {
    int total = 0;
    bool bonusEarned = true;
    for (int i = 0; i < this.scoredElements.length; i++) {
      if (this.scoredElements[i]) {
        total += this.POINT_VALUES[i];
      } else {
        bonusEarned = false;
      }
    }

    if (bonusEarned) {
      total += this.BONUS_POINTS;
    }

    return total;
  }

  List<String> getSheetsScoredElementsRowContentList() {
    List<String> returnList = [];

    bool bonusEarned = true;

    returnList.add(this.secondsRemaining.toString());
    for (bool b in this.scoredElements) {
      if (b) {
        returnList.add('Y');
      } else {
        bonusEarned = false;
        returnList.add('N');
      }
    }

    return returnList;
  }

  List<String> getMatchInfoRowContentList() {
    List<String> returnList = [];
    returnList.add(this.refereeID.toString());
    returnList.add('');
    returnList.add('');
    returnList.add(this.teamNumber.toString());
    returnList.add(this.matchNumber.toString());
    return returnList;
  }
}
