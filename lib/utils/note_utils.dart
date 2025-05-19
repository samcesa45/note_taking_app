import 'dart:convert';
import 'package:flutter_quill/flutter_quill.dart' as quill;

String extractPlainText(String content) {
  try {
    final deltaJson = jsonDecode(content);
    final doc = quill.Document.fromJson(deltaJson);
    return doc.toPlainText().trim();
  } catch (_) {
    return content;
  }
}
