import 'dart:io';

import 'package:dear_dairy/helpers/db_helper.dart';
import 'package:dear_dairy/models/paper.dart';
import 'package:flutter/material.dart';

class Papers with ChangeNotifier {
  List<Paper> _items = [];

  List<Paper> get items {
    return [..._items];
  }

  List<Paper> get favorites {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Future<Paper> addPaper({
    String title,
    String body,
    File coverImage,
    String mood,
    DateTime date,
  }) async {
    final newPaper = Paper(
      id: DateTime.now().toString(),
      title: title,
      body: body,
      coverImage: coverImage,
      mood: mood,
      date: date,
      createdAt: DateTime.now(),
    );

    // do: add cover image
    try {
      await DBHelper.insert('papers', {
        'id': newPaper.id,
        'title': newPaper.title,
        'body': newPaper.body,
        'mood': newPaper.mood,
        'date': newPaper.date.toIso8601String(),
        'image': newPaper.coverImage != null ? newPaper.coverImage.path : null,
        'createdAt': newPaper.createdAt.toIso8601String(),
        'isFavorite': 0,
      });
      await fetchPapers();
      return newPaper;
    } catch (e) {
      print(e);
      throw e;
    }
  }

  Future<void> fetchPapers() async {
    try {
      final dataList = await DBHelper.getData('papers');

      _items = dataList
          .map((e) => Paper(
                id: e['id'],
                title: e['title'],
                body: e['body'],
                mood: e['mood'],
                coverImage: e['image'] == null ? null : File(e['image']),
                date: DateTime.parse(e['date']),
                createdAt: DateTime.parse(e['createdAt']),
                isFavorite: e['isFavorite'] == 1 ? true : false,
              ))
          .toList();
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  Future<void> deletePaper(String id) async {
    final deletedIndex = _items.indexWhere((element) => element.id == id);
    final deletedItem = _items.removeAt(deletedIndex);
    notifyListeners();

    try {
      await DBHelper.delete('papers', id);
    } catch (e) {
      _items.insert(deletedIndex, deletedItem);
      notifyListeners();
      throw e;
    }
  }

  Future<Paper> updatePaper({
    String id,
    String title,
    String body,
    File coverImage,
    String mood,
    DateTime date,
    bool isFavorite,
  }) async {
    final newPaper = Paper(
      id: id,
      title: title,
      body: body,
      coverImage: coverImage,
      mood: mood,
      date: date,
      createdAt: DateTime.now(),
      isFavorite: isFavorite,
    );

    final itemIndex = _items.indexWhere((element) => element.id == id);
    final oldItem = _items[itemIndex];
    _items[itemIndex] = newPaper;
    notifyListeners();

    try {
      await DBHelper.update('papers', {
        'id': newPaper.id,
        'title': newPaper.title,
        'body': newPaper.body,
        'mood': newPaper.mood,
        'date': newPaper.date.toIso8601String(),
        'image': newPaper.coverImage != null ? newPaper.coverImage.path : null,
        'createdAt': newPaper.createdAt.toIso8601String(),
        'isFavorite': newPaper.isFavorite == true ? 1 : 0,
      });

      return newPaper;
    } catch (e) {
      _items[itemIndex] = oldItem;
      notifyListeners();
      throw e;
    }
  }

  Paper findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }
}
