import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool selected;

  ItemSetting(
      {required this.onTap, required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      margin:EdgeInsets.symmetric(vertical: 5.0) ,
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50.0),
        color: selected ? Colors.deepOrange: Colors.amberAccent ,
      ),
      child: InkWell(
        onTap: onTap,
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: selected ? Colors.white : Colors.blueGrey, fontSize: 20),
        ),
      ),
    );
  }
}
