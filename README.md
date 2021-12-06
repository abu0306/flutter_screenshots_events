# flutter_screenshots

禁用Android截屏、监听iOS截屏的一个插件

## Getting Started

android 禁用截屏:
```dart
FlutterScreenshots.disableScreenshots(true);
```

监听iOS事件
```dart
FlutterScreenshots.statusStream?.listen((event) {
    setState(() {
        _message = event.toString();
    });
});
```

