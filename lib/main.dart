import 'package:flutter/material.dart';
import 'package:nuwo/values/colors.dart';
import 'package:nuwo/values/strings.dart';

void main() => runApp(NuWoApp());

class NuWoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: Strings.applicationName,
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        canvasColor: Colors.white,
        fontFamily: 'WorkSans',
      ),
      home: MainPage(title: 'Main Page'),
    );
  }
}

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _numberController = TextEditingController();
  String resultWord = '';

  setWordText(String content) {
    setState(() {
      resultWord = content;
    });
  }

  Widget genericHeader(String title) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: headerTextStlye(),
      ),
    );
  }

  Widget darkGenericHeader(String title) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: darkHeaderTextStlye(),
      ),
    );
  }

  TextStyle headerTextStlye() {
    return TextStyle(
      color: Colors.white,
      fontSize: 32,
      fontWeight: FontWeight.w400,
    );
  }

  TextStyle darkHeaderTextStlye() {
    return TextStyle(
      color: LightGreen,
      fontSize: 32,
      fontWeight: FontWeight.w300,
    );
  }

  TextStyle darkInputTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: LightGreen,
      fontSize: 48,
    );
  }

  TextStyle inputTextStyle() {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: Colors.white,
      fontSize: 48,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Text("Gello"),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    genericHeader(Strings.headerNumber),
                    TextField(
                      style: inputTextStyle(),
                      controller: _numberController,
                      textAlign: TextAlign.center,
                      onChanged: (content) {
                        setWordText(content);
                      },
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.numberWithOptions(
                          signed: true, decimal: true),
                      decoration: InputDecoration.collapsed(),
                      autofocus: true,
                      cursorWidth: 5,
                    ),
                  ],
                ),
                color: LightGreen,
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    darkGenericHeader(Strings.headerWord),
                    Text(
                      resultWord,
                      textAlign: TextAlign.center,
                      style: darkInputTextStyle(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
