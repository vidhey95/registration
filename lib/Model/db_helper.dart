import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:registration/Model/reg_model.dart';


class dbhelper {
  static final dbhelper _instance = new dbhelper.internal();

  factory dbhelper() => _instance;

  final String regtable = 'regtable';
  final String columnName = 'Name';
  final String columnLastName = 'LastName';
  final String columnDOB = 'DOB';
  /*final String columnDescription = 'description';*/

  static Database _db;

  dbhelper.internal();

  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  initDb() async {
    String databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'reg.db');

//    await deleteDatabase(path); // just for testing

    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
  }

  void _onCreate(Database db, int newVersion) async {
    await db.execute(
        'CREATE TABLE $regtable($columnName TEXT, $columnLastName TEXT,$columnDOB TESXT)');
  }

  Future<int> saveNote(Registration reg) async {
    var dbClient = await db;
    var m = reg.Tomap();
    var result = await dbClient.insert(regtable, reg.Tomap());
//    var result = await dbClient.rawInsert(
//        'INSERT INTO $tableNote ($columnTitle, $columnDescription) VALUES (\'${note.title}\', \'${note.description}\')');
    var re= result;
    return result;

  }

  Future<List> getAllNotes() async {
    var dbClient = await db;
    var result = await dbClient
        .query(regtable, columns: [columnName, columnLastName,columnDOB]);
//    var result = await dbClient.rawQuery('SELECT * FROM $tableNote');
    var re= result;
     return result.toList();
  }

 
  Future<int> deleteNote(String name) async {
    var dbClient = await db;
    return await dbClient
        .delete(regtable, where: '$columnName = ?', whereArgs: [name]);
//    return await dbClient.rawDelete('DELETE FROM $tableNote WHERE $columnId = $id');
  }
/*

  Future<int> updateNote(Note note) async {
    var dbClient = await db;
    return await dbClient.update(regtable, note.toMap(),
        where: "$columnId = ?", whereArgs: [note.id]);
//    return await dbClient.rawUpdate(
//        'UPDATE $tableNote SET $columnTitle = \'${note.title}\', $columnDescription = \'${note.description}\' WHERE $columnId = ${note.id}');
  }
*/

  Future close() async {
    var dbClient = await db;
    return dbClient.close();
  }
}
