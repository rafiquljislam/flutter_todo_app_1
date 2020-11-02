import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final _databasename = 'persion.db';
  static final _databaseversion = 1;
  static final table = 'my_table';

  static final columnId = 'id';
  static final columnName = 'title';
  static final columnComplit = 'complite';

// *****Instence of Database*****
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
// *****Instence of Database END*****

  // create database
  _initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _databasename);
    return await openDatabase(path,
        version: _databaseversion, onCreate: _onCreate);
  }
  // create database quret

  _onCreate(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $table($columnId INTEGER PRIMARY KEY, $columnName TEXT NOT NULL, $columnComplit TEXT NOT NULL)');
  }

  // Chack database is or not createed
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

// insert
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

//Getall
  Future<List<Map<String, dynamic>>> quaryallrows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // queryfilter
  Future<List<Map<String, dynamic>>> qusryfilter(int id) async {
    Database db = await instance.database;
    var res = await db.rawQuery('SELECT * FROM $table WHERE id= ?', [id]);
    return res;
  }

  // Delate data
  Future<int> deleteData(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // Update data
  Future<int> updateData(int id, Map<String, dynamic> row) async {
    Database db = await instance.database;
    var res = await db.update(table, row, where: "id = ?", whereArgs: [id]);
    return res;
  }
}
