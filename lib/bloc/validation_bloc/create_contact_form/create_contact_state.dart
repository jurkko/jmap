part of 'create_contact_bloc.dart';

@immutable
class CreateContactState extends Equatable {
  const CreateContactState({
    this.name = const Name.pure(),
    this.surname = const Surname.pure(),
    this.status = FormzStatus.pure,
  });


  final Name name;
  final Surname surname;
  final FormzStatus status;

  CreateContactState copyWith({
    Name name,
    Surname surname,
    FormzStatus status,
  }) {
    return CreateContactState(
      surname: surname ?? this.surname,
      name: name ?? this.name,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, surname, status];
}


