import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rounded_corners/rounded_corners.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ScreenRoundedCorners? _screenRoundedCorners;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    final screenRoundedCorners = await RoundedCorners.getRoundedCorners();

    setState(() {
      _screenRoundedCorners = screenRoundedCorners;
    });
  }

  @override
  Widget build(BuildContext context) {
    print("LINH: ${_screenRoundedCorners?.topLeft?.radius ?? 0}");
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('TopLeft: ${_screenRoundedCorners?.topLeft?.radius ?? 0}\nTopRight: ${_screenRoundedCorners?.topRight?.radius ?? 0}\nBottomLeft: ${_screenRoundedCorners?.bottomLeft?.radius ?? 0}\nBottomRight: ${_screenRoundedCorners?.bottomRight?.radius ?? 0}'),
        ),
      ),
    );
  }
}
