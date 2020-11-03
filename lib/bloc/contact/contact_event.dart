part of 'contact_bloc.dart';

@immutable
abstract class ContactEvent extends Equatable {
  const ContactEvent();

  @override
  List<Object> get props => [];
}

class TriggeredContactSavePage extends ContactEvent {
  double latitude;
  double longitude;


  TriggeredContactSavePage(this.latitude, this.longitude);
}

class ContactSaveStarted extends ContactEvent {
  String name;
  String surname;
  String latitude;
  String longitude;

  ContactSaveStarted(this.name, this.surname, this.latitude, this.longitude);
}

class TriggeredShowContactsPage extends ContactEvent {
  TriggeredShowContactsPage();
}

class TriggeredEditContactPage extends ContactEvent {
  int id;

  TriggeredEditContactPage(this.id);
}

class DeleteContact extends ContactEvent {
  int id;

  DeleteContact(this.id);
}

class ChangedMarker extends ContactEvent {
  Contact contact;
  LatLng position;

  ChangedMarker(this.contact, this.position);
}

class UpdateContact extends ContactEvent {
  int id;
  String name;
  String surname;
  double latitude;
  double longitude;


  UpdateContact(this.id, this.name, this.surname, this.latitude, this.longitude);
}

///////////
//Testing//
///////////
class DeleteDbInputs extends ContactEvent {}

class QueryDbInputs extends ContactEvent {}
