import 'package:flutter/material.dart';

class DialogContent extends StatelessWidget {
  const DialogContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: const Icon(Icons.info_outline),
      contentPadding: const EdgeInsets.all(25),
      children: [
        const Text(
            textAlign: TextAlign.center,
            "Laz alfabesindeki harfleri kullanabilmek için klavyenizde halihazırda var olan harflerin yanına \".\" eklemeniz yeterli"),
        const SizedBox(height: 15),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                dialogContentListItem("p", "\u024d"),
                dialogContentListItem("c", "ç"),
                dialogContentListItem("ç", "\u024b"),
                dialogContentListItem("g", "ğ"),
                dialogContentListItem("s", "ş"),
              ],
            ),
            Column(
              children: [
                dialogContentListItem("t", "ť"),
                dialogContentListItem("z", "ż"),
                dialogContentListItem("k", "ǩ"),
                dialogContentListItem("e", "\u024f"),
                dialogContentListItem("\u024f", "ǯ"),
              ],
            )
          ],
        )
      ],
    );
  }

  Row dialogContentListItem(String char1, String char2) {
    return Row(
      children: [
        Text("$char1. "),
        const Icon(Icons.arrow_forward),
        Text(" $char2")
      ],
    );
  }
}
