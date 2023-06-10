import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:socialdl/models/saved.model.dart';

class DatabaseHelper {
  static Database? _database;
  static const _tableName = 'saved_items';

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, 'main.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR(255) NOT NULL,
            date DATE NOT NULL,
            provider TEXT NOT NULL CHECK (provider IN ('Youtube', 'TikTok', 'Twitter')),
            url VARCHAR(255) NOT NULL,
            path VARCHAR(255) NOT NULL,
            type TEXT NOT NULL CHECK (type IN ('Video', 'Audio', 'Images'))
          )
        ''');
      },
    );
  }

  static Future<List<Map<String, dynamic>>> fetchSavedLinks() async {
    final db = await database;
    return await db.query(_tableName);
  }

  // insert a new saved record
  // the saved record will be of the Saved model

  static Future<void> insertSaved(Saved saved) async {
    final db = await database;
    await db.insert(_tableName, saved.toMap());
  }
}
