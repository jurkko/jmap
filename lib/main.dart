import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jmap/bloc/validation_bloc/create_contact_form/create_contact_bloc.dart';
import 'app.dart';
import 'bloc/contact/contact_bloc.dart';
import 'bloc/home_map/home_map_bloc.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => HomeMapBloc()..add(TriggeredHomePage()),
        ),
        BlocProvider(
          create: (context) => ContactBloc(),
        ),
        BlocProvider(
          create: (context) => CreateContactBloc(),
        ),
      ],
      child: Jmap(),
    ),
  );
}
