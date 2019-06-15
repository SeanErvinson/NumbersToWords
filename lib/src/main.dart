import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuwo/pages/about_page.dart';
import 'package:nuwo/utils/cheque_utils.dart';
import 'package:nuwo/utils/conversion.dart';
import 'package:nuwo/values/colors.dart';
import 'package:nuwo/values/strings.dart';

import 'package:auto_size_text/auto_size_text.dart';

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
      home: MainPage(title: 'Main Page'),
    );
  }
}