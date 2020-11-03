import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jmap/bloc/contact/contact_bloc.dart';
import 'package:jmap/bloc/home_map/home_map_bloc.dart';
import 'package:jmap/bloc/validation_bloc/create_contact_form/create_contact_bloc.dart';

class CreateContact extends StatelessWidget {
  var latitudeController = TextEditingController();
  var longitudeController = TextEditingController();

  Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
          child: BlocBuilder<ContactBloc, ContactState>(
            builder: (context, state) {
              String name;
              String surname;

              if (state is SaveContactPageLoadedSucces) {
                print('test ' + state.latitude.toString());
                latitudeController.text = state.latitude.toString();
                longitudeController.text = state.longtitude.toString();

                return Column(
                  children: [
                    TextButton(
                      child: Row(
                        children: [
                          Icon(Icons.arrow_back_ios_rounded),
                          Text(
                            'Back',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      onPressed: () {
                        Navigator.of(context).pushNamed('/');
                      },
                    ),
                    BlocBuilder<CreateContactBloc, CreateContactState>(
                      buildWhen: (previous, current) =>
                          previous.name != current.name,
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Name',
                              errorText:
                                  state.name.invalid ? 'Invalid Name' : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              context
                                  .bloc<CreateContactBloc>()
                                  .add(NameChanged(name: value));
                              name = value;
                            },
                          ),
                        );
                      },
                    ),
                    BlocBuilder<CreateContactBloc, CreateContactState>(
                      buildWhen: (previous, current) =>
                          previous.surname != current.surname,
                      builder: (context, state) {
                        return Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Surname',
                              errorText: state.surname.invalid
                                  ? 'Invalid Surname'
                                  : null,
                            ),
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              context
                                  .bloc<CreateContactBloc>()
                                  .add(SurnameChanged(surname: value));
                              surname = value;
                            },
                          ),
                        );
                      },
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextField(
                                  controller: latitudeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Lat',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextField(
                                  controller: longitudeController,
                                  readOnly: true,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: 'Len',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        BlocProvider.of<ContactBloc>(context).add(
                            ContactSaveStarted(
                                name,
                                surname,
                                latitudeController.text,
                                longitudeController.text));
                      },
                      child: Container(
                        child: Center(
                          child: Text(
                            'Add new contact',
                            style: TextStyle(color: Colors.white,
                            fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        width: 200,
                        height: 50,
                      ),
                    ),
                  ],
                );
              } else if (state is ContactSavingSuccess) {
                BlocProvider.of<HomeMapBloc>(context).add(TriggeredHomePage());
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(

                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text('Contact successfully Added!',
                          style: TextStyle(color: Colors.black,
                              fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,),
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
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              width: 200,
                              height: 50,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
              } else
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(

                      children: [
                        SizedBox(
                          height: 100,
                        ),
                        Text('No marker selected !',
                          style: TextStyle(color: Colors.black,
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,),
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
                                  style: TextStyle(color: Colors.white,
                                      fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(10)
                              ),
                              width: 200,
                              height: 50,
                            ),
                          ),
                        ),

                      ],
                    ),
                  ),
                );
            },
          ),
        ),
      ),
    );
  }
}
