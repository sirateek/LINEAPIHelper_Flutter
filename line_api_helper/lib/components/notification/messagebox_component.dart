import 'package:flutter/material.dart';

void messageBox(BuildContext context, Widget title, Widget content) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: title,
        content: content,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        actions: <Widget>[
          FlatButton(
            child: Text("Close"),
            onPressed: () => Navigator.pop(context),
          )
        ],
      );
    },
  );
}
