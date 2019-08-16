import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picolo_clone/model/player.dart';
import 'package:flutter_picolo_clone/model/rule.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO : manage to end viruses and bugs

class GamePage extends StatefulWidget {
  final List<Player> players;
  final List<Rule> rules;

  GamePage(List<Player> players, List<Rule> rules, {Key key})
      : this.players = players,
        this.rules = rules,
        super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  ListQueue<Rule> rulesToDisplay;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    rulesToDisplay = ListQueue<Rule>()..addAll(widget.rules);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  MaterialColor getPrimaryColor(Rule rule) {
    switch (rule.type) {
      case Type.RULE:
        return Colors.blue;
      case Type.BUG:
        return Colors.teal;
      case Type.GAME:
        return Colors.green;
      case Type.SHOT:
        return Colors.red;
      case Type.VIRUS:
        return Colors.amber;
      default:
        return Colors.purple;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              rulesToDisplay.length == 0
                  ? Navigator.of(context).pop()
                  : setState(() {
                      rulesToDisplay.removeFirst();
                    });
            },
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: rulesToDisplay.length > 0
                            ? [
                                getPrimaryColor(rulesToDisplay.elementAt(0)),
                                getPrimaryColor(
                                    rulesToDisplay.elementAt(0))[300]
                              ]
                            : [Colors.purple, Colors.purple[300]],
                        stops: [0.8, 1.0])),
                child: Center(
                    child: rulesToDisplay.length > 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(rulesToDisplay.elementAt(0).typeAsString,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontFamily: 'Comix-Loud'),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 40.0),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    maxWidth:
                                        MediaQuery.of(context).size.width /
                                            1.2),
                                child: Text(rulesToDisplay.elementAt(0).content,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 30.0),
                                    textAlign: TextAlign.center),
                              )
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text("GAME OVER",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30.0,
                                      fontFamily: 'Comix-Loud'),
                                  textAlign: TextAlign.center),
                              SizedBox(height: 40.0),
                              Text("Alors, qui est le plus mort ?",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30.0),
                                  textAlign: TextAlign.center),
                            ],
                          ))),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, left: 10.0),
            child: IconButton(
              icon: Icon(FontAwesomeIcons.arrowLeft),
              color: Colors.white,
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
        ],
      ),
    );
  }
}
