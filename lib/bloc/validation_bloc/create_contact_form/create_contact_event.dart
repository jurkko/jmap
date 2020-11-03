part of 'create_contact_bloc.dart';

@immutable
abstract class CreateContactEvent extends Equatable{}


class NameChanged extends CreateContactEvent {

  NameChanged({@required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class SurnameChanged extends CreateContactEvent {
  SurnameChanged({@required this.surname});

  final String surname;

  @override
  List<Object> get props => [surname];
}

class FormSubmitted extends CreateContactEvent {
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
