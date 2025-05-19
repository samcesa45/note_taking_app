import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;

final currentNoteProvider = StateProvider<Note?>((ref) => null);

final noteCreationEditControllerProvider =
    Provider.autoDispose<NoteCreationEditController>(
      (ref) => NoteCreationEditController(
        ref.read(notesProvider.notifier),
        ref.read(currentNoteProvider),
      ),
    );

class NoteCreationEditController {
  final NoteController _noteController;
  final Note? _initialNote;
  final titleController = TextEditingController();
  late final quill.QuillController contentController;

  NoteCreationEditController(this._noteController, this._initialNote) {
    if (_initialNote != null && _initialNote.content.startsWith('[{"insert":')) {
      titleController.text = _initialNote.title;
      try {
        final deltaJson = jsonDecode(_initialNote.content);
        contentController = quill.QuillController(
          document: quill.Document.fromJson(deltaJson),
          selection: const TextSelection.collapsed(offset: 0),
        );
      } catch (e) {
        contentController = quill.QuillController.basic();
      }
    } else {
      titleController.clear();
      contentController = quill.QuillController.basic();
    }
  }

  Future<void> saveNote() async {
    final content = jsonEncode(contentController.document.toDelta().toJson());
    final title = titleController.text.trim();
    if (title.isNotEmpty || content.isNotEmpty) {
      await _noteController.saveNote(
        id: _initialNote?.id,
        title: title,
        content: content,
      );
    }
  }

  Future<void> deleteNote(BuildContext context) async {
    if (_initialNote != null) {
      await _noteController.deleteNote(_initialNote.id);
      Navigator.pop(context);
    }
  }
}
