import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nuwo/utils/conversion.dart';
import 'package:nuwo/values/colors.dart';
import 'package:nuwo/values/strings.dart';

import 'package:auto_size_text/auto_size_text.dart';

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

class BaseHeader extends StatelessWidget {
  final color;
  final title;

  const BaseHeader({Key key, this.color, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 40,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}

class _MainPageState extends State<MainPage> {
  final _numberController = TextEditingController();
  String resultWord = '';

  setWordText(String content) {
    setState(() {
      if (content.length > 19)
        resultWord = Strings.numberErrorOutput;
      else
        resultWord = Conversion.parseWord(content);
    });
  }

  TextStyle inputTextStyle(color) {
    return TextStyle(
      fontWeight: FontWeight.w700,
      color: color,
      fontSize: 48,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
          child: ListView(
        children: <Widget>[
          Container(
            height: 96.0,
            child: DrawerHeader(
              child: Text("Hello"),
            ),
          ),
          ListTile(
            title: Text("About Me"),
            leading: Icon(Icons.person),
          ),
          ListTile(
            title: Text("Cheque Mode"),
            trailing: Switch(
              value: false, onChanged: (bool value) {print(value);},
            ),
          )
        ],
      )),
      body: SafeArea(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 48, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      BaseHeader(
                          color: Colors.white, title: Strings.headerNumber),
                      Expanded(
                        child: Center(
                          child: TextField(
                            style: inputTextStyle(Colors.white),
                            controller: _numberController,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            onChanged: (content) {
                              setWordText(content);
                            },
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration.collapsed(hintText: null),
                            cursorWidth: 5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: LightGreen,
                ),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      BaseHeader(color: LightGreen, title: Strings.headerWord),
                      Expanded(
                        child: Center(
                          child: AutoSizeText(
                            resultWord,
                            style: inputTextStyle(LightGreen),
                            minFontSize: 16.0,
                            maxLines: 5,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
