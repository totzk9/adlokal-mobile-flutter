import 'package:flutter/material.dart';

// Model class to hold menu option data (language and theme)
class MenuOptionsModel {
  MenuOptionsModel({required this.key, required this.value, this.icon});

  final String key;
  final String value;
  final IconData? icon;
}
