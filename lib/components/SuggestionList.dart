import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lazca_sozluk/bloc/brower_state.dart';
import 'package:lazca_sozluk/bloc/browser_bloc.dart';
import 'package:lazca_sozluk/components/SuggestionList/ListItem.dart';
import 'package:lazca_sozluk/entities/Word.dart';

class SuggestionList extends StatelessWidget {
  const SuggestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrowserBloc, BrowserState, BrowserStatus>(
      selector: (state) => state.status,
      builder: (_, state) {
        return AnimatedOpacity(
            opacity: state == BrowserStatus.initial ? 0 : 1,
            duration: const Duration(milliseconds: 300),
            child: const SearchList());
      },
    );
  }
}

class SearchList extends StatelessWidget {
  const SearchList({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 20, 10, 60),
      child: BlocSelector<BrowserBloc, BrowserState, BrowserStatus>(
        selector: (state) => state.status,
        builder: (context, state) {
          if (state == BrowserStatus.searching) {
            return Padding(
              padding: EdgeInsets.only(top: screenSize.height * 0.05),
              child: const CircularProgressIndicator(),
            );
          } else {
            return const SearchResults();
          }
        },
      ),
    );
  }
}

class SearchResults extends StatelessWidget {
  const SearchResults({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<BrowserBloc, BrowserState, List<Word>>(
      selector: (state) => state.filteredResults,
      builder: (context, state) {
        return ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ListItem(index: index);
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: state.length);
      },
    );
  }
}