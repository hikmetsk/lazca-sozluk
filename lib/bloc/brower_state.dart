import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:lazca_sozluk/entities/Word.dart';

enum BrowserStatus { initial, searching, success, failure }

enum SearchLang {
  lazToTurkish("lazca-turkce"),
  turkishToLaz("turkce-lazca");

  final String value;
  const SearchLang(this.value);
}

class BrowserState extends Equatable {
  static FirebaseFirestore db = FirebaseFirestore.instance;
  final SearchLang searchLang;
  final BrowserStatus status;
  final String lastSearchedText;
  final String text;
  final List<Word> results;
  final List<Word> filteredResults;
  late final TextEditingController textEditingController;
  late final FocusNode focusNode;

  BrowserState(
      {textEditingController,
      focusNode,
      this.searchLang = SearchLang.lazToTurkish,
      this.lastSearchedText = "<^|~>",
      this.status = BrowserStatus.initial,
      this.text = "",
      this.results = const <Word>[],
      this.filteredResults = const <Word>[]})
      : textEditingController =
            textEditingController ?? TextEditingController(),
        focusNode = focusNode ?? FocusNode();

  BrowserState copyWith(
      {BrowserStatus? status,
      SearchLang? searchLang,
      String? lastSearchedText,
      String? text,
      List<Word>? results,
      List<Word>? filteredResults}) {
    return BrowserState(
        textEditingController: textEditingController,
        focusNode: focusNode,
        searchLang: searchLang ?? this.searchLang,
        lastSearchedText: lastSearchedText ?? this.lastSearchedText,
        status: status ?? this.status,
        text: text ?? this.text,
        results: results ?? this.results,
        filteredResults: filteredResults ?? this.filteredResults);
  }

  @override
  List<Object> get props =>
      [searchLang, status, lastSearchedText, text, filteredResults, results];
}
