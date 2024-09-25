import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_database.db');
    return await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(''' 
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          username TEXT UNIQUE,
          password TEXT
        )
      ''');
      // Tambahkan akun default jika diperlukan
      String hashedPassword = _hashPassword('1234');
      await db.insert('users', {'username': 'admin', 'password': hashedPassword});
    });
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    final hashed = sha256.convert(bytes);
    return hashed.toString();
  }

  Future<bool> validateUser(String username, String password) async {
    final db = await database;
    String hashedPassword = _hashPassword(password); // Hash the input password
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    // Debugging
    print("Validating user: $username with hashed password: $hashedPassword");
    print("Query Result: $result"); // Debugging

    return result.isNotEmpty; // Return true if there are results
  }
}
