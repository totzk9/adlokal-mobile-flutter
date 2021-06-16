import 'package:adlokal/auth/domain/logic/password_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

@immutable
class Password {
  factory Password(String input) => Password._(password(input));

  const Password._(this.value);

  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is Password && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EmailAddress($value)';
}

class InvalidPasswordException implements Exception {
  InvalidPasswordException({required this.failedValue});

  final String failedValue;
}
