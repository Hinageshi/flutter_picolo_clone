import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_picolo_clone/model/player.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GamePage extends StatefulWidget {
  final List<Player> players;

  GamePage(List<Player> players, {Key key})
      : this.players = players,
        super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.landscapeRight,
    ]);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.blue[300]],
            stops: [0.8, 1.0]),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            Center(
              child: Text("${widget.players.toString()}",
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center),
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
      ),
    );
  }
}
