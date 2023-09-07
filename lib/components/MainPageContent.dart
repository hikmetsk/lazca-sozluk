import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lazca_sozluk/components/InfoButton.dart';
import 'package:lazca_sozluk/components/SearchPage.dart';
import 'package:lazca_sozluk/components/SunImage.dart';
import 'package:lazca_sozluk/components/ToggleLetters/ToggleLettersMobile.dart';
import 'package:lazca_sozluk/components/WelcomeText.dart';
import 'package:lazca_sozluk/components/WelcomeText/BirdImage.dart';

class MainPageContent extends StatelessWidget {
  const MainPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const SunImage(),
        const WelcomeText(),
        const InfoButton(),
        const SearchPage(),
        const BirdImage(),
        if (defaultTargetPlatform == TargetPlatform.iOS ||
            defaultTargetPlatform == TargetPlatform.android)
          const ToggleLettersMobile(),
      ],
    );
  }
}
