class Game {
  final List<int> POINT_VALUES = [100, 200, 100, 200, 100, 200, 200];
  final int BONUS_POINTS = 200;


  int matchNumber = -1;
  int teamNumber = -1;
  int refereeID = -1;

  int secondsRemaining;

  List<bool> scoredElements;

  Game([this.matchNumber, this.teamNumber, this.refereeID]) {
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

  List<String> getSheetsFirstHalfRowContentList() {
    List<String> returnList = [];
    returnList.add(this.refereeName);
    returnList.add(this.scorerName);
    returnList.add(this.teamName);
    returnList.add(this.teamNumber.toString());
    returnList.add(this.matchNumber.toString());
    returnList.add('');

    returnList.add(this.secondsRemaining.toString());
    for (bool b in this.scoredElements) {
      if (b) {
        returnList.add('Y');
      } else {
        returnList.add('N');
      }
    }
    return returnList;
  }

  List<String> getSheetsSecondHalfRowContentList() {
    List<String> returnList = [];
    bool bonusEarned = true;
//    for (bool b in this.scoredElements) {
    for (int i = 0; i < this.scoredElements.length; i++) {
      bool b = this.scoredElements[i];
      if (b) {
        returnList.add(this.POINT_VALUES[i].toString());
      } else {
        bonusEarned = false;
        returnList.add('0');
      }
    }
    if (bonusEarned) {
      returnList.add(this.BONUS_POINTS.toString());
    } else {
      returnList.add('');
    }
    returnList.add(this.getTotalScoredPoints().toString());

    return returnList;
  }
  
  

}
