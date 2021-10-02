import 'package:flutter/material.dart';

class ItemSetting extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool selected;

  ItemSetting({required this.onTap, required this.text, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        margin: EdgeInsets.symmetric(vertical: 1.0),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: selected ? Colors.deepOrange : Colors.amberAccent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(width: 20),
            selected
                ? Icon(
                    Icons.check_circle_outline_outlined,
                    color: Colors.white,
                  )
                : Icon(
                    Icons.radio_button_unchecked,
                    color: Colors.blueGrey,
                  ),
            SizedBox(width: 20),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: selected ? Colors.white : Colors.blueGrey,
                  fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
