import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/models/note_model.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');

final searchResultsProvider = Provider<List<Note>>((ref) {
  final query = ref.watch(searchQueryProvider);
  ref.watch(notesProvider);
return ref.read(notesProvider.notifier).searchNotes(query);
});