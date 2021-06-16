import 'package:adlokal/auth/domain/entities/password.dart';
import 'package:get/get.dart';

String password(String value) {
  const String pattern = r'^.{6,}$';
  final RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'validator.password'.tr;
  else
    throw InvalidPasswordException(failedValue: value);
}