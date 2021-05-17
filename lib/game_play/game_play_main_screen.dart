import 'dart:math';

import 'package:flipgame/commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'item_game.dart';

class GamePlayMainScreen extends StatefulWidget {
  @override
  _GamePlayMainScreenState createState() => _GamePlayMainScreenState();
}

class _GamePlayMainScreenState extends State<GamePlayMainScreen> {
  late int _width, _height; // size of matrix game
  List<List<bool>> _stateOpened = []; // state open of item in matrix game
  List<List<bool>> _stateVisible = []; //state visible matrix game
  String _valueA = "", _valueB = ""; // value of items game is opening
  int _xPre = -1, _yPre = -1;
  late int _itemCountDown;
  late List<List<String>> _valueGame = [];
  late List<String> _textGame;
  bool _isDelaying = false;

  /// Create const of game
  void _initGame() {
    _stateOpened.clear();
    _stateVisible.clear();
    _width = GlobalSetting.getGamePlayWidth();
    _height = GlobalSetting.getGamePlayHeight();
    _itemCountDown = _width * _height;
    for (int y = 1; y <= _height; y++) {
      _stateOpened.add(List.generate(_width, (index) => false));
      _stateVisible.add(List.generate(_width, (index) => true));
      _valueGame.add(List.generate(_width, (index) => ""));
    }
    _crateListValueInGame();
  }

  /// Handle onTap on item game
  void _actionGame(int y, int x) {
    if (_yPre == y && _xPre == x) return; // Kiem tra viec nhan cung 1 item
    setState(() => _stateOpened[y][x] = true);
    (_valueA == "") ? _valueA = _valueGame[y][x] : _valueB = _valueGame[y][x];

    // Kiem tra co mo 2 item khong
    if (_valueB == "") {
      _xPre = x;
      _yPre = y;
      return;
    }

    setState(() => _isDelaying = true);
    Future.delayed(Duration(milliseconds: GlobalSetting.timeDelay), () {
      if (_valueA == _valueB) {
        _itemCountDown -= 2;
        setState(() {
          _stateVisible[y][x] = false;
          _stateVisible[_yPre][_xPre] = false;
        });
      }
      if (_itemCountDown == 0) {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Clear!"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  )
                ],
              );
            });
      }
      setState(() {
        _isDelaying = false;
        _stateOpened[y][x] = false;
        _stateOpened[_yPre][_xPre] = false;
      });
      _xPre = -1;
      _yPre = -1;
      _valueA = "";
      _valueB = "";
    });
  }

  /// Build matrix game
  Widget _buildWidgetMatrixGame() {
    List<String> copyValueList = List.from(_textGame);
    late Column widgetMatrixGame; // display main screen game play
    List<Row> childrenColumn = [];
    for (int y = 0; y < _height; y++) {
      List<ItemGame> gameRow = [];
      for (int x = 0; x < _width; x++) {
        var itemGame = new ItemGame(
          onTap: () => _actionGame(y, x),
          text: copyValueList[0],
          visible: _stateVisible[y][x],
          isOpen: _stateOpened[y][x],
        );
        copyValueList.removeAt(0);
        gameRow.add(itemGame);
      }
      Row row =
          Row(mainAxisAlignment: MainAxisAlignment.center, children: gameRow);
      GlobalSetting.matrixGame.add(gameRow);
      childrenColumn.add(row);
    }
    widgetMatrixGame = Column(
        mainAxisAlignment: MainAxisAlignment.center, children: childrenColumn);
    return widgetMatrixGame;
  }

  /// create random list text
  void _crateListValueInGame() {
    _textGame = List.generate(_itemCountDown, (index) => "");
    List<int> listIndex = List.generate(_itemCountDown, (index) => index);
    for (int i = 0; i < _itemCountDown; i++) {
      var random = Random();
      var index = random.nextInt(_itemCountDown - i);
      _textGame[listIndex[index]] = GlobalSetting.listValue[i ~/ 2];
      _valueGame[listIndex[index] ~/ _width][listIndex[index] % _width] =
          _textGame[listIndex[index]];
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
        child: AbsorbPointer(
          absorbing: _isDelaying,
          child: _buildWidgetMatrixGame(),
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
