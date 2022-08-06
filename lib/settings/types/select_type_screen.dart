import 'package:flipgame/commons/commons.dart';
import 'package:flipgame/settings/item_setting.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../commons/button_close_dialog.dart';

class SelectTypeScreen extends StatefulWidget {
  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  Future<void> _saveType() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("type", GlobalSetting.getStringType());
  }

  void _select(GamePlayTypes type) {
    setState(() {
      GlobalSetting.type = type;
    });
    _saveType();
  }

  Future<void> saveTimeSetting(int seconds) async {
    setState(() {
      GlobalSetting.seconds = seconds;
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("time", seconds);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ButtonCloseDialog(
          onClose: SmartDialog.dismiss,
        ),
        ItemSetting(
            onTap: () => _select(GamePlayTypes.infinity),
            text: "Infinity",
            selected: GlobalSetting.type == GamePlayTypes.infinity),
        ItemSetting(
            onTap: () => _select(GamePlayTypes.timeLimit),
            text: "Time limit",
            selected: GlobalSetting.type == GamePlayTypes.timeLimit),
        Opacity(
          opacity: GlobalSetting.type == GamePlayTypes.timeLimit ? 1 : 0.5,
          child: AbsorbPointer(
            absorbing: GlobalSetting.type != GamePlayTypes.timeLimit,
            child: Column(
              children: [
                SizedBox(height: 5),
                ItemSetting(
                  onTap: () {
                    saveTimeSetting(30);
                  },
                  text: "00:30",
                  selected: GlobalSetting.seconds == 30,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  backColor: Colors.greenAccent,
                  selectedColor: Colors.cyan,
                ),
                ItemSetting(
                  onTap: () {
                    saveTimeSetting(90);
                  },
                  text: "01:30",
                  selected: GlobalSetting.seconds == 90,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  backColor: Colors.greenAccent,
                  selectedColor: Colors.cyan,
                ),
                ItemSetting(
                  onTap: () {
                    saveTimeSetting(120);
                  },
                  text: "02:00",
                  selected: GlobalSetting.seconds == 120,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  backColor: Colors.greenAccent,
                  selectedColor: Colors.cyan,
                ),
                ItemSetting(
                  onTap: () {
                    saveTimeSetting(180);
                  },
                  text: "03:00",
                  selected: GlobalSetting.seconds == 180,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  backColor: Colors.greenAccent,
                  selectedColor: Colors.cyan,
                ),
                ItemSetting(
                  onTap: () {
                    saveTimeSetting(300);
                  },
                  text: "05:00",
                  selected: GlobalSetting.seconds == 300,
                  width: 150,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  backColor: Colors.greenAccent,
                  selectedColor: Colors.cyan,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
