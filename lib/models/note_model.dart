import 'package:intl/intl.dart';

class Note {
  String id;
  String title;
  String content;
  List<String> tags;
  DateTime? createdAt;
  DateTime? updatedAt;

  Note({
    required this.id,
    required this.title,
    required this.content,
    this.tags = const [],
    this.createdAt,
    this.updatedAt,
  });

  // Named constructor for creating a Note object from a JSON map
  Note.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        content = json['content'],
        tags = List<String>.from(json['tags'] ?? []),
        createdAt = json['createdAt'] == null
            ? null
            : DateTime.tryParse(json['createdAt']),
        updatedAt = json['updatedAt'] == null
            ? null
            : DateTime.tryParse(json['updatedAt']);

  // Method to convert the Note object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'tags': tags,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  String get formattedCreatedAt => createdAt != null
      ? DateFormat('yyyy-MM-dd HH:mm').format(createdAt!)
      : 'N/A';

  String get formattedUpdatedAt => updatedAt != null
      ? DateFormat('yyyy-MM-dd HH:mm').format(updatedAt!)
      : 'N/A';
}