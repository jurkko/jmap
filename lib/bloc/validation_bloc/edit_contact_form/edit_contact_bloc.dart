import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'edit_contact_event.dart';
part 'edit_contact_state.dart';

class EditContactBloc extends Bloc<EditContactEvent, EditContactState> {
  EditContactBloc() : super(EditContactInitial());

  @override
  Stream<EditContactState> mapEventToState(
    EditContactEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
