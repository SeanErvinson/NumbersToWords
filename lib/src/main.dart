import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuwo/src/bloc/bloc.dart';
import 'package:nuwo/src/scenes/scenes.dart';
import 'package:nuwo/src/values/strings.dart';

void main() => runApp(NuWoApp());

class NuWoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.applicationName,
      theme: ThemeData(
        fontFamily: 'WorkSans',
      ),
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => WordBloc(),
        child: HomeScene(),
      ),
      routes: {
        "home": (context) => HomeScene(),
        "about": (context) => AboutScene()
      },
    );
  }
}
