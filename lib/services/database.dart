import 'package:jmap/models/contact.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseRepository {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final contact = 'contact'; //table

  static final columnId = '_id';
  static final columnName = 'name';
  static final columnSurname = 'surname';
  static final columnLatitude = 'lat';
  static final columnLongitude = 'len';

  DatabaseRepository._privateConstructor();

  static final DatabaseRepository instance =
      DatabaseRepository._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $contact (
            $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
            $columnName STRING NOT NULL,
            $columnSurname STRING NOT NULL,
            $columnLatitude DOUBLE NOT NULL,
            $columnLongitude DOUBLE NOT NULL
          )
          ''');
  }

  Future<int> insert(Map<String, dynamic> row) async {
    print('inserting');
    Database db = await instance.database;
    return await db.insert(contact, row);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(contact, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(contact);
  }

  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(
        await db.rawQuery('SELECT COUNT(*) FROM $contact'));
  }

  Future<Contact> queryContact(int id) async {
    Database db = await instance.database;

    List<Map> maps = await db.query(contact,
        columns: [
          columnId,
          columnName,
          columnSurname,
          columnLatitude,
          columnLongitude
        ],
        where: '$columnId = $id');
    if (maps.length > 0) {
      return Contact.fromMap(maps.first);
    }
    return null;
  }

  Future<Contact> update(
      Contact oldContact, String name, String surname, double latitude, double longitude) async {
    int id = oldContact.id;
    Database db = await instance.database;

    int updatedRows = await db.rawUpdate('''
    UPDATE $contact 
    SET name = ? , surname = ? , lat = ?, len = ?
    WHERE _id = ?
    ''', [name, surname, latitude, longitude, id]);
//    await db.update(contact, newRow,
//        where: '$columnId = $id',
//        whereArgs: [oldContact.name, oldContact.surname]);
  }

  void emptyTable() async {
    await _database.execute("DELETE FROM $contact");
  }
}
//   $columnId STRING PRIMARY KEY,
//            $columnSurname STRING NOT NULL,
//            $columnLat DOUBLE NOT NULL,
//            $columnLen DOUBLE NOT NULL
