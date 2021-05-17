import 'package:flipgame/commons/commons.dart';
import 'package:flipgame/settings/item_setting.dart';
import 'package:flutter/material.dart';

class SelectLevelScreen extends StatefulWidget {
  @override
  _SelectLevelScreenState createState() => _SelectLevelScreenState();
}

class _SelectLevelScreenState extends State<SelectLevelScreen> {
  void _select(GamePlayLevels level) {
    setState(() {
      GlobalSetting.level = level;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ItemSetting(
                  onTap: () => _select(GamePlayLevels.lv3x4),
                  text: "Level (3x4)",
                  selected: GlobalSetting.level == GamePlayLevels.lv3x4),
              ItemSetting(
                  onTap: () => _select(GamePlayLevels.lv4x5),
                  text: "Level (4x5)",
                  selected: GlobalSetting.level == GamePlayLevels.lv4x5),
              ItemSetting(
                  onTap: () => _select(GamePlayLevels.lv5x6),
                  text: "Level (5x6)",
                  selected: GlobalSetting.level == GamePlayLevels.lv5x6),
              ItemSetting(
                  onTap: () => _select(GamePlayLevels.lv6x7),
                  text: "Level (6x7)",
                  selected: GlobalSetting.level == GamePlayLevels.lv6x7),
            //   ItemSetting(
            //       onTap: () => _select(GamePlayLevels.lv7x8),
            //       text: "Level (7x8)",
            //       selected: GlobalSetting.level == GamePlayLevels.lv7x8),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: () { Navigator.pop(context);},
        child: Text("Back"),
      ),
    );
  }
}
