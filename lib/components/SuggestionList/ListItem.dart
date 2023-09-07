import 'package:flutter/material.dart';
import 'package:lazca_sozluk/SearchModel.dart';
import 'package:lazca_sozluk/bloc/browser_bloc.dart';
import 'package:lazca_sozluk/entities/Word.dart';
import 'package:lazca_sozluk/components/ModalBottomSheet.dart';
import 'package:provider/provider.dart';

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    print("ListItem: build");
    Word word = context.read<BrowserBloc>().state.filteredResults[index];
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(word.getWord(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: Theme.of(context).colorScheme.primary)),
            const SizedBox(height: 5),
            Text(
              word.getMeanings().toString(),
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
        IconButton(
            icon: Icon(
              Icons.arrow_circle_right,
              color: Theme.of(context).colorScheme.primary,
            ),
            onPressed: () {
              Provider.of<SearchModel>(context, listen: false)
                  .searchDetails(word.getMeaningsList());
              showModalBottomSheet<void>(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  context: context,
                  builder: (_) =>
                      ModalBottomSheet(context: context, word: word));
            })
      ],
    );
  }
}

// Word word =
//         Provider.of<SearchModel>(context, listen: false).filteredResults[index];
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(word.getWord(),
//                 style: Theme.of(context)
//                     .textTheme
//                     .titleLarge!
//                     .copyWith(color: Theme.of(context).colorScheme.primary)),
//             const SizedBox(height: 5),
//             Text(
//               word.getMeanings().toString(),
//               style: Theme.of(context).textTheme.titleMedium,
//             )
//           ],
//         ),
//         IconButton(
//             icon: Icon(
//               Icons.arrow_circle_right,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             onPressed: () {
//               Provider.of<SearchModel>(context, listen: false)
//                   .searchDetails(word.getMeaningsList());
//               showModalBottomSheet<void>(
//                   clipBehavior: Clip.hardEdge,
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(10)),
//                   context: context,
//                   builder: (_) =>
//                       ModalBottomSheet(context: context, word: word));
//             })
//       ],
//     );
//   }
