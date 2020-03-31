import 'package:flutter/material.dart';
import 'package:line_api_helper/screens/rich_menu_helper/create_rich_menu.dart';

FloatingActionButton richMenuHelperFloatingActionButton(BuildContext context) {
  return FloatingActionButton(
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CreateRichMenu()),
      );
    },
    tooltip: "Create a new Rich Menu",
    child: Icon(Icons.add),
  );
}
