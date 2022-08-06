import 'package:flutter/material.dart';

const defaultPadding = EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0);
const defaultMargin = EdgeInsets.symmetric(vertical: 1.0);

class ItemSetting extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool selected;
  final Color selectedColor;
  final Color backColor;

  /// EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0)
  final EdgeInsetsGeometry padding;

  /// EdgeInsets.symmetric(vertical: 1.0)
  final EdgeInsetsGeometry margin;

  /// default 300
  final double width;

  ItemSetting(
      {required this.onTap,
      required this.text,
      this.selected = false,
      this.backColor = Colors.amberAccent,
      this.selectedColor = Colors.deepOrange,
      this.margin = defaultMargin,
      this.padding = defaultPadding,
      this.width = 300});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        margin: margin,
        padding: padding,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50.0),
          color: selected ? selectedColor : backColor,
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
