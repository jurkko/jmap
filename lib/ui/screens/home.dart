import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jmap/bloc/contact/contact_bloc.dart' as ContactBlocHome;
import 'package:jmap/bloc/contact/contact_bloc.dart';
import 'package:jmap/bloc/home_map/home_map_bloc.dart';

class HomeScreen extends StatelessWidget {
  Set<Marker> markers;
  int initialMarkersLength;
  Completer<GoogleMapController> _controller = Completer();
  double latitude;
  double longitude;

  static final CameraPosition maribor = CameraPosition(
    target: LatLng(46.562483, 15.643975),
    zoom: 14.4746,
  );

  Set<Marker> checkMarkers(Set<Marker> stateMarkers) {
    stateMarkers.forEach((marker) {
      print('Position: ${marker.position}');
    });
    return stateMarkers;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return BlocBuilder<HomeMapBloc, HomeMapState>(
      builder: (context, state) {
        if (state is HomePageLoadSuccess) {
          initialMarkersLength = state.markers.length;
          checkMarkers(state.markers);
          markers = state.markers;
          return Scaffold(
            appBar: AppBar(title: Text('Jmap'),actions: <Widget>[
              FlatButton(
                textColor: Colors.white,
                onPressed: () {
                                  Navigator.of(context).pushNamed('/showContacts');
                  BlocProvider.of<ContactBloc>(context).add(TriggeredShowContactsPage());


                },
                child: Text("Edit"),
                shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
              ),
            ],),
            floatingActionButton: FloatingActionButton(
                child: Icon(Icons.add),
                heroTag: null,
                onPressed: () {
                  Navigator.of(context).pushNamed('/createContact');
                }),
            body: Stack(children: [
              Expanded(
                child: GoogleMap(
                  initialCameraPosition: maribor,
                  zoomControlsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);
                    checkMarkers(state.markers);
                  },
                  markers: Set<Marker>.from(markers),
                  onTap: (tap) {

                    latitude = tap.latitude;
                    longitude = tap.longitude;
                    print(latitude.toString());
                    print(longitude.toString());

                    LatLng tempLatLng = new LatLng(latitude, longitude);

                    BlocProvider.of<ContactBlocHome.ContactBloc>(context).add(
                        ContactBlocHome.TriggeredContactSavePage(
                            latitude, longitude));






                    BlocProvider.of<HomeMapBloc>(context)
                        .add(AddedTempMarker(markers, tempLatLng));



                  },
                ),
              ),
//              Opacity(
//                  opacity: 1.0,
//                  child: Container(width: width, height:100, color: Colors.red)),
            ]),
          );
        }
        return CircularProgressIndicator();
      },
    );
  }
}
//Scaffold(
//floatingActionButton: FloatingActionButton(
//heroTag: null,
//onPressed: () {
//Navigator.of(context).pushNamed('/createContact');
//}),
//body: Stack(children: [
//GoogleMap(
//initialCameraPosition: _kGooglePlex,
//onMapCreated: (GoogleMapController controller) {
//_controller.complete(controller);
//},
//markers: markers,
//onTap: (tap) {
//latitude = tap.latitude;
//longitude = tap.longitude;
//print(latitude.toString());
//print(longitude.toString());
//BlocProvider.of<ContactBloc>(context)
//    .add(TriggeredContactSavePage(latitude, longitude));
//},
//),
//
//]),
//);
