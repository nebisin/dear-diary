import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();

    // if openDatabase find this database open that or create one.
    return sql.openDatabase(
      path.join(dbPath, 'papers.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE papers(id TEXT PRIMARY KEY, title TEXT, body TEXT, mood TEXT, date TEXT, image TEXT, createdAt TEXT, isFavorite INTEGER)');
      },
      version: 2,
    );
  }

  static Future<void> insert(String table, Map<String, Object?> data) async {
    try {
      final db = await DBHelper.database();

      // If we try to insert a place that already exist replace it:
      db.insert(
        table,
        data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
    }
  }

  static Future<void> delete(String table, String? id) async {
    try {
      final db = await DBHelper.database();

      await db.delete(table, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw e;
    }
  }

  static Future<void> update(String table, Map<String, Object?> data) async {
    try {
      final db = await DBHelper.database();

      await db
          .update(table, data, where: 'id = ?', whereArgs: [data['id']]);
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    try {
      final db = await DBHelper.database();

      return db.query(table, orderBy: 'date DESC');
    } catch (e) {
      print(e);
      return [];
    }
  }
}
