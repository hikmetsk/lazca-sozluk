import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:provider/provider.dart';

class WelcomeTextText extends StatelessWidget {
  const WelcomeTextText({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Selector<SearchModel, bool>(
      selector: (_, model) => model.searchbarRaised,
      builder: (_, searchbarRaised, child) {
        return AnimatedOpacity(
            opacity: searchbarRaised ? 0 : 1,
            duration: const Duration(milliseconds: 100),
            child: child!);
      },
      child: SizedBox(
        height: screenSize.height * 0.18,
        child: Column(children: [
          Expanded(
            flex: 59,
            child: FittedBox(
              child: Text("Lazca",
                  style: GoogleFonts.lobster(
                      color: Theme.of(context).colorScheme.primary)),
            ),
          ),
          Expanded(
            flex: 41,
            child: FittedBox(
              child: Text(
                "sözlük",
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSurface),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
