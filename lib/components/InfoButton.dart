import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/components/InfoButton/DialogContent.dart';
import 'package:provider/provider.dart';

class InfoButton extends StatelessWidget {
  const InfoButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<SearchModel, bool>(
      selector: (_, model) => model.searchbarRaised,
      builder: (_, searchbarRaised, child) {
        if (searchbarRaised) {
          return const Align();
        } else {
          return child!;
        }
      },
      child: Positioned(
          top: 15,
          right: 20,
          child: IconButton(
              iconSize: 30,
              icon: Icon(
                Icons.info_outline,
                color: Theme.of(context).colorScheme.onSurface,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const DialogContent();
                  },
                );
              })),
    );
  }
}
