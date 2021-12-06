import 'package:flutter/material.dart';
import 'package:flutter_screenshot_events/flutter_screenshot_events.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _message = "";

  @override
  void initState() {
    super.initState();
    if (mounted) {
      FlutterScreenshotEvents.disableScreenshots(true);

      FlutterScreenshotEvents.statusStream?.listen((event) {
        setState(() {
          _message = event.toString();
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_message'),
        ),
      ),
    );
  }
}
