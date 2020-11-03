import 'package:flutter/material.dart';
import 'package:jmap/ui/screens/create_contact.dart';
import 'package:jmap/ui/screens/edit_contact.dart';
import 'package:jmap/ui/screens/show_contacts.dart';
import 'package:jmap/ui/screens/home.dart';

class Jmap extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => HomeScreen(),
        '/createContact': (context) => CreateContact(),
        '/showContacts': (context) => ShowContacts(),
        '/editContact': (context) => EditContact(),
      },
      initialRoute: '/',
    );
  }
}
