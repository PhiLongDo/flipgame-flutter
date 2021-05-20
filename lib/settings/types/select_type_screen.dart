import 'package:flipgame/commons/commons.dart';
import 'package:flipgame/settings/item_setting.dart';
import 'package:flutter/material.dart';

class SelectTypeScreen extends StatefulWidget {
  @override
  _SelectTypeScreenState createState() => _SelectTypeScreenState();
}

class _SelectTypeScreenState extends State<SelectTypeScreen> {
  void _select(GamePlayTypes type) {
    setState(() {
      GlobalSetting.type = type;
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
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Text("Back"),
      ),
    );
  }
}
