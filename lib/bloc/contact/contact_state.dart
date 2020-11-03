part of 'contact_bloc.dart';

@immutable
abstract class ContactState extends Equatable {}

class ContactInitial extends ContactState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SaveContactPageLoadedSucces extends ContactState {
  double latitude;
  double longtitude;

  SaveContactPageLoadedSucces(this.latitude, this.longtitude);

  @override
  // TODO: implement props
  List<Object> get props => [latitude, longtitude];
}

class ContactSavingInProgress extends ContactState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContactSavingSuccess extends ContactState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContactSavingFailure extends ContactState {
  ContactSavingFailure();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class EditContactPageLoadedSuccess extends ContactState {
  Contact contact;
  Set<Marker> markers;

  EditContactPageLoadedSuccess(this.contact, this.markers);

  @override
  // TODO: implement props
  List<Object> get props => [contact, markers];
}

class EditContactPageLoadedSuccess2 extends ContactState {
  Contact contact;
  Set<Marker> markers;

  EditContactPageLoadedSuccess2(this.contact, this.markers);

  @override
  // TODO: implement props
  List<Object> get props => [contact, markers];
}

class ShowAllContacts extends ContactState {
  List<Contact> contacts;

  ShowAllContacts(this.contacts);

  @override
  // TODO: implement props
  List<Object> get props => [contacts];
}

class ContactDeletedSuccess extends ContactState {
  ContactDeletedSuccess();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class ContactUpdateSuccess extends ContactState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class LoadingState extends ContactState {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
