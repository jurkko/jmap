part of 'home_map_bloc.dart';

@immutable
abstract class HomeMapEvent extends Equatable {}

class TriggeredHomePage extends HomeMapEvent {


  @override
  List<Object> get props => [];
}

class AddedTempMarker extends HomeMapEvent {
  Set<Marker> markers;
  LatLng tempMarkerLatLng;

  AddedTempMarker(this.markers, this.tempMarkerLatLng);


  @override
  List<Object> get props => [markers];
}

class EditContacts extends HomeMapEvent {


  EditContacts();


  @override
  List<Object> get props => [];
}