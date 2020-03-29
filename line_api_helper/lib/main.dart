import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'LINE API Helper',
      home: WelcomePage(),
    );
  }
}

class WelcomePage extends StatefulWidget {
  WelcomePage({Key key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  bool obscuretext = true;
  bool agreement = true;
  var channelAccessTokenTextField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(64, 64, 64, 1),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Image.asset("assets/images/messagingAPI.png"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                  ),
                  Text(
                    'Welcome to LINE API Helper',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Text(
                      "LINE API Helper (LAH) are the tools helping you develop with LINE API easier.",
                      style:
                          TextStyle(fontSize: 20, fontStyle: FontStyle.italic),
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
                  Wrap(
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: <Widget>[
                      Checkbox(
                        onChanged: (bool newValue) {
                          setState(() {
                            agreement = newValue;
                          });
                        },
                        value: agreement,
                      ),
                      Text(
                        "I accept to the LINE API Helper term of use.",
                        textAlign: TextAlign.center,
                      ),
                      FlatButton(
                        child: Text(
                          "Read term of use",
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                      child: RaisedButton(
                        color: Colors.green,
                        onPressed: () {
                          print(channelAccessTokenTextField.text.length);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            "Start using LINE API Helper",
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
                          onPressed: () {},
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
    );
  }
}
