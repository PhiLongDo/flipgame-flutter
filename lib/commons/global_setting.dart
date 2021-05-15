import 'package:flipgame/game_play/item_game.dart';

/// Save current setting (ex: level, type,...)
class GlobalSetting {
  static GamePlayLevels level = GamePlayLevels.lv3x4;
  static GamePlayTypes type = GamePlayTypes.infinity;
  static List<List<ItemGame>> matrixGame = []; // matrix game
  static List<List<bool>> stateTouched = []; // state taped matrix game
  static List<List<bool>> stateVisible = []; //state visible matrix game

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
    if (level == GamePlayLevels.lv10x10) {
      height = 10;
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
  lv10x10,
}
