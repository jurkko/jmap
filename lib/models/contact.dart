import 'package:flutter/foundation.dart';
final String columnName = '';
final String columnSurname = '';

class Contact {
  @required
  int id;
  @required
  String name;
  @required
  String surname;
  @required
  double latitude;
  @required
  double longitude;

  Contact(this.id, this.name, this.surname, this.latitude, this.longitude);

  Contact.fromMap(dynamic obj) {
    this.id = obj['_id'];
    this.name = obj['name'];
    this.surname = obj['surname'];
    this.latitude = obj['lat'];
    this.longitude = obj['len'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnSurname:surname
    };
//    if (id != null) {
//      map[columnId] = id;
//    }
    return map;
  }
}
