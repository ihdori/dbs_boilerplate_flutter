import 'package:sqflite/sqflite.dart';

class SqfliteReveiw {
  Database? _database;

  static const String dbName = 'mydb.db';
  static const int dbVersion = 1;
  Future<Database?> get database async {
    if (_database == null) {
      _database = await _initDatabase();
      return _database;
    } else {
      return _database;
    }
  }

  _initDatabase() async {
    final String path = await getDatabasesPath();
    final initDb = openDatabase(
      '$path/$dbName',
      onCreate: _onCreate,
      version: dbVersion,
      onUpgrade: _onUpgrade,
    );
    return initDb;
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE 'countries'(
    "id" INT PRIMARY KEY AUTOINCREMENT,
    );
    ''');

    await db.execute('''
    CREATE TABLE 'users'(
    "id" INT PRIMARY KEY AUTOINCREMENT,
    );
    ''');
  }

  _onUpgrade(
    Database db,
    int newVersion,
    int oldVersion,
  ) async {}

  read(String sql) async {
    Database? db = await database;
    List<Map> response = await db!.rawQuery(sql);
    return response;
  }

  insert(String sql) async {
    Database? db = await database;
    int response = await db!.rawInsert(sql);
    return response;
  }

  update(String sql) async {
    Database? db = await database;
    int response = await db!.rawUpdate(sql);
    return response;
  }

  delete(String sql) async {
    Database? db = await database;
    int response = await db!.rawDelete(sql);
    return response;
  }
}
