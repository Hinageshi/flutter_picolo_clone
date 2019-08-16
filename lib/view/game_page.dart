import 'dart:collection';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picolo_clone/model/display_element.dart';
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
  ListQueue<DisplayElement> elementsToDisplay;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
    elementsToDisplay = ListQueue();
    widget.rules.forEach((Rule rule) {
      if (rule.nbPlayers != 0) {
        List<Player> playersRule = getRandomPlayers(rule.nbPlayers);
        String ruleContent = rule.content;
        for (int i = 0; i < rule.nbPlayers; i++) {
          ruleContent = ruleContent.replaceAll(
              "{{${i.toString()}}}", playersRule[i].name);
        }
        elementsToDisplay.addLast(new DisplayElement(
            getPrimaryColor(rule), rule.typeAsString, ruleContent));
      } else
        elementsToDisplay.addLast(new DisplayElement(
            getPrimaryColor(rule), rule.typeAsString, rule.content));
    });
  }

  List<Player> getRandomPlayers(int nb) {
    List<Player> playersList = [];
    if (nb > 0 && nb <= widget.players.length) {
      while (playersList.length != nb) {
        var random = new Random();
        int nb = random.nextInt(widget.players.length);
        if (!playersList.contains(widget.players[nb]))
          playersList.add(widget.players[nb]);
      }
    } else {
      if (nb < 0) throw new Exception("Number can't be negative.");
      if (nb > widget.players.length)
        throw new Exception(
            "Number can't be superior to number of players. Current number of players is ${widget.players.length}");
    }
    return playersList;
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
              elementsToDisplay.length == 0
                  ? Navigator.of(context).pop()
                  : setState(() {
                      elementsToDisplay.removeFirst();
                    });
            },
            child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: elementsToDisplay.length > 0
                            ? [
                                elementsToDisplay.elementAt(0).backgroundColor,
                                elementsToDisplay
                                    .elementAt(0)
                                    .backgroundColor[300]
                              ]
                            : [Colors.purple, Colors.purple[300]],
                        stops: [0.8, 1.0])),
                child: Center(
                    child: elementsToDisplay.length > 0
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(elementsToDisplay.elementAt(0).title,
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
                                child: Text(
                                    elementsToDisplay.elementAt(0).content,
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
