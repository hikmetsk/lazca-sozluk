import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/components/WelcomeText/JumpingBird.dart';
import 'package:lazca_sozluk/config.dart';
import 'package:provider/provider.dart';

class BirdImage extends StatefulWidget {
  const BirdImage({super.key});

  @override
  State<BirdImage> createState() => _BirdImageState();
}

class _BirdImageState extends State<BirdImage> {
  double birdJump = 0;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    double birdPositionLeft(searchbarRaised) {
      double containerWidth = min(screenSize.width, 700);
      if (!searchbarRaised) {
        return containerWidth / 2 - screenSize.height * 0.095;
      } else {
        return containerWidth * 0.7;
      }
    }

    double birdPositionTop(searchbarRaised) {
      if (!searchbarRaised) {
        return screenSize.height * 0.206;
      } else {
        return screenSize.height * -0.3;
      }
    }

    return Selector<SearchModel, bool>(
        selector: (context, model) => model.searchbarRaised,
        builder: (context, searchbarRaised, child) {
          return AnimatedPositioned(
              duration: MyElements.birdSvg.duration,
              curve: Curves.easeOutSine,
              left: birdPositionLeft(searchbarRaised),
              top: birdPositionTop(searchbarRaised),
              child: child ?? const SizedBox());
        },
        child: const JumpingBird());
  }
}
