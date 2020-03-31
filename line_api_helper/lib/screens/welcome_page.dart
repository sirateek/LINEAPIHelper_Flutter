import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_api_helper/components/notification/informbox_component.dart';
import 'package:line_api_helper/screens/main_page.dart';
import 'package:line_api_helper/services/credential_service.dart';
import 'package:url_launcher/url_launcher.dart';

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool obscuretext = true;
  var channelAccessTokenTextField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromRGBO(6, 207, 152, 1),
            Color.fromRGBO(3, 200, 147, 1),
            Color.fromRGBO(0, 160, 243, 1),
            Color.fromRGBO(2, 130, 255, 1)
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Image.asset("assets/images/logo.png"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 15),
                    ),
                    Text(
                      'Welcome to LINE API Helper',
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 5),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "LINE API Helper (LAH) are the tools helping you develop with LINE API easier.",
                        style: TextStyle(
                            fontSize: 20, fontStyle: FontStyle.italic),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(15, 20, 15, 0),
                      child: Text(
                        "Please enter your Channel Access Token of your Channel you want to control",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30),
                      child: TextField(
                        controller: channelAccessTokenTextField,
                        obscureText: obscuretext,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                obscuretext
                                    ? obscuretext = false
                                    : obscuretext = true;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye),
                          ),
                          labelText: "Your Channel Access Token",
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20),
                      child: Text(
                        "** Your Channel Access Token won't be stored in any online storage for your security (Which mean you need to provide your Channel Access Token every time you come back.). **",
                        style: TextStyle(color: Color.fromRGBO(252, 3, 90, 1)),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                        child: RaisedButton(
                          color: Colors.green,
                          onPressed: () {
                            if (channelAccessTokenTextField.text.length == 0) {
                              return informBox(context,
                                  iconData:
                                      FontAwesomeIcons.exclamationTriangle,
                                  color: Color.fromRGBO(237, 211, 14, 1),
                                  title: "Warning",
                                  content:
                                      "Please provided your Channel Access Token in the textbox (You Channel Access Token won't be stored)");
                            }
                            /* if (channelAccessTokenTextField.text.length !=
                                172) {
                              return informBox(context,
                                  iconData: FontAwesomeIcons.exclamationCircle,
                                  color: Color.fromRGBO(252, 3, 90, 1),
                                  title: "Error",
                                  content:
                                      "The Channel Access Token must contain 172 charactors.");
                            } */
                            credential.channelAccessToken =
                                channelAccessTokenTextField.text;
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MainPage(),
                              ),
                            );
                            informBox(context,
                                iconData: FontAwesomeIcons.infoCircle,
                                color: Color.fromRGBO(28, 201, 106, 1),
                                title: "Welcome to LINE API Helper",
                                content:
                                    "You can now start using LINE API Helper, Enjoy!");
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              "Start using LINE API Helper",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Develop & Share with ",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          FaIcon(
                            FontAwesomeIcons.solidHeart,
                            color: Colors.redAccent,
                          ),
                          Text(" by",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          FlatButton(
                            onPressed: () async {
                              if (await canLaunch("https://sirateek.dev")) {
                                launch("https://sirateek.dev");
                              }
                            },
                            child: Text(
                              "Siratee K.",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
