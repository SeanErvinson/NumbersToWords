import 'package:meta/meta.dart';

@immutable
abstract class WordEvent {
  final String input;

  WordEvent(this.input);
}

class ParseInput extends WordEvent {
  final String input;

  ParseInput(this.input) : super(input);
}

class ConvertNormalFormat extends WordEvent {
  final String input;

  ConvertNormalFormat(this.input) : super(input);
}

class ConvertChequeFormat extends WordEvent {
  final String input;

  ConvertChequeFormat(this.input) : super(input);
}
