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


      //akun default
      String hashedPassword = _hashPassword('test123');
      print('Storing hashed password: $hashedPassword');
      await db.insert('users', {'username': 'testlari', 'password': hashedPassword});
      print('User added: testlari with hashed password: $hashedPassword');
    });
  }

  String _hashPassword(String password) {
    final bytes = utf8.encode(password); // Encode password masuk byte
    final hashed = sha256.convert(bytes); // Hash make sha256
    print('Hashed password: $hashed');  // Print hashed pw di debug 
    return hashed.toString(); 
  }

  Future<bool> validateUser(String username, String password) async {
    final db = await database;
    String hashedPassword = _hashPassword(password); 
    final List<Map<String, dynamic>> result = await db.query(
      'users',
      where: 'username = ? AND password = ?',
      whereArgs: [username, hashedPassword],
    );

    // Debugging
    print("Validating user: $username with hashed password: $hashedPassword");
    print("Query Result: $result"); // Print query 

    return result.isNotEmpty; 
  }
}
//commit fix robet auth
//push 25/09/24