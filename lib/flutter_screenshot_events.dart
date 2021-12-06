import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FlutterScreenshotEvents {
  static const MethodChannel _channel = MethodChannel('flutter_screenshots');
  static const EventChannel _eventChannel =
  EventChannel('flutter_screenshots/event');

  /// 监听iOS录屏截屏事件
  static Stream? get statusStream {
    if (Platform.isIOS) {
      return _eventChannel.receiveBroadcastStream();
    } else {
      debugPrint('only support of iOS');
      return null;
    }
  }

  ///禁用Android手机截屏
  static Future<void> disableScreenshots(bool disable) async {
    if (Platform.isAndroid) {
      return await _channel
          .invokeMethod("disableScreenshots", {"disable": disable});
    } else {
      debugPrint('only support of Android');
    }
  }
}
