import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuwo/src/scenes/scenes.dart';
import 'package:nuwo/src/values/colors.dart';
import 'package:nuwo/src/values/strings.dart';

void main() => runApp(NuWoApp());

class NuWoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: LightGreen,
    ));
    return MaterialApp(
      title: Strings.applicationName,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: LightGreen,
        fontFamily: 'WorkSans',
      ),
      home: HomeScene(title: 'Main Page'),
    );
  }
}
