import 'package:flipgame/commons/commons.dart';
import 'package:flutter/material.dart';

import 'item_game.dart';

class GamePlayMainScreen extends StatefulWidget {
  @override
  _GamePlayMainScreenState createState() => _GamePlayMainScreenState();
}

class _GamePlayMainScreenState extends State<GamePlayMainScreen> {
  late Column _widgetMatrixGame;

  late int _width, _height; // size of matrix game
  String valueA = "", valueB = "";

  void _actionGame(int y, int x) {
    if (valueA == "") {
      valueA = GlobalSetting.matrixGame[y][x].value;
    } else {
      valueB = GlobalSetting.matrixGame[y][x].value;
    }
    GlobalSetting.stateTouched[y][x] = true;
  }

  void _initGame() {
    GlobalSetting.stateTouched.clear();
    GlobalSetting.stateVisible.clear();
    GlobalSetting.matrixGame.clear();
    _width = GlobalSetting.getGamePlayWidth();
    _height = GlobalSetting.getGamePlayHeight();
    List<Row> column = [];
    for (int y = 1; y <= _height; y++) {
      List<ItemGame> gameRow = [];
      GlobalSetting.stateTouched.add(List.generate(_width, (index) => false));
      GlobalSetting.stateVisible.add(List.generate(_width, (index) => true));
      print (GlobalSetting.stateVisible[y-1]);
      for (int x = 1; x <= _width; x++) {
        String valueI = (x * y + y).toString();
        var itemGame = new ItemGame(
          // onTap: _actionGame(y-1, x-1),
          value: valueI,
          x: x-1,
          y: y-1,
        );
        gameRow.add(itemGame);
      }
      Row row =
          Row(mainAxisAlignment: MainAxisAlignment.center, children: gameRow);
      GlobalSetting.matrixGame.add(gameRow);
      column.add(row);
    }
    _widgetMatrixGame =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: column);
  }

  @override
  void initState() {
    _initGame();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: _widgetMatrixGame,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Back"),
      ),
    );
  }
}
