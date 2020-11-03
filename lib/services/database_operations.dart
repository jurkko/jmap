import 'package:flutter/cupertino.dart';
import 'package:jmap/models/contact.dart';

import 'database.dart';

class DatabaseOperations {
  DatabaseOperations._privateConstructor();

  static final DatabaseOperations instance =
      DatabaseOperations._privateConstructor();

  final dbHelper = DatabaseRepository.instance;

  Future insert(
      String name, String surname, double latitude, double longitude) async {
    // row to insert
    Map<String, dynamic> row = {
      //     DatabaseRepository.columnId: contact.id,
      DatabaseRepository.columnName: name,
      DatabaseRepository.columnSurname: surname,
      DatabaseRepository.columnLatitude: latitude,
      DatabaseRepository.columnLongitude: longitude
    };
    final id = await dbHelper.insert(row);
    print('inserted row id: $id');
  }

  Future query() async {
    final allRows = await dbHelper.queryAllRows();
    print('query all rows:');
    allRows.forEach((row) => print(row));
  }

  Future<Contact> findContact(int id) async {
    final Contact contact = await dbHelper.queryContact(id);
    return contact;
  }

  Future<bool> updateContact(Contact oldContact, String name, String surname,
      double latitude, double longitude) async {
    await dbHelper.update(oldContact, name, surname, latitude, longitude);
  }

  Future<List<Map<String, dynamic>>> getAllContacts() async {
    final allRows = await dbHelper.queryAllRows();
    return allRows;
  }
  void delete(int id) async {

    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }

  Future emptyTable() async {
    dbHelper.emptyTable();
    print('rows deleted');
    query();
  }
}



