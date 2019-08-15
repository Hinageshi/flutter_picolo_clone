import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picolo_clone/model/quote.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//TODO : change colors (find a nice color scheme)
//TODO : add settingd
//TODO : add email
//TODO : add credits
//TODO : create a service that handles JSON loading only one time and make it available with Provider.

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
  }

  Future<Quote> getRandomQuote() async {
    String quotes =
        await DefaultAssetBundle.of(context).loadString("lib/data/quotes.json");
    final jsonData = json.decode(quotes);
    var random = new Random();
    int nb = random.nextInt(jsonData["number_of_quotes"] - 1);
    return new Quote(jsonData["quotes"][nb]["quote"],
        author: jsonData["quotes"][nb]["author"]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: Center(
        child: Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Icon(
                  Icons.settings,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.0),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 30.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "BIB'INSA",
                          style: TextStyle(
                              fontFamily: 'Comix-Loud',
                              color: Colors.white,
                              fontSize: 35.0),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  FutureBuilder<Quote>(
                      future: getRandomQuote(),
                      builder: (BuildContext context,
                          AsyncSnapshot<Quote> snapshot) {
                        if (snapshot.hasData) {
                          return Padding(
                            padding: EdgeInsets.only(left: 50.0, right: 50.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                ConstrainedBox(
                                  constraints: BoxConstraints(),
                                  child: Text(snapshot.data.content,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 15.0),
                                  child: Row(
                                    children: <Widget>[
                                      Expanded(child: Container()),
                                      ConstrainedBox(
                                        constraints: BoxConstraints(
                                            maxWidth: MediaQuery.of(context)
                                                    .size
                                                    .width -
                                                100.0),
                                        child: Text("- ${snapshot.data.author}",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontStyle: FontStyle.italic),
                                            textAlign: TextAlign.right),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else {
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      height: 190.0,
                      child: Image.asset("assets/images/race.png"),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.blue[300], Colors.indigo],
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(30.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(bottom: 20.0),
                              child: RaisedButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(20.0)),
                                color: Colors.white,
                                onPressed: () {},
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(
                                      20.0, 30.0, 20.0, 20.0),
                                  child: Text(
                                    "PLAY",
                                    style: TextStyle(
                                        fontFamily: 'Comix-Loud',
                                        color: Colors.blue[300],
                                        fontSize: 30.0),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.envelope,
                                      color: Colors.white, size: 30.0),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: Icon(FontAwesomeIcons.question,
                                      color: Colors.white, size: 30.0),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
