import 'package:equatable/equatable.dart';
import 'package:lazca_sozluk/entities/Example.dart';

class Word extends Equatable {
  final String _word;
  final List _meanings;
  final List<Example> _examples;

  Word(this._word, this._meanings, this._examples);

  String getWord() {
    return _word;
  }

  String getMeanings() {
    return _meanings.join("; ");
  }

  List getMeaningsList() {
    return _meanings;
  }

  List<Example> getExamples() {
    return _examples;
  }

  @override
  List<Object> get props => [_word, _meanings, _examples];
}
