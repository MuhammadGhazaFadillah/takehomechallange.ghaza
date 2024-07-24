import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:async';
import 'package:take_home_challange_ghaza/data/models/character.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  DatabaseHelper._internal();

  static Database? _database;
  static final _databaseName = "favorites.db";
  static final _databaseVersion = 1;
  static final table = 'favorites';

  static final columnId = 'id';
  static final columnName = 'name';
  static final columnSpecies = 'species';
  static final columnGender = 'gender';
  static final columnOrigin = 'origin';
  static final columnLocation = 'location';
  static final columnImage = 'image';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY,
        $columnName TEXT NOT NULL,
        $columnSpecies TEXT NOT NULL,
        $columnGender TEXT NOT NULL,
        $columnOrigin TEXT NOT NULL,
        $columnLocation TEXT NOT NULL,
        $columnImage TEXT NOT NULL
      )
    ''');
  }

  Future<int> insert(CharacterModel character) async {
    Database db = await database;
    return await db.insert(table, character.toMap());
  }

  Future<List<CharacterModel>> queryAllFavorites() async {
    Database db = await database;
    final List<Map<String, dynamic>> maps = await db.query(table);

    return List.generate(maps.length, (i) {
      return CharacterModel.fromMap(maps[i]);
    });
  }

  Future<int> delete(int id) async {
    Database db = await database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }
}
