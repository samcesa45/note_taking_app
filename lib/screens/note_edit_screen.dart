import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:note_taking_app/controllers/note_controller.dart';
import 'package:note_taking_app/controllers/note_edit_controller.dart';

class NoteEditScreen extends ConsumerStatefulWidget {
  final String? noteId;

  const NoteEditScreen({super.key, this.noteId});

  @override
  ConsumerState<NoteEditScreen> createState() => _NoteCreationEditScreenState();
}

class _NoteCreationEditScreenState extends ConsumerState<NoteEditScreen> {
  NoteCreationEditController? _controller;
  final FocusNode _editorFocusNode = FocusNode();
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final note =
          widget.noteId != null
              ? ref.read(notesProvider).firstWhere((n) => n.id == widget.noteId)
              : null;
      ref.read(currentNoteProvider.notifier).state = note;

      _controller = NoteCreationEditController(
        ref.read(notesProvider.notifier),
        note,
      );

      setState(() {
        _isInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _controller?.titleController.dispose();
    _controller?.contentController.dispose();
    _editorFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator(color: Colors.black)),
      );
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(widget.noteId == null ? 'Create New Note' : 'Edit Note'),
        actions: [
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.folder_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          TextButton(
            onPressed: () {},
            child: Icon(
              Icons.push_pin_outlined,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          TextButton(
            onPressed: () async {
              try {
                await _controller?.saveNote();
                // await _controller.saveNote();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Note saved successfully')),
                  );
                  context.pop();
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to save note: ${e.toString()}'),
                    ),
                  );
                }
              }
            },
            child: Icon(
              Icons.ios_share_rounded,
              color: Theme.of(context).iconTheme.color,
              semanticLabel: 'save note',
            ),
          ),
          if (widget.noteId != null)
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => _controller!.deleteNote(context),
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller!.titleController,
              cursorColor: Colors.black,
              decoration: InputDecoration(
                labelStyle: TextStyle(color: Colors.grey),
                hintText: 'Title',
                hintStyle: TextStyle(color: Colors.grey),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1.0, color: Colors.grey),
                ),
              ),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: quill.QuillEditor.basic(
                  controller: _controller!.contentController,
                  config: const quill.QuillEditorConfig(),
                ),
              ),
            ),
            quill.QuillSimpleToolbar(
              controller: _controller!.contentController,
              config: const quill.QuillSimpleToolbarConfig(),
            ),
          ],
        ),
      ),
    );
  }
}
