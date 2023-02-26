import 'dart:io';

class AdHelper {
  static String get nativeAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-1639646276807467/6807191129";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }
}
