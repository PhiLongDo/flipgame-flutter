import 'dart:io';

import 'package:flipgame/settings/settings.dart';
import 'package:flutter/material.dart';

import 'game_play/game_play_main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lật hình',
      routes: {
        'play': (context) => GamePlayMainScreen(),
        'types': (context) => SelectTypeScreen(),
        'levels': (context) => SelectLevelScreen(),
      },
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "play"),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 50.0, horizontal: 45.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100.0),
                    color: Colors.greenAccent,
                  ),
                  child: Text(
                    "Play",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 42,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "levels"),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.cyanAccent,
                  ),
                  child: Text(
                    "Levels",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, "types"),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.indigoAccent,
                  ),
                  child: Text(
                    "Types",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Exit"),
                          content: Text("Do you want exit app?"),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("No"),
                            ),
                            TextButton(
                              onPressed: () => exit(0),
                              child: Text("Yes"),
                            ),
                          ],
                        );
                      });
                },
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0),
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: Colors.grey,
                  ),
                  child: Text(
                    "Exit",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.brown,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
