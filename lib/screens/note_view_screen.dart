import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:note_taking_app/controllers/note_view_controller.dart';
import 'package:note_taking_app/routing/app_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

class NoteViewScreen extends ConsumerWidget {
  final String noteId;

  const NoteViewScreen({super.key, required this.noteId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final note = ref.watch(noteViewControllerProvider(noteId));
    late final quill.QuillController viewController;

    try {
      final delta = quill.Document.fromJson(jsonDecode(note!.content));
      viewController = quill.QuillController(
        document: delta,
        selection: const TextSelection.collapsed(offset: 0),
      );
    } catch (e) {
      viewController = quill.QuillController.basic();
    }

    if (note == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('View Note')),
        body: const Center(child: Text('Note not found.')),
        backgroundColor: Colors.transparent,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(note.title),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed:
                () => context.push('${AppRouter.createNoteRoute}/${note.id}'),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final actionsController = ref.read(
                noteViewActionsControllerProvider,
              );
              await actionsController.deleteNote(note.id);
              context.push(AppRouter.homeRoute);
            },
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.ios_share,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Created at: ${note.formattedCreatedAt}',
              style: const TextStyle(color: Colors.grey),
            ),
            if (note.updatedAt != null)
              Text(
                'Last modified: ${note.formattedUpdatedAt}',
                style: const TextStyle(color: Colors.grey),
              ),
            const SizedBox(height: 16),
            Expanded(
              child: quill.QuillEditor.basic(
                controller: viewController,
                config: const quill.QuillEditorConfig(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
