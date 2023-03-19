import 'dart:io';

class AdHelper {
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-5199311768438403/7451340682";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
