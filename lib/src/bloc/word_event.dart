import 'package:meta/meta.dart';

@immutable
abstract class WordEvent {}

class ParseInput extends WordEvent {
  final String input;

  ParseInput(this.input);
}

class ConvertNormalFormat extends WordEvent {
  final String input;

  ConvertNormalFormat(this.input);
}

class ConvertChequeFormat extends WordEvent {
  final String input;

  ConvertChequeFormat(this.input);
}
