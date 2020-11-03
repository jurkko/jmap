import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jmap/bloc/contact/contact_bloc.dart';
import 'package:jmap/bloc/home_map/home_map_bloc.dart';

class EditContact extends StatelessWidget {
  var nameController = TextEditingController();
  var surnameController = TextEditingController();
  Set<Marker> markers;
  LatLng position;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jmap'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushNamed('/showContacts');

              BlocProvider.of<ContactBloc>(context).add(TriggeredShowContactsPage());
            },
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
          child:
              BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
            if (state is EditContactPageLoadedSuccess) {
              markers = state.markers;
              final CameraPosition _currentPosition = CameraPosition(
                target: LatLng(state.contact.latitude, state.contact.longitude),
                zoom: 14.4746,
              );
              nameController.text = state.contact.name;
              surnameController.text = state.contact.surname;

              String newName = nameController.text;
              String newSurname = surnameController.text;
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text('Edit contact',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Name',
                      ),
                      onChanged: (nameValue) {
                        newName = nameValue;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: TextField(
                      controller: surnameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Surname',
                      ),
                      onChanged: (surnameValue) {
                        newSurname = surnameValue;
                      },
                    ),
                  ),
                  SizedBox(
                    width: 400,
                    height: 300,
                    child: GoogleMap(
                      zoomControlsEnabled: false,
                      initialCameraPosition: _currentPosition,
                      markers: markers,
                      onMapCreated: (GoogleMapController controller) {},
                      onTap: (location) {
                        position =
                            LatLng(location.latitude, location.longitude);
                        BlocProvider.of<ContactBloc>(context)
                            .add(ChangedMarker(state.contact, position));
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: GestureDetector(
                      onTap: () {
                        BlocProvider.of<ContactBloc>(context).add(UpdateContact(
                            state.contact.id,
                            newName,
                            newSurname,
                            position.latitude,
                            position.longitude));
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        width: 200,
                        height: 50,
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is LoadingState) {
              return CircularProgressIndicator();
            } else if (state is ContactSavingSuccess) {
              markers.clear();
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                      ),
                      Text(
                        'Contact successfully Edited!',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushNamed('/');
                       
                          },
                          child: Container(
                            child: Center(
                              child: Text(
                                'Back to main page',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(10)),
                            width: 200,
                            height: 50,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Text('Something went wrong :(');
            }
          }),
        ),
      ),
    );
  }
}
