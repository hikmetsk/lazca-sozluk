import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/entities/Word.dart';
import 'package:lazca_sozluk/components/ModalBottomSheet/ModalBottomSheetListItem.dart';
import 'package:provider/provider.dart';

class ModalBottomSheetContent extends StatelessWidget {
  final Word word;
  final BuildContext context;

  const ModalBottomSheetContent({super.key, required this.word, required this.context});

  @override
  Widget build(BuildContext _) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5)),
      margin: const EdgeInsets.fromLTRB(10, 15, 10, 0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Text(word.getWord(),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)
                ),
            const SizedBox(height: 25),
            FutureBuilder(
              future: Provider.of<SearchModel>(context, listen: false)
                  .searchDetails(word.getMeaningsList()),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: [
                      ModalBottomSheetListItem(data: snapshot.data ?? [])
                    ],
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
