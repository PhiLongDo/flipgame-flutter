import 'dart:math';

import 'package:flipgame/commons/commons.dart';
import 'package:flutter/material.dart';

import 'item_game.dart';

class GamePlayMainScreen extends StatefulWidget {
  @override
  _GamePlayMainScreenState createState() => _GamePlayMainScreenState();
}

class _GamePlayMainScreenState extends State<GamePlayMainScreen> {
  late Column _widgetMatrixGame; // display main screen game play

  late int _width, _height; // size of matrix game
  late int _itemCountDown;
  late List<String> _valueGame;

  /// Create widgetMatrixGame
  void _initGame() {
    GlobalSetting.stateTouched.clear();
    GlobalSetting.stateVisible.clear();
    GlobalSetting.matrixGame.clear();
    _width = GlobalSetting.getGamePlayWidth();
    _height = GlobalSetting.getGamePlayHeight();
    List<Row> column = [];
    _itemCountDown = _width *_height;
    _crateListValueInGame();

    // create widget
    for (int y = 1; y <= _height; y++) {
      List<ItemGame> gameRow = [];
      GlobalSetting.stateTouched.add(List.generate(_width, (index) => false));
      GlobalSetting.stateVisible.add(List.generate(_width, (index) => true));
      for (int x = 1; x <= _width; x++) {
        String valueI = (x * y + y).toString();
        var itemGame = new ItemGame(
          // onTap: _actionGame(y-1, x-1),
          value: _valueGame.last,
          x: x-1,
          y: y-1,
        );
        _valueGame.removeLast();
        gameRow.add(itemGame);
      }
      Row row =
          Row(mainAxisAlignment: MainAxisAlignment.center, children: gameRow);
      GlobalSetting.matrixGame.add(gameRow);
      column.add(row);
    }
    _widgetMatrixGame =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: column);
    _itemCountDown = _width & _height;
  }

  /// create random list value
  void _crateListValueInGame() {
    _valueGame = List.generate(_itemCountDown, (index) => "");
    List<int> listIndex = List.generate(_itemCountDown, (index) => index);
    for (int i = 0; i < _itemCountDown ; i++) {
      var random = Random();
      var index = random.nextInt(_itemCountDown - i);
      _valueGame[listIndex[index]] = GlobalSetting.listValue[i~/2];
      listIndex.removeAt(index);
    }
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
