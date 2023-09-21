import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {

  Future<String> get path async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'app.db');
    return path;
  }

  Future<Database> get database async {
    Database db = await openDatabase(await path);
    return db;
  }
  Future<void> init() async {
    final db = await openDatabase(
      await path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
          CREATE TABLE PRODUCTS(
            ID INTEGER PRIMARY KEY,
            NAME TEXT,
            DESCRIPTION TEXT,
            PRICE REAL
          )
          """);
      },
    );
  }

  Future<List<Map<String, dynamic>>> select(String table) async {
    Database db = await database;
    return db.query(table);
  }

  Future<void> insert(String table, Map<String, dynamic> values) async {
    Database db = await database;
    await db.insert(table, values);
  }
  
  Future<void> deleteById(String table, {required String where, required List<Object?> whereArgs}) async {
    Database db = await database;
    await db.delete(table, where: where, whereArgs: whereArgs);
  }
}