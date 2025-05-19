import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/repositories/note_repository.dart';
import 'package:note_taking_app/services/local_storage_service.dart';
import 'package:uuid/uuid.dart';

enum NoteSortOption { createdAt, updatedAt, title }

final localStorageServiceProvider = Provider<LocalStorageService>((ref) {
  return SharedPreferencesLocalStorageService();
});

final noteRepositoryProvider = Provider<NoteRepository>(
  (ref) => NoteRepository(ref.read(localStorageServiceProvider)),
);

final notesProvider = StateNotifierProvider<NoteController, List<Note>>(
  (ref) => NoteController(ref.read(noteRepositoryProvider)),
);

final isLoadingProvider = StateProvider<bool>((ref) => false);

final noteSortOptionProvider = StateProvider<NoteSortOption>(
  (ref) => NoteSortOption.updatedAt,
);
final sortedNotesProvider = Provider<List<Note>>((ref) {
  final notes = ref.watch(notesProvider);
  final sortOption = ref.watch(noteSortOptionProvider);

  List<Note> sortedNotes = [...notes];
  switch (sortOption) {
    case NoteSortOption.createdAt:
      sortedNotes.sort(
        (a, b) => (b.createdAt ?? DateTime.now()).compareTo(
          a.createdAt ?? DateTime.now(),
        ),
      );
      break;
    case NoteSortOption.updatedAt:
      sortedNotes.sort(
        (a, b) => (b.updatedAt ?? DateTime.now()).compareTo(
          a.updatedAt ?? DateTime.now(),
        ),
      );
      break;
    case NoteSortOption.title:
      sortedNotes.sort(
        (a, b) => a.title.toLowerCase().compareTo(b.title.toLowerCase()),
      );
      break;
  }
  return sortedNotes;
});

class NoteController extends StateNotifier<List<Note>> {
  final NoteRepository _noteRepository;

  NoteController(this._noteRepository) : super([]) {
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    try {
      state = await _noteRepository.getAllNotes();
      // state = notes;
    } catch (e) {
      print("Error loading notes: $e");
      state = [];
      rethrow;
    }
  }

  Future<void> saveNote({
    String? id,
    required String title,
    required String content,
  }) async {
    final now = DateTime.now();
    final existingNote =
        id != null ? state.firstWhere((n) => n.id == id) : null;

    final note = Note(
      id: id ?? const Uuid().v4(),
      title: title,
      content: content.trim(),
      createdAt: existingNote?.createdAt ?? now,
      updatedAt: now,
      tags: existingNote?.tags ?? [],
    );

    try {
      await _noteRepository.saveNote(note);
      if (existingNote == null) {
        state = [note, ...state];
      } else {
        state = [
          for (final n in state)
            if (n.id == note.id) note else n,
        ];
      }
    } catch (e) {
      print("Error saving note: $e");
      rethrow; // Important to rethrow so the UI can handle the error
    }
  }

  Future<void> deleteNote(String id) async {
    try {
      await _noteRepository.deleteNote(id);
      state = state.where((note) => note.id != id).toList();
    } catch (e) {
      print("Error deleting note: $e");
    }
  }

  List<Note> searchNotes(String query) {
    if (query.isEmpty) return state;
    return state.where((note) {
      return note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.content.toLowerCase().contains(query.toLowerCase());
    }).toList();
  }
}
