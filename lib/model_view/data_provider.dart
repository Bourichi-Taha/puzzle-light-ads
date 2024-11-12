import 'package:puzzle/model/data.dart';
import 'package:flutter/material.dart';
import 'package:puzzle/services/local_storage.dart';

class DataProvider extends ChangeNotifier {
  Data data = Data();
  int score = 0;
  List<String> missiondone = [];

  void setData(Data data) {
    this.data = data;
    notifyListeners();
  }

  Data getData() {
    return data;
  }

  //get score
  void getScore() {
    LocalStorage.getscore().then((value) {
      if (value == null) {
        score = 0;
      } else {
        score = value;
      }
      notifyListeners();
    });
  }

  //set score
  void setScore(int score) {
    this.score = score;
    LocalStorage.savescore(score);
    notifyListeners();
  }

  void incrementScore(int def) {
    int exp = 100 * def;
    score = score + exp;
    LocalStorage.savescore(score);
    notifyListeners();
  }

  //get mission done
  Future getMissionDone() async {
    LocalStorage.getmissiondone().then((value) {
      if (value == null) {
        missiondone = [];
      } else {
        missiondone = value;
      }
      notifyListeners();
    });
  }

  //set mission done
  void setMissionDone(String mission) {
    missiondone.add(mission);
    LocalStorage.savemissiondone(missiondone);
    notifyListeners();
  }
}
