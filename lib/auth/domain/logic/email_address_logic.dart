import 'package:adlokal/auth/domain/entities/email_address.dart';
import 'package:get/get.dart';

String email(String value) {
  const String pattern = r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+';
  final RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value))
    return 'validator.email'.tr;
  else
    throw InvalidEmailException(failedValue: value);
}