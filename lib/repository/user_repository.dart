import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:eval_flutter/data_base/db_connexion.dart';

class UserRepository {
  late DatabaseConnection _databaseConnection;

  UserRepository() {
    _databaseConnection = DatabaseConnection.instance;
  }

  static Database? _database;
  String table = "users";

  Future<Database?> get database async {
    if (_database != null) {
      return _database;
    } else {
      _database = await _databaseConnection.database;
      return _database;
    }
  }

  Future<int?> insertData(Map<String, dynamic> data) async {
    try {
      var connection = await database;
      return await connection?.insert(
        table,
        data,
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Erreur lors de l'insertion des données : $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> readData() async {
    try {
      var connection = await database;
      return await connection?.query(table);
    } catch (e) {
      print("Erreur lors de la lecture des données : $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> readDataById(int userId) async {
    try {
      var connection = await database;
      return await connection?.query(table, where: 'id = ?', whereArgs: [userId]);
    } catch (e) {
      print("Erreur lors de la lecture des données par ID : $e");
      return null;
    }
  }

  Future<int?> updateData(Map<String, dynamic> data) async {
    try {
      var connection = await database;
      return await connection?.update(table, data, where: 'id = ?', whereArgs: [data['id']]);
    } catch (e) {
      print("Erreur lors de la mise à jour des données : $e");
      return null;
    }
  }

  Future<int?> deleteDataById(int userId) async {
    try {
      var connection = await database;
      return await connection?.delete(table, where: 'id = ?', whereArgs: [userId]);
    } catch (e) {
      print("Erreur lors de la suppression des données par ID : $e");
      return null;
    }
  }
}
