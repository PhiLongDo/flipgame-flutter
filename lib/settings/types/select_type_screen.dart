import 'package:flipgame/commons/commons.dart';
import 'package:flipgame/settings/item_setting.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ItemSetting(
            onTap: () => _select(GamePlayTypes.infinity),
            text: "Infinity",
            selected: GlobalSetting.type == GamePlayTypes.infinity),
        ItemSetting(
            onTap: () => _select(GamePlayTypes.timeLimit),
            text: "Time limit",
            selected: GlobalSetting.type == GamePlayTypes.timeLimit),
        // Visibility(
        //   visible: GlobalSetting.type == GamePlayTypes.timeLimit,
        //     child: Row(children: [Text("seconds:"), Container(width: 100, child: TextField()),Text(formatMMSS(GlobalSetting.seconds))],)),
      ],
    );
  }
}
