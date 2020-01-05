import 'package:equatable/equatable.dart';

class NumberWord extends Equatable {
  final String output;
  final String input;
  final bool chequeMode;

  NumberWord(this.input, this.output, this.chequeMode);

  @override
  List<Object> get props => [output, input, chequeMode];
}
