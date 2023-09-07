import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/bloc/browser_bloc.dart';
import 'package:lazca_sozluk/bloc/browser_event.dart';
import 'package:lazca_sozluk/components/ToggleLetters/ToggleLettersNotMobile.dart';
import 'package:provider/provider.dart';

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    BrowserBloc browserBloc = context.read<BrowserBloc>();
    SearchModel searchModel = Provider.of<SearchModel>(context, listen: false);
    return AnimatedSize(
      alignment: Alignment.topCenter,
      duration: const Duration(milliseconds: 150),
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: const BorderRadius.all(Radius.circular(18))),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(17),
                color: Theme.of(context).colorScheme.secondaryContainer,
              ),
              child: TextField(
                  onChanged: (String value) =>
                      browserBloc.add(BrowserNewLetterTyped()),
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlignVertical: TextAlignVertical.center,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.text,
                  cursorColor:
                      Theme.of(context).colorScheme.onSecondaryContainer,
                  controller: browserBloc.state.textEditingController,
                  focusNode: browserBloc.state.focusNode,
                  enableSuggestions: false,
                  autocorrect: false,
                  textCapitalization: TextCapitalization.none,
                  onTap: () {
                    searchModel.setSearchBarRaised(true);
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                    border: InputBorder.none,
                    prefixIcon: Icon(
                        color:
                            Theme.of(context).colorScheme.onSecondaryContainer,
                        Icons.auto_stories),
                    suffixStyle: Theme.of(context).textTheme.labelLarge,
                    suffix: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(width: 5),
                        Selector<SearchModel, String>(
                          selector: (_, model) => model.searchLang,
                          builder: (_, searchLang, __) => Text(
                              searchLang == "turkce-lazca" ? "TR-LZ" : "LZ-TR"),
                        ),
                        const SizedBox(width: 5),
                        IconButton(
                            color: Theme.of(context)
                                .colorScheme
                                .onSecondaryContainer,
                            onPressed: () =>
                                browserBloc.add(BrowserSearchLangChanged()),
                            //onPressed: searchModel.changeSearchbarLang,
                            icon: const Icon(Icons.swap_horiz))
                      ],
                    ),
                  )),
            ),
            Selector<SearchModel, bool>(
                selector: (_, model) => model.searchbarRaised,
                builder: (_, searchbarRaised, __) {
                  if (defaultTargetPlatform != TargetPlatform.android &&
                      defaultTargetPlatform != TargetPlatform.iOS &&
                      searchbarRaised) {
                    return const ToggleLettersNotMobile();
                  } else {
                    return const SizedBox();
                  }
                })
          ],
        ),
      ),
    );
  }
}
