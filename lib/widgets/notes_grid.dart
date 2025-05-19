import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:note_taking_app/constants/colors.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:note_taking_app/routing/app_router.dart';
import 'package:note_taking_app/utils/date_formatter.dart';
import 'package:note_taking_app/widgets/note_list_item.dart';
import 'package:go_router/go_router.dart';

class NotesGrid extends StatelessWidget {
  final List<Note> notes;
  const NotesGrid({super.key, required this.notes});
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
  Widget build(BuildContext context) {
    final noteColors = [
      AppColors.appBlue1,
      AppColors.appPink1,
      AppColors.appYellow1,
      AppColors.appYellow2,
      AppColors.appGreen,
      AppColors.appPink2,
      AppColors.appBlue2,
      AppColors.appPink3,
    ];
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate((context, index) {
          final note = notes[index];
          final snippet =
              note.content.length > 200
                  ? "${note.content.substring(0, 200)}..."
                  : note.content;
          final color = noteColors[index % noteColors.length];
          final quillSnippet = extractPlainText(snippet);
          return NoteListItem(
            title: note.title,
            date: formatDate(note.updatedAt ?? note.createdAt),
            snippet: quillSnippet,
            onTap: () => context.push('${AppRouter.viewNoteRoute}/${note.id}'),
            backgroundColor: color,
          );
        }, childCount: notes.length),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 12.0,
          mainAxisSpacing: 12.0,
          childAspectRatio: 0.9,
        ),
      ),
    );
  }
}
