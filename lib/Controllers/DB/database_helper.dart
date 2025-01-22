import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('scores.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE scores (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        player TEXT NOT NULL,
        score INTEGER NOT NULL
      )
    ''');
  }

  Future<Map<String, int>> getScores() async {
    final db = await instance.database;
    final result = await db.query('scores');

    final scores = <String, int>{'X': 0, 'O': 0};
    for (var row in result) {
      scores[row['player'] as String] = row['score'] as int;
    }
    return scores;
  }

  Future<void> updateScore(String player) async {
    final db = await instance.database;

    await db.rawInsert('''
      INSERT INTO scores (player, score)
      VALUES (?, 1)
      ON CONFLICT(player) DO UPDATE SET score = score + 1
    ''', [player]);
  }
}