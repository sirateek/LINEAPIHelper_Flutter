import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(28, 201, 106, 1),
        title: Text(
          "LINE API Helper",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
