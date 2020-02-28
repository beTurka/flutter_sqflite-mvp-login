import 'dart:io';
import 'package:path/path.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_mvp_login/model/user_model';

class DataBaseHelper{
  static final DataBaseHelper _instance = new DataBaseHelper.internal();
  factory DataBaseHelper () => _instance;

  static Database _db;

  Future<Database> get db async{
    if(_db != null)
      return _db;

    _db = await initDb();
    return _db;
  }

  DataBaseHelper.internal();

  initDb() async {
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, "main.db");
    var ourDb = await openDatabase(path, version: 1, onCreate: _onCreate);
    return ourDb;
  }

  void _onCreate(Database db, int verson) async {
    await db.execute("CREATE TABLE User(id INTEGER PRIMARY KEY, username TEXT, password TEXT)");
    print("Table is created");
  }

//* Insertion
  Future<int> saveUser(User user) async{
    var dbClien = await db;
    int res = await dbClien.insert("User", user.toMap());
    return res;
  }

  //* Delete user
  Future<int> deleteUser(User user) async{
    var dbClien = await db;
    int res = await dbClien.delete("User");
    return res;
  }
 
}