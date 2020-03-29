import 'package:flutter/material.dart';
import 'package:line_api_helper/screens/welcome_page.dart';

void main() {
  runApp(Lah());
}

class Lah extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINE API Helper',
      home: WelcomePage(),
    );
  }
}
