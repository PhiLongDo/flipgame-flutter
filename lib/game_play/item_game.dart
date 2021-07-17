import 'package:flipgame/commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemGame extends StatefulWidget {
  final String text;
  final VoidCallback onTap;
  final bool visible, isOpen;


  ItemGame({required this.onTap, required this.visible, required this.isOpen, required this.text});

  @override
  _ItemGameState createState() => _ItemGameState();
}

class _ItemGameState extends State<ItemGame> {

  double _getWidth() {
    const double dentaw = 240;
    const double dentah = 60;
    double w, h, real;
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    if (h < w) {
      if (w - h >= dentaw){
        real = MediaQuery.of(context).size.height /
            GlobalSetting.getGamePlayHeight();
      } else {
        real = (MediaQuery.of(context).size.height - (dentaw - w + h)) /
            GlobalSetting.getGamePlayHeight();
      }
    } else {
      if (h - w >= dentah){
        real = MediaQuery.of(context).size.width / GlobalSetting.getGamePlayWidth();
    } else {
        real = (MediaQuery.of(context).size.width - (dentah - h + w))  / GlobalSetting.getGamePlayWidth();
    }

    }
    return real;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getWidth(),
      height: _getWidth(),
      child: Visibility(
        visible: widget.visible,
        child: GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width:_getWidth(),
            height:  _getWidth(),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3.0),
              border: Border.all(color: Colors.white, width: 1),
              color: widget.isOpen ? Colors.amberAccent : Colors.greenAccent,
            ),
            child: Center(
              child: Text(
                widget.isOpen ? widget.text : "*",
                style: TextStyle(
                  color: widget.isOpen ? Colors.brown : Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
