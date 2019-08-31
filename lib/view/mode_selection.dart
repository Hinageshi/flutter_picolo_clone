import 'package:flutter/material.dart';
import 'package:flutter_picolo_clone/model/player.dart';
import 'package:flutter_picolo_clone/model/rule.dart';
import 'package:flutter_picolo_clone/services/json_handler_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import 'game_page.dart';

enum Mode { CLASSIC, KINKY, CUSTOM }

class ModeSelectionPage extends StatefulWidget {
  final List<Player> players;
  ModeSelectionPage(List<Player> players, {Key key})
      : this.players = players,
        super(key: key);

  @override
  _ModeSelectionPageState createState() => _ModeSelectionPageState();
}

class _ModeSelectionPageState extends State<ModeSelectionPage> {
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
                    "CHOISIS LE",
                    style: TextStyle(
                        fontFamily: "Comix-Loud",
                        color: Colors.white,
                        fontSize: 15.0),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 25.0),
                  Text(
                    "MODE DE JEU",
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
                  SizedBox(height: 40.0),
                  Column(
                    children: <Widget>[
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          onTap: () => onModeSelected(Mode.CLASSIC),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 75.0,
                                height: 75.0,
                                child: Image.asset("assets/images/cheers.png"),
                              ),
                              SizedBox(width: 10.0),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text("CLASSIQUE",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(fontSize: 20.0)),
                                        Text(
                                            "Parfait pour les before et faire boire tes potes")
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          //onTap: () => onModeSelected(Mode.KINKY),
                          child: Opacity(
                            opacity: 0.3,
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 75.0,
                                    height: 75.0,
                                    child:
                                        Image.asset("assets/images/mouth.png")),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("KINKY",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                          Text(
                                              "Dévoile tes pires secrets... et fais parler les autres !")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: 10.0, left: 16.0, right: 16.0),
                        child: GestureDetector(
                          //onTap: () => onModeSelected(Mode.CUSTOM),
                          child: Opacity(
                            opacity: 0.3,
                            child: Row(
                              children: <Widget>[
                                Container(
                                    width: 75.0,
                                    height: 75.0,
                                    child:
                                        Image.asset("assets/images/paint.png")),
                                SizedBox(width: 10.0),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text("CUSTOM",
                                              textAlign: TextAlign.left,
                                              style: TextStyle(fontSize: 20.0)),
                                          Text(
                                              "Joue avec tes propres règles ! (modifiables dans les paramètres)")
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

  void onModeSelected(Mode mode) async {
    List<Rule> rules = await Provider.of<JsonHandlerService>(context)
        .getRulesList(context, mode, 50);
    Navigator.of(context).push(
        MaterialPageRoute(builder: (_) => GamePage(widget.players, rules)));
  }
}
