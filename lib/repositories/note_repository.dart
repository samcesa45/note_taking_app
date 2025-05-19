import 'package:note_taking_app/models/note_model.dart';
import 'package:note_taking_app/services/local_storage_service.dart';

class NoteRepository {
  final LocalStorageService _storageService;
  NoteRepository(this._storageService);

  Future<List<Note>> getAllNotes() async {
    return await _storageService.getAllNotes();
  }

  Future<void> saveNote(Note note) async {
    return _storageService.saveNote(note);
  }

  Future<void> deleteNote(String id) async {
    return _storageService.deleteNote(id);
  }
}