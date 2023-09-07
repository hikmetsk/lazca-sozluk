import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/config.dart';
import 'package:provider/provider.dart';

class SunImage extends StatelessWidget {
  const SunImage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    bool searchbarRaised =
        context.select<SearchModel, bool>((model) => model.searchbarRaised);
    return Selector<SearchModel, bool>(
      selector: (_, model) => model.searchbarRaised,
      builder: (_, searchbarRaised, child) {
        return AnimatedPositioned(
            duration: MyElements.sunSvg.duration,
            curve: Curves.ease,
            left: MyElements.sunSvg.left * screenSize.width,
            top: (searchbarRaised
                    ? MyElements.sunSvg.after.top
                    : MyElements.sunSvg.before.top) *
                screenSize.height,
            child: child!);
      },
      child: SizedBox.square(
          dimension: 100,
          child: SvgPicture.asset(
            "assets/sun.svg",
          )),
    );
  }
}
