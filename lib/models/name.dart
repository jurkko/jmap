import 'package:formz/formz.dart';

enum NameValidationError { invalid }

class Name extends FormzInput<String, NameValidationError> {
  const Name.pure() : super.pure('');

  const Name.dirty([String value = '']) : super.dirty(value);

  static final _NameRegex =
  RegExp(r'^(?=.*[A-Za-z])[A-Za-z\d]{1,}$');

  @override
  NameValidationError validator(String value) {
    return _NameRegex.hasMatch(value) ? null : NameValidationError.invalid;
  }
}
