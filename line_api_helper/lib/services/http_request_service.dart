import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:line_api_helper/components/notification/informbox_component.dart';

dynamic httpRequest(BuildContext context,
    {String uri, String method, String headers, String body}) async {
  var response;
  Map<String, String> requestBody = {
    "uri": uri,
    "method": method,
    "headers": headers,
  };

  if (body != null) {
    requestBody["body"] = body;
  }
  try {
    response = await http.post(
        "https://asia-east2-sirateek-me.cloudfunctions.net/lah",
        body: requestBody);
    return response;
  } catch (e) {
    print(e);
    Navigator.pop(context);
    return informBox(context,
        iconData: FontAwesomeIcons.exclamationCircle,
        color: Color.fromRGBO(252, 3, 90, 1),
        title: "Error",
        content: "An error occurred: " + e.toString());
  }
}
