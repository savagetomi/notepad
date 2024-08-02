import 'package:notepad/models/notess.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Noterepository {
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

  static Future<Database> _database() async {
    final database = openDatabase(
      join(
          await getDatabasesPath(), _dbName
      ),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY,title TEXT,categories TEXT, createdAt TEXT)');
      },
      version: 1,
    );
    return database;
  }

  static insert({
    required Notess notess
  }) async {
    final db = await _database();
    await db.insert(_tableName, notess.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future <List<Notess>> getNotes() async {
    final db = await _database();
    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    return List.generate((maps.length), (i) {
      return Notess(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          createdAt: DateTime.parse(maps[i]['createdAt']),
          categories: maps[i]['categories'] as String);
    });
  }
}