import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:provider/provider.dart';

class ToggleLettersTextButton extends StatelessWidget {
  final String _letter;

  const ToggleLettersTextButton(this._letter, {super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: TextButton.styleFrom(
            padding: const EdgeInsets.all(13),
            backgroundColor: Theme.of(context).colorScheme.tertiary,
            shape: const ContinuousRectangleBorder()),
        onPressed: () {
          SearchModel searchModel =
              Provider.of<SearchModel>(context, listen: false);
          String txt = searchModel.searchTextController.text;
          int cursorIndex =
              searchModel.searchTextController.selection.extentOffset;
          String updatedText =
              txt.replaceRange(cursorIndex, cursorIndex, _letter);

          searchModel.updateTextEditValue(updatedText, cursorIndex + 1);
          searchModel.onSearchTextChanged();
          searchModel.searchbarFocus.requestFocus();
        },
        child: Text(
          _letter,
          style: TextStyle(color: Theme.of(context).colorScheme.onTertiary),
        ));
  }
}
