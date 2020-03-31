import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_api_helper/components/rich_menu_helper/floating_action_button.dart';
import 'package:line_api_helper/screens/home_page/home_page.dart';
import 'package:line_api_helper/screens/rich_menu_helper/rich_menu_helper_main_page.dart';
import 'package:line_api_helper/screens/welcome_page.dart';
import 'package:line_api_helper/services/credential_service.dart';

class MainPage extends StatefulWidget {
  MainPage({Key key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  String pageTitle = "Home";
  Widget body;
  Widget floatingActionButton;
  @override
  void initState() {
    super.initState();
    body = HomePage();
  }

  void pageSwitcher(String page) {
    switch (page) {
      case "Home":
        {
          setState(
            () {
              pageTitle = "Home";
              body = HomePage();
              floatingActionButton = null;
            },
          );
        }
        break;
      case "RichMenuHelper":
        {
          setState(
            () {
              pageTitle = "Rich Menu Helper";
              body = RichMenuHelper();
              floatingActionButton =
                  richMenuHelperFloatingActionButton(context);
            },
          );
        }
        break;

      default:
        {
          setState(
            () {
              pageTitle = "Unknown Page";
              body = Center(
                child: Text("404 Page not found"),
              );
              floatingActionButton = null;
            },
          );
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(61, 61, 61, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(6, 207, 152, 1),
        title: Text(
          pageTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          Center(
            child: Text(
              "You are logged in as: " +
                  credential.channelAccessToken.substring(0, 5) +
                  "****...",
              style:
                  TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
          ),
          IconButton(
            tooltip: "Logout",
            icon: FaIcon(
              FontAwesomeIcons.powerOff,
              color: Color.fromRGBO(255, 89, 119, 1),
            ),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => WelcomePage()),
              );
            },
          )
        ],
      ),
      floatingActionButton: floatingActionButton,
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Image.asset("assets/images/logo.png"),
              ),
              decoration: BoxDecoration(
                color: Color.fromRGBO(77, 77, 77, 1),
              ),
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.home),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  Text(
                    'Home',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                pageSwitcher("Home");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.caretSquareRight),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  Text(
                    'Rich Menu Helper',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {
                pageSwitcher("RichMenuHelper");
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: Row(
                children: <Widget>[
                  FaIcon(FontAwesomeIcons.locationArrow),
                  Padding(
                    padding: const EdgeInsets.all(10),
                  ),
                  Text(
                    'Narrow Cast Helper',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )
                ],
              ),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: body,
    );
  }
}
