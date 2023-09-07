import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazca_sozluk/bloc/brower_state.dart';
import 'package:lazca_sozluk/bloc/browser_event.dart';
import 'package:lazca_sozluk/entities/Word.dart';

const Map<String, String> unicodeLetters = {
  "p": "\u024d",
  "P": "\u024c",
  "c": "ç",
  "C": "Ç",
  "ç": "\u024b",
  "Ç": "\u024a",
  "t": "ť",
  "T": "Ť",
  "k": "ǩ",
  "K": "Ǩ",
  "z": "ż",
  "Z": "Ż",
  "e": "\u024f",
  "E": "\u024e",
  "\u024f": "ǯ",
  "\u024e": "Ǯ",
  "s": "ş",
  "S": "Ş",
  "g": "ğ",
  "G": "Ğ",
};

class BrowserBloc extends Bloc<BrowserEvent, BrowserState> {
  BrowserBloc(BrowserState initialState) : super(initialState) {
    on<BrowserNewLetterTyped>(_newLetterTyped);
    on<BrowserSearchLangChanged>(_changeSearchLang);
  }

  void _changeSearchLang(event, emit) {
    SearchLang searchLang = state.searchLang == SearchLang.lazToTurkish
        ? SearchLang.turkishToLaz
        : SearchLang.lazToTurkish;

    emit(state.copyWith(
        searchLang: searchLang,
        lastSearchedText: "<^|~>",
        filteredResults: []));
    search(state.textEditingController.text, emit);
  }

  void _newLetterTyped(event, emit) async {
    TextEditingController searchTextController = state.textEditingController;
    String txt = searchTextController.text;
    if (txt.length >= 2) {
      int cursorIndex = searchTextController.selection.extentOffset;
      String rawLetter = txt[cursorIndex - 2];
      String addition = txt[cursorIndex - 1];

      // SEARCH'e yollamadan unicode çevirilmesi gereken bir yer varsa çevir
      if (addition == "." && unicodeLetters.containsKey(rawLetter)) {
        String updatedText = txt
            .replaceRange(cursorIndex - 1, cursorIndex, "")
            .replaceRange(
                cursorIndex - 2, cursorIndex - 1, unicodeLetters[rawLetter]!);

        updateTextEditValue(updatedText, cursorIndex - 1);

        // Controller'da güncellenen değeri local variable'ımıza da alalım
        txt = searchTextController.text;
      }

      // #SEARCH#
      if (txt.startsWith(state.lastSearchedText)) {
        print("+" + txt);
        print("-" + state.lastSearchedText);
        emit(state.copyWith(
            filteredResults: state.results
                .where((Word word) => word.getWord().contains(txt))
                .toList()));
      } else {
        await search(txt, emit);
      }
    } else if (txt.isEmpty) {
      emit(state.copyWith(filteredResults: []));
    }
  }

  Future<void> search(String value, emit) async {
    String lowerValue = value.toLowerCase();
    emit(state.copyWith(status: BrowserStatus.searching));

    await BrowserState.db
        .collection(state.searchLang.value)
        .where('word', isGreaterThanOrEqualTo: lowerValue)
        .where('word', isLessThanOrEqualTo: "$lowerValue\uf8ff")
        .get()
        .then((data) {
      List<Word> results = data.docs.map((doc) {
        Map<String, dynamic> dataMap = doc.data();
        List meanings = List.from(dataMap["meanings"])
            .map((map) => map["meaning"])
            .toList();
        return Word(dataMap["word"], meanings, const []);
      }).toList();
      emit(state.copyWith(
          results: results,
          filteredResults: [...results],
          status: BrowserStatus.success,
          lastSearchedText: lowerValue));
    });
  }

  void updateTextEditValue(String updatedText, int offset) {
    TextEditingController searchTextController = state.textEditingController;
    searchTextController.value = searchTextController.value.copyWith(
        text: updatedText, selection: TextSelection.collapsed(offset: offset));
  }
}
