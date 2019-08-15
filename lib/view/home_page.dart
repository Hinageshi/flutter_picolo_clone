import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

//TODO : change colors (find a nice color scheme)

class _HomePageState extends State<HomePage> {
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
                padding: EdgeInsets.all(12.0),
                child: Icon(
                  Icons.settings,
                  size: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 150.0),
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
                      height: 170.0,
                      color: Colors.blue[300],
                      child: Center(
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(20.0)),
                          color: Colors.white,
                          onPressed: () {},
                          child: Padding(
                            padding:
                                EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 20.0),
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
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
