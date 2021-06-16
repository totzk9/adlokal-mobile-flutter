import 'package:adlokal/auth/domain/logic/email_address_logic.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

@immutable
class EmailAddress {
  factory EmailAddress(String input) => EmailAddress._(email(input));

  const EmailAddress._(this.value);

  final String value;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) {
      return true;
    }
    return other is EmailAddress && other.value == value;
  }

  @override
  int get hashCode => value.hashCode;

  @override
  String toString() => 'EmailAddress($value)';
}

class InvalidEmailException implements Exception {
  InvalidEmailException({required this.failedValue});

  final String failedValue;
}
