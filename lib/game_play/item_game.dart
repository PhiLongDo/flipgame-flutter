import 'package:flipgame/commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemGame extends StatefulWidget {
  final String value;
  final int x;
  final int y;

  ItemGame({required this.value, required this.x, required this.y});

  @override
  _ItemGameState createState() => _ItemGameState();
}

class _ItemGameState extends State<ItemGame> {
  bool _isTouched = false;

  double _getWidth(BuildContext context) {
    double w;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      w = MediaQuery.of(context).size.height /
          GlobalSetting.getGamePlayHeight();
    } else {
      w = MediaQuery.of(context).size.width / GlobalSetting.getGamePlayWidth();
    }
    return w - 6;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          _isTouched = !_isTouched;
        });
      },
      child: Container(
        width: _getWidth(context),
        height: _getWidth(context),
        margin: EdgeInsets.all(3.0),
        padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3.0),
          color: _isTouched ? Colors.deepOrange : Colors.amberAccent,
        ),
        child: Visibility(
          visible: GlobalSetting.stateVisible[widget.y][widget.x],
          child: Center(
            child: Text(
              widget.value,
              style: TextStyle(
                color: _isTouched ? Colors.brown : Colors.blue,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
