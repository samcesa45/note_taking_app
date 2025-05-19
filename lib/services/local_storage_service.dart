import 'dart:convert';

import 'package:note_taking_app/models/note_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class LocalStorageService {
  Future<void> init();
  Future<List<Note>> getAllNotes();
  Future<void> saveNote(Note notes);
  Future<void> deleteNote(String id);
  Future<void> setThemeModeIndex(int index);
  Future<int> getThemeModeIndex();
}

final localStorageProvider = Provider<SharedPreferencesLocalStorageService>(
  (ref) => SharedPreferencesLocalStorageService(),
);

class SharedPreferencesLocalStorageService implements LocalStorageService {
  static const String _notesKey = 'notes';
  static const String _themeKey = 'themeMode';

  late SharedPreferences _prefs;

  @override
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<List<Note>> getAllNotes() async {
    _prefs = await SharedPreferences.getInstance();
    final notesJson = _prefs.getStringList(_notesKey) ?? [];
    return notesJson.map((json) => Note.fromJson(jsonDecode(json))).toList();
  }

  @override
  Future<void> saveNote(Note note) async {
    _prefs = await SharedPreferences.getInstance();
    final notes = await getAllNotes();
    notes.removeWhere((n) => n.id == note.id);
    notes.add(note);
    final notesJson = notes.map((n) => jsonEncode(n.toJson())).toList();
    await _prefs.setStringList(_notesKey, notesJson);
  }

  @override
  Future<void> deleteNote(String id) async {
    _prefs = await SharedPreferences.getInstance();
    final notes = await getAllNotes();
    notes.removeWhere((n) => n.id == id);
    final notesJson = notes.map((n) => jsonEncode(n.toJson())).toList();
    await _prefs.setStringList(_notesKey, notesJson);
  }

  @override
  Future setThemeModeIndex(int index) async {
    _prefs = await SharedPreferences.getInstance();
    await _prefs.setInt(_themeKey, index);
  }

  @override
  Future<int> getThemeModeIndex() async {
    _prefs = await SharedPreferences.getInstance();
    return _prefs.getInt(_themeKey) ?? 0;
  }
}
