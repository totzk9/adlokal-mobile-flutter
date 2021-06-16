import 'package:flutter/material.dart';

class SplashUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
