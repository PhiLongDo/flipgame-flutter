import 'dart:async';
/// Save current setting (ex: level, type,...)
class GlobalSetting {
  static int timeDelay = 400;
  static GamePlayLevels level = GamePlayLevels.lv3x4;
  static GamePlayTypes type = GamePlayTypes.infinity;
  static List<String> listValue = ['🍓','🍒','🍎','🍉','🍑','🍊','🥭','🍍','🍌','🍈','🍏','🍐','🥝','🍇','🥥','🍅','🌶','🍄','🥕','🍠','🌽','🥦','🥒','🥬','🥑','🍆','🥔','🌰','🥜','🍞','🥐','🥖','🥯','🥞','🍳','🥣','🥗','🍲','🍛','🍜','🦞','🍣','🍤','🥡','🥠','🍡','🍥','🍘','🍙','🍢','🥟','🍱','🍚','🥮','🍧','🍨','🍦','🥧'];
  static int timeCounter = 0;
  static Timer? timer;
  static int itemCountDown = 0;
  static int seconds = 180;    // time limit

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
    if (level == GamePlayLevels.lv10x10) {
      width = 10;
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
    if (level == GamePlayLevels.lv10x10) {
      height = 10;
    }
    return height;
  }

  static void setLevel(String lv) {
    switch (lv) {
      case "lv3x4":
        level = GamePlayLevels.lv3x4;
        break;
      case "lv4x5":
        level = GamePlayLevels.lv4x5;
        break;
      case "lv5x6":
        level = GamePlayLevels.lv5x6;
        break;
      case "lv6x7":
        level = GamePlayLevels.lv6x7;
        break;
      case "lv7x8":
        level = GamePlayLevels.lv7x8;
        break;
      case "lv10x10":
        level = GamePlayLevels.lv10x10;
        break;
    }
  }
  static void setType(String tp) {
    switch (tp) {
      case "infinity":
        type = GamePlayTypes.infinity;
        break;
      case "timeLimit":
        type = GamePlayTypes.timeLimit;
        break;
    }
  }
  static String getStringLevel() {
    switch (level) {
      case GamePlayLevels.lv3x4:
        return "lv3x4";
      case GamePlayLevels.lv4x5:
        return "lv4x5";
      case GamePlayLevels.lv5x6:
        return "lv5x6";
      case GamePlayLevels.lv6x7:
        return "lv6x7";
      case GamePlayLevels.lv7x8:
        return "lv7x8";
      case GamePlayLevels.lv10x10:
        return "lv10x10";
    }
  }
  static String getStringType() {
    switch (type) {
      case GamePlayTypes.infinity:
        return "infinity";
      case GamePlayTypes.timeLimit:
        return "timeLimit";
    }
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
  lv10x10,
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
