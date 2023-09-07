import 'package:flutter/material.dart';
import 'package:lazca_sozluk/entities/Word.dart';

class ModalBottomSheetListItem extends StatelessWidget {
  final List<Word> data;

  ModalBottomSheetListItem({required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: data.map((meaning) {
        return ListTile(
          leading: const Icon(
            Icons.subdirectory_arrow_right_rounded,
          ),
          title: Text(meaning.getWord(),
              style: Theme.of(context).textTheme.headlineSmall!),
          subtitle: Text(
            meaning.getMeanings(),
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        );
      }).toList(),
    );
  }
}
