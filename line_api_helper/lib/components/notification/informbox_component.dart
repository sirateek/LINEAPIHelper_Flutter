import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_api_helper/components/notification/messagebox_component.dart';

void informBox(BuildContext context,
    {IconData iconData, Color color, String title, String content}) {
  return messageBox(
      context,
      Row(
        children: <Widget>[
          FaIcon(
            iconData ?? FontAwesomeIcons.infoCircle,
            color: color ?? Color.fromRGBO(0, 0, 0, 1),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
          ),
          Flexible(
            child: Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
      Text(content));
}
