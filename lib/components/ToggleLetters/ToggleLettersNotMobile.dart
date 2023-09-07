import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/components/ToggleLetters/ToggleLettersTextButton.dart';
import 'package:provider/provider.dart';

class ToggleLettersNotMobile extends StatelessWidget {
  static const List<String> letters = [
    "\u024b",
    "\u024d",
    "ť",
    "ż",
    "ǩ",
    "\u024f",
    "ǯ",
    "ç",
    "ş",
    "ğ",
  ];

  const ToggleLettersNotMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      direction: Axis.horizontal,
      alignment: WrapAlignment.center,
      children: letters.map((letter) {
        return ToggleLettersTextButton(letter);
      }).toList(),
    );
  }
}
