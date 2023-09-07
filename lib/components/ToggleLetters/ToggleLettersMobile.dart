import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/components/ToggleLetters/ToggleLettersTextButton.dart';
import 'package:provider/provider.dart';

class ToggleLettersMobile extends StatefulWidget {
  const ToggleLettersMobile({super.key});

  @override
  State<ToggleLettersMobile> createState() => _ToggleLettersMobileState();
}

class _ToggleLettersMobileState extends State<ToggleLettersMobile> {
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

  bool isSearchbarFocused = false;

  @override
  void initState() {
    super.initState();
    FocusNode focusNode = context.read<SearchModel>().searchbarFocus;
    focusNode.addListener(() {
      setState(() => isSearchbarFocused = focusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return isSearchbarFocused
        ? Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 50,
              color: Theme.of(context).colorScheme.tertiary,
              child: ListView.separated(
                  separatorBuilder: (context, index) => const VerticalDivider(
                        color: Colors.black,
                        width: 0,
                        endIndent: 10,
                        indent: 10,
                      ),
                  scrollDirection: Axis.horizontal,
                  itemCount: letters.length,
                  itemBuilder: (context, index) {
                    String letter = letters[index];
                    return ToggleLettersTextButton(letter);
                  }),
            ),
          )
        : const Align();
  }
}
