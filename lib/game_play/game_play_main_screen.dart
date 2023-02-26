import 'dart:math';

import 'package:flipgame/commons/commons.dart';
import 'package:flipgame/game_play/time_counter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

import '../commons/button_close_dialog.dart';
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

  // late int _itemCountDown;
  late List<List<String>> _valueGame = [];
  late List<String> _textGame;
  bool _isPause = true;
  bool _isShowPlayInCenter = true;

  /// Create const of game
  void _initGame() {
    _stateOpened.clear();
    _stateVisible.clear();
    _width = GlobalSetting.getGamePlayWidth();
    _height = GlobalSetting.getGamePlayHeight();
    GlobalSetting.itemCountDown = _width * _height;
    for (int y = 1; y <= _height; y++) {
      _stateOpened.add(List.generate(_width, (index) => false));
      _stateVisible.add(List.generate(_width, (index) => true));
      _valueGame.add(List.generate(_width, (index) => ""));
    }
    _crateListValueInGame();
  }

  /// Handle onTap on item game
  void _actionGame(int y, int x, BuildContext mainContext) {
    if (_yPre == y && _xPre == x) return; // Kiem tra viec nhan cung 1 item
    setState(() => _stateOpened[y][x] = true);
    (_valueA == "")
        ? _valueA = _valueGame[y][x]
        : _valueB = _valueGame[y][x]; // Luu lai value cua item vua mo
    // Kiem tra co mo 2 item khong
    if (_valueB == "") {
      _xPre = x;
      _yPre = y;
      return;
    }
    // delay neu mo 2 item
    setState(() => _isPause = true);
    Future.delayed(Duration(milliseconds: GlobalSetting.timeDelay), () {
      if (_valueA == _valueB) {
        GlobalSetting.itemCountDown -= 2;
        setState(() {
          _stateVisible[y][x] = false;
          _stateVisible[_yPre][_xPre] = false;
        });
      }
      if (GlobalSetting.itemCountDown == 0) {
        GlobalSetting.timer!.cancel();
        SmartDialog.show(
            alignment: Alignment.center,
            clickMaskDismiss: false,
            maskColor: Colors.black87,
            builder: (BuildContext context) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonCloseDialog(onClose: () {
                    SmartDialog.dismiss();
                    Future.delayed(Duration(milliseconds: 100),
                        () => Navigator.pop(mainContext));
                  }),
                  Container(
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 1.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white70,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text("You win!",
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                        Divider(thickness: 2),
                        Text(
                          GlobalSetting.type == GamePlayTypes.infinity
                              ? formatMMSS(GlobalSetting.timeCounter)
                              : formatMMSS(GlobalSetting.seconds -
                                  GlobalSetting.timeCounter),
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            });
      }
      setState(() {
        _isPause = false;
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
    List<Row> childrenColumn = [];
    ItemGame itemGame;
    for (int y = 0; y < _height; y++) {
      List<ItemGame> gameRow = [];
      for (int x = 0; x < _width; x++) {
        itemGame = new ItemGame(
          onTap: () => _actionGame(y, x, context),
          text: copyValueList[0],
          visible: _stateVisible[y][x],
          isOpen: _stateOpened[y][x],
        );
        copyValueList.removeAt(0);
        gameRow.add(itemGame);
      }
      Row row =
          Row(mainAxisAlignment: MainAxisAlignment.center, children: gameRow);
      childrenColumn.add(row);
    }
    return Column(
        mainAxisAlignment: MainAxisAlignment.center, children: childrenColumn);
  }

  /// create random list text
  void _crateListValueInGame() {
    _textGame = List.generate(GlobalSetting.itemCountDown, (index) => "");
    List<int> listIndex =
        List.generate(GlobalSetting.itemCountDown, (index) => index);
    Random random;
    int index;
    for (int i = 0; i < GlobalSetting.itemCountDown; i++) {
      random = Random();
      index = random.nextInt(GlobalSetting.itemCountDown - i);
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
        child: Stack(
          children: [
            AbsorbPointer(
              absorbing: _isPause,
              child: _buildWidgetMatrixGame(),
            ),
            Visibility(
                visible: _isShowPlayInCenter,
                child: Container(
                  constraints: BoxConstraints.expand(),
                  color: Colors.white30,
                )),
            Align(
              alignment: _isShowPlayInCenter
                  ? Alignment.center
                  : Alignment.bottomRight,
              child: AnimatedContainer(
                margin: EdgeInsets.all(13),
                curve: Threshold(0.0),
                duration: Duration(milliseconds: 200),
                child: TimeCounter(
                  onStart: () => setState(() {
                    _isPause = !_isPause;
                    _isShowPlayInCenter = !_isShowPlayInCenter;
                  }),
                  onTimeout: () {},
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Container(
        margin: EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                alignment: Alignment.center,
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                ),
                child: Text("Back", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
