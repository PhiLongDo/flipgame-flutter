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

  double _getWidth(BuildContext context) {
    double w;
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      w = MediaQuery.of(context).size.height /
          GlobalSetting.getGamePlayHeight();
    } else {
      w = MediaQuery.of(context).size.width / GlobalSetting.getGamePlayWidth();
    }
    return w;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _getWidth(context),
      height: _getWidth(context),
      child: Visibility(
        visible: widget.visible,
        child: InkWell(
          onTap: widget.onTap,
          child: Container(
            width: _getWidth(context),
            height: _getWidth(context),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
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
