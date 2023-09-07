import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/components/SearchBar.dart';
import 'package:lazca_sozluk/components/SuggestionList.dart';
import 'package:lazca_sozluk/config.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Selector<SearchModel, bool>(
      selector: (_, model) => model.searchbarRaised,
      builder: (context, searchbarRaised, child) {
        return AnimatedPositioned(
            left: 0,
            right: 0,
            bottom: 0,
            duration: MyElements.searchbar.duration,
            curve: Curves.ease,
            top: searchbarRaised
                ? MyElements.searchbar.after.top * screenSize.height
                : MyElements.searchbar.before.top * screenSize.height,
            child: child!);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 27),
        child: Column(
          children: const [SearchBar(), SuggestionList()],
        ),
      ),
    );
  }
}
