import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'movie.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._internal();
  static Database? _db;

  DatabaseHelper._internal();

  Future<Database> get database async {
    _db ??= await _initDb();
    return _db!;
  }

  Future<Database> _initDb() async {
    final dbPath = await getDatabasesPath();
    return openDatabase(
      join(dbPath, 'movies.db'),
      version: 2,
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            director TEXT,
            actors TEXT,
            genre TEXT,
            plot TEXT,
            poster TEXT,
            imdbRating TEXT
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        await db.execute('DROP TABLE IF EXISTS movies');
        await db.execute('''
          CREATE TABLE movies (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            director TEXT,
            actors TEXT,
            genre TEXT,
            plot TEXT,
            poster TEXT,
            imdbRating TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertMovies(List<Movie> movies) async {
    final db = await database;
    final batch = db.batch();
    for (final movie in movies) {
      batch.insert(
        'movies',
        movie.toMap(),
        conflictAlgorithm: ConflictAlgorithm.ignore,
      );
    }
    await batch.commit(noResult: true);
  }

  Future<List<Movie>> searchByTitle(String query) async {
    final db = await database;
    final rows = await db.query(
      'movies',
      where: 'title LIKE ?',
      whereArgs: ['%$query%'],
    );
    return rows.map(Movie.fromMap).toList();
  }

  Future<List<Movie>> getAllMovies() async {
    final db = await database;
    final rows = await db.query('movies');
    return rows.map(Movie.fromMap).toList();
  }

  Future<int> count() async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) FROM movies');
    return Sqflite.firstIntValue(result) ?? 0;
  }
}
