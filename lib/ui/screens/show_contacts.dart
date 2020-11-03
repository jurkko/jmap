import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmap/bloc/contact/contact_bloc.dart';
import 'package:jmap/bloc/home_map/home_map_bloc.dart';
import 'package:jmap/models/contact.dart';

class ShowContacts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jmap'),
        actions: <Widget>[
          FlatButton(
            textColor: Colors.white,
            onPressed: () {
              BlocProvider.of<HomeMapBloc>(context).add(TriggeredHomePage());
            },
            shape: CircleBorder(side: BorderSide(color: Colors.transparent)),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 40, 8, 20),
        child:
            BlocBuilder<ContactBloc, ContactState>(builder: (context, state) {
          if (state is ShowAllContacts) {
            List<Contact> contacts = state.contacts;

            return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Center(
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(' ${contacts[index].name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                         Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.blue)),
                                    color: Colors.orange[200],
                                    onPressed: () {
                                      BlocProvider.of<ContactBloc>(context).add(
                                          TriggeredEditContactPage(
                                              contacts[index].id));
                                      Navigator.of(context)
                                          .pushNamed('/editContact');
                                    },
                                    child: Text(
                                      'Edit',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FlatButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        side: BorderSide(color: Colors.blue)),
                                    color: Colors.redAccent,
                                    onPressed: () {
                                      BlocProvider.of<ContactBloc>(context).add(
                                          DeleteContact(contacts[index].id));
                                    },
                                    child: Text(
                                      'Delete',
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                          BlocBuilder<ContactBloc, ContactState>(
                              builder: (context, innerState) {
                            if (state is ContactDeletedSuccess) {
                              return AlertDialog(
                                title: Text('Contact Deleted'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: <Widget>[
                                      Text(
                                          'Choosen contact succesfully deleted'),
                                    ],
                                  ),
                                ),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Approve'),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pushNamed('/showContacts');
                                      BlocProvider.of<ContactBloc>(context)
                                          .add(TriggeredShowContactsPage());
                                    },
                                  ),
                                ],
                              );
                            } else
                              return Container();
                          })
                        ],
                      ),
                    ),
                  );
                });
          } else if (state is ContactDeletedSuccess) {
            return AlertDialog(
              title: Text('Contact Succesfully deleted'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    Text(
                        'Choosen contact was succesfully deleted from database'),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text('Ok'),
                  onPressed: () {
                    BlocProvider.of<HomeMapBloc>(context)
                        .add(TriggeredHomePage());
                    Navigator.of(context).pushNamed('/showContacts');
                    BlocProvider.of<ContactBloc>(context)
                        .add(TriggeredShowContactsPage());
                  },
                ),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }),
      ),
    );
  }
}
