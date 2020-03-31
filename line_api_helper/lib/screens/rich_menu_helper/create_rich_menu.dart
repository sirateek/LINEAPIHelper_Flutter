import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'dart:html';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_api_helper/components/notification/informbox_component.dart';
import 'package:line_api_helper/components/notification/loading_stack_component.dart';
import 'package:image/image.dart' as I;
import 'package:line_api_helper/services/credential_service.dart';
import 'package:line_api_helper/services/http_request_service.dart';

class CreateRichMenu extends StatefulWidget {
  CreateRichMenu({Key key}) : super(key: key);

  @override
  _CreateRichMenuState createState() => _CreateRichMenuState();
}

class _CreateRichMenuState extends State<CreateRichMenu> {
  Uint8List uploadedImage;
  var payloadTextController = TextEditingController();
  void _startFilePicker() async {
    InputElement uploadInput = FileUploadInputElement();
    uploadInput.click();

    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files.length == 1) {
        final file = files[0];
        FileReader reader = FileReader();

        reader.onLoadEnd.listen((e) {
          setState(() {
            uploadedImage = reader.result;
          });
          print(uploadedImage);
        });

        reader.onError.listen((fileEvent) {
          informBox(context,
              iconData: FontAwesomeIcons.info,
              color: Colors.red,
              content: "Error");
        });

        reader.readAsArrayBuffer(file);
      }
    });
  }

  void startUploadRichmenu() async {
    loadingStack(context, label: "Creating a new Rich Menu. . .");
    var payload = payloadTextController.text;
    var response = await httpRequest(context,
        uri: "https://api.line.me/v2/bot/richmenu",
        method: "POST",
        headers: '{"Authorization": "Bearer ' +
            credential.channelAccessToken +
            '", "Content-Type": "application/json"}',
        body: payload);
    if (response.statusCode != 200) {
      Map<String, dynamic> responseDecode =
          jsonDecode(response.body ?? {"message": "Error"});
      Navigator.pop(context);
      return informBox(context,
          iconData: FontAwesomeIcons.exclamationCircle,
          color: Color.fromRGBO(252, 3, 90, 1),
          title: "Error",
          content: responseDecode["message"]);
    }
    Map<String, dynamic> responseDecode =
        jsonDecode(response.body ?? {"richmenuId": []});
    var richmenuId = responseDecode["richMenuId"];
    print(richmenuId);
    var uploadImageResponse = await httpRequest(context,
        uri: "https://api-data.line.me/v2/bot/richmenu/" +
            richmenuId +
            "/content",
        method: "POST",
        headers: '{"Authorization": "Bearer ' +
            credential.channelAccessToken +
            '", "Content-Type": "image/png"}',
        body: uploadedImage.buffer.asByteData().toString());
    if (uploadImageResponse.statusCode != 200) {
      Map<String, dynamic> responseDecode =
          jsonDecode(uploadImageResponse.body ?? {"message": "Error"});
      Navigator.pop(context);
      return informBox(context,
          iconData: FontAwesomeIcons.exclamationCircle,
          color: Color.fromRGBO(252, 3, 90, 1),
          title: "Error",
          content: responseDecode["message"]);
    }
    Navigator.pop(context);
    informBox(context,
        iconData: FontAwesomeIcons.exclamationCircle,
        color: Color.fromRGBO(252, 3, 90, 1),
        title: "Successfully",
        content: "Successfully to create Rich Menu with id : " + richmenuId);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(61, 61, 61, 1),
      appBar: AppBar(
        title: Text(
          "Create a new Rich Menu",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  TextField(
                    controller: payloadTextController,
                    autocorrect: false,
                    enableSuggestions: false,
                    maxLines: 20,
                    decoration: InputDecoration(
                      labelText: "Enter your Rich Menu payload",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  uploadedImage != null
                      ? Image.memory(
                          uploadedImage,
                          scale: 5,
                        )
                      : Text("Please select your Rich Menu image"),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  RaisedButton(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FaIcon(FontAwesomeIcons.image),
                        Padding(
                          padding: const EdgeInsets.all(10),
                        ),
                        Text("Pick your Rich Menu image")
                      ],
                    ),
                    onPressed: () {
                      _startFilePicker();
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Color.fromRGBO(66, 135, 245, 1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Row(
                              children: <Widget>[
                                FaIcon(FontAwesomeIcons.plusSquare,
                                    color: Colors.white),
                                Padding(
                                  padding: const EdgeInsets.all(5),
                                ),
                                Text(
                                  "Create a new Rich Menu",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () {
                            if (payloadTextController.text == null ||
                                uploadedImage == null) {
                              return informBox(context,
                                  iconData:
                                      FontAwesomeIcons.exclamationTriangle,
                                  color: Color.fromRGBO(245, 197, 66, 1),
                                  title: "Error",
                                  content:
                                      "Please upload your Rich Menu Payload and Image before create a new Rich menu");
                            } else {
                              startUploadRichmenu();
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
