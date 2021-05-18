import 'dart:async';

import 'package:flipgame/commons/commons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TimeCounter extends StatefulWidget {
  final VoidCallback onStart;
  final VoidCallback onTimeout;

  const TimeCounter({Key? key, required this.onTimeout, required this.onStart})
      : super(key: key);

  @override
  _TimeCounterState createState() => _TimeCounterState();
}

class _TimeCounterState extends State<TimeCounter> {
  int _seconds = 300;

  // late Timer _timer;
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
        if (GlobalSetting.timeCounter == 0) {
          timer.cancel();
          widget.onTimeout();
          setState(() {
            _isPlaying = false;
          });
          if (GlobalSetting.itemCountDown != 0) {
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("You close!"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: Text("OK"),
                      )
                    ],
                  );
                });
          }
        } else {
          setState(() {
            GlobalSetting.timeCounter--;
          });
        }
      },
    );
  }

  String _formatMMSS() {
    String str = "";
    int minutes = GlobalSetting.timeCounter ~/ 60;
    str = ("0" + minutes.toString()).substring(minutes.toString().length - 1);
    int seconds = GlobalSetting.timeCounter % 60;
    str = str +
        ":" +
        ("0" + seconds.toString()).substring(seconds.toString().length - 1);
    return str;
  }

  @override
  void initState() {
    GlobalSetting.timeCounter = _seconds;
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
              _formatMMSS(),
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              if (_isPlaying) {
                GlobalSetting.timer.cancel();
                widget.onStart();
                setState(() {
                  _isPlaying = false;
                });
                return;
              }
              startTimer();
            },
            child: Text(_isPlaying ? "Pause" : "Start"),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    GlobalSetting.timer.cancel();
    super.dispose();
  }
}
