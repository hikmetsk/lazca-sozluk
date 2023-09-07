import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:provider/provider.dart';

class JumpingBird extends StatefulWidget {
  const JumpingBird({super.key});

  @override
  State<JumpingBird> createState() => _JumpingBirdState();
}

class _JumpingBirdState extends State<JumpingBird> {
  bool jumped = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return SizedBox.square(
      dimension: screenSize.height * 0.085,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedPositioned(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 300),
            bottom: jumped ? 10 : 0,
            onEnd: () => setState(() => jumped = false),
            child: Selector<SearchModel, double>(
              selector: (_, model) => model.birdScaleX,
              builder: (_, birdScaleX, child) {
                return Transform.scale(
                  scaleX: birdScaleX,
                  child: child,
                );
              },
              child: Listener(
                onPointerDown: (event) => setState(() => jumped = true),
                child: SvgPicture.asset(
                  height: screenSize.height * 0.085,
                  "assets/bird.svg",
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
