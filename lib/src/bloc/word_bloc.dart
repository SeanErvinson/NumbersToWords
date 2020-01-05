import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:nuwo/src/models/number_word.dart';
import 'package:nuwo/src/utils/cheque_utils.dart';
import './bloc.dart';
import 'package:nuwo/src/utils/conversion.dart';

class WordBloc extends Bloc<WordEvent, NumberWord> {
  @override
  NumberWord get initialState => NumberWord("", "", false);

  @override
  Stream<NumberWord> mapEventToState(
    WordEvent event,
  ) async* {
    if (event is ParseInput) {
      var result = Conversion.parseWord(event.input);
      yield NumberWord(event.input, result, state.chequeMode);
    }
    if (event is WordEvent) {
      var result = Conversion.parseWord(event.input);
      if (event is ConvertChequeFormat) {
        result = ChequeUtils.toNormalFormat(result);
        yield NumberWord(event.input, result, false);
      } else if (event is ConvertNormalFormat) {
        result = ChequeUtils.toChequeFormat(result);
        yield NumberWord(event.input, result, true);
      }
    }
  }
}
