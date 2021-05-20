import 'dart:async';

import 'package:flipgame/game_play/item_game.dart';

/// Save current setting (ex: level, type,...)
class GlobalSetting {
  static int timeDelay = 400;
  static GamePlayLevels level = GamePlayLevels.lv3x4;
  static GamePlayTypes type = GamePlayTypes.infinity;
  static List<List<ItemGame>> matrixGame = []; // matrix game
  static List<String> listValue = ['🍓','🍒','🍎','🍉','🍑','🍊','🥭','🍍','🍌','🍄','🍈','🍏','🍐','🥝','🍇','🥥','🍅','🌶','🍄','🥕','🍠','🌽','🥦','🥒','🥬','🥑','🍆','🥔','🌰','🥜','🍞','🥐','🥖','🥯','🥞','🍳','🥣','🥗','🍲','🍛','🍜','🦞','🍣','🍤','🥡','🥠','🍡','🍥','🍘','🍙','🍢','🥟','🍱','🍚','🥮','🍧','🍨','🍦','🥧'];
  static int timeCounter = 0;
  static late Timer timer;
  static int itemCountDown = 0;
  static int seconds = 180;    // time limit
  // static bool isPlaying = false;

  static int getGamePlayWidth() {
    int width = 3;
    if (level == GamePlayLevels.lv3x4) {
      width = 3;
    }
    if (level == GamePlayLevels.lv4x5) {
      width = 4;
    }
    if (level == GamePlayLevels.lv5x6) {
      width = 5;
    }
    if (level == GamePlayLevels.lv6x7) {
      width = 6;
    }
    if (level == GamePlayLevels.lv7x8) {
      width = 7;
    }
    return width;
  }
  static int getGamePlayHeight() {
    int height = 4;
    if (level == GamePlayLevels.lv3x4) {
      height = 4;
    }
    if (level == GamePlayLevels.lv4x5) {
      height = 5;
    }
    if (level == GamePlayLevels.lv5x6) {
      height = 6;
    }
    if (level == GamePlayLevels.lv6x7) {
      height = 7;
    }
    if (level == GamePlayLevels.lv7x8) {
      height = 8;
    }
    return height;
  }
}

enum GamePlayTypes {
  infinity,
  timeLimit,
}
enum GamePlayLevels {
  lv3x4,
  lv4x5,
  lv5x6,
  lv6x7,
  lv7x8,
}

/// Format MMSS
String formatMMSS(int ticks) {
  String str = "";
  int minutes = ticks ~/ 60;
  str = ("0" + minutes.toString()).substring(minutes.toString().length - 1);
  int seconds = ticks % 60;
  str = str +
      ":" +
      ("0" + seconds.toString()).substring(seconds.toString().length - 1);
  return str;
}
