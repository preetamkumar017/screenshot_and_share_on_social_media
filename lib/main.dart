import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ScreenshotController screenshotController;
  late File tempFile;
  @override
  void initState() {
    super.initState();
    screenshotController = ScreenshotController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Take Screenshot and Share'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Screenshot(
                controller: screenshotController,
                child: Container(
                  width: 200,
                  height: 200,
                  color: Colors.red,
                  child: Text("Preetam Sinha"),
                ),
              ),
              TextButton(
                onPressed: () {
                  takeScreenshot();
                },
                child: Text('Take Screenshot'),
              ),
              TextButton(
                onPressed: () {
                  shareScreenshot();
                },
                child: Text('Share Screenshot'),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Future<void> takeScreenshot() async {
    final image = await screenshotController.capture();
    final appDocumentsDir = await getApplicationDocumentsDirectory();
    tempFile = File('${appDocumentsDir.path}/screenshot.png');
    await tempFile.writeAsBytes(image!);
    print('Screenshot saved to ${tempFile.path}');
  }

  Future<void> shareScreenshot() async {
    if (tempFile != null) {
      await Share.shareFiles([tempFile.path]);
    }
  }
}