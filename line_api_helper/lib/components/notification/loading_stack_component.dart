import 'package:flutter/material.dart';

void loadingStack(BuildContext context, {String label}) async {
  return showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Center(
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Padding(
                      padding: const EdgeInsets.all(10),
                    ),
                    Text(
                      label ?? "Loading. . .",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
