import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//TODO : add TextFieldControllers
//TODO : add random name generation
//TODO : correct fields removal

class PlayersSelectionPage extends StatefulWidget {
  PlayersSelectionPage({Key key}) : super(key: key);

  @override
  _PlayersSelectionPageState createState() => _PlayersSelectionPageState();
}

class _PlayersSelectionPageState extends State<PlayersSelectionPage> {
  List<Widget> widgets;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ]);
    widgets = [
      generatePlayerLine(false),
      generatePlayerLine(false),
    ];
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
              Align(
                alignment: Alignment.topLeft,
                child: BackButton(color: Colors.white),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                        maxHeight: MediaQuery.of(context).size.height / 2.5),
                    child: ListView.builder(
                      //shrinkWrap: true,
                      itemCount: widgets.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: EdgeInsets.all(5.0),
                          child: widgets[index],
                        );
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(FontAwesomeIcons.plusCircle,
                        color: Colors.white, size: 30.0),
                    onPressed: () {
                      setState(() {
                        widgets.add(generatePlayerLine(true));
                      });
                    },
                  ),
                  SizedBox(height: 20.0),
                  RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                    color: Colors.white,
                    onPressed: () {},
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(5.0, 30.0, 5.0, 20.0),
                      child: Text(
                        "ENVOIE LA SAUCE",
                        style: TextStyle(
                            fontFamily: 'Comix-Loud',
                            color: Colors.blue[300],
                            fontSize: 15.0),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget generatePlayerLine(bool isRemovable) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: IconButton(
            icon: Icon(FontAwesomeIcons.dice),
            color: Colors.white,
            onPressed: () {},
          ),
        ),
        Container(
            width: 200.0,
            child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
                  child: TextField(
                    style: TextStyle(fontSize: 20.0),
                    decoration: new InputDecoration(
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
                      widgets.removeLast();
                    });
                  }
                : () {},
          ),
        ),
      ],
    );
  }
}
