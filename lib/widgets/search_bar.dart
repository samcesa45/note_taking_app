import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconly/iconly.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/routing/app_router.dart';

class SearchAndFilterBar extends ConsumerWidget {
  const SearchAndFilterBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Shearch for notes',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
            onTap: () => context.push(AppRouter.searchRoute),
            readOnly: true,
          ),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => _SortOptionsSheet(),
            );
          },
          icon: const Icon(IconlyLight.filter),
        ),
      ],
    );
  }
}

class _SortOptionsSheet extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(noteSortOptionProvider).index;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
          NoteSortOption.values.map((option) {
            final index = option.index;
            return ListTile(
              title: Text(option.name, textAlign: TextAlign.center),
              selected: currentIndex == index,
              onTap: () {
                ref.read(noteSortOptionProvider.notifier).state = option;
                Navigator.pop(context);
              },
            );
          }).toList(),
    );
  }
}
