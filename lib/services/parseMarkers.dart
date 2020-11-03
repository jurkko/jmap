import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jmap/models/contact.dart';
import 'package:jmap/services/database_operations.dart';

class EventParser {
  final _databaseOperations = DatabaseOperations.instance;

  Future<Set<Marker>> transformContactsToMarkers(List<Contact> contacts) async {
    Set<Marker> markers = Set<Marker>();

    try {
      for (int i = 0; i < contacts.length; i++) {
        LatLng tempLatLng =
            new LatLng(contacts[i].latitude, contacts[i].longitude);
        Marker marker = new Marker(
            markerId: MarkerId(contacts[i].id.toString()),
            position: tempLatLng,
            infoWindow: InfoWindow(title: contacts[i].name.toString()),
            onTap: onMarkerTapped(contacts[i].id));
        markers.add(marker);
      }

      print('method inside' + markers.length.toString());
      return markers;
    } catch (e) {
      e.toString();
    }
  }

  Future<List<Contact>> getAllContacts() async {
    try {
      List<Map<String, dynamic>> test =
          await _databaseOperations.getAllContacts();

      List<Contact> list = test.map((e) => Contact.fromMap(e)).toList();

      for (var i = 0; i < list.length; i++) {
        print(list[i].id.toString());
      }
      return list;
    } catch (e) {
      print(e.toString());
    }
  }

  // marker click event
  onMarkerTapped(int id) {
    print(id.toString());
  }
}
