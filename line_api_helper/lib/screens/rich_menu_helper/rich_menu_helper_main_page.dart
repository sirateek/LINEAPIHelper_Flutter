import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:line_api_helper/services/credential_service.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RichMenuHelper extends StatefulWidget {
  RichMenuHelper({Key key}) : super(key: key);

  @override
  _RichMenuHelperState createState() => _RichMenuHelperState();
}

class _RichMenuHelperState extends State<RichMenuHelper> {
  List richMenus = [];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  String statusText = "Loading . . .";
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    getRichMenu();
  }

  void getRichMenu() async {
    var response;
    try {
      response = await http.post(
        "https://asia-east2-sirateek-me.cloudfunctions.net/lah",
        body: {
          "uri": "https://api.line.me/v2/bot/richmenu/list",
          "method": "GET",
          "headers": '{"Authorization": "Bearer ' +
              credential.channelAccessToken +
              '"}'
        },
      );
    } catch (e) {
      print(e);
      return setState(() {
        isLoading = false;
        statusText = "Error: " + e.toString();
      });
    }
    if (response.statusCode != 200) {
      Map<String, dynamic> responseDecode =
          jsonDecode(response.body ?? {"message": "Error"});
      switch (response.statusCode) {
        case 401:
          {
            setState(() {
              isLoading = false;
              statusText =
                  "Your Channel Access Token is invalid (401 Unauthorized request), Please re-login again with the correct Channel Access Token.";
            });
          }
          break;
        default:
          {
            setState(() {
              isLoading = false;
              statusText = responseDecode["message"];
            });
          }
      }
    } else {
      Map<String, dynamic> responseDecode =
          jsonDecode(response.body ?? {"richmenus": []});
      if (responseDecode["richmenus"].length == 0) {
        setState(() {
          isLoading = false;
          statusText =
              "You don't have any Rich menu created with this Channel Access Token. Create a new one!";
        });
      } else {
        setState(() {
          richMenus = responseDecode["richmenus"];
        });
      }
    }
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    if (richMenus.isEmpty) {
      return Container(
        color: Color.fromRGBO(61, 61, 61, 1),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isLoading
                  ? CircularProgressIndicator()
                  : FaIcon(
                      FontAwesomeIcons.exclamationTriangle,
                      color: Color.fromRGBO(245, 197, 66, 1),
                    ),
              Padding(
                padding: const EdgeInsets.all(10),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  statusText,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Container(
        color: Color.fromRGBO(61, 61, 61, 1),
        child: SmartRefresher(
          enablePullDown: true,
          header: ClassicHeader(),
          controller: _refreshController,
          onRefresh: getRichMenu,
          child: ListView.builder(
              itemCount: richMenus.length,
              itemBuilder: (context, index) {
                Map<String, dynamic> richmenuData = richMenus[index];
                return Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                  child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Container(
                          child: InkWell(
                        onTap: () {},
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              leading:
                                  FaIcon(FontAwesomeIcons.caretSquareRight),
                              title: Text(
                                  "Name: " + richmenuData["name"].toString()),
                              subtitle: Text("richMenuId: " +
                                  richmenuData["richMenuId"].toString()),
                              trailing:
                                  FaIcon(FontAwesomeIcons.chevronCircleRight),
                            ),
                          ],
                        ),
                      ))),
                );
              }),
        ),
      );
    }
  }
}
