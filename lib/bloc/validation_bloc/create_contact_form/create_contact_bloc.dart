import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:jmap/models/name.dart';
import 'package:jmap/models/surname.dart';
import 'package:meta/meta.dart';

part 'create_contact_event.dart';
part 'create_contact_state.dart';

class CreateContactBloc extends Bloc<CreateContactEvent, CreateContactState> {
  CreateContactBloc() : super(CreateContactState());

  @override
  Stream<CreateContactState> mapEventToState(
    CreateContactEvent event,
  ) async* {
    if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name,
        status: Formz.validate([name, state.surname]),
      );
    } else if (event is SurnameChanged) {
      final surname = Surname.dirty(event.surname);
      yield state.copyWith(
        surname: surname,
        status: Formz.validate([state.name, surname]),
      );
    } else if (event is FormSubmitted) {
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        await Future<void>.delayed(const Duration(seconds: 1));
        yield state.copyWith(status: FormzStatus.submissionSuccess);
      }
    }

  }
}
