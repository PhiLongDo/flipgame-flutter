import 'dart:io';

class AdHelper {
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-3940256099942544/2247696110'; // test unit
      return "ca-app-pub-5199311768438403/1124869742";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      // return 'ca-app-pub-3940256099942544/6300978111'; //test unit
      return "ca-app-pub-5199311768438403/1750150739";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
