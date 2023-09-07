import 'package:flutter/material.dart';
import 'package:lazca_sozluk/entities/Word.dart';
import 'package:lazca_sozluk/components/ModalBottomSheet/ModalBottomSheetContent.dart';

class ModalBottomSheet extends StatelessWidget {
  final Word word;
  final BuildContext context;

  const ModalBottomSheet({super.key, required this.word, required this.context});

  @override
  Widget build(BuildContext _) {
    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 650),
        child: Stack(
          alignment: Alignment.topCenter,
          fit: StackFit.expand,
          children: [
            ModalBottomSheetContent(word: word, context: context),
            Positioned(
              right: 12,
              top: 12,
              child: Material(
                color: Colors.transparent,
                child: IconButton(
                    splashRadius: 22,
                    iconSize: 30,
                    color: Theme.of(context).primaryColor,
                    onPressed: () {},
                    icon: const Icon(Icons.volume_up)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
