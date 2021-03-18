import 'dart:io';


class Paper {
  String? id;
  String? title;
  String? body;
  File? coverImage;
  String? mood;
  DateTime? date;
  DateTime createdAt;
  bool? isFavorite;

  Paper({
    required this.id,
    required this.title,
    this.body,
    this.coverImage,
    required this.mood,
    required this.date,
    required this.createdAt,
    this.isFavorite = false,
  });
}
