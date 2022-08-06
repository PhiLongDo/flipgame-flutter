import 'dart:async';

import 'package:flipgame/commons/button_close_dialog.dart';
import 'package:flipgame/commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

class TimeCounter extends StatefulWidget {
  final VoidCallback onStart;
  final VoidCallback onTimeout;

  const TimeCounter({Key? key, required this.onTimeout, required this.onStart})
      : super(key: key);

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  bool _isPlaying = false;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    widget.onStart();
    setState(() {
      _isPlaying = true;
    });
    GlobalSetting.timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (GlobalSetting.timeCounter == 0 &&
            GlobalSetting.type == GamePlayTypes.timeLimit) {
          timer.cancel();
          widget.onTimeout();
          setState(() {
            _isPlaying = false;
          });
          if (GlobalSetting.itemCountDown != 0) {
            SmartDialog.show(
              alignmentTemp: Alignment.center,
              clickBgDismissTemp: false,
              maskColorTemp: Colors.black87,
              widget: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ButtonCloseDialog(onClose: () {
                    SmartDialog.dismiss();
                    Navigator.pop(context);
                  }),
                  Container(
                    width: 300,
                    margin: EdgeInsets.symmetric(vertical: 1.0),
                    padding:
                        EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Colors.white70,
                    ),
                    alignment: Alignment.center,
                    child: Text("You close!",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            );
          }
        } else {
          setState(() {
            if (GlobalSetting.type == GamePlayTypes.infinity) {
              GlobalSetting.timeCounter++;
              return;
            }
            GlobalSetting.timeCounter--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    (GlobalSetting.type == GamePlayTypes.timeLimit)
        ? GlobalSetting.timeCounter = GlobalSetting.seconds
        : GlobalSetting.timeCounter = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              formatMMSS(GlobalSetting.timeCounter),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 45,
            child: FloatingActionButton(
              backgroundColor: Colors.pinkAccent,
              onPressed: () {
                if (_isPlaying) {
                  GlobalSetting.timer!.cancel();
                  widget.onStart();
                  setState(() {
                    _isPlaying = false;
                  });
                  return;
                }
                startTimer();
              },
              child: Icon(
                _isPlaying
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
                size: 35,
              ),
              tooltip: _isPlaying ? "Pause" : "Start",
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    GlobalSetting.timer?.cancel();
    super.dispose();
  }
}
