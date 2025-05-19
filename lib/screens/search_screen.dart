import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/constants/colors.dart';
import 'package:note_taking_app/controllers/search_controller.dart';
import 'package:note_taking_app/widgets/note_list_item.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  final List<Color> noteColors = const [
    AppColors.appBlue1,
    AppColors.appPink1,
    AppColors.appYellow1,
    AppColors.appYellow2,
    AppColors.appGreen,
    AppColors.appPink2,
    AppColors.appBlue2,
    AppColors.appPink3,
  ];

  String extractPlainText(String content) {
    try {
      final deltaJson = jsonDecode(content);
      final doc = quill.Document.fromJson(deltaJson);
      return doc.toPlainText().trim();
    } catch (_) {
      return content;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final searchResults = ref.watch(searchResultsProvider);
    final searchController = ref.read(searchQueryProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Notes'),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                hintText: 'Search notes...',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => searchController.state = value,
            ),
            const SizedBox(height: 16),
            Expanded(
              child:
                  searchResults.isEmpty && searchQuery.isNotEmpty
                      ? const Center(child: Text('No matching notes found.'))
                      : searchResults.isEmpty && searchQuery.isEmpty
                      ? const Center(
                        child: Text('Start typing to search notes.'),
                      )
                      : GridView.builder(
                        itemCount: searchResults.length,
                        itemBuilder: (context, index) {
                          final note = searchResults[index];
                          final snippet =
                              note.content.length > 50
                                  ? "${note.content.substring(0, 50)}..."
                                  : note.content;
                          final color = noteColors[index % noteColors.length];
                          final quillSnippet = extractPlainText(snippet);
                          return NoteListItem(
                            title: note.title,
                            date: note.formattedUpdatedAt,
                            snippet: quillSnippet,
                            onTap: () => context.push('/view/${note.id}'),
                            backgroundColor: color,
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 12.0,
                              mainAxisSpacing: 12.0,
                              childAspectRatio: 0.9,
                            ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
