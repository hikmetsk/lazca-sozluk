import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'entities/Word.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SearchModel extends ChangeNotifier {
  static const Map<String, String> unicodeLetters = {
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
  List<Word> results = [];
  List<Word> filteredResults = [];
  bool detailsLoading = false;
  bool loading = false;
  bool loaded = false;
  bool searchbarRaised = false;
  FocusNode searchbarFocus = FocusNode();
  TextEditingController searchTextController = TextEditingController();
  String lastFetchedText = "<^|~>";
  double birdScaleX = 1;
  String searchLang = "lazca-turkce";

  static FirebaseFirestore db = FirebaseFirestore.instance;

  void onSearchTextChanged() {
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
      if (txt.startsWith(lastFetchedText)) {
        filteredResults =
            results.where((Word word) => word.getWord().contains(txt)).toList();
        notifyListeners();
      } else {
        search(txt);
      }
    } else if (txt.isEmpty) {
      filteredResults = [];
      notifyListeners();
    }
  }

  void updateTextEditValue(String updatedText, int offset) {
    searchTextController.value = searchTextController.value.copyWith(
        text: updatedText, selection: TextSelection.collapsed(offset: offset));
  }

  void changeSearchbarLang() {
    if (searchLang == "turkce-lazca") {
      searchLang = "lazca-turkce";
    } else {
      searchLang = "turkce-lazca";
    }

    lastFetchedText = "<^|~>";
    filteredResults = [];
    if (searchTextController.text.length >= 2) {
      search(searchTextController.text);
    }

    notifyListeners();
  }

  void search(String value) {
    String lowerValue = value.toLowerCase();
    setLoaded(false);
    setLoading(true);

    db
        .collection(searchLang)
        .where('word', isGreaterThanOrEqualTo: lowerValue)
        .where('word', isLessThanOrEqualTo: "$lowerValue\uf8ff")
        .get()
        .then((data) {
      results = data.docs.map((doc) {
        Map<String, dynamic> dataMap = doc.data();
        List meanings = List.from(dataMap["meanings"])
            .map((map) => map["meaning"])
            .toList();
        return Word(dataMap["word"], meanings, []);
      }).toList();
      filteredResults = [...results];
      lastFetchedText = lowerValue;
      setLoading(false);
      setLoaded(true);
    });
  }

  Future<List<Word>> searchDetails(List words) {
    setDetailsLoading(true);
    return db
        .collection(
            searchLang == "turkce-lazca" ? "lazca-turkce" : "turkce-lazca")
        .where("word", whereIn: words)
        .get()
        .then((data) {
      setDetailsLoading(false);
      List<Word> results = data.docs.map((doc) {
        Map<String, dynamic> dataMap = doc.data();
        List meanings = List.from(dataMap["meanings"])
            .map((map) => map["meaning"])
            .toList();
        return Word(dataMap["word"], meanings, []);
      }).toList();

      return results;
    });
  }

  Future<bool> onWillPop() async {
    if (!searchbarRaised) {
      return true;
    }

    birdScaleX = -1;
    searchbarFocus.unfocus();
    searchTextController.clear();
    reset();
    Timer(const Duration(seconds: 1), () {
      birdScaleX = 1;
      notifyListeners();
    });

    return false;
  }

  void setSearchBarRaised(bool searchBarRaised) {
    if (this.searchbarRaised != searchBarRaised) {
      this.searchbarRaised = searchBarRaised;
      notifyListeners();
    }
  }

  void setDetailsLoading(bool detailsLoading) {
    if (this.detailsLoading != detailsLoading) {
      this.detailsLoading = detailsLoading;
    }
  }

  void setLoading(bool loading) {
    if (this.loading != loading) {
      this.loading = loading;
      notifyListeners();
    }
  }

  void setLoaded(bool loaded) {
    if (this.loaded != loaded) {
      this.loaded = loaded;
      notifyListeners();
    }
  }

  void reset() {
    setLoading(false);
    setLoaded(false);
    setSearchBarRaised(false);
    results = [];
  }
}
