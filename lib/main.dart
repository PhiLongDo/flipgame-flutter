import 'dart:io';

import 'package:flipgame/settings/settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ad_helper.dart';
import 'commons/commons.dart';
import 'game_play/game_play_main_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Google Mobile Ads SDK
  await MobileAds.instance.initialize();
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
        home: MyHomePage(),
        builder: (BuildContext context, Widget? child) {
          return FlutterSmartDialog(child: child);
        });
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String lv = '';
  String type = '';

  // NativeAd instance
  late NativeAd _nativeAd;
  bool _isAdLoaded = false;

  Future<void> readSetting() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      lv = (prefs.getString("level") ?? "lv3x4");
      GlobalSetting.setLevel(lv);
      type = (prefs.getString("type") ?? "infinity");
      GlobalSetting.setType(type);
    });
  }

  void _showSetting(Widget child) {
    SmartDialog.show(
      alignmentTemp: Alignment.center,
      clickBgDismissTemp: true,
      maskColorTemp: Colors.black87,
      widget: child,
    );
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    readSetting();
    // TODO: Create a NativeAd instance
    _nativeAd = NativeAd(
      adUnitId: AdHelper.nativeAdUnitId,
      factoryId: 'listTile',
      request: AdRequest(),
      listener: NativeAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isAdLoaded = true;
          });
        },
        onAdFailedToLoad: (ad, error) {
          // Releases an ad resource when it fails to load
          ad.dispose();
          print('Ad load failed (code=${error.code} message=${error.message})');
        },
      ),
    );
    _nativeAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (SmartDialog.instance.config.isExist) {
          SmartDialog.dismiss();
          return false;
        }
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, "play"),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 10.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 50.0, horizontal: 45.0),
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
                      onTap: () => _showSetting(SelectLevelScreen()),
                      //Navigator.pushNamed(context, "levels"),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
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
                      onTap: () => _showSetting(SelectTypeScreen()),
                      //Navigator.pushNamed(context, "types"),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 5.0),
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
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
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 30.0),
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
              SizedBox(
                child: _isAdLoaded ? AdWidget(ad: _nativeAd) : Container(),
                height: 72.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    _nativeAd.dispose();
    super.dispose();
  }
}
