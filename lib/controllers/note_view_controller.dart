import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';

final noteViewControllerProvider = Provider.autoDispose.family<Note?, String>((
  ref,
  noteId,
) {
  final notes = ref.watch(notesProvider);
  try {
    return notes.firstWhere((note) => note.id == noteId);
  } catch (e) {
    return null;
  }
});

final noteViewActionsControllerProvider =
    Provider.autoDispose<NoteViewActionsController>(
      (ref) => NoteViewActionsController(ref.read(notesProvider.notifier)),
    );

class NoteViewActionsController {
  final NoteController _noteController;

  NoteViewActionsController(this._noteController);

  Future<void> deleteNote(String id) async {
    await _noteController.deleteNote(id);
  }
}
