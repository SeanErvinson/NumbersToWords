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

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _numberController = TextEditingController();
  bool _chequeMode = false;
  String resultWord = '';

  @override
  void initState() {
    super.initState();
    _numberController.addListener(setWordText);
  }

  @override
  void dispose() {
    _numberController.dispose();
    super.dispose();
  }

  setWordText() {
    var content = _numberController.text;
    setState(() {
      if (content.length > 19)
        resultWord = Strings.numberErrorOutput;
      else {
        resultWord = Conversion.parseWord(content);
        resultWord = _chequeMode
            ? ChequeUtils.toChequeFormat(resultWord)
            : ChequeUtils.toNormalFormat(resultWord);
      }
    });
  }

  Widget baseHeader(title, color) {
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
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.help),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => AboutPage()));
          },
        ),
        actions: <Widget>[
          Row(
            children: <Widget>[
              Text(
                'Cheque Mode',
                style: TextStyle(fontSize: 16, color: Colors.white),
              ),
              Switch(
                value: _chequeMode,
                activeColor: Colors.white,
                onChanged: (bool value) {
                  _chequeMode = value;
                  setWordText();
                },
              ),
            ],
          )
        ],
        backgroundColor: Colors.transparent,
      ),
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
                      baseHeader(Strings.headerNumber, Colors.white),
                      Expanded(
                        child: Center(
                          child: TextField(
                            style: inputTextStyle(Colors.white),
                            controller: _numberController,
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            inputFormatters: <TextInputFormatter>[
                              WhitelistingTextInputFormatter.digitsOnly
                            ],
                            cursorColor: Colors.white,
                            keyboardType: TextInputType.number,
                            decoration:
                                InputDecoration.collapsed(hintText: null),
                            cursorWidth: 5,
                            autofocus: true,
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
                      baseHeader(Strings.headerWord, LightGreen),
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
