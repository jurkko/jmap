import 'package:formz/formz.dart';

enum SurnameValidationError { invalid }

class Surname extends FormzInput<String, SurnameValidationError> {
  const Surname.pure() : super.pure('');

  const Surname.dirty([String value = '']) : super.dirty(value);

  static final _SurnameRegex = RegExp(r'^(?=.*[A-Za-z])[A-Za-z\d]{1,}$');

  @override
  SurnameValidationError validator(String value) {
    return _SurnameRegex.hasMatch(value) ? null : SurnameValidationError.invalid;
  }
}
