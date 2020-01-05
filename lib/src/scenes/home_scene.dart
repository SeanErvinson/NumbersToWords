import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nuwo/src/bloc/bloc.dart';
import 'package:nuwo/src/models/number_word.dart';
import 'package:nuwo/src/values/values.dart';

class HomeScene extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _usableScreenHeight =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<WordBloc, NumberWord>(
          builder: (context, state) {
            return Column(
              children: <Widget>[
                Container(
                  height: _usableScreenHeight / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          IconButton(
                              color: Colors.white,
                              icon: Icon(Icons.help),
                              onPressed: () =>
                                  Navigator.pushNamed(context, "about")),
                          ChequeSwitch(state),
                        ],
                      ),
                      TitleHeader(
                          title: Strings.headerNumber, color: Colors.white),
                      Flexible(
                        flex: 1,
                        child: NumberInputField(),
                      ),
                    ],
                  ),
                  color: LightGreen,
                ),
                Container(
                  height: _usableScreenHeight / 2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
                  child: Column(
                    children: <Widget>[
                      TitleHeader(title: Strings.headerWord, color: LightGreen),
                      Flexible(
                        flex: 1,
                        child: WordResultField(state.output),
                      ),
                    ],
                  ),
                  color: Colors.white,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class WordResultField extends StatelessWidget {
  final String output;

  const WordResultField(this.output);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AutoSizeText(
        output,
        style: inputTextStyle(LightGreen),
        minFontSize: 16.0,
        maxLines: 5,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }
}

class ChequeSwitch extends StatelessWidget {
  final NumberWord result;
  ChequeSwitch(this.result);
  void convertOutput(BuildContext context, NumberWord word) {
    final wordBloc = BlocProvider.of<WordBloc>(context);
    if (!word.chequeMode) {
      wordBloc.add(ConvertNormalFormat(word.input));
    } else {
      wordBloc.add(ConvertChequeFormat(word.input));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(
          Strings.chequeMode,
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        Switch(
            value: result.chequeMode,
            activeColor: Colors.white,
            onChanged: (value) {
              convertOutput(context, result);
            }),
      ],
    );
  }
}

class TitleHeader extends StatelessWidget {
  const TitleHeader({
    Key key,
    @required this.title,
    @required this.color,
  }) : super(key: key);

  final String title;
  final Color color;

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

class NumberInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextField(
        style: inputTextStyle(Colors.white),
        textInputAction: TextInputAction.done,
        onChanged: (value) => setWordText(context, value),
        textAlign: TextAlign.center,
        maxLines: 2,
        inputFormatters: <TextInputFormatter>[
          WhitelistingTextInputFormatter.digitsOnly
        ],
        cursorColor: Colors.white,
        keyboardType: TextInputType.number,
        decoration: InputDecoration.collapsed(hintText: null),
        cursorWidth: 5,
      ),
    );
  }

  void setWordText(BuildContext context, String value) {
    final wordBloc = BlocProvider.of<WordBloc>(context);
    wordBloc.add(ParseInput(value));
  }
}

TextStyle inputTextStyle(color) {
  return TextStyle(
    fontWeight: FontWeight.w700,
    color: color,
    fontSize: 48,
  );
}
