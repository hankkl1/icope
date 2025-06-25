import 'package:flutter/services.dart';

class YoutubeLauncher {
  static const MethodChannel _channel =
  MethodChannel('com.example.youtube/launcher');

  static Future<void> openYoutubeUrl(String url) async {
    try {
      await _channel.invokeMethod('launchYoutubeUrl', {
        'url': url,
      });
    } on PlatformException catch (e) {
      print('開啟 YouTube 網址失敗：${e.message}');
    }
  }
}