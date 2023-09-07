import 'package:flutter/material.dart';
import 'package:lazca_sozluk/components/WelcomeText/WelcomeTextText.dart';
import 'package:lazca_sozluk/config.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Positioned(
      top: MyElements.welcomeText.top * screenSize.height,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxHeight: 500),
        child: const WelcomeTextText(),
      ),
    );
  }
}
