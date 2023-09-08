import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';

import '../model/user_model.dart';

class DatabaseConnection {
  static final DatabaseConnection instance = DatabaseConnection._privateConstructor();
  static Database? _database;

  DatabaseConnection._privateConstructor();


  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'db.users');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDatabase,
    );
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        username TEXT,
        password TEXT
      )
    ''');
  }
  Future<void> saveUser(String username, String password) async {
    final db = await DatabaseConnection.instance.database;

    final user = User(username: username, password: password);

    final existingUser = await getUserByUsername(username);

    if (existingUser != null) {
      await db.update(
        'users',
        user.toMap(),
        where: 'id = ?',
        whereArgs: [existingUser.id],
      );
    } else {
      await db.insert('users', user.toMap());
    }
  }

  Future<User?> getUserByUsername(String username) async {
    final db = await DatabaseConnection.instance.database;

    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ?',
      whereArgs: [username],
      limit: 1,
    );

    if (result.isNotEmpty) {
      return User.fromMap(result.first);
    } else {
      return null;
    }
  }



}
