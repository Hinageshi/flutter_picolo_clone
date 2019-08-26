import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picolo_clone/model/player.dart';
import 'package:flutter_picolo_clone/model/rule.dart';
import 'package:flutter_picolo_clone/services/json_handler_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'mode_selection.dart';

class PlayersSelectionPage extends StatefulWidget {
  PlayersSelectionPage({Key key}) : super(key: key);

  @override
  _PlayersSelectionPageState createState() => _PlayersSelectionPageState();
}

class _PlayersSelectionPageState extends State<PlayersSelectionPage> {
  Map<int, Widget> playersRows;
  Map<int, TextEditingController> controllers;
  int id;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    id = 0;
    controllers = {
      1: TextEditingController(),
      2: TextEditingController(),
    };
    playersRows = {
      1: generatePlayerLine(1, false, controllers[1]),
      2: generatePlayerLine(2, false, controllers[2]),
    };
    id += 2;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo, Colors.blue[300]],
            stops: [0.8, 1.0]),
      ),
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              ListView(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  Text(
                    "C'EST L'HEURE",
                    style: TextStyle(
                        fontFamily: "Comix-Loud",
                        color: Colors.white,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    "DE TRINQUER",
                    style: TextStyle(
                        fontFamily: "Comix-Loud",
                        color: Colors.white,
                        fontSize: 25.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: 60.0,
                        child: Image.asset("assets/images/cheers.png"),
                      ),
                      Text("*",
                          style: TextStyle(
                              fontFamily: 'Comix-Loud', color: Colors.white)),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Choisis qui va morfler ce soir :",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.0),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2.2),
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: playersRows.length,
                      itemBuilder: (BuildContext context, int index) {
                        List<Widget> values = playersRows.values.toList();
                        return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: values[index],
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plusCircle,
                        color: Colors.white, size: 30.0),
                    onPressed: () {
                      setState(() {
                        id++;
                        controllers.putIfAbsent(
                            id, () => TextEditingController());
                        playersRows.putIfAbsent(
                            id,
                            () =>
                                generatePlayerLine(id, true, controllers[id]));
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  Padding(
                    padding:
                        EdgeInsets.only(left: 30.0, right: 30.0, bottom: 20.0),
                    child: RaisedButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(20.0)),
                      color: Colors.white,
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 20.0),
                        child: Text(
                          "MODE DE JEU",
                          style: TextStyle(
                              fontFamily: 'Comix-Loud',
                              color: Colors.blue[300],
                              fontSize: 15.0),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () async {
                        List<Player> players = [];
                        retrievePlayersNames().forEach((String name) {
                          players.add(Player(name));
                        });
                        if (players.length >= 2) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ModeSelectionPage(players)));
                        } else {
                          print("There is not enough players.");
                        }
                      },
                    ),
                  ),
                ],
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
          )),
    );
  }

  List<String> retrievePlayersNames() {
    List<String> players = [];
    controllers.values.toList().forEach((TextEditingController tec) {
      if (tec.text.trim().isNotEmpty) players.add(tec.text.trim());
    });
    return players;
  }

  Widget generatePlayerLine(
      int key, bool isRemovable, TextEditingController tec) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.dice),
            color: Colors.white,
            onPressed: () {
              controllers[key].text =
                  Provider.of<JsonHandlerService>(context).getRandomName();
            },
          ),
        ),
        Container(
            width: 200.0,
            child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: TextField(
                    controller: tec,
                    style: TextStyle(fontSize: 20.0),
                    decoration: new InputDecoration(
                      //hintText: "Soiffard $key",
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                    ),
                  ),
                ))),
        Padding(
          padding: EdgeInsets.only(left: 10.0),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.minusCircle,
                color: isRemovable ? Colors.white : Colors.transparent),
            color: Colors.white,
            onPressed: isRemovable
                ? () {
                    setState(() {
                      playersRows.remove(key);
                      controllers.remove(key);
                    });
                  }
                : () {},
          ),
        ),
      ],
    );
  }
}
