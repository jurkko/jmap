
import 'package:jmap/models/contact.dart';
import 'package:jmap/services/database_operations.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:jmap/services/parseMarkers.dart';
import 'package:jmap/util/doubleParser.dart';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'contact_event.dart';

part 'contact_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  ContactBloc() : super(ContactInitial());
  final _databaseOperations = DatabaseOperations.instance;
  EventParser eventParser = new EventParser();
  DoubleParser doubleParser = DoubleParser();

  List<Contact> contactMarker = [];
  Set<Marker> markers;
  Set<Marker> createMarker;


  @override
  Stream<ContactState> mapEventToState(
    ContactEvent event,
  ) async* {
    if (event is TriggeredContactSavePage) {

      yield SaveContactPageLoadedSucces(
          event.latitude, event.longitude);


    } else if (event is ContactSaveStarted) {

      yield ContactSavingInProgress();


      double longitude = doubleParser.parseStringToDouble(event.longitude);
      double latitude = doubleParser.parseStringToDouble(event.latitude);
      _databaseOperations.insert(
          event.name, event.surname, latitude, longitude);
      yield ContactSavingSuccess();

    } else if (event is TriggeredShowContactsPage) {

      List<Contact> contacts = await eventParser.getAllContacts();
      yield ShowAllContacts(contacts);

    } else if (event is TriggeredEditContactPage) {

      Contact contact = await _databaseOperations.findContact(event.id);
      contactMarker.clear();
      contactMarker.add(contact);
      markers = await eventParser.transformContactsToMarkers(contactMarker);
      yield LoadingState();
      yield EditContactPageLoadedSuccess(contact, markers);

    } else if (event is UpdateContact) {

      Contact contact = await _databaseOperations.findContact(event.id);
      await _databaseOperations.updateContact(
          contact, event.name, event.surname, event.latitude, event.longitude);
      yield ContactSavingSuccess();

    } else if (event is ChangedMarker) {

      Marker marker = new Marker(
        markerId: MarkerId('temp'),
        position: event.position,
        infoWindow: InfoWindow(title: 'Updated location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      markers.add(marker);
      yield LoadingState();
      yield EditContactPageLoadedSuccess(event.contact, markers);

    } else if (event is QueryDbInputs) {

      _databaseOperations.query();

    } else if(event is DeleteContact){
      //Contact contact = await _databaseOperations.findContact(event.id);
      await _databaseOperations.delete(event.id);
      yield ContactDeletedSuccess();



    }


    ///////////
    //Testing//
    ///////////

    else if (event is DeleteDbInputs) {
      _databaseOperations.emptyTable();
    }
  }
}
