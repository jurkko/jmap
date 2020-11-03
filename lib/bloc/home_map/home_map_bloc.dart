import 'dart:async';
import 'package:jmap/models/contact.dart';
import 'package:jmap/services/database_operations.dart';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jmap/services/parseMarkers.dart';
import 'package:meta/meta.dart';

part 'home_map_event.dart';

part 'home_map_state.dart';

class HomeMapBloc extends Bloc<HomeMapEvent, HomeMapState> {
  HomeMapBloc() : super(HomeMapInitial());
  EventParser eventParser = new EventParser();
  Set<Marker> markers;
  Marker tempMarker;
  List<Contact> contacts;

  @override
  Stream<HomeMapState> mapEventToState(
    HomeMapEvent event,
  ) async* {
    if (event is TriggeredHomePage) {
      contacts = await eventParser.getAllContacts();
      if (markers != null) {
        markers.clear();
      }

      markers = await eventParser.transformContactsToMarkers(contacts);
      print('bloc markers' + markers.length.toString());
      yield HomePageLoadSuccess(markers);
    } else if (event is AddedTempMarker) {
      Marker markerTempRemove = markers.firstWhere(
          (marker) => marker.markerId.value == 'temp',
          orElse: () => null);
      markers.remove(markerTempRemove);
      Marker marker = new Marker(
        markerId: MarkerId('temp'),
        position: event.tempMarkerLatLng,
        infoWindow: InfoWindow(title: 'New location'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      );

      markers.add(marker);
      yield HomePageLoadingState();
      yield HomePageLoadSuccess(markers);
    }
  }
}
